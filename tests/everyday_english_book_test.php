<?php
declare(strict_types=1);
require_once dirname(__DIR__).'/lib/Repository.php';

function expectBook(bool $condition,string $message): void {
    if(!$condition){fwrite(STDERR,"FAIL: {$message}\n");exit(1);}
}

// Content and lesson configuration checks run without touching any learner database.
$class=new ReflectionClass(Repository::class);
$repo=$class->newInstanceWithoutConstructor();
$read=$class->getMethod('everydayEnglishFlashbook');
$rowsMethod=$class->getMethod('everydayEnglishFlashbookRows');
$settingsMethod=$class->getMethod('flashbookLessonSettings');
foreach([$read,$rowsMethod,$settingsMethod] as $method)$method->setAccessible(true);
$book=$read->invoke($repo);
$rows=$rowsMethod->invoke($repo);
expectBook($book['code']==='everyday-english-a1-a2'&&$book['source_type']==='everyday_english_a1_a2_book','new book has a distinct identity');
expectBook($book['folder_name']==='English hằng ngày','new book uses its own folder');
expectBook(count($rows)===60&&count($book['lessons'])===6,'60 cards across six short lessons');
$terms=[];$topics=[];
foreach($rows as $row){
    foreach(['term','definition','example_en','example_vi','explanation'] as $field)expectBook(trim((string)$row[$field])!=='',$row['term'].' has '.$field);
    $key=mb_strtolower(trim($row['term']));
    expectBook(!isset($terms[$key]),'unique term '.$row['term']);$terms[$key]=true;
    expectBook(mb_stripos($row['example_en'],$row['term'])!==false,'example supports cloze for '.$row['term']);
    expectBook(in_array($row['cefr'],['A1','A2'],true),'beginner level for '.$row['term']);
    expectBook(in_array($row['card_type'],['VOCABULARY','COLLOCATION','SENTENCE_PATTERN','LISTENING_CHUNK'],true),'supported card type for '.$row['term']);
    $topics[$row['subtopic']]=($topics[$row['subtopic']]??0)+1;
}
expectBook(count($topics)===6&&array_unique(array_values($topics))===[10],'each topic contains ten cards');
$newSettings=$settingsMethod->invoke($repo,['source_type'=>$book['source_type']],20);
expectBook($newSettings['size']===10&&count($newSettings['lessons'])===6,'default API size resolves to ten for the new book');
$oldSettings=$settingsMethod->invoke($repo,['source_type'=>'verb_irregular_800_book'],20);
expectBook($oldSettings['size']===20&&$oldSettings['lessons']===[],'old book keeps its original lesson grouping');
$customSettings=$settingsMethod->invoke($repo,['source_type'=>'manual'],30);
expectBook($customSettings['size']===30,'manual sets keep their requested lesson grouping');

// Guard against reintroducing the old automatic content refresh path.
$source=file_get_contents(dirname(__DIR__).'/lib/Repository.php');
expectBook(!str_contains($source,'syncInstalledFlashcardBook')&&!str_contains($source,"'refresh_existing'=>true"),'catalog sync cannot rewrite old book content');
expectBook(str_contains($source,'GET_LOCK(?,10)')&&str_contains($source,'RELEASE_LOCK(?)'),'installation serializes concurrent requests');
echo "EVERYDAY ENGLISH BOOK OK\n";
