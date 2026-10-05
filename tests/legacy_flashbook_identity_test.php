<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$configPath=(string)getenv('YL_TEST_CONFIG_PATH');
if($configPath===''||!is_file($configPath)){fwrite(STDERR,"NOT EXECUTED: set YL_TEST_CONFIG_PATH to an isolated local test configuration.\n");exit(2);}
$config=require $configPath;$cfg=$config['db']??[];
if(!in_array($cfg['host']??'',['127.0.0.1','localhost','::1'],true)||!preg_match('/(?:_qa|_test)$/',(string)($cfg['name']??'')))throw new RuntimeException('This regression test requires an isolated local QA/test database.');
require_once $root.'/lib/compat.php';
require_once $root.'/lib/Database.php';
require_once $root.'/lib/Repository.php';
$db=new Database($cfg,$root.'/database/schema.sql');$repo=new Repository($db);
$token=bin2hex(random_bytes(8));
$db->run('INSERT INTO users(name,email,password_hash) VALUES(?,?,?)',['Legacy book regression','legacy-'.$token.'@example.test',password_hash($token,PASSWORD_DEFAULT)]);
$uid=$db->lastId();
$code='verb-irregular-extended-flashcards';$source='verb_irregular_extended_800_book';$alias=substr($source,0,30);
$fail=[];
$check=function(bool $ok,string $name)use(&$fail):void{echo ($ok?'PASS ':'FAIL ').$name.PHP_EOL;if(!$ok)$fail[]=$name;};
try{
    $legacyIds=[];
    for($i=1;$i<=2;$i++){
        $set=$repo->createSet($uid,'Legacy Extended '.$i,'Old learner content',null,$alias);$sid=(int)$set['id'];$legacyIds[]=$sid;
        $card=$repo->createCard($uid,$sid,['term'=>'learn','definition'=>'ghi chú riêng cũ '.$i,'example_en'=>'I learn every day.','example_vi'=>'Tôi học mỗi ngày.']);
        $db->run("INSERT INTO srs_progress(user_id,card_id,state,due_at,interval_days,repetitions) VALUES(?,?,'review','2030-01-01 09:00:00',6,3)",[$uid,(int)$card['id']]);
    }
    $legacySets=$db->all('SELECT * FROM flashcard_sets WHERE user_id=? AND source_type=? ORDER BY id',[$uid,$alias]);
    $legacyCards=$db->all('SELECT c.* FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE s.user_id=? AND s.source_type=? ORDER BY c.id',[$uid,$alias]);
    $legacyProgress=$db->all('SELECT * FROM srs_progress WHERE user_id=? ORDER BY card_id',[$uid]);
    $expectedId=max($legacyIds);
    $first=$repo->installFlashcardBook($uid,$code);$again=$repo->installFlashcardBook($uid,$code);
    $check(!empty($first['already_installed'])&&(int)$first['set_id']===$expectedId,'installer recognizes the latest truncated legacy book');
    $check(!empty($again['already_installed'])&&(int)$again['set_id']===$expectedId,'reinstall preserves the legacy book ID');
    $findBook=static function(array $books)use($code):array{foreach($books as $book)if($book['code']===$code)return $book;throw new RuntimeException('Catalog book missing.');};
    $catalog=$findBook($repo->flashcardBooks($uid));
    $check(!empty($catalog['installed'])&&(int)$catalog['set_id']===$expectedId,'catalog recognizes the latest truncated legacy book');
    $sync=$repo->ensureFlashcardBooksInstalled($uid);
    $newExtended=array_filter($sync['created'],static fn(array $book):bool=>$book['code']===$code);
    $existingExtended=array_values(array_filter($sync['existing'],static fn(array $book):bool=>$book['code']===$code));
    $check(!empty($sync['complete'])&&!$newExtended&&count($existingExtended)===1&&(int)$existingExtended[0]['set_id']===$expectedId,'sync reuses legacy identity without creating another Extended book');
    $check((int)$db->one('SELECT COUNT(*) n FROM flashcard_sets WHERE user_id=? AND (source_type=? OR source_type=?)',[$uid,$source,$alias])['n']===2,'two historical duplicate rows remain exactly two');
    $check($legacySets===$db->all('SELECT * FROM flashcard_sets WHERE user_id=? AND source_type=? ORDER BY id',[$uid,$alias]),'legacy set rows and source values remain unchanged');
    $check($legacyCards===$db->all('SELECT c.* FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE s.user_id=? AND s.source_type=? ORDER BY c.id',[$uid,$alias]),'legacy cards and IDs remain unchanged');
    $check($legacyProgress===$db->all('SELECT * FROM srs_progress WHERE user_id=? ORDER BY card_id',[$uid]),'legacy SRS remains unchanged');
    $exact=$repo->createSet($uid,'Exact Extended fixture','Test only',null,$source);
    $check((int)$repo->installFlashcardBook($uid,$code)['set_id']===(int)$exact['id'],'newer exact source takes precedence by ID');
    $newestAlias=$repo->createSet($uid,'Newest legacy fixture','Test only',null,$alias);
    $check((int)$repo->installFlashcardBook($uid,$code)['set_id']===(int)$newestAlias['id']&&(int)$findBook($repo->flashcardBooks($uid))['set_id']===(int)$newestAlias['id'],'newer legacy source also takes precedence by ID');
}finally{
    // Remove only this synthetic local test learner and its fixture rows.
    $db->run('DELETE FROM users WHERE id=? AND email=?',[$uid,'legacy-'.$token.'@example.test']);
}
if($fail)exit(1);
echo "LEGACY FLASHBOOK IDENTITY PASS\n";
