<?php
declare(strict_types=1);
$root=dirname(__DIR__);$configPath=(string)getenv('YL_TEST_CONFIG_PATH');
if($configPath===''||!is_file($configPath)){fwrite(STDERR,"NOT EXECUTED: use an isolated local QA/test configuration.\n");exit(2);}
$cfg=(require $configPath)['db']??[];
if(!in_array($cfg['host']??'',['127.0.0.1','localhost','::1'],true)||!preg_match('/(?:_qa|_test)$/D',(string)($cfg['name']??'')))throw new RuntimeException('Refusing nonlocal/non-test database.');
require_once $root.'/lib/compat.php';require_once $root.'/lib/Database.php';require_once $root.'/lib/Repository.php';
$db=new Database($cfg,$root.'/database/schema.sql');$repo=new Repository($db);
$token=bin2hex(random_bytes(8));$uids=[];$checks=[];$workers=[];$readyFiles=[];$lockHeld=false;$lockName='';
$check=static function(bool $ok,string $name)use(&$checks):void{$checks[]=['pass'=>$ok,'check'=>$name];if(!$ok)throw new RuntimeException('FAIL '.$name);echo 'PASS '.$name.PHP_EOL;};
$user=static function(string $label)use($db,$token,&$uids):int{$email='web48-'.$label.'-'.$token.'@example.test';$db->run('INSERT INTO users(name,email,password_hash) VALUES(?,?,?)',['Web English synthetic fixture',$email,password_hash($token,PASSWORD_DEFAULT)]);$id=$db->lastId();$uids[$id]=$email;return $id;};
$catalogBook=static function(array $catalog):array{foreach($catalog as $book)if($book['code']==='english-for-web-a2-b1')return $book;throw new RuntimeException('Missing new catalog entry.');};
$snapshot=static function(int $uid,array $setIds)use($db):array{
    $marks=implode(',',array_fill(0,count($setIds),'?'));
    return [
        'sets'=>$db->all("SELECT * FROM flashcard_sets WHERE user_id=? AND id IN ({$marks}) ORDER BY id",[$uid,...$setIds]),
        'cards'=>$db->all("SELECT * FROM flashcards WHERE set_id IN ({$marks}) ORDER BY id",$setIds),
        'folders'=>$db->all('SELECT * FROM folders WHERE user_id=? ORDER BY id',[$uid]),
        'srs'=>$db->all("SELECT * FROM srs_progress WHERE user_id=? AND card_id IN (SELECT id FROM flashcards WHERE set_id IN ({$marks})) ORDER BY card_id",[$uid,...$setIds]),
        'events'=>$db->all("SELECT * FROM study_events WHERE user_id=? AND set_id IN ({$marks}) ORDER BY id",[$uid,...$setIds]),
        'mistake_v2'=>$db->all("SELECT * FROM mistake_book_v2 WHERE user_id=? AND card_id IN (SELECT id FROM flashcards WHERE set_id IN ({$marks})) ORDER BY id",[$uid,...$setIds]),
        'mistake_legacy'=>$db->all("SELECT * FROM mistake_book WHERE user_id=? AND card_id IN (SELECT id FROM flashcards WHERE set_id IN ({$marks})) ORDER BY id",[$uid,...$setIds]),
        'notebook'=>$db->all('SELECT * FROM learning_notebook_notes WHERE user_id=? ORDER BY id',[$uid]),
    ];
};
$hashes=static function(array $rows):array{$out=[];foreach($rows as $table=>$value)$out[$table]=hash('sha256',json_encode($value,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR));return $out;};
try{
    $uid=$user('owner');$other=$user('other');$concurrent=$user('concurrent');
    $class=new ReflectionClass(Repository::class);$method=$class->getMethod('flashcardBookSpecs');$method->setAccessible(true);$specs=$method->invoke($repo);
    $folder=$repo->createFolder($uid,'English cho sinh viên');$oldIds=[];
    foreach($specs as $code=>$spec){
        if($code==='english-for-web-a2-b1')continue;
        $set=$repo->createSet($uid,'Edited '.$code,'Personal fictional description',(int)$folder['id'],$spec['source_type']);$sid=(int)$set['id'];$oldIds[]=$sid;
        $card=$repo->createCard($uid,$sid,['term'=>'saved-'.$sid,'definition'=>'Nghĩa hư cấu riêng '.$sid,'ipa'=>'UK /seɪvd/','part_of_speech'=>'adjective','example_en'=>'This is a saved example.','example_vi'=>'Đây là ví dụ đã lưu.','notes'=>'Ghi chú riêng hư cấu.','card_type'=>'LISTENING','explanation'=>'Giải thích hư cấu riêng.']);$cid=(int)$card['id'];
        $db->run("INSERT INTO srs_progress(user_id,card_id,state,due_at,interval_days,repetitions,correct_reviews,total_reviews,last_rating) VALUES(?,?,'review','2030-01-01 09:00:00',7,4,3,4,3)",[$uid,$cid]);
        $db->run("INSERT INTO study_events(user_id,set_id,card_id,mode,result,score,xp) VALUES(?,?,?,'review',1,80,4)",[$uid,$sid,$cid]);
        $db->run("INSERT INTO mistake_book_v2(user_id,source_type,source_key,card_id,question,user_answer,correct_answer,explanation) VALUES(?,'flashcard',?,?,?,'saved','answer','Fictional retained feedback')",[$uid,'card:'.$cid,$cid,'Fictional question '.$cid]);
        $db->run("INSERT INTO mistake_book(user_id,card_id,module,wrong_count) VALUES(?,?,'review',2)",[$uid,$cid]);
    }
    $manual=$repo->createSet($uid,$specs['english-for-web-a2-b1']['title'],'Same-title manual fixture',(int)$folder['id'],'manual');$oldIds[]=(int)$manual['id'];
    $repo->createCard($uid,(int)$manual['id'],['term'=>'my own word','definition'=>'Từ riêng hư cấu','example_en'=>'This is my own word.','example_vi'=>'Đây là từ riêng của tôi.']);
    $db->run("INSERT INTO learning_notebook_notes(user_id,title,body,own_sentence,kind,is_pinned) VALUES(?,'Fictional private note','Giữ ghi chú cũ hư cấu.','I write my own sentence.','word',1)",[$uid]);
    $old=$snapshot($uid,$oldIds);$beforeSets=(int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=?',[$uid])['n'];
    $catalog=$catalogBook($repo->flashcardBooks($uid));
    $check(!$catalog['installed']&&$catalog['source_rows']===48&&$catalog['topic_count']===6,'fresh read-only catalog: new 48-card/6-topic book');
    $check($catalog['lesson_size']===8&&$catalog['lesson_count']===6&&$catalog['estimated_minutes']===10,'catalog six eight-card lessons and estimate10');
    $check($old===$snapshot($uid,$oldIds)&&$beforeSets===(int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=?',[$uid])['n'],'catalog preserves all old rows/counts');
    $denied=false;try{$repo->installFlashcardBook($uid,'not-a-real-book');}catch(InvalidArgumentException $error){$denied=true;}
    $check($denied&&$old===$snapshot($uid,$oldIds),'unknown install code rejected without writes');
    $first=$repo->installFlashcardBook($uid,'english-for-web-a2-b1');$sid=(int)$first['set_id'];
    $check(!$first['already_installed']&&$first['card_count']===48&&$first['topic_count']===6,'first install creates exactly48 cards/6 topics');
    $check($sid!==(int)$manual['id']&&(int)$repo->ownSet($uid,$sid)['folder_id']===(int)$folder['id'],'same-title manual book separate, existing owner folder reused');
    $cards=$db->all('SELECT * FROM flashcards WHERE set_id=? ORDER BY id',[$sid]);$cardIds=array_map('intval',array_column($cards,'id'));
    $check(count($cards)===48&&count(array_unique($cardIds))===48,'48 unique assigned new card IDs');
    $seed=json_decode(file_get_contents($root.'/assets/flashbooks/english-for-web-a2-b1/english-for-web-a2-b1.json'),true,512,JSON_THROW_ON_ERROR);
    $prompts=json_decode(file_get_contents($root.'/assets/flashbooks/english-for-web-a2-b1/practice-prompts.json'),true,512,JSON_THROW_ON_ERROR);$promptMap=[];
    foreach($prompts['prompts'] as $prompt)$promptMap[$prompt['lesson'].'|'.$prompt['term']]=$prompt['own_sentence_prompt'];
    $expected=[];
    foreach($seed['lessons'] as $i=>$lesson)foreach($lesson['cards'] as $card)$expected[]=array_merge(['ipa'=>'','pattern'=>'','collocations'=>'','word_family'=>''],$card,[
        'difficulty'=>$card['cefr']==='B1'?2:1,'topic'=>'English for Web','subtopic'=>$lesson['title'],'toeic_part'=>null,'notes'=>'Bài '.($i+1).' · '.$lesson['objective'],
        'explanation'=>$card['explanation']."\n\nThử dùng từ: ".$promptMap[($i+1).'|'.$card['term']],
        'audio_text'=>$card['example_en'],'tags'=>'english-for-web,a2-b1,lesson-'.($i+1),'source'=>'YangLingo English for Web · A2–B1']);
    $mapped=[];
    foreach($expected as $i=>$want){$got=[];foreach($want as $field=>$value){$got[$field]=$cards[$i][$field];if($got[$field]!==$value)throw new RuntimeException('Stored mapping mismatch '.$i.' '.$field);}$mapped[]=$got;}
    $check($mapped===$expected,'all48 stored content fields exactly match seed+consumed prompt mapping');
    $check(count(array_filter($cards,fn($c)=>str_starts_with($c['ipa'],'US /')))===20&&count(array_filter($cards,fn($c)=>$c['ipa']===''))===28,'20 exact sourced IPA/28 untouched blanks');
    $check(array_count_values(array_column($cards,'card_type'))===['VOCABULARY'=>38,'COLLOCATION'=>8,'LISTENING_CHUNK'=>2],'three authored genres retained');
    $check((int)$db->one('SELECT COUNT(*) n FROM srs_progress WHERE card_id IN (SELECT id FROM flashcards WHERE set_id=?)',[$sid])['n']===0,'installation creates no SRS progress');
    $again=$repo->installFlashcardBook($uid,'english-for-web-a2-b1');
    $check($again['already_installed']&&(int)$again['set_id']===$sid&&$again['card_count']===48,'repeat install same book ID');
    $check($cards===$db->all('SELECT * FROM flashcards WHERE set_id=? ORDER BY id',[$sid]),'repeat keeps every card field/ID/timestamp');
    $lessons=$repo->studyLessons($uid,$sid,20);$check(count($lessons)===6&&array_unique(array_column($lessons,'card_count'))===[8],'study API6x8 overrides default20');$allLessonIds=[];
    foreach($lessons as $i=>$lesson){
        $detail=$repo->studyLessonCards($uid,$sid,$i+1,20);
        $check($lesson['title']===$seed['lessons'][$i]['title']&&$lesson['objective']===$seed['lessons'][$i]['objective']&&$detail['count']===8&&$lesson['estimated_minutes']===10&&$detail['estimated_minutes']===10,'lesson '.($i+1).' title/objective/eightcards/minutes');
        $check($detail['speaking_prompt']===$seed['lessons'][$i]['speaking_prompt']&&$detail['speaking_model']===$seed['lessons'][$i]['speaking_model'],'lesson '.($i+1).' exact speaking metadata');
        $allLessonIds=array_merge($allLessonIds,array_map('intval',array_column($detail['cards'],'id')));
    }
    $check($allLessonIds===$cardIds,'lesson IDs/order exact and no extra cards');
    $check($repo->studyLessonCards($uid,$sid,7)['cards']===[],'beyond final lesson returns no cards');
    foreach(['daily-essentials-a1-a2'=>8,'student-life-work-a2-b1'=>10,'everyday-english-a1-a2'=>10] as $code=>$size){
        $found=$db->one('SELECT id FROM flashcard_sets WHERE user_id=? AND source_type=?',[$uid,$specs[$code]['source_type']]);$oldLesson=$repo->studyLessons($uid,(int)$found['id'],20);$oldDetail=$repo->studyLessonCards($uid,(int)$found['id'],1,20);
        $check($oldLesson[0]['estimated_minutes']===8&&$oldDetail['estimated_minutes']===8,'unchanged old estimate8 for '.$code);
    }
    $sync=$repo->ensureFlashcardBooksInstalled($uid);
    $check($sync['complete']&&$sync['created_count']===0&&$sync['updated_count']===0&&$sync['added_cards']===0,'sync does not append/reset existing books');
    $check((int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=? AND source_type=?',[$uid,'english_for_web_a2_b1_book'])['n']===1,'owner/source exactly one book');
    $check(!$catalogBook($repo->flashcardBooks($other))['installed'],'other owner catalog has no inherited installation');
    $otherFirst=$repo->installFlashcardBook($other,'english-for-web-a2-b1');$otherSid=(int)$otherFirst['set_id'];
    $check($otherSid!==$sid&&$otherFirst['card_count']===48,'other owner separate full book');
    $check((int)$db->one('SELECT COUNT(*) n FROM folders WHERE user_id=? AND name=?',[$other,'English cho sinh viên'])['n']===1,'other owner receives exactly one new folder');
    foreach(['studyLessonCards','studyLessons','getSet'] as $method){$denied=false;try{$repo->$method($other,$sid,1);}catch(RuntimeException $error){$denied=true;}$check($denied,'cross-owner '.$method.' denied');}
    $edited=$cardIds[0];$db->run('UPDATE flashcards SET definition=?,notes=? WHERE id=?',['Nghĩa tự sửa hư cấu','Ghi chú người học hư cấu',$edited]);
    $db->run("INSERT INTO srs_progress(user_id,card_id,state,due_at,repetitions,interval_days) VALUES(?,?,'mastered','2031-01-02 10:00:00',9,18)",[$uid,$edited]);
    $editedSnapshot=$snapshot($uid,[$sid]);$repo->installFlashcardBook($uid,'english-for-web-a2-b1');$repo->ensureFlashcardBooksInstalled($uid);$repo->flashcardBooks($uid);
    $check($editedSnapshot===$snapshot($uid,[$sid]),'later learner edit/SRS retained by repeat/catalog/sync');
    $repo->deleteCard($uid,$cardIds[47]);$deletedSnapshot=$snapshot($uid,[$sid]);$partial=$repo->installFlashcardBook($uid,'english-for-web-a2-b1');$repo->ensureFlashcardBooksInstalled($uid);$partialCatalog=$catalogBook($repo->flashcardBooks($uid));
    $check($partial['already_installed']&&(int)$partial['set_id']===$sid&&$partial['card_count']===47&&$partialCatalog['missing_count']===1&&$deletedSnapshot===$snapshot($uid,[$sid]),'deleted learner card is not silently restored or duplicated');
    $check($old===$snapshot($uid,$oldIds),'all old full rows preserved including both mistakes/notebook');
    $lockName='yanglingo:flashbooks:'.$concurrent;$lockHeld=(int)$db->one('SELECT GET_LOCK(?,10) acquired',[$lockName])['acquired']===1;if(!$lockHeld)throw new RuntimeException('Cannot acquire concurrency lock.');
    $phpArgs=json_decode((string)(getenv('YL_TEST_PHP_ARGS')?:'[]'),true,512,JSON_THROW_ON_ERROR);if(!is_array($phpArgs)||!array_is_list($phpArgs)||count(array_filter($phpArgs,'is_string'))!==count($phpArgs))throw new RuntimeException('Invalid PHP flags.');
    for($i=0;$i<2;$i++){
        $ready=dirname($configPath).'/web48-ready-'.bin2hex(random_bytes(6)).'.txt';$readyFiles[]=$ready;$pipes=[];$env=getenv();$env['YL_TEST_CONFIG_PATH']=$configPath;
        $process=proc_open([PHP_BINARY,...$phpArgs,__DIR__.'/web_english_install_worker.php',(string)$concurrent,$ready],[0=>['pipe','r'],1=>['pipe','w'],2=>['pipe','w']],$pipes,null,$env,['bypass_shell'=>true]);
        if(!is_resource($process))throw new RuntimeException('Cannot start worker.');fclose($pipes[0]);$workers[]=['process'=>$process,'pipes'=>$pipes];
    }
    $deadline=microtime(true)+5;while(microtime(true)<$deadline&&count(array_filter($readyFiles,'is_file'))!==2)usleep(20000);
    $check(count(array_filter($readyFiles,'is_file'))===2,'two concurrent workers reach held owner lock');$db->one('SELECT RELEASE_LOCK(?) released',[$lockName]);$lockHeld=false;$results=[];
    foreach($workers as $worker){$out=stream_get_contents($worker['pipes'][1]);$err=stream_get_contents($worker['pipes'][2]);fclose($worker['pipes'][1]);fclose($worker['pipes'][2]);$exit=proc_close($worker['process']);if($exit!==0)throw new RuntimeException('Concurrent fixture failed: '.$err);$results[]=json_decode(trim($out),true,512,JSON_THROW_ON_ERROR);}$workers=[];
    $check((int)$results[0]['set_id']===(int)$results[1]['set_id']&&$results[0]['already_installed']!==$results[1]['already_installed'],'concurrent installs return one stable book ID');
    $conSid=(int)$results[0]['set_id'];$check((int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=? AND source_type=?',[$concurrent,'english_for_web_a2_b1_book'])['n']===1&&(int)$db->one('SELECT COUNT(*) n FROM flashcards WHERE set_id=?',[$conSid])['n']===48,'concurrency creates exactly one book/48 cards');
    $check($old===$snapshot($uid,$oldIds),'other-owner concurrency preserves old learner rows');
    $report=['pass'=>true,'checks'=>$checks,'check_count'=>count($checks),'old_before_sha256'=>$hashes($old),'old_after_sha256'=>$hashes($snapshot($uid,$oldIds)),
        'expected_new_mapping_sha256'=>hash('sha256',json_encode($expected,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR)),'actual_new_mapping_sha256'=>hash('sha256',json_encode($mapped,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR)),
        'cards'=>48,'lessons'=>6,'rows_fixture_only'=>true,'concurrent_results'=>$results,'shared_or_live_mutation'=>false];
    $reportPath=(string)getenv('YL_TEST_REPORT_PATH');if($reportPath!=='')file_put_contents($reportPath,json_encode($report,JSON_UNESCAPED_UNICODE|JSON_PRETTY_PRINT|JSON_THROW_ON_ERROR).PHP_EOL);
}finally{
    if($lockHeld)$db->one('SELECT RELEASE_LOCK(?) released',[$lockName]);
    foreach($workers as $worker){foreach($worker['pipes'] as $pipe)if(is_resource($pipe))fclose($pipe);if(is_resource($worker['process'])){proc_terminate($worker['process']);proc_close($worker['process']);}}
    foreach($readyFiles as $path)if(is_file($path))unlink($path);
    foreach($uids as $id=>$email)$db->run('DELETE FROM users WHERE id=? AND email=?',[$id,$email]);
}
echo 'WEB ENGLISH INSTALL PASS: '.count($checks).' checks'.PHP_EOL;
