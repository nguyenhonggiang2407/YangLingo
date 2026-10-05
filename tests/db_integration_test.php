<?php
declare(strict_types=1);
$root=dirname(__DIR__);
if(!class_exists('PDO')||!in_array('mysql',PDO::getAvailableDrivers(),true)){fwrite(STDERR,"NOT EXECUTED: pdo_mysql is unavailable.\n");exit(2);}
$config=require $root.'/config.php';
$cfg=$config['db']??[];
if(trim((string)($cfg['host']??''))===''||trim((string)($cfg['name']??''))===''||trim((string)($cfg['user']??''))===''){fwrite(STDERR,"NOT EXECUTED: database configuration is not available.\n");exit(2);}
require_once $root.'/lib/Database.php';
$db=new Database($cfg,$root.'/database/schema.sql',$root.'/database/migrations',$root.'/database/seeds');
$db->ensureSchema();
$pdo=$db->pdo();
$required=['users','flashcards','srs_progress','mistake_book_v2','toeic_questions','global_learning_items','aptis_questions','connected_speech_examples','content_seeds','schema_migrations'];
foreach($required as $table){$s=$pdo->query("SHOW TABLES LIKE ".$pdo->quote($table));if(!$s->fetchColumn())throw new RuntimeException("Missing table $table");}
$counts=[
    'global_learning_items'=>(int)$pdo->query('SELECT COUNT(*) FROM global_learning_items')->fetchColumn(),
    'connected_speech'=>(int)$pdo->query('SELECT COUNT(*) FROM connected_speech_examples')->fetchColumn(),
    'toeic_adaptive'=>(int)$pdo->query("SELECT COUNT(*) FROM toeic_questions WHERE tags LIKE '%adaptive%'")->fetchColumn(),
    'aptis_active'=>(int)$pdo->query('SELECT COUNT(*) FROM aptis_questions WHERE is_active=1')->fetchColumn(),
    'aptis_retired'=>(int)$pdo->query('SELECT COUNT(*) FROM aptis_questions WHERE is_active=0')->fetchColumn(),
];
if($counts['global_learning_items']<1449||$counts['connected_speech']<100||$counts['toeic_adaptive']<300||$counts['aptis_active']<608)throw new RuntimeException('Seed counts are below bundled minimum: '.json_encode($counts));
echo 'DB INTEGRATION PASS '.json_encode($counts,JSON_UNESCAPED_UNICODE).PHP_EOL;
