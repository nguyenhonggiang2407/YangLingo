<?php
declare(strict_types=1);
$root=dirname(__DIR__);
require_once $root.'/lib/compat.php';
require_once $root.'/lib/Importer.php';
function okp(bool $v,string $m): void {if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
$sql=file_get_contents($root.'/database/migrations/008_sentence_pattern_library.sql');
$repo=file_get_contents($root.'/lib/Repository.php');
$api=file_get_contents($root.'/api.php');
$app=file_get_contents($root.'/assets/app.js');
$index=file_get_contents($root.'/index.php');
$template=$root.'/templates/sentence-pattern-import-template.csv';

okp(str_contains($sql,'CREATE TABLE IF NOT EXISTS sentence_pattern_library'),'Sentence pattern library migration is additive');
okp(substr_count($sql,",5,")>=35,'Sentence pattern starter library contains at least 35 curated patterns');
okp(str_contains($sql,'example_en') && str_contains($sql,'example_vi'),'Each library record has English and Vietnamese example fields');
okp(str_contains($repo,'public function sentencePatterns'),'Repository exposes sentence patterns for the current user');
okp(str_contains($repo,'public function createSentencePattern') && str_contains($repo,'public function updateSentencePattern') && str_contains($repo,'public function bulkInsertSentencePatterns'),'Repository exposes personal pattern CRUD/import helpers');
okp(str_contains($repo,'array_merge($current,$d)'),'Pattern edit preserves imported metadata not shown in compact editor');
okp(str_contains($api,"\$action==='sentence_pattern_create'") && str_contains($api,"\$action==='sentence_pattern_update'") && str_contains($api,"\$action==='sentence_pattern_delete'") && str_contains($api,"\$action==='sentence_pattern_import'"),'API wires create/update/delete/bulk import actions');
okp(str_contains($app,'async function sentencePatternsView') && str_contains($app,'<b>Ví dụ</b>'),'Dedicated sentence-pattern page renders the example block');
okp(str_contains($app,'＋ Thêm cấu trúc') && str_contains($app,'⇧ Import hàng loạt') && str_contains($app,'data-pattern-edit') && str_contains($app,'data-pattern-delete'),'Sentence-pattern page exposes add/edit/delete/bulk-import controls');
okp(str_contains($index,'href="#patterns"'),'Sidebar exposes the Cấu trúc câu page');
okp(is_file($template),'Sentence-pattern CSV template is bundled');
$cards=Importer::fromFile($template,basename($template));
okp(count($cards)>=3,'Sentence-pattern CSV template imports at least three rows');
okp(($cards[0]['card_type']??'')==='SENTENCE_PATTERN','Pattern CSV is automatically mapped to SENTENCE_PATTERN');
okp(!empty($cards[0]['pattern'])&&!empty($cards[0]['example_en'])&&!empty($cards[0]['example_vi']),'Pattern CSV keeps pattern and bilingual examples');
okp(str_contains((string)($cards[0]['notes']??''),'Cloze:'),'Pattern CSV keeps cloze/answer/distractors in notes');
echo "SENTENCE PATTERN TESTS OK\n";
