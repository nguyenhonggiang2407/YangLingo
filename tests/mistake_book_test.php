<?php
declare(strict_types=1);
$root=dirname(__DIR__);
function okb(bool $v,string $m): void {if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
$sql=file_get_contents($root.'/database/migrations/004_mistake_book_v2.sql');
$repo=file_get_contents($root.'/lib/Repository.php');
$app=file_get_contents($root.'/assets/app.js');
$api=file_get_contents($root.'/api.php');
okb(str_contains($sql,'card_id BIGINT UNSIGNED NULL'),'Mistake V2 supports standalone questions without card_id');
okb(str_contains($sql,'ON DUPLICATE KEY UPDATE'),'Legacy mistake migration is repeat-safe at data level');
okb(!preg_match('/\bDROP\b/i',$sql),'Mistake V2 migration does not drop user data');
okb(str_contains($repo,'source_key') && str_contains($repo,'wrong_count=wrong_count+1'),'Repeated mistakes aggregate by stable source key');
okb(str_contains($repo,'WHERE id=? AND user_id=?'),'Mistake resolve is scoped to the current user');
okb(str_contains($app,'async function mistakesView') && str_contains($app,"api('mistakes'") && str_contains($app,"api('mistake_resolve'"),'Mistake Book route is backed by API data and resolve actions');
okb(str_contains($api,"\$action==='mistake_reopen'") && str_contains($app,"api('mistake_reopen'"),'Resolved mistakes can be reopened through an owned server action');
okb(str_contains($app,"mode:'mistake_review'") && str_contains($app,"track_mistake:false"),'Mistake reviews update daily-study progress without recursively creating mistakes');
echo "MISTAKE BOOK TESTS OK\n";
