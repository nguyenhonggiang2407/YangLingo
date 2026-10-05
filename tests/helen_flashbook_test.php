<?php
declare(strict_types=1);
$root=dirname(__DIR__);require_once $root.'/lib/compat.php';$csv=$root.'/assets/handbooks/helen-toeic-part1-vocabulary.csv';
if(!is_file($csv)){fwrite(STDERR,"Missing HELEN CSV\n");exit(1);} $h=fopen($csv,'rb');fgetcsv($h);$rows=0;$topics=[];$terms=[];
while(($r=fgetcsv($h))!==false){$r=array_pad($r,6,'');if(trim((string)$r[2])==='')continue;$rows++;$topics[trim((string)$r[0])]=1;$terms[]=mb_strtolower(trim((string)$r[2]));}fclose($h);
$repo=file_get_contents($root.'/lib/Repository.php');$api=file_get_contents($root.'/api.php');$app=file_get_contents($root.'/assets/app.js');$index=file_get_contents($root.'/index.php');
$checks=[
  'source rows'=>($rows===141), 'topics'=>(count($topics)===7), 'unique terms'=>(count(array_unique($terms))===140),
  'repo catalog'=>str_contains($repo,'function flashcardBooks'), 'repo installer'=>str_contains($repo,'function installFlashcardBook'),
  'api catalog'=>str_contains($api,"action==='flashcard_books'"), 'api installer'=>str_contains($api,"action==='flashcard_book_install'"),
  'route'=>str_contains($app,"route==='flashbooks'"), 'view'=>str_contains($app,'function flashcardBooksView'), 'nav'=>str_contains($index,'#flashbooks'), 'handbook crosslink'=>str_contains($app,'Học bằng Flashcard'),
  '141 source'=>str_contains($repo,"'source_type'=>'helen_part1_book'") && str_contains($repo,"'toeic_part'=>1"),
  'vietnamese categories'=>str_contains($repo,'Quan sát & Hành động bằng mắt')&&str_contains($repo,'Trạng thái & Sắp xếp đồ vật')
];
$bad=[];foreach($checks as $k=>$ok){echo ($ok?'PASS ':'FAIL ').$k."\n";if(!$ok)$bad[]=$k;}if($bad)exit(1);echo "HELEN FLASHBOOK OK rows={$rows} topics=".count($topics)." unique_terms=".count(array_unique($terms))."\n";
