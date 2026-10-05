<?php
declare(strict_types=1);
$root=dirname(__DIR__);
function okt(bool $v,string $m): void {if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
$sql=file_get_contents($root.'/database/migrations/005_personalized_learning_toeic.sql').file_get_contents($root.'/database/migrations/006_taxonomies_and_toeic_seed.sql').file_get_contents($root.'/database/migrations/007_toeic_part1_7_starter_and_connected_speech.sql');
$repo=file_get_contents($root.'/lib/Repository.php');
$api=file_get_contents($root.'/api.php');
$app=file_get_contents($root.'/assets/app.js');
okt(str_contains($sql,'CREATE TABLE IF NOT EXISTS toeic_questions'),'TOEIC question table is created additively');
okt(str_contains($sql,'CREATE TABLE IF NOT EXISTS toeic_attempts'),'TOEIC attempts are persisted per user');
okt(str_contains($sql,"SELECT 5,'multiple_choice'") && substr_count($sql,'WHERE NOT EXISTS')>=5,'Small Part 5 seed is idempotent and quality-focused');
okt(str_contains($repo,'recordToeicAttempt') && str_contains($repo,"'toeic:'"),'TOEIC attempts feed the mistake system');
okt(str_contains($repo,'adminSaveToeicQuestion') && str_contains($api,'admin_toeic_save'),'Admin can manage the TOEIC question bank');
okt(str_contains($repo,'Soft archive keeps historical toeic_attempts intact') && !str_contains($repo,"DELETE FROM toeic_questions WHERE id=?"),'TOEIC archive preserves attempt history');
okt(str_contains($repo,'normalizeMediaUrl') && str_contains($repo,'URL http(s)'),'TOEIC media URL input is constrained');
okt(str_contains($sql,'CREATE TABLE IF NOT EXISTS connected_speech_examples') && str_contains($repo,'connectedSpeechExamples'),'Connected speech curriculum is seeded and readable');
$start=strpos($repo,'public function toeicQuestions');$end=strpos($repo,'public function recordToeicAttempt',$start);$learnerBody=substr($repo,$start,$end-$start);
okt($start!==false && $end!==false && !str_contains($learnerBody,'correct_option') && !str_contains($learnerBody,'correct_answer') && !str_contains($learnerBody,'explanation') && !str_contains($learnerBody,'transcript'),'Learner TOEIC fetch does not disclose answers, explanations or transcript before submission');
okt(str_contains($sql,'assets/toeic/part1-office-meeting.svg') && is_file($root.'/assets/toeic/part1-office-meeting.svg') && is_file($root.'/assets/toeic/part1-warehouse-pallets.svg'),'Part 1 starter questions reference bundled local visual assets');
okt(str_contains($repo,"'transcript'=>\$q['transcript']??null") && str_contains($app,'r.transcript'),'Transcript/explanation are revealed from the attempt response after submission');
okt(str_contains($repo,"in_array(\$selected,['A','B','C','D'],true)"),'Learner TOEIC attempt validates the submitted option');
echo "TOEIC TESTS OK\n";
