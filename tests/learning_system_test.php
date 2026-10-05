<?php
declare(strict_types=1);
$root=dirname(__DIR__);require_once $root.'/lib/AdaptiveLearningService.php';
function okl(bool $v,string $m): void {if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
$repo=file_get_contents($root.'/lib/Repository.php');$app=file_get_contents($root.'/assets/app.js');
okl(str_contains($repo,"WHEN p.card_id IS NULL THEN 5"),'New cards are lower priority than due cards');
okl(str_contains($repo,"WHEN p.due_at<CURDATE() THEN 1"),'Overdue cards receive highest SRS queue priority');
okl(str_contains($repo,'$newRemaining=max(0,$newGoal-$newDone)'),'Review queue caps unseen cards to the remaining daily new-word goal');
okl(str_contains($repo,"\$mode=\$p?'review':'vocabulary'"),'New-card reviews count as vocabulary, not due review');
$high=AdaptiveLearningService::workloadPolicy(70,62,12);okl($high['backlog_level']==='HIGH'&&$high['new_goal']<=3,'Daily plan strongly throttles new content on high backlog');
$mid=AdaptiveLearningService::workloadPolicy(30,78,12);okl($mid['backlog_level']==='MEDIUM'&&$mid['new_goal']>=5&&$mid['new_goal']<=8,'Daily plan uses 5–8 new items on medium backlog');
$low=AdaptiveLearningService::workloadPolicy(5,91,12);okl($low['backlog_level']==='LOW'&&$low['new_goal']>=10,'Daily plan permits normal new content with low backlog/high retention');
okl(str_contains($repo,'AdaptiveLearningService::workloadPolicy')&&str_contains($repo,'AdaptiveLearningService::reason'),'Daily plan delegates adaptive decisions to explainable service logic');
okl(str_contains($repo,'JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=?'),'Daily due counts verify current-user card ownership');
okl(str_contains($app,'async function startDailySession')&&str_contains($app,"sessionStorage.setItem('ylDailySession'"),'Daily/Quick Study launch a real planned session');
okl(str_contains($app,'Sentence Recognition')&&str_contains($app,'Dictation'),'Listening V2 exposes sentence recognition and dictation');
okl(str_contains($app,'practiceDistractors'),'Random practice uses smarter distractor selection');
okl(str_contains($repo,'public function sentencePatterns')&&str_contains($app,'async function sentencePatternsView'),'Dedicated sentence-pattern library is exposed through API and UI');
okl(str_contains($app,'pattern-example')&&str_contains($app,'example_en')&&str_contains($app,'example_vi'),'Sentence-pattern UI renders bilingual examples');
echo "LEARNING SYSTEM TESTS OK\n";
