<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$repo=file_get_contents($root.'/lib/Repository.php');
$app=file_get_contents($root.'/assets/app.js');
$api=file_get_contents($root.'/api.php');
$index=file_get_contents($root.'/index.php');
$sw=file_get_contents($root.'/service-worker.js');
preg_match('/assets\/app\.js\?v=(\d+)/',$index,$assetRevision);
preg_match('/yanglingo-static-v(\d+)/',$sw,$cacheRevision);
$checks=[];
$order=['srs','relearning','mistake_review','weak_skill','hard_cards','listening','toeic','collocation','sentence_pattern','new_knowledge'];
$last=-1;foreach($order as $key){$pos=strpos($repo,"['key'=>'{$key}'");$checks['priority '.$key]=$pos!==false&&$pos>$last;if($pos!==false)$last=$pos;}
$checks['dedicated priority queues']=str_contains($repo,"public function priorityCards")&&str_contains($api,"['due','relearning','hard','new']")&&str_contains($app,"priorityMode=['due','relearning','hard','new']");
$checks['daily plan TOEIC focus']=str_contains($repo,"'label'=>'TOEIC Practice'")&&!str_contains($repo,"'label'=>'TOEIC / Aptis practice'");
$checks['part5 step-by-step explanation']=str_contains($repo,"'part5_analysis'=>")&&str_contains($app,'Phân tích Part 5 từng bước')&&str_contains($repo,"'title'=>'Loại đáp án sai'");
$checks['weakness has real TOEIC accuracy']=str_contains($repo,"source_dimension'=>'TOEIC_PART'")&&str_contains($repo,"source_dimension'=>'TOEIC_GRAMMAR'")&&str_contains($repo,'SUM(a.is_correct) correct');
$dashStart=strpos($app,'async function dashboard(){');$dashEnd=strpos($app,"\nfunction stat(",$dashStart);$dash=substr($app,$dashStart,$dashEnd-$dashStart);
$checks['dashboard prioritizes daily session over optional practice']=str_contains($dash,'id="start-daily-quick"')&&str_contains($dash,'startDailySession')&&strpos($dash,'id="start-daily-quick"')<strpos($dash,'learning-method-grid');
$checks['today navigation and page title']=preg_match('/data-route="dashboard"[\s\S]*?<\/span>Hôm nay<\/a>/',$index)===1&&str_contains($app,"dashboard:['Hôm nay','Học đúng thứ bạn đang yếu.']");
$checks['new content obeys adaptive cap']=str_contains($repo,"AdaptiveLearningService::workloadPolicy")&&str_contains($repo,"'new_knowledge'")&&str_contains($repo,"mode==='new'");
$checks['asset and cache revisions match']=isset($assetRevision[1],$cacheRevision[1])&&$assetRevision[1]===$cacheRevision[1];
$bad=[];foreach($checks as $name=>$ok){echo ($ok?'PASS ':'FAIL ').$name."\n";if(!$ok)$bad[]=$name;}
if($bad)exit(1);
echo "ADAPTIVE TOEIC DAILY PLAN V32 OK\n";
