<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$repo=file_get_contents($root.'/lib/Repository.php');
$app=file_get_contents($root.'/assets/app.js');
$api=file_get_contents($root.'/api.php');
$sw=file_get_contents($root.'/service-worker.js');
$index=file_get_contents($root.'/index.php');
preg_match('/assets\/app\.js\?v=(\d+)/',$index,$assetRevision);
preg_match('/yanglingo-static-v(\d+)/',$sw,$cacheRevision);
$csv=$root.'/assets/flashbooks/toeic-verb-master-800-flashcards.csv';
if(!is_file($csv)){fwrite(STDOUT,"NOT EXECUTED: overwrite package does not contain the Verb Master flashbook CSV; run this test on the full production tree.\n");exit(2);}
$h=fopen($csv,'rb');$header=fgetcsv($h);$header=array_map(static fn($v)=>trim(preg_replace('/^\xEF\xBB\xBF/','',(string)$v)??(string)$v),$header);$idx=array_flip($header);$counts=[];while(($r=fgetcsv($h))!==false){$cat=trim((string)($r[$idx['category']]??''));if($cat!=='')$counts[$cat]=($counts[$cat]??0)+1;}fclose($h);
$checks=[
 'section 5.1 title'=>str_contains($repo,"'title'=>'5.1 Kinh doanh & Quản lý'")&&(($counts['Kinh doanh & Quản lý']??0)===109),
 'section 5.2 title'=>str_contains($repo,"'title'=>'5.2 Nhân sự & Giao tiếp'")&&(($counts['Nhân sự & Giao tiếp']??0)===38),
 'section 5.3 title'=>str_contains($repo,"'title'=>'5.3 Tài chính & Mua sắm'")&&(($counts['Tài chính & Mua sắm']??0)===14),
 'section 5.4 title'=>str_contains($repo,"'title'=>'5.4 Vận hành & Hậu cần'")&&(($counts['Vận hành & Hậu cần']??0)===26),
 'section 1 ed'=>str_contains($repo,"'title'=>'1. Phát âm đuôi -ed: /t/ · /d/ · /ɪd/'")&&str_contains($repo,"],42"),
 'section 3 irregular core'=>str_contains($repo,"'title'=>'3A. Irregular Verbs Core – TOEIC'")&&str_contains($repo,"toeic-irregular-verbs-core-v33.csv',120"),
 'section 4 special'=>str_contains($repo,"'title'=>'4. TOEIC Verb Traps – Cặp dễ nhầm'")&&str_contains($repo,'rise vs raise')&&str_contains($repo,'lie vs lay')&&str_contains($repo,'find vs found')&&str_contains($repo,'oversee vs overlook'),
 'no combined catalog spec'=>!str_contains($repo,"'verb-800-flashcards'=>["),
 'lesson mode api'=>str_contains($api,"\$mode==='lesson'")&&str_contains($api,'studyLessonCards($uid,$set,$unit,20)'),
 'lesson mode ui'=>str_contains($app,"const lessonMode=!!sid&&!!current&&!context.reviewOnly")&&str_contains($app,"mode:lessonMode?'lesson':'review'")&&str_contains($app,"Danh sách từ của bài học"),
 'lesson title cleaned'=>str_contains($repo,"'title'=>'Bài '.\$n")&&!str_contains($repo,"'title'=>'Nhóm cá nhân '.\$n"),
 'asset and cache revisions match'=>isset($assetRevision[1],$cacheRevision[1])&&$assetRevision[1]===$cacheRevision[1],
 'legacy migration'=>is_file($root.'/database/migrations/014_flashcard_book_section_titles.sql')&&str_contains(file_get_contents($root.'/database/migrations/014_flashcard_book_section_titles.sql'),'Tổng hợp (bản cũ)')
];
$bad=[];foreach($checks as $k=>$ok){echo ($ok?'PASS ':'FAIL ').$k."\n";if(!$ok)$bad[]=$k;}
if($bad)exit(1);
echo "VERB SECTION BOOKS OK\n";
