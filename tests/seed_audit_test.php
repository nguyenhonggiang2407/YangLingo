<?php
declare(strict_types=1);$root=dirname(__DIR__);$dir=$root.'/database/seeds';$files=glob($dir.'/*.sql')?:[];sort($files,SORT_STRING);if(!$files){fwrite(STDERR,"FAIL: no seeds\n");exit(1);} $bad=[];
foreach($files as $f){$s=file_get_contents($f)?:'';$name=basename($f);if(preg_match('/@gmail\.com|password\s*=|api[_-]?key\s*=|secret\s*=/i',$s))$bad[]="$name contains personal/credential-like data";if(preg_match('/\b(DROP\s+TABLE|TRUNCATE\s+TABLE)\b/i',$s))$bad[]="$name contains destructive DDL";if(preg_match('/\b(CREATE|ALTER)\s+TABLE\b/i',$s))$bad[]="$name mixes schema DDL into content seed";}
$db=file_get_contents($root.'/lib/Database.php')?:'';foreach(['content_seeds','sha1_file','beginTransaction','rollBack','commit'] as $t)if(!str_contains($db,$t))$bad[]="Database content seed tracking missing $t";
if($bad){foreach($bad as $x)fwrite(STDERR,"FAIL: $x\n");exit(1);}echo "SEED STATIC AUDIT OK: ".count($files)." SQL seed files; checksum tracking + per-seed transaction enabled\n";
