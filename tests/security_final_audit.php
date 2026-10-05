<?php
declare(strict_types=1);
$root=dirname(__DIR__);$fail=[];
$auth=file_get_contents($root.'/lib/Auth.php')?:'';$boot=file_get_contents($root.'/lib/bootstrap.php')?:'';$db=file_get_contents($root.'/lib/Database.php')?:'';$api=file_get_contents($root.'/api.php')?:'';$zip=file_get_contents($root.'/lib/ZipReader.php')?:'';$xlsx=file_get_contents($root.'/lib/XlsxReader.php')?:'';$docx=file_get_contents($root.'/lib/DocxReader.php')?:'';
foreach(['password_hash','password_verify','session_regenerate_id','auth_login_throttle','DUMMY_HASH'] as $t)if(strpos($auth,$t)===false)$fail[]="Auth missing $t";
foreach(['session.use_strict_mode','httponly','samesite','random_bytes(32)'] as $t)if(strpos($boot,$t)===false)$fail[]="Session/CSRF missing $t";
foreach(['PDO::ATTR_EMULATE_PREPARES => false','prepare($sql)','execute($params)'] as $t)if(strpos($db,$t)===false)$fail[]="PDO safety missing $t";
foreach(['csrf','requireAdmin','requireUser'] as $t)if(stripos($api,$t)===false)$fail[]="API authorization/CSRF missing $t";
foreach(['MAX_ARCHIVE_BYTES','MAX_ENTRIES','MAX_ENTRY_COMPRESSED','MAX_ENTRY_UNCOMPRESSED','MAX_RATIO','..','gzinflate'] as $t)if(strpos($zip,$t)===false)$fail[]="ZipReader limit missing $t";
foreach(['MAX_XML_BYTES','MAX_ROWS','MAX_COLUMNS'] as $t)if(strpos($xlsx,$t)===false)$fail[]="XLSX limit missing $t";
if(strpos($docx,'MAX_XML_BYTES')===false)$fail[]='DOCX XML limit missing';
if(is_file($root.'/config.local.php'))$fail[]='config.local.php must not ship';
$it=new RecursiveIteratorIterator(new RecursiveDirectoryIterator($root,FilesystemIterator::SKIP_DOTS));foreach($it as $f){if(!$f->isFile())continue;$p=$f->getPathname();if(str_contains($p,'/tests/security_final_audit.php'))continue;if(in_array(strtolower(pathinfo($p,PATHINFO_EXTENSION)),['php','sql','js','md','json','txt','csv'],true)){ $s=@file_get_contents($p); if($s!==false&&preg_match('/[A-Z0-9._%+-]+@(gmail|yahoo|outlook|hotmail)\.[A-Z]{2,}/i',$s))$fail[]='Personal-style email remains: '.substr($p,strlen($root)+1); }}
if($fail){foreach(array_unique($fail) as $x)fwrite(STDERR,"FAIL: $x\n");exit(1);}echo "SECURITY FINAL AUDIT OK\n";
