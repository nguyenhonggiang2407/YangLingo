<?php
$root=dirname(__DIR__);$must=[
 'database/migrations/011_adaptive_learning_schema.sql'=>['CREATE TABLE IF NOT EXISTS aptis_questions','CREATE TABLE IF NOT EXISTS aptis_attempts','global_learning_items'],
 'database/seeds/013_aptis_adaptive_expansion.sql'=>['INSERT IGNORE INTO aptis_questions','sentence_ordering','YangLingo Adaptive original practice content'],
 'assets/aptis-v5.js'=>['window.YLAptis','aptis_attempt','aptis_writing_submit','aptis_speaking_submit','sentence_ordering','Aptis Quick Check'],
 'api.php'=>["\$action==='aptis_summary'","\$action==='admin_aptis_import'",'aptis_questions'],
 'lib/Repository.php'=>['function aptisSummary','function recordAptisAttempt','function adminSaveAptisQuestion'],
];foreach($must as $file=>$tokens){$s=file_get_contents($root.'/'.$file);if($s===false){fwrite(STDERR,"Missing $file\n");exit(1);}foreach($tokens as $tok)if(strpos($s,$tok)===false){fwrite(STDERR,"Missing token $tok in $file\n");exit(1);}}echo "aptis_adaptive_test: OK\n";
