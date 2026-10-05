<?php
declare(strict_types=1);
require dirname(__DIR__).'/lib/SRS.php';
function ok(bool $v,string $m): void { if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);} echo "PASS: $m\n"; }
$now=new DateTimeImmutable('2026-08-22 10:00:00');
$again=SRS::review(null,1,$now);
ok($again['state']==='relearning','Again enters relearning');
ok($again['lapses']===1,'Again increments lapses');
ok($again['due_at']==='2026-08-22 10:10:00','Again schedules a short retry');
$good=SRS::review(null,3,$now);
ok($good['state']==='review','Good enters review');
ok($good['repetitions']===1,'Good increments repetitions');
ok($good['correct_reviews']===1,'Good records a correct review');
$easy=SRS::review($good,4,$now->modify('+1 day'));
ok($easy['stability_days']>$good['stability_days'],'Easy increases stability');
ok(new DateTimeImmutable($easy['due_at'])>$now->modify('+1 day'),'Easy schedules a future review');
echo "SRS TESTS OK\n";
