<?php
declare(strict_types=1);
$root=dirname(__DIR__);
function hbFail(string $message): never { fwrite(STDERR,"FAIL: {$message}\n"); exit(1); }
function mustContain(string $haystack,string $needle,string $where): void { if(!str_contains($haystack,$needle)) hbFail("Missing {$needle} in {$where}"); }

$migration=$root.'/database/migrations/013_toeic_800_handbooks.sql';
$seed=$root.'/database/seeds/021_toeic_800_handbooks.sql';
if(!is_file($migration)) hbFail('Missing handbook migration 013');
if(!is_file($seed)) hbFail('Missing handbook seed 021');
$m=file_get_contents($migration)?:'';
$s=file_get_contents($seed)?:'';
foreach(['learning_handbooks','learning_handbook_sections','user_handbook_progress','handbook_practice_items','handbook_section_items'] as $table) mustContain($m,"CREATE TABLE IF NOT EXISTS {$table}",'migration 013');
if(preg_match('/\b(DROP\s+TABLE|TRUNCATE\s+TABLE|DELETE\s+FROM\s+users)\b/i',$m.$s)) hbFail('Destructive SQL detected');

foreach(['grammar-800','listening-800','verb-800'] as $code) if(substr_count($s,"VALUES('{$code}'")!==1) hbFail("Handbook {$code} not seeded exactly once");
if(substr_count($s,'INSERT INTO learning_handbook_sections')!==35) hbFail('Expected 35 handbook sections');
if(substr_count($s,'INSERT INTO handbook_practice_items')!==100) hbFail('Expected exactly 100 listening self-check items');

preg_match_all("/\\('hbk-verb-[^']+'\\s*,\\s*'VERB_MASTER'/",$s,$verbs);
preg_match_all("/\\('hbk-grammar-[^']+'\\s*,\\s*'GRAMMAR_LESSON'/",$s,$grammar);
preg_match_all("/\\('hbk-listening-[^']+'\\s*,\\s*'LISTENING_RECOGNITION'/",$s,$listening);
if(count($verbs[0])!==293) hbFail('Expected 293 Verb Master Global Knowledge items');
if(count($grammar[0])!==16) hbFail('Expected 16 Grammar Lesson Global Knowledge items');
if(count($listening[0])!==60) hbFail('Expected 60 Listening Recognition Global Knowledge items');
if(substr_count($s,'INSERT IGNORE INTO handbook_section_items')!==378) hbFail('Expected 378 handbook-to-knowledge relations');

$pdfFiles=[
  'assets/handbooks/toeic-grammar-800-plus.pdf',
  'assets/handbooks/toeic-listening-100-cau-800-plus.pdf',
  'assets/handbooks/toeic-verb-master-800-plus.pdf',
];
foreach($pdfFiles as $pdf){$path=$root.'/'.$pdf;if(!is_file($path)||filesize($path)<10000)hbFail("Missing/empty bundled source PDF: {$pdf}");}

$repo=file_get_contents($root.'/lib/Repository.php')?:'';
foreach(['function handbooks(','function handbook(','function handbookSection(','function handbookPractice(','function handbookRelatedItems(','function markHandbookSection('] as $token) mustContain($repo,$token,'Repository.php');
mustContain($repo,"'VERB_MASTER'=>'VOCABULARY'",'Repository.php');

$api=file_get_contents($root.'/api.php')?:'';
foreach(['handbooks','handbook_get','handbook_section','handbook_practice','handbook_related','handbook_mark'] as $action) mustContain($api,"'{$action}'",'api.php');

$app=file_get_contents($root.'/assets/app.js')?:'';
foreach(['handbooksView','handbookPracticeHtml','handbookRelatedHtml','Mở nguồn gốc','Active Listening / Self-check'] as $token) mustContain($app,$token,'assets/app.js');
$index=file_get_contents($root.'/index.php')?:'';
mustContain($index,'href="#handbooks"','index.php');
mustContain($index,'Học liệu TOEIC 800+','index.php');
$adaptive=file_get_contents($root.'/assets/adaptive.js')?:'';
mustContain($adaptive,"VERB_MASTER:'Verb Master 800+'",'assets/adaptive.js');

$css=file_get_contents($root.'/assets/app.css')?:'';
foreach(['.handbook-book-grid','.handbook-reader-layout','.handbook-reading-text','.handbook-practice-card','.handbook-related-grid'] as $token) mustContain($css,$token,'assets/app.css');

echo "HANDBOOKS OK: books=3, sections=35, listening_self_check=100, global_items=369 (verb=293, grammar=16, listening=60), relations=378\n";
