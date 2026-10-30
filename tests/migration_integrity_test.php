<?php
declare(strict_types=1);
$root=dirname(__DIR__);$dir=$root.'/database/migrations';$files=glob($dir.'/*.sql')?:[];sort($files,SORT_STRING);$fail=[];$names=array_map('basename',$files);
if(!$files)$fail[]='No migrations found';
$prev=-1;foreach($files as $f){$name=basename($f);if(!preg_match('/^(\d{3})_[a-z0-9_]+\.sql$/',$name,$m)){$fail[]="Bad migration name: $name";continue;}$n=(int)$m[1];if($n<=$prev)$fail[]="Migration order error: $name";$prev=$n;$s=file_get_contents($f)?:'';
  if(preg_match('/[A-Z0-9._%+-]+@(gmail|yahoo|outlook|hotmail)\.[A-Z]{2,}/i',$s))$fail[]="Personal email in $name";
  if(preg_match('/\b(DROP\s+DATABASE|TRUNCATE\s+TABLE)\b/i',$s))$fail[]="Destructive SQL in $name";
  if(preg_match_all('/CREATE TABLE IF NOT EXISTS\s+`?([a-z0-9_]+)`?\s*\(/i',$s,$mm)){foreach($mm[1] as $table){$pos=stripos($s,'CREATE TABLE IF NOT EXISTS '.$table);}}
}
$adaptive=file_get_contents($dir.'/011_adaptive_learning_schema.sql')?:'';
if(preg_match('/\bINSERT\s+INTO\b/i',$adaptive))$fail[]='011 must be schema-only';
foreach(['global_learning_items','user_global_learning','aptis_questions','aptis_attempts'] as $table)if(!preg_match('/CREATE TABLE IF NOT EXISTS\s+'.$table.'\b/i',$adaptive))$fail[]="Missing adaptive table $table";
if(substr_count($adaptive,'ENGINE=InnoDB')<6)$fail[]='Adaptive tables must use InnoDB';
if(substr_count($adaptive,'CHARSET=utf8mb4')<6)$fail[]='Adaptive tables must use utf8mb4';
$db=file_get_contents($root.'/lib/Database.php')?:'';foreach(['schema_migrations','content_seeds','checksum','hash_equals','sort($files, SORT_STRING)'] as $tok)if(strpos($db,$tok)===false)$fail[]="Migration runner missing $tok";
if($fail){foreach($fail as $x)fwrite(STDERR,"FAIL: $x\n");exit(1);}echo 'MIGRATION STATIC AUDIT OK: '.count($files).' active migration files'.PHP_EOL;
