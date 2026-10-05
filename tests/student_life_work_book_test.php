<?php
declare(strict_types=1);
require_once dirname(__DIR__).'/lib/Repository.php';
function studentExpect(bool $pass,string $message): void {if(!$pass){fwrite(STDERR,'FAIL '.$message.PHP_EOL);exit(1);}}
$class=new ReflectionClass(Repository::class);$repo=$class->newInstanceWithoutConstructor();
$methods=[];foreach(['studentLifeFlashbook','studentLifeFlashbookRows','everydayEnglishFlashbookRows','flashbookLessonSettings','flashcardBookSpecs'] as $name){$methods[$name]=$class->getMethod($name);$methods[$name]->setAccessible(true);}
$book=$methods['studentLifeFlashbook']->invoke($repo);$rows=$methods['studentLifeFlashbookRows']->invoke($repo);
studentExpect(count($rows)===120&&count($book['lessons'])===12,'120 cards in 12 short lessons');
$oldKeys=array_map(fn($r)=>mb_strtolower(trim($r['term'])),$methods['everydayEnglishFlashbookRows']->invoke($repo));
$keys=[];
foreach($rows as $row){
    foreach(['term','definition','example_en','example_vi','explanation','cefr','notes','audio_text','source'] as $field)studentExpect(trim((string)($row[$field]??''))!=='','required content '.$field.' for '.$row['term']);
    $key=mb_strtolower(trim($row['term']));studentExpect(!isset($keys[$key])&&!in_array($key,$oldKeys,true),'distinct new word '.$row['term']);$keys[$key]=true;
    studentExpect(mb_stripos($row['example_en'],$row['term'])!==false,'example supports recall in context');
    studentExpect(in_array($row['card_type'],['VOCABULARY','COLLOCATION','SENTENCE_PATTERN','LISTENING_CHUNK'],true),'valid card type');
    studentExpect(in_array($row['cefr'],['A2','B1'],true),'valid suggested level');
}
$settings=$methods['flashbookLessonSettings']->invoke($repo,['source_type'=>$book['source_type']],20);
studentExpect($settings['size']===10&&count($settings['lessons'])===12,'new book grouping');
$legacy=$methods['flashbookLessonSettings']->invoke($repo,['source_type'=>'manual'],30);
studentExpect($legacy['size']===30&&$legacy['lessons']===[],'personal book grouping stays unchanged');
$catalog=$methods['flashcardBookSpecs']->invoke($repo);
studentExpect(isset($catalog['student-life-work-a2-b1'],$catalog['everyday-english-a1-a2']),'new and previous books both available');
studentExpect($catalog['student-life-work-a2-b1']['source_type']!==$catalog['everyday-english-a1-a2']['source_type'],'separate book identity');
echo 'STUDENT LIFE & WORK CONTENT PASS'.PHP_EOL;
