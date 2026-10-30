<?php
declare(strict_types=1);
$root=dirname(__DIR__);
function csvRows(string $path): array {
    if(!is_file($path))throw new RuntimeException('Missing '.$path);
    $h=fopen($path,'rb');$header=fgetcsv($h);$header=array_map(static fn($v)=>trim(preg_replace('/^\xEF\xBB\xBF/','',(string)$v)??(string)$v),$header);$idx=array_flip($header);$rows=[];
    while(($r=fgetcsv($h))!==false){$row=[];foreach($idx as $k=>$i)$row[$k]=trim((string)($r[$i]??''));if(($row['term']??'')!=='')$rows[]=$row;}fclose($h);return $rows;
}
$core=csvRows($root.'/assets/flashbooks/toeic-irregular-verbs-core-v33.csv');
$ext=csvRows($root.'/assets/flashbooks/toeic-irregular-verbs-extended-v33.csv');
$repo=file_get_contents($root.'/lib/Repository.php');$app=file_get_contents($root.'/assets/app.js');$sw=file_get_contents($root.'/service-worker.js');$index=file_get_contents($root.'/index.php');
preg_match('/assets\/app\.js\?v=(\d+)/',$index,$assetRevision);
preg_match('/yanglingo-static-v(\d+)/',$sw,$cacheRevision);
$map=[];foreach(array_merge($core,$ext) as $r){$k=strtolower($r['term']);$map[$k]=$r;}
$terms=array_map(static fn($r)=>strtolower($r['term']),array_merge($core,$ext));
$checks=[
 'core count'=>count($core)===120,
 'extended count'=>count($ext)===40,
 '160 unique'=>count($terms)===160&&count(array_unique($terms))===160,
 'be included'=>isset($map['be'])&&str_contains($map['be']['pattern'],'was/were')&&str_contains($map['be']['pattern'],'been'),
 'oversee included'=>isset($map['oversee'])&&$map['oversee']['pattern']==='oversee → oversaw → overseen',
 'overlook excluded from irregular'=>!isset($map['overlook']),
 'all meanings'=>count(array_filter(array_merge($core,$ext),static fn($r)=>($r['definition']??'')===''))===0,
 'all patterns'=>count(array_filter(array_merge($core,$ext),static fn($r)=>substr_count((string)($r['pattern']??''),'→')!==2))===0,
 'repo core source'=>str_contains($repo,"toeic-irregular-verbs-core-v33.csv',120"),
 'repo extended source'=>str_contains($repo,"toeic-irregular-verbs-extended-v33.csv',40"),
 'existing content is preserved'=>!str_contains($repo,'syncInstalledFlashcardBook')&&!str_contains($repo,"'refresh_existing'=>true"),
 'preserve ids'=>!str_contains($repo,"DELETE FROM flashcards WHERE set_id=?")&&!str_contains($repo,'UPDATE flashcards SET definition='),
 'read-only integrity status'=>str_contains($repo,'missing_count')&&str_contains($repo,'extra_count')&&str_contains($repo,'flashcardBookIntegrityForSet'),
 'oversee overlook trap'=>str_contains($repo,"['oversee vs overlook'")&&str_contains($repo,'oversee–oversaw–overseen'),
 'asset and cache revisions match'=>isset($assetRevision[1],$cacheRevision[1])&&$assetRevision[1]===$cacheRevision[1],
];
$bad=[];foreach($checks as $k=>$ok){echo ($ok?'PASS ':'FAIL ').$k."\n";if(!$ok)$bad[]=$k;}
if($bad)exit(1);
echo "IRREGULAR VERBS V33 OK: core=120 extended=40 unique=160\n";
