<?php
declare(strict_types=1);

/**
 * Real MariaDB/HTTP tests, restricted to an isolated local QA server on 13307.
 * Set YANG_NOTEBOOK_TEST_CONFIG to an ignored PHP config returning a db array.
 * Main fixtures are rolled back. Concurrent/HTTP fixtures must be committed for
 * separate connections to see them, and their fictional users/sessions are removed
 * in finally. Requires a database name ending in _qa or _test.
 */
$root=dirname(__DIR__);
require_once $root.'/lib/Database.php';
require_once $root.'/lib/LearningNotebook.php';
$cfgPath=getenv('YANG_NOTEBOOK_TEST_CONFIG');
if(!$cfgPath||!is_file($cfgPath)){fwrite(STDERR,"NOT EXECUTED: provide isolated QA configuration.\n");exit(2);}
$cfg=(require $cfgPath)['db']??[];
if(!in_array($cfg['host']??'',['127.0.0.1','localhost'],true)||(int)($cfg['port']??0)!==13307||!preg_match('/^[a-zA-Z0-9_]+_(qa|test)$/D',$cfg['name']??'')){
    fwrite(STDERR,"NOT EXECUTED: only local QA port 13307 is allowed.\n");exit(2);
}
function qaDb(array $cfg,string $name,string $root): Database {
    if($name!==($cfg['name']??'')||!preg_match('/^[a-zA-Z0-9_]+_(qa|test)$/D',$name))throw new RuntimeException('Invalid QA database name.');
    $cfg['name']=$name;return new Database($cfg,$root.'/database/schema.sql',$root.'/database/migrations',$root.'/database/seeds');
}
if(($argv[1]??'')==='--worker'){
    try{
        $db=qaDb($cfg,$argv[2]??'',$root);$uid=(int)($argv[3]??0);$pdo=$db->pdo();
        $pdo->exec('SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ');$pdo->beginTransaction();
        // Establish a stale, non-locking snapshot before both workers create.
        if((int)$db->one('SELECT COUNT(*) n FROM learning_notebook_notes WHERE user_id=?',[$uid])['n']!==499)throw new RuntimeException('Race fixture is not ready.');
        echo "READY\n";flush();if(trim((string)fgets(STDIN))!=='GO')throw new RuntimeException('Missing race barrier.');
        try{(new LearningNotebook($db))->save($uid,['title'=>'Concurrent note']);$pdo->commit();echo "created\n";}
        catch(LearningNotebookException $e){if($pdo->inTransaction())$pdo->rollBack();echo $e->status===409?"capped\n":"unexpected\n";}
    }catch(Throwable $e){if(isset($pdo)&&$pdo->inTransaction())$pdo->rollBack();fwrite(STDERR,"Race worker failed.\n");exit(1);}
    exit;
}
$checks=0;
function check(bool $ok,string $label): void {global $checks;if(!$ok)throw new RuntimeException('FAIL: '.$label);$checks++;}
function rejects(callable $fn,string $class,string $label,?int $status=null): void {
    try{$fn();}catch(Throwable $e){check($e instanceof $class&&($status===null||($e->status??null)===$status),$label);return;}
    throw new RuntimeException('FAIL: '.$label.' was accepted');
}
function fixtureUser(Database $db,string $name,string $password='Fictional-QA-Only-42'): int {
    $db->run('INSERT INTO users(name,email,password_hash) VALUES(?,?,?)',[$name,$name.'@example.invalid',password_hash($password,PASSWORD_DEFAULT)]);return $db->lastId();
}
function srsSnapshot(Database $db): string {
    $data=[];foreach(['flashcard_sets','flashcards','srs_progress','study_events'] as $table)$data[$table]=$db->all('SELECT * FROM '.$table.' ORDER BY '.($table==='srs_progress'?'user_id,card_id':'id'));
    return hash('sha256',serialize($data));
}
function copyQaTree(string $source,string $target): void {
    if(is_file($source)){if(!copy($source,$target))throw new RuntimeException('Cannot copy QA file.');return;}
    if(!is_dir($target)&&!mkdir($target,0700,true))throw new RuntimeException('Cannot create QA directory.');
    foreach(new DirectoryIterator($source) as $entry)if(!$entry->isDot()&&!$entry->isLink())copyQaTree($entry->getPathname(),$target.'/'.$entry->getFilename());
}
function removeQaTree(string $path): void {
    $resolved=realpath($path);$temp=realpath(sys_get_temp_dir());
    if(!$resolved)return;
    if(dirname($resolved)!==$temp||!preg_match('/^yanglingo-notebook-http-[a-f0-9]{12}$/D',basename($resolved)))throw new RuntimeException('Refusing QA cleanup outside exact temporary directory.');
    foreach(new RecursiveIteratorIterator(new RecursiveDirectoryIterator($resolved,FilesystemIterator::SKIP_DOTS),RecursiveIteratorIterator::CHILD_FIRST) as $entry){
        if($entry->isDir()&&!$entry->isLink())rmdir($entry->getPathname());else unlink($entry->getPathname());
    }
    rmdir($resolved);
}
function httpCall(string $base,string $action,string $method='GET',?array $data=null,array $query=[],string &$cookie='',?string $csrfHeader=null): array {
    $headers=['Content-Type: application/json'];if($cookie!=='')$headers[]='Cookie: '.$cookie;if($csrfHeader!==null)$headers[]='X-CSRF-Token: '.$csrfHeader;
    $ctx=stream_context_create(['http'=>['method'=>$method,'header'=>implode("\r\n",$headers),'content'=>$data===null?'':json_encode($data,JSON_THROW_ON_ERROR),'ignore_errors'=>true,'timeout'=>15]]);
    $body=@file_get_contents($base.'/api.php?'.http_build_query(['action'=>$action]+$query),false,$ctx);
    $responseHeaders=$http_response_header??[];$status=0;
    foreach($responseHeaders as $header){if(preg_match('~^HTTP/\S+\s+(\d+)~',$header,$m))$status=(int)$m[1];if(preg_match('/^Set-Cookie:\s*(YLANGSESSID=[^;]+)/i',$header,$m))$cookie=$m[1];}
    return ['status'=>$status,'json'=>is_string($body)?json_decode($body,true):null];
}
$db=null;$server=null;$serverPipes=[];$workers=[];$dbName=$cfg['name'];$committedUsers=[];$cookie='';$qaTree=null;
try{
    $db=qaDb($cfg,$dbName,$root);$pdo=$db->pdo();
    // Apply only this feature's idempotent migration. Existing QA content may use
    // older, already-applied migration bytes; do not rewrite their checksums.
    $pdo->exec(file_get_contents($root.'/database/migrations/016_learning_notebook.sql'));
    $notebook=new LearningNotebook($db);
    $baselineSrs=srsSnapshot($db);$baselineNotes=(int)$db->one('SELECT COUNT(*) n FROM learning_notebook_notes')['n'];
    $pdo->beginTransaction();
    $alice=fixtureUser($db,'notebook-alice');$bob=fixtureUser($db,'notebook-bob');
    $db->run('INSERT INTO flashcard_sets(user_id,title,description) VALUES(?,?,?)',[$alice,'Fictional QA book','SRS preservation fixture']);$set=$db->lastId();
    $db->run('INSERT INTO flashcards(set_id,term,definition,example_en,example_vi,notes) VALUES(?,?,?,?,?,?)',[$set,'study','học','I study every day.','Tôi học mỗi ngày.','']);$card=$db->lastId();
    $db->run("INSERT INTO srs_progress(user_id,card_id,state,repetitions,due_at) VALUES(?,?,'review',7,'2030-01-01 12:00:00')",[$alice,$card]);
    $db->run("INSERT INTO study_events(user_id,set_id,card_id,mode,xp) VALUES(?,?,?,'review',5)",[$alice,$set,$card]);$srsBefore=srsSnapshot($db);
    $note=$notebook->save($alice,['id'=>null,'title'=>'  Học từ café 📚  ','body'=>'Giảm 50%: a_b! \\ thử','own_sentence'=>'I study every day.','kind'=>'word','is_pinned'=>false]);$id=(int)$note['id'];
    check($pdo->inTransaction(),'create preserves caller transaction');
    check($note['title']==='Học từ café 📚'&&$note['body']==='Giảm 50%: a_b! \\ thử','UTF-8 round trip and trim');
    check(!isset($note['user_id'])&&!isset($note['card_id']),'response exposes only notebook fields');
    check((int)$notebook->get($alice,(string)$id)['id']===$id,'canonical string ID accepted');
    $other=$notebook->save($bob,['title'=>'Private second learner']);
    foreach(['read'=>fn()=>$notebook->get($bob,$id),'edit'=>fn()=>$notebook->save($bob,['id'=>$id,'title'=>'forged']),
        'archive'=>fn()=>$notebook->archive($bob,$id,1),'pin'=>fn()=>$notebook->pin($bob,$id,1)] as $label=>$fn)rejects($fn,LearningNotebookException::class,'ownership '.$label,404);
    rejects(fn()=>$notebook->get($alice,PHP_INT_MAX),LearningNotebookException::class,'absent note matches ownership failure',404);
    check($notebook->get($alice,$id)['title']==='Học từ café 📚','cross-user operations did not mutate note');
    foreach([true,false,1.0,0,-1,'01','+1','1e0','1.0',' 1','1x',str_repeat('9',40),[],null] as $bad)rejects(fn()=>$notebook->get($alice,$bad),InvalidArgumentException::class,'strict note ID '.gettype($bad));
    foreach([null,[],-1,'yes',1.0,2] as $bad)rejects(fn()=>$notebook->pin($alice,$id,$bad),InvalidArgumentException::class,'strict flag '.gettype($bad));
    foreach([true,false,1,0,'1','0'] as $flag)check((int)$notebook->pin($alice,$id,$flag)['is_pinned']===(int)$flag,'supported exact flag');
    foreach([[],['title'=>''],['title'=>" \n\t\u{00a0}"],['title'=>null],['title'=>12],['title'=>[]],['title'=>"bad\0"],['title'=>"bad\xff"],['title'=>str_repeat('á',161)],
        ['title'=>'valid','body'=>null],['title'=>'valid','body'=>[]],['title'=>'valid','body'=>str_repeat('文',2501)],['title'=>'valid','own_sentence'=>false],
        ['title'=>'valid','own_sentence'=>str_repeat('📚',501)],['title'=>'valid','kind'=>null],['title'=>'valid','kind'=>'unknown'],['title'=>'valid','kind'=>[]],
        ['title'=>'valid','is_pinned'=>null],['title'=>'valid','user_id'=>$bob],['title'=>'valid','is_archived'=>true]] as $bad)rejects(fn()=>$notebook->save($alice,$bad),InvalidArgumentException::class,'save validation');
    $boundary=$notebook->save($alice,['title'=>str_repeat('á',160),'body'=>str_repeat('文',2500),'own_sentence'=>str_repeat('📚',500),'kind'=>'grammar']);
    check(mb_strlen($boundary['body'],'UTF-8')===2500&&mb_strlen($boundary['own_sentence'],'UTF-8')===500,'multibyte character limits inclusive');
    $notebook->save($alice,['title'=>'Ordinary percent-free note','body'=>'axb']);
    foreach(['%','_','!','\\','café'] as $q){$found=$notebook->list($alice,['q'=>$q]);check($found['total']===1&&(int)$found['notes'][0]['id']===$id,'literal search '.$q);}
    check($notebook->list($alice,['q'=>"' OR 1=1 --"])['total']===0,'search injection literal');
    check($notebook->list($bob)['total']===1,'list scoped to learner');
    foreach([['q'=>[]],['q'=>null],['q'=>"\xff"],['q'=>str_repeat('x',161)],['kind'=>'invalid'],['archived'=>null],['page'=>true],['page'=>0],['page'=>1.0],['page'=>1001],['user_id'=>$bob]] as $query)rejects(fn()=>$notebook->list($alice,$query),InvalidArgumentException::class,'list validation');
    $notebook->pin($alice,$id,1);check((int)$notebook->list($alice)['notes'][0]['id']===$id,'pinned note first');
    $notebook->archive($alice,$id,1);check($notebook->list($alice,['q'=>'%'])['total']===0,'archive hidden from active list');
    $archived=$notebook->list($alice,['archived'=>'1']);check($archived['total']===1&&(int)$archived['notes'][0]['id']===$id,'archived tab owns note');
    $notebook->save($alice,['id'=>$id,'title'=>'Edited archived note','body'=>'New text']);check((int)$notebook->get($alice,$id)['is_archived']===1,'editing keeps archive flag');
    $notebook->archive($alice,$id,false);check($notebook->list($alice,['archived'=>1])['total']===0,'restore works');
    $count=(int)$db->one('SELECT COUNT(*) n FROM learning_notebook_notes WHERE user_id=?',[$alice])['n'];
    for($n=$count;$n<500;$n++)$db->run('INSERT INTO learning_notebook_notes(user_id,title,body,is_archived) VALUES(?,?,?,?)',[$alice,'Cap fixture '.$n,'',$n%2]);
    $list=$notebook->list($alice,['page'=>'1000']);check($list['page']===$list['pages']&&count($list['notes'])<=20&&$list['saved_count']===500&&$list['max_notes']===500,'pagination and cap metadata');
    check($notebook->list($alice,['kind'=>'grammar'])['total']===1,'kind filter');
    rejects(fn()=>$notebook->save($alice,['title'=>'Over cap']),LearningNotebookException::class,'500 including archive cap',409);
    check($pdo->inTransaction(),'rejected create leaves caller transaction active');
    check($notebook->save($alice,['id'=>$id,'title'=>'Can edit at cap'])['title']==='Can edit at cap','edit allowed at cap');
    check(srsSnapshot($db)===$srsBefore,'notes do not alter book/card/SRS/history rows');
    $pdo->rollBack();check((int)$db->one('SELECT COUNT(*) n FROM learning_notebook_notes')['n']===$baselineNotes&&srsSnapshot($db)===$baselineSrs,'outer rollback removes all note fixtures');

    // Both workers see 499 in their own old snapshot. Only one may create #500.
    $race=fixtureUser($db,'notebook-race');$committedUsers[]=$race;
    for($n=0;$n<499;$n++){$db->run('INSERT INTO learning_notebook_notes(user_id,title,body,is_archived) VALUES(?,?,?,?)',[$race,'Race fixture '.$n,'',$n%2]);if($n===0)$raceNoteId=$db->lastId();}
    for($n=0;$n<2;$n++){
        $pipes=[];$proc=proc_open([PHP_BINARY,__FILE__,'--worker',$dbName,(string)$race],[0=>['pipe','r'],1=>['pipe','w'],2=>['pipe','w']],$pipes);
        if(!is_resource($proc))throw new RuntimeException('Cannot start race worker.');
        stream_set_timeout($pipes[1],20);$workers[]=['proc'=>$proc,'pipes'=>$pipes];
    }
    foreach($workers as $worker)check(trim((string)fgets($worker['pipes'][1]))==='READY','race worker snapshot barrier');
    foreach($workers as $worker){fwrite($worker['pipes'][0],"GO\n");fclose($worker['pipes'][0]);}
    $outcomes=[];foreach($workers as &$worker){$outcomes[]=trim((string)fgets($worker['pipes'][1]));fclose($worker['pipes'][1]);fclose($worker['pipes'][2]);check(proc_close($worker['proc'])===0,'race worker exited');$worker['proc']=null;}unset($worker);sort($outcomes);
    check($outcomes===['capped','created']&&(int)$db->one('SELECT COUNT(*) n FROM learning_notebook_notes WHERE user_id=?',[$race])['n']===500,'concurrent stale snapshots cannot exceed cap');

    $qaTree=sys_get_temp_dir().'/yanglingo-notebook-http-'.bin2hex(random_bytes(6));mkdir($qaTree,0700,true);
    copyQaTree($root.'/lib',$qaTree.'/lib');copyQaTree($root.'/api.php',$qaTree.'/api.php');copyQaTree($root.'/config.php',$qaTree.'/config.php');
    $runtime=getenv('YANG_NOTEBOOK_TEST_RUNTIME')?:dirname($cfgPath);
    if(!is_dir($runtime.'/database'))$runtime=$root;
    copyQaTree($runtime.'/database',$qaTree.'/database');
    copyQaTree($root.'/database/migrations/016_learning_notebook.sql',$qaTree.'/database/migrations/016_learning_notebook.sql');
    $socket=stream_socket_server('tcp://127.0.0.1:0',$errno,$errstr);if(!$socket)throw new RuntimeException('Cannot select HTTP QA port.');
    $address=stream_socket_get_name($socket,false);fclose($socket);$port=(int)substr(strrchr($address,':'),1);$base='http://127.0.0.1:'.$port;
    $env=getenv();$env['DB_HOST']=$cfg['host'];$env['DB_PORT']='13307';$env['DB_NAME']=$dbName;$env['DB_USER']=$cfg['user'];$env['DB_PASS']=$cfg['pass']??'';$env['APP_DEBUG']='0';
    // Do not leave access/error output in an unread pipe: its small buffer can
    // stall Windows PHP's server during a sequence of HTTP requests.
    $null=PHP_OS_FAMILY==='Windows'?'NUL':'/dev/null';
    $server=proc_open([PHP_BINARY,'-S','127.0.0.1:'.$port,'-t',$qaTree],[0=>['pipe','r'],1=>['file',$null,'a'],2=>['file',$null,'a']],$serverPipes,$qaTree,$env);
    if(!is_resource($server))throw new RuntimeException('Cannot start HTTP QA server.');
    $ready=false;for($n=0;$n<50;$n++){if($sock=@fsockopen('127.0.0.1',$port,$errno,$errstr,0.1)){fclose($sock);$ready=true;break;}usleep(100000);}check($ready,'HTTP QA server ready');
    $cookie='';check(httpCall($base,'notebook_notes','GET',null,[],$cookie)['status']===401,'HTTP anonymous rejected');
    $password='Fictional-QA-Only-'.bin2hex(random_bytes(8));
    $response=httpCall($base,'register','POST',['name'=>'Notebook HTTP Learner','email'=>'notebook-http@example.invalid','password'=>$password],[],$cookie);
    check($response['status']===200&&($response['json']['ok']??false),'HTTP fixture login');$token=$response['json']['data']['csrf'];$httpUid=(int)$response['json']['data']['user']['id'];$committedUsers[]=$httpUid;
    check(httpCall($base,'notebook_save','GET',null,['title'=>'GET must fail'],$cookie)['status']===405,'HTTP GET cannot create');
    check(httpCall($base,'notebook_save','POST',['title'=>'Missing token'],[],$cookie)['status']===419,'HTTP CSRF required');
    $response=httpCall($base,'notebook_save','POST',['csrf'=>$token,'title'=>'HTTP note','body'=>'<script>text only</script>','kind'=>'phrase'],[],$cookie);
    check($response['status']===200&&$response['json']['data']['body']==='<script>text only</script>','HTTP plain text preserved');$httpId=(int)$response['json']['data']['id'];
    check(httpCall($base,'notebook_notes','GET',null,[],$cookie)['json']['data']['total']===1,'HTTP authenticated list');
    check(httpCall($base,'notebook_get','GET',null,['id'=>$httpId],$cookie)['status']===200,'HTTP authenticated get');
    check(httpCall($base,'notebook_get','POST',['csrf'=>$token,'id'=>$httpId],[],$cookie)['status']===405,'HTTP read method enforced');
    check(httpCall($base,'notebook_get','GET',null,['id'=>'true'],$cookie)['status']===422,'HTTP nonnumeric ID rejected');
    // A JSON boolean must not be coerced to note ID 1.
    check(httpCall($base,'notebook_save','POST',['csrf'=>$token,'id'=>true,'title'=>'forged'],[],$cookie)['status']===422,'HTTP bool ID rejected');
    check(httpCall($base,'notebook_save','POST',['csrf'=>$token,'title'=>'forged','user_id'=>$race],[],$cookie)['status']===422,'HTTP incoming owner rejected');
    foreach(['notebook_get'=>'GET','notebook_save'=>'POST','notebook_archive'=>'POST','notebook_pin'=>'POST'] as $action=>$method){
        $payload=$action==='notebook_save'?['csrf'=>$token,'id'=>$raceNoteId,'title'=>'forged']:($action==='notebook_archive'?['csrf'=>$token,'id'=>$raceNoteId,'archived'=>1]:['csrf'=>$token,'id'=>$raceNoteId,'pinned'=>1]);
        check(httpCall($base,$action,$method,$method==='POST'?$payload:null,['id'=>$raceNoteId],$cookie)['status']===404,'HTTP cross-user '.$action);
    }
    check(httpCall($base,'notebook_pin','POST',['id'=>$httpId,'pinned'=>1],[],$cookie,$token)['status']===200,'HTTP CSRF header and pin');
    check(httpCall($base,'notebook_archive','POST',['csrf'=>$token,'id'=>$httpId,'archived'=>1],[],$cookie)['status']===200,'HTTP archive');
    check(httpCall($base,'notebook_notes','GET',null,['archived'=>1],$cookie)['json']['data']['total']===1,'HTTP archived list');
    check(httpCall($base,'notebook_archive','GET',null,['id'=>$httpId,'archived'=>0],$cookie)['status']===405,'HTTP GET cannot restore');
    $restored=httpCall($base,'notebook_archive','POST',['csrf'=>$token,'id'=>$httpId,'archived'=>false],[],$cookie);
    check($restored['status']===200,'HTTP restore status '.$restored['status']);
    for($n=1;$n<500;$n++)$db->run('INSERT INTO learning_notebook_notes(user_id,title,body,is_archived) VALUES(?,?,?,?)',[$httpUid,'HTTP cap '.$n,'',1]);
    check(httpCall($base,'notebook_save','POST',['csrf'=>$token,'title'=>'Over cap'],[],$cookie)['status']===409,'HTTP cap status');
    check(srsSnapshot($db)===$baselineSrs,'HTTP and races create no SRS/history');
    echo 'NOTEBOOK INTEGRATION PASS '.$checks.' checks: real DB, ownership, validation, Unicode/literal search, archive/restore, cap, concurrent snapshots, HTTP auth/CSRF/methods, SRS preservation.'.PHP_EOL;
} finally {
    if($db&&$db->pdo()->inTransaction())$db->pdo()->rollBack();
    foreach($workers as $worker)if(is_resource($worker['proc'])){proc_terminate($worker['proc']);foreach($worker['pipes'] as $pipe)if(is_resource($pipe))fclose($pipe);proc_close($worker['proc']);}
    if(is_resource($server)){proc_terminate($server);foreach($serverPipes as $pipe)if(is_resource($pipe))fclose($pipe);proc_close($server);}
    if($qaTree!==null)removeQaTree($qaTree);
    if($db){
        foreach($committedUsers as $uid)$db->run("DELETE FROM users WHERE id=? AND email IN ('notebook-race@example.invalid','notebook-http@example.invalid')",[$uid]);
        if(preg_match('/^YLANGSESSID=([a-zA-Z0-9,-]+)$/D',$cookie,$match))$db->run('DELETE FROM app_sessions WHERE session_id=?',[$match[1]]);
    }
}
