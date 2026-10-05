<?php
declare(strict_types=1);
$root=dirname(__DIR__);
if(!is_file($root.'/lib/compat.php')){fwrite(STDOUT,"NOT EXECUTED: overwrite package does not contain lib/compat.php; run this test on the full production tree.\n");exit(2);}
require_once $root.'/lib/compat.php';
function csvStats(string $path): array {
    if(!is_file($path)) throw new RuntimeException('Missing '.$path);
    $h=fopen($path,'rb'); $header=fgetcsv($h); if(!is_array($header)) throw new RuntimeException('Bad header');
    $header=array_map(static function($v){$v=(string)$v;return trim(preg_replace('/^\xEF\xBB\xBF/','',$v)??$v);},$header);
    $idx=array_flip($header); $rows=0;$terms=[];$topics=[];
    while(($r=fgetcsv($h))!==false){$term=trim((string)($r[$idx['term']??-1]??''));if($term==='')continue;$rows++;$terms[]=mb_strtolower($term);$t=trim((string)($r[$idx['subtopic']??-1]??''));if($t!=='')$topics[$t]=1;}
    fclose($h); return [$rows,count(array_unique($terms)),count($topics)];
}
[$verbRows,$verbUnique,$verbTopics]=csvStats($root.'/assets/flashbooks/toeic-verb-master-800-flashcards.csv');
[$listenRows,$listenUnique,$listenTopics]=csvStats($root.'/assets/flashbooks/toeic-listening-vocab-800-flashcards.csv');
[$grammarRows,$grammarUnique,$grammarTopics]=csvStats($root.'/assets/flashbooks/toeic-grammar-800-flashcards.csv');
$repo=file_get_contents($root.'/lib/Repository.php');$app=file_get_contents($root.'/assets/app.js');$index=file_get_contents($root.'/index.php');$sw=file_get_contents($root.'/service-worker.js');
preg_match('/assets\/app\.js\?v=(\d+)/',$index,$assetRevision);
preg_match('/yanglingo-static-v(\d+)/',$sw,$cacheRevision);
$checks=[
 'verb rows'=>($verbRows===337),'verb unique'=>($verbUnique===337),'verb topics'=>($verbTopics>=8),
 'listening rows'=>($listenRows===85),'listening unique'=>($listenUnique===84),'listening topics'=>($listenTopics>=8),
 'grammar rows'=>($grammarRows===233),'grammar unique'=>($grammarUnique===231),'grammar topics'=>($grammarTopics>=12),
 'section book specs'=>str_contains($repo,"'helen-part1-flashcards'")&&str_contains($repo,"'verb-5-1-business-flashcards'")&&str_contains($repo,"'verb-5-4-operations-flashcards'")&&str_contains($repo,"'listening-vocab-800-flashcards'")&&str_contains($repo,"'grammar-800-flashcards'"),
 'source types'=>str_contains($repo,"'verb_5_1_business_book'")&&str_contains($repo,"'verb_5_4_ops_book'")&&str_contains($repo,"'listening_vocab_800_book'")&&str_contains($repo,"'grammar_800_book'"),
 'pdf data loaders'=>str_contains($repo,"toeic-verb-master-800-flashcards.csv")&&str_contains($repo,"toeic-listening-vocab-800-flashcards.csv")&&str_contains($repo,"toeic-grammar-800-flashcards.csv"),
 'renamed folder'=>str_contains($repo,'Bộ Flashcard TOEIC 800+')&&str_contains($repo,'TOEIC Flashcard Books'),
 'dynamic UI count'=>str_contains($app,'data-source-rows')&&str_contains($app,'b.source_rows'),
 'dynamic source handbook'=>str_contains($app,'b.source_handbook_code'),
 'all handbook crosslinks'=>str_contains($app,"['grammar-800','listening-800','verb-800','helen-part1-vocab']"),
 'book catalog navigation'=>str_contains($index,'href="#flashbooks"')&&str_contains($index,'Khám phá book'),
 'asset and cache revisions match'=>isset($assetRevision[1],$cacheRevision[1])&&$assetRevision[1]===$cacheRevision[1],
];
$bad=[];foreach($checks as $k=>$ok){echo ($ok?'PASS ':'FAIL ').$k."\n";if(!$ok)$bad[]=$k;}
if($bad)exit(1);
echo "PDF FLASHBOOKS OK verb={$verbRows} listening={$listenRows} grammar={$grammarRows} total=".($verbRows+$listenRows+$grammarRows)."\n";
