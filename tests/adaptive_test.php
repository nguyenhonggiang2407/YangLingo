<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$checks=[
 'lib/Database.php'=>['runContentSeeds','content_seeds'],
 'lib/Repository.php'=>['globalLearningItems','saveGlobalItemToSrs','learnerProfile','knowledgeMap','mistakeMicroLesson','recordRemedialAttempt','recordCollocationAttempt','collocationChallenge','RECURRED'],
 'lib/AdaptiveLearningService.php'=>['workloadPolicy','priorityScore','Deterministic workload policy'],
 'api.php'=>["\$action==='adaptive_summary'","\$action==='adaptive_library'","\$action==='adaptive_save_to_srs'","\$action==='knowledge_map'","\$action==='mistake_remedial_attempt'","\$action==='collocation_attempt'"],
 'assets/adaptive.js'=>['window.YLAdaptive','Knowledge Map','Build the Collocation','adaptive_save_to_srs','collocation_attempt','Mistake Book'],
 'index.php'=>['#adaptive','assets/adaptive.js'],
 'lib/ZipReader.php'=>['MAX_ARCHIVE_BYTES','MAX_ENTRIES','MAX_RATIO'],
 'lib/XlsxReader.php'=>['MAX_ROWS','MAX_COLUMNS','MAX_XML_BYTES'],
];
foreach($checks as $file=>$tokens){$s=file_get_contents($root.'/'.$file);if($s===false){fwrite(STDERR,"Missing $file\n");exit(1);}foreach($tokens as $tok){if(strpos($s,$tok)===false){fwrite(STDERR,"Missing $tok in $file\n");exit(1);}}}
require_once $root.'/lib/AdaptiveLearningService.php';
$a=AdaptiveLearningService::workloadPolicy(70,62,12);if($a['backlog_level']!=='HIGH'||$a['new_goal']>3){fwrite(STDERR,"High backlog adaptation failed\n");exit(1);} 
$b=AdaptiveLearningService::workloadPolicy(5,91,12);if($b['backlog_level']!=='LOW'||$b['new_goal']<10){fwrite(STDERR,"Low backlog adaptation failed\n");exit(1);} 
$listen=AdaptiveLearningService::priorityScore(['error_frequency'=>5,'recurrence_count'=>1,'weakness_severity'=>62,'exam_relevance'=>2]);
$grammar=AdaptiveLearningService::priorityScore(['error_frequency'=>1,'recurrence_count'=>0,'weakness_severity'=>18,'exam_relevance'=>2]);
if($listen<=$grammar){fwrite(STDERR,"Weakness priority ordering failed\n");exit(1);} 
echo "ADAPTIVE TESTS OK\n";
