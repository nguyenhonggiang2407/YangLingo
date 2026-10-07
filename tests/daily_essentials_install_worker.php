<?php
declare(strict_types=1);
$path=(string)getenv('YL_TEST_CONFIG_PATH');
if($path===''||!is_file($path))throw new RuntimeException('Missing isolated test configuration.');
$config=require $path;$cfg=$config['db']??[];
if(!in_array($cfg['host']??'',['127.0.0.1','localhost','::1'],true)||!preg_match('/(?:_qa|_test)$/',(string)($cfg['name']??'')))throw new RuntimeException('Refusing nonlocal/non-test database.');
require_once dirname(__DIR__).'/lib/compat.php';require_once dirname(__DIR__).'/lib/Database.php';require_once dirname(__DIR__).'/lib/Repository.php';
$uid=filter_var($argv[1]??'',FILTER_VALIDATE_INT,['options'=>['min_range'=>1]]);
if($uid===false)throw new RuntimeException('Missing synthetic user.');
$db=new Database($cfg,dirname(__DIR__).'/database/schema.sql');$repo=new Repository($db);
$user=$db->one('SELECT email FROM users WHERE id=?',[$uid]);
if(!$user||!preg_match('/^essential-concurrent-[a-f0-9]+@example\.test$/D',$user['email']))throw new RuntimeException('Refusing a nonsynthetic worker account.');
$ready=(string)($argv[2]??'');
if($ready!==''){
    if(dirname($ready)!==dirname($path)||!preg_match('/^essential-ready-[a-f0-9]+\.txt$/D',basename($ready)))throw new RuntimeException('Invalid private ready marker.');
    file_put_contents($ready,'ready');
}
echo json_encode($repo->installFlashcardBook($uid,'daily-essentials-a1-a2'),JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR).PHP_EOL;
