<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$app=file_get_contents($root.'/assets/app.js');
$api=file_get_contents($root.'/api.php');
$repo=file_get_contents($root.'/lib/Repository.php');
$index=file_get_contents($root.'/index.php');
$sw=file_get_contents($root.'/service-worker.js');
preg_match('/assets\/app\.js\?v=(\d+)/',$index,$assetRevision);
preg_match('/yanglingo-static-v(\d+)/',$sw,$cacheRevision);
$checks=[
 'selected set enters lesson mode'=>str_contains($app,"const lessonMode=!!sid&&!!current&&!context.reviewOnly"),
 'lesson mode bypasses due queue'=>str_contains($app,"mode:lessonMode?'lesson':'review'")&&str_contains($app,"lessonMode?lessonQuery(current):{}"),
 'api returns exact lesson slice'=>str_contains($api,"if(\$mode==='lesson')")&&str_contains($api,'studyLessonCards($uid,$set,$unit,20)'),
 'repository slices 20 by unit'=>str_contains($repo,'private function lessonCardIds')&&str_contains($repo,'$offset=($unit-1)*$size')&&str_contains($repo,"'title'=>'Bài '.\$unit"),
 'lesson navigator label'=>str_contains($app,"Danh sách từ của bài học")&&str_contains($app,"Bài này có đủ '+cards.length+' thẻ"),
 'lesson progress mode label'=>str_contains($app,'Chế độ bài học · đủ ${cards.length}/${cards.length} thẻ'),
 'direct review remains SRS due'=>str_contains($app,"priorityMode?priorityLabels[priorityMode]:'Danh sách thẻ SRS đến hạn'"),
 'same-route lesson start rerenders'=>str_contains($app,"if(routeName()==='review')reviewView({setId:String(setId),lesson});else navigate('review');"),
 'asset and cache revisions match'=>isset($assetRevision[1],$cacheRevision[1])&&$assetRevision[1]===$cacheRevision[1]
];
$bad=[];foreach($checks as $name=>$ok){echo ($ok?'PASS ':'FAIL ').$name."\n";if(!$ok)$bad[]=$name;}
if($bad)exit(1);
echo "LESSON FULL SESSION OK\n";
