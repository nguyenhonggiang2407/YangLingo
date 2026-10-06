<?php
declare(strict_types=1);
// Explicit isolated local database only; never reads production configuration.
$cfg=['host'=>getenv('YL_TEST_DB_HOST')?:'127.0.0.1','port'=>(int)(getenv('YL_TEST_DB_PORT')?:3306),'name'=>getenv('YL_TEST_DB_NAME')?:'','user'=>getenv('YL_TEST_DB_USER')?:'','pass'=>getenv('YL_TEST_DB_PASS')?:''];
if(!in_array($cfg['host'],['127.0.0.1','localhost'],true)||!preg_match('/^[a-zA-Z0-9_]+_(qa|test)$/',$cfg['name'])||$cfg['user']===''){
    fwrite(STDERR,"NOT EXECUTED: set YL_TEST_DB_* for an isolated local database ending _qa or _test.\n");exit(2);
}
$root=dirname(__DIR__);require $root.'/lib/Database.php';require $root.'/lib/Repository.php';
$db=new Database($cfg,$root.'/database/schema.sql');$pdo=$db->pdo();$repo=new Repository($db);
$tables=['users','flashcard_sets','flashcards','srs_progress','study_events'];$counts=[];
foreach($tables as $t)$counts[$t]=(int)$pdo->query("SELECT COUNT(*) FROM `{$t}`")->fetchColumn();
$pdo->beginTransaction();$checks=0;
function verifyType(bool $ok,string $message): void {global $checks;if(!$ok)throw new RuntimeException($message);$checks++;}
try{
    $insert=$pdo->prepare('INSERT INTO users(name,email,password_hash) VALUES(?,?,?)');
    $insert->execute(['Type test','types-'.bin2hex(random_bytes(6)).'@example.test',password_hash('FictionalTest!2026',PASSWORD_DEFAULT)]);$uid=(int)$pdo->lastInsertId();
    $s=$pdo->prepare('INSERT INTO flashcard_sets(user_id,title) VALUES(?,?)');$s->execute([$uid,'Type regression fixture']);$sid=(int)$pdo->lastInsertId();
    foreach(['VOCABULARY','COLLOCATION','SENTENCE_PATTERN','GRAMMAR','LISTENING','LISTENING_CHUNK','MISTAKE_CARD'] as $type){
        $input=['term'=>'listen','definition'=>'nghe','card_type'=>$type,'example_en'=>'Listen to the announcement.','example_vi'=>'Hãy nghe thông báo.','audio_text'=>'Listen to the announcement.'];
        $card=$repo->createCard($uid,$sid,$input);verifyType($card['card_type']===$type,'Create changed type '.$type);
        $updated=$repo->updateCard($uid,(int)$card['id'],array_merge($card,['example_vi'=>'Hãy lắng nghe thông báo.']));
        verifyType($updated['card_type']===$type,'Editing a translation changed type '.$type);
        verifyType($updated['audio_text']===$input['audio_text'],'Audio text changed');
        verifyType((int)$updated['id']===(int)$card['id']&&(int)$updated['set_id']===$sid,'Card identity changed');
        try{$repo->updateCard($uid+1000000,(int)$card['id'],$updated);throw new LogicException('Foreign edit allowed');}catch(RuntimeException $expected){verifyType($expected->getMessage()==='Không tìm thấy flashcard.','Wrong ownership rejection');}
    }
}finally{if($pdo->inTransaction())$pdo->rollBack();}
foreach($counts as $t=>$n)verifyType((int)$pdo->query("SELECT COUNT(*) FROM `{$t}`")->fetchColumn()===$n,'Fixture rows were not rolled back');
echo "CARD TYPE PRESERVATION PASS {$checks} checks; fixture rolled back.\n";
