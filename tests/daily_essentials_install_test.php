<?php
declare(strict_types=1);
$root=dirname(__DIR__);$configPath=(string)getenv('YL_TEST_CONFIG_PATH');
if($configPath===''||!is_file($configPath)){fwrite(STDERR,"NOT EXECUTED: set YL_TEST_CONFIG_PATH to an isolated local QA/test configuration.\n");exit(2);}
$config=require $configPath;$cfg=$config['db']??[];
if(!in_array($cfg['host']??'',['127.0.0.1','localhost','::1'],true)||!preg_match('/(?:_qa|_test)$/',(string)($cfg['name']??'')))throw new RuntimeException('This test requires an isolated local QA/test database.');
require_once $root.'/lib/compat.php';require_once $root.'/lib/Database.php';require_once $root.'/lib/Repository.php';
$db=new Database($cfg,$root.'/database/schema.sql');$repo=new Repository($db);
$token=bin2hex(random_bytes(8));$uids=[];$fail=[];$checks=[];$readyFiles=[];$workers=[];
$check=function(bool $ok,string $name)use(&$checks,&$fail):void{$checks[]=['pass'=>$ok,'check'=>$name];echo ($ok?'PASS ':'FAIL ').$name.PHP_EOL;if(!$ok)$fail[]=$name;};
$newUser=function(string $label)use($db,$token,&$uids):int{$email='essential-'.$label.'-'.$token.'@example.test';$db->run('INSERT INTO users(name,email,password_hash) VALUES(?,?,?)',['Essential synthetic fixture',$email,password_hash($token,PASSWORD_DEFAULT)]);$id=$db->lastId();$uids[$id]=$email;return $id;};
$findBook=static function(array $catalog):array{foreach($catalog as $b)if($b['code']==='daily-essentials-a1-a2')return $b;throw new RuntimeException('New catalog entry missing.');};
$snapshot=function(int $uid,array $setIds)use($db):array{
    $marks=implode(',',array_fill(0,count($setIds),'?'));
    return [
        'sets'=>$db->all("SELECT * FROM flashcard_sets WHERE user_id=? AND id IN ({$marks}) ORDER BY id",[$uid,...$setIds]),
        'cards'=>$db->all("SELECT * FROM flashcards WHERE set_id IN ({$marks}) ORDER BY id",$setIds),
        'folders'=>$db->all("SELECT * FROM folders WHERE user_id=? AND id IN (SELECT folder_id FROM flashcard_sets WHERE id IN ({$marks})) ORDER BY id",[$uid,...$setIds]),
        'srs'=>$db->all("SELECT * FROM srs_progress WHERE user_id=? AND card_id IN (SELECT id FROM flashcards WHERE set_id IN ({$marks})) ORDER BY card_id",[$uid,...$setIds]),
        'events'=>$db->all("SELECT * FROM study_events WHERE user_id=? AND set_id IN ({$marks}) ORDER BY id",[$uid,...$setIds]),
        'mistakes'=>$db->all("SELECT * FROM mistake_book_v2 WHERE user_id=? AND card_id IN (SELECT id FROM flashcards WHERE set_id IN ({$marks})) ORDER BY id",[$uid,...$setIds]),
    ];
};
$oldIds=[];$oldHashes=[];$finalHashes=[];$lockHeld=false;$lockName='';
try{
    $uid=$newUser('owner');$other=$newUser('other');$concurrent=$newUser('concurrent');
    $method=(new ReflectionClass(Repository::class))->getMethod('flashcardBookSpecs');$method->setAccessible(true);$specs=$method->invoke($repo);
    $oldFolder=$repo->createFolder($uid,'Synthetic existing student folder');
    foreach($specs as $code=>$spec){
        if($code==='daily-essentials-a1-a2')continue;
        $set=$repo->createSet($uid,'Edited '.$code,'Personal fictional description',(int)$oldFolder['id'],$spec['source_type']);$sid=(int)$set['id'];$oldIds[]=$sid;
        $card=$repo->createCard($uid,$sid,['term'=>'saved-'.$sid,'definition'=>'Nghĩa riêng hư cấu '.$sid,'ipa'=>'UK /seɪvd/','part_of_speech'=>'adjective','example_en'=>'This is a saved example.','example_vi'=>'Đây là ví dụ đã lưu.','notes'=>'Ghi chú riêng hư cấu.','card_type'=>'LISTENING','explanation'=>'Giải thích riêng hư cấu.']);
        $cid=(int)$card['id'];
        $db->run("INSERT INTO srs_progress(user_id,card_id,state,due_at,interval_days,repetitions,correct_reviews,total_reviews,last_rating) VALUES(?,?,'review','2030-01-01 09:00:00',7,4,3,4,3)",[$uid,$cid]);
        $db->run("INSERT INTO study_events(user_id,set_id,card_id,mode,result,score,xp) VALUES(?,?,?,'review',1,80,4)",[$uid,$sid,$cid]);
        $db->run("INSERT INTO mistake_book_v2(user_id,source_type,source_key,card_id,question,user_answer,correct_answer,explanation) VALUES(?,'flashcard',?,?,?,'saved','answer','Fictional retained feedback')",[$uid,'card:'.$cid,$cid,'Synthetic question '.$cid]);
    }
    // Same title is intentionally not the source identity and must not be reused.
    $manual=$repo->createSet($uid,$specs['daily-essentials-a1-a2']['title'],'Manual same-title fixture',(int)$oldFolder['id'],'manual');$oldIds[]=(int)$manual['id'];
    $repo->createCard($uid,(int)$manual['id'],['term'=>'my own word','definition'=>'Từ riêng hư cấu','example_en'=>'This is my own word.','example_vi'=>'Đây là từ riêng của tôi.']);
    $old=$snapshot($uid,$oldIds);foreach($old as $key=>$value)$oldHashes[$key]=hash('sha256',json_encode($value,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR));
    $beforeCount=(int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=?',[$uid])['n'];
    $catalog=$findBook($repo->flashcardBooks($uid));
    $check(!$catalog['installed']&&$catalog['source_rows']===64&&$catalog['topic_count']===8,'fresh catalog advertises a separate 64-card/8-topic book');
    $check($catalog['lesson_size']===8&&$catalog['lesson_count']===8,'catalog has eight-card lessons');
    $check($old===$snapshot($uid,$oldIds)&&$beforeCount===(int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=?',[$uid])['n'],'catalog does not mutate existing learner data');
    $first=$repo->installFlashcardBook($uid,'daily-essentials-a1-a2');$sid=(int)$first['set_id'];
    $check(!$first['already_installed']&&$first['card_count']===64&&$first['topic_count']===8,'first install creates exactly 64 cards');
    $check($sid!==(int)$manual['id'],'same-title manual book is preserved separately');
    $newCards=$db->all('SELECT * FROM flashcards WHERE set_id=? ORDER BY id',[$sid]);$cardIds=array_map('intval',array_column($newCards,'id'));
    $check(count($newCards)===64&&count(array_unique($cardIds))===64,'64 unique stable new card IDs');
    $check(count(array_filter($newCards,fn($c)=>str_starts_with($c['ipa'],'US /')))===39,'all 39 IPA fields retained verbatim');
    $check(count(array_filter($newCards,fn($c)=>$c['ipa']===''))===25,'25 chunks have no fabricated IPA');
    $check(array_count_values(array_column($newCards,'card_type'))===['VOCABULARY'=>39,'LISTENING_CHUNK'=>12,'COLLOCATION'=>9,'SENTENCE_PATTERN'=>4],'four card types survive bulk insertion');
    $check((int)$db->one('SELECT COUNT(*) n FROM srs_progress WHERE user_id=? AND card_id IN (SELECT id FROM flashcards WHERE set_id=?)',[$uid,$sid])['n']===0,'installation does not create or reset SRS progress');
    $again=$repo->installFlashcardBook($uid,'daily-essentials-a1-a2');
    $check($again['already_installed']&&(int)$again['set_id']===$sid&&$again['card_count']===64,'repeat install reuses book ID');
    $check($newCards===$db->all('SELECT * FROM flashcards WHERE set_id=? ORDER BY id',[$sid]),'repeat install preserves every new card field and ID');
    $lessons=$repo->studyLessons($uid,$sid,20);
    $check(count($lessons)===8&&array_unique(array_column($lessons,'card_count'))===[8],'study API splits 64 into 8x8 regardless of default size20');
    $seed=json_decode(file_get_contents($root.'/assets/flashbooks/daily-essentials-a1-a2.json'),true,512,JSON_THROW_ON_ERROR);
    $allLessonIds=[];
    foreach($lessons as $i=>$lesson){
        $detail=$repo->studyLessonCards($uid,$sid,$i+1,20);$ids=array_map('intval',array_column($detail['cards'],'id'));
        $check($lesson['title']===$seed['lessons'][$i]['title']&&$lesson['objective']===$seed['lessons'][$i]['objective']&&$detail['count']===8,'lesson '.($i+1).' title/objective/count');
        $check(($detail['speaking_prompt']??'')===$seed['lessons'][$i]['speaking_prompt']&&($detail['speaking_model']??'')===$seed['lessons'][$i]['speaking_model'],'lesson '.($i+1).' speaking metadata');
        $allLessonIds=array_merge($allLessonIds,$ids);
    }
    $check($allLessonIds===$cardIds,'lesson cards keep the same IDs and original ordering');
    $sync=$repo->ensureFlashcardBooksInstalled($uid);
    $check($sync['complete']&&$sync['created_count']===0&&$sync['updated_count']===0&&$sync['added_cards']===0,'sync adds nothing to already installed books');
    $check((int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=? AND source_type=?',[$uid,'daily_essentials_a1_a2_book'])['n']===1,'owner/source identity remains exactly one book');
    $freshOther=$findBook($repo->flashcardBooks($other));$check(!$freshOther['installed'],'other owner does not inherit installed state');
    $otherFirst=$repo->installFlashcardBook($other,'daily-essentials-a1-a2');
    $check((int)$otherFirst['set_id']!==$sid&&$otherFirst['card_count']===64,'other owner receives a separate book');
    $denied=false;try{$repo->studyLessonCards($other,$sid,1);}catch(RuntimeException $e){$denied=true;}$check($denied,'cross-owner study access is denied');
    // A learner's later edit/progress must survive all subsequent install/sync calls.
    $edited=(int)$newCards[0]['id'];$db->run('UPDATE flashcards SET definition=?,notes=? WHERE id=?',['Nghĩa tự sửa hư cấu','Ghi chú của người học hư cấu',$edited]);
    $db->run("INSERT INTO srs_progress(user_id,card_id,state,due_at,repetitions,interval_days) VALUES(?,?,'mastered','2031-01-02 10:00:00',9,18)",[$uid,$edited]);
    $editedSnapshot=$snapshot($uid,[$sid]);$repo->installFlashcardBook($uid,'daily-essentials-a1-a2');$repo->ensureFlashcardBooksInstalled($uid);$repo->flashcardBooks($uid);
    $check($editedSnapshot===$snapshot($uid,[$sid]),'repeat catalog/install/sync preserves later learner edits and SRS');
    $check($old===$snapshot($uid,$oldIds),'all old books/cards/folders/SRS/events/mistakes remain exactly unchanged');
    foreach($snapshot($uid,$oldIds) as $key=>$value)$finalHashes[$key]=hash('sha256',json_encode($value,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR));
    // Hold the existing per-owner advisory lock until both subprocesses are ready.
    $lockName='yanglingo:flashbooks:'.$concurrent;$lockHeld=(int)$db->one('SELECT GET_LOCK(?,10) acquired',[$lockName])['acquired']===1;
    if(!$lockHeld)throw new RuntimeException('Cannot acquire synthetic concurrency lock.');
    for($i=0;$i<2;$i++){
        $ready=dirname($configPath).'/essential-ready-'.bin2hex(random_bytes(6)).'.txt';$readyFiles[]=$ready;
        $phpArgs=json_decode((string)(getenv('YL_TEST_PHP_ARGS')?:'[]'),true,512,JSON_THROW_ON_ERROR);
        if(!is_array($phpArgs)||!array_is_list($phpArgs)||count(array_filter($phpArgs,'is_string'))!==count($phpArgs))throw new RuntimeException('Invalid subprocess PHP flags.');
        $cmd=[PHP_BINARY,...$phpArgs,__DIR__.'/daily_essentials_install_worker.php',(string)$concurrent,$ready];
        $env=getenv();$env['YL_TEST_CONFIG_PATH']=$configPath;$pipes=[];
        $process=proc_open($cmd,[0=>['pipe','r'],1=>['pipe','w'],2=>['pipe','w']],$pipes,null,$env,['bypass_shell'=>true]);
        if(!is_resource($process))throw new RuntimeException('Cannot spawn synthetic concurrency worker.');fclose($pipes[0]);
        $workers[]=['process'=>$process,'pipes'=>$pipes];
    }
    $deadline=microtime(true)+5;while(microtime(true)<$deadline&&count(array_filter($readyFiles,'is_file'))!==2)usleep(20000);
    $check(count(array_filter($readyFiles,'is_file'))===2,'two concurrent installers reach the held owner lock');
    $db->one('SELECT RELEASE_LOCK(?) released',[$lockName]);$lockHeld=false;
    $results=[];
    foreach($workers as $worker){$stdout=stream_get_contents($worker['pipes'][1]);$stderr=stream_get_contents($worker['pipes'][2]);fclose($worker['pipes'][1]);fclose($worker['pipes'][2]);$exit=proc_close($worker['process']);if($exit!==0)throw new RuntimeException('Concurrent synthetic worker failed: '.$stderr);$results[]=json_decode(trim($stdout),true,512,JSON_THROW_ON_ERROR);}$workers=[];
    $check((int)$results[0]['set_id']===(int)$results[1]['set_id']&&$results[0]['already_installed']!==$results[1]['already_installed'],'concurrent requests share a single new book ID');
    $conSid=(int)$results[0]['set_id'];
    $check((int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=? AND source_type=?',[$concurrent,'daily_essentials_a1_a2_book'])['n']===1&&(int)$db->one('SELECT COUNT(*) n FROM flashcards WHERE set_id=?',[$conSid])['n']===64,'concurrent requests create one book and 64 cards');
    $check($old===$snapshot($uid,$oldIds),'concurrency on another owner leaves old learner data unchanged');
    $report=['pass'=>!$fail,'checks'=>$checks,'check_count'=>count($checks),'synthetic_only'=>true,'old_before_sha256'=>$oldHashes,'old_after_sha256'=>$finalHashes,'book_code'=>'daily-essentials-a1-a2','cards'=>64,'lessons'=>8,'shared_or_live_mutation'=>false];
    $reportPath=(string)getenv('YL_TEST_REPORT_PATH');if($reportPath!=='')file_put_contents($reportPath,json_encode($report,JSON_UNESCAPED_UNICODE|JSON_PRETTY_PRINT|JSON_THROW_ON_ERROR).PHP_EOL);
}finally{
    if($lockHeld)$db->one('SELECT RELEASE_LOCK(?) released',[$lockName]);
    foreach($workers as $worker){foreach($worker['pipes'] as $pipe)if(is_resource($pipe))fclose($pipe);if(is_resource($worker['process'])){proc_terminate($worker['process']);proc_close($worker['process']);}}
    foreach($readyFiles as $path)if(is_file($path))unlink($path);
    foreach($uids as $id=>$email)$db->run('DELETE FROM users WHERE id=? AND email=?',[$id,$email]);
}
if($fail)throw new RuntimeException('Daily Essentials checks failed: '.implode('; ',$fail));
echo 'DAILY ESSENTIALS INSTALL PASS: '.count($checks)." checks\n";
