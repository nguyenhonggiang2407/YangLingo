<?php
declare(strict_types=1);
require dirname(__DIR__).'/lib/compat.php';
require dirname(__DIR__).'/lib/DocxReader.php';
require dirname(__DIR__).'/lib/ZipReader.php';
require dirname(__DIR__).'/lib/XlsxReader.php';
require dirname(__DIR__).'/lib/Importer.php';
function ok(bool $v,string $m): void { if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);} echo "PASS: $m\n"; }
$cards=Importer::parseStructured("appointment | cuộc hẹn | /əˈpɔɪntmənt/ | noun\nconfirm => xác nhận");
ok(count($cards)===2,'Structured text parses two cards');
ok($cards[0]['term']==='appointment' && $cards[0]['definition']==='cuộc hẹn','Structured fields are mapped');
$rows=[['term','definition','ipa','part_of_speech','example_en','example_vi','cefr','notes'],['deadline','hạn chót','/ˈdedlaɪn/','noun','The deadline is Friday.','Hạn chót là thứ Sáu.','B1','TOEIC']];
$parsed=Importer::parseRows($rows);
ok(count($parsed)===1,'CSV-style rows skip detected header');
ok($parsed[0]['cefr']==='B1' && $parsed[0]['notes']==='TOEIC','Optional fields are retained');
$v2=[['term','definition','card_type','topic','toeic_part','difficulty','pattern','collocations','audio_text'],['responsible','chịu trách nhiệm','SENTENCE_PATTERN','Office','5','2','be responsible for + N/V-ing','responsible for','She is responsible for training staff.']];
$v2Parsed=Importer::parseRows($v2);
ok($v2Parsed[0]['card_type']==='SENTENCE_PATTERN' && $v2Parsed[0]['toeic_part']==='5','Importer V2 keeps card type and TOEIC metadata');
ok($v2Parsed[0]['pattern']==='be responsible for + N/V-ing' && $v2Parsed[0]['audio_text']!=='','Importer V2 keeps pattern and listening text');
$patternRows=[['category','title','pattern','meaning_vi','grammar_note','example_en','example_vi','cloze_question','correct_answer','distractors','toeic_part','difficulty','tags','sort_order'],['CORE_STRUCTURE','There is / There are','There is/are + N + place/time','có / tồn tại','Dùng there is với số ít; there are với số nhiều.','There are several openings in the marketing department.','Có một số vị trí tuyển dụng trong bộ phận marketing.','There ____ several openings in the marketing department.','are','is||be||has','5','2','daily-high,toeic-high,foundation','900']];
$patternParsed=Importer::parseRows($patternRows);
ok(count($patternParsed)===1 && $patternParsed[0]['card_type']==='SENTENCE_PATTERN','sentence_patterns_v2 format is auto-detected as SENTENCE_PATTERN');
ok($patternParsed[0]['term']==='There is / There are' && $patternParsed[0]['definition']==='có / tồn tại','Pattern title and Vietnamese meaning aliases are mapped');
ok($patternParsed[0]['explanation']!=='' && str_contains($patternParsed[0]['notes'],'Đáp án: are'),'Grammar note and cloze metadata are preserved');
echo "IMPORTER TESTS OK\n";
