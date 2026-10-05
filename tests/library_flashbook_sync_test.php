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
$checks=[
 'sync repository method'=>str_contains($repo,'public function ensureFlashcardBooksInstalled(int $uid): array'),
 'sync installs missing books'=>str_contains($repo,'$result=$this->installFlashcardBook($uid,$code)')&&str_contains($repo,"WHERE user_id=? AND (source_type=? OR source_type=?)"),
 'sync api endpoint'=>str_contains($api,"if(\$action==='flashcard_books_sync')")&&str_contains($api,'ensureFlashcardBooksInstalled($uid)'),
 'library browsing never installs books'=>!str_contains($app,'await syncBundledFlashcardBooks()'),
 'existing books never refresh or append'=>!str_contains($repo,'syncInstalledFlashcardBook')&&!str_contains($repo,"'refresh_existing'=>true"),
 'explicit book install remains available'=>str_contains($app,"api('flashcard_book_install'"),
 'section titles 5.1'=>str_contains($repo,"'title'=>'5.1 Kinh doanh & Quản lý'"),
 'section titles 5.2'=>str_contains($repo,"'title'=>'5.2 Nhân sự & Giao tiếp'"),
 'section titles 5.3'=>str_contains($repo,"'title'=>'5.3 Tài chính & Mua sắm'"),
 'section titles 5.4'=>str_contains($repo,"'title'=>'5.4 Vận hành & Hậu cần'"),
 'asset and cache revisions match'=>isset($assetRevision[1],$cacheRevision[1])&&$assetRevision[1]===$cacheRevision[1],
];
$bad=[];foreach($checks as $k=>$ok){echo ($ok?'PASS ':'FAIL ').$k."\n";if(!$ok)$bad[]=$k;}
if($bad)exit(1);
echo "LIBRARY FLASHBOOK PRESERVATION OK\n";
