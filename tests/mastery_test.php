<?php
declare(strict_types=1);
require dirname(__DIR__).'/lib/SRS.php';
function okm(bool $v,string $m): void {if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
$now=new DateTimeImmutable('2026-08-23 10:00:00');
$base=['state'=>'review','stability_days'=>40,'difficulty'=>4,'ease_factor'=>2.5,'repetitions'=>5,'lapses'=>1,'correct_streak'=>0,'total_reviews'=>8,'correct_reviews'=>6,'last_reviewed_at'=>'2026-08-20 10:00:00'];
$r1=SRS::review($base,3,$now);
okm($r1['state']!=='mastered','High stability alone does not master after a recent lapse/low correct streak');
$base['correct_streak']=2;
$r2=SRS::review($base,3,$now);
okm($r2['state']==='mastered','Mastery requires stability, repetitions and correct streak');
okm($r2['correct_streak']>=3,'Correct streak is carried into mastery');
echo "MASTERY TESTS OK\n";
