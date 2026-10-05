<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$csv=$root.'/assets/handbooks/helen-toeic-part1-vocabulary.csv';
$sql=$root.'/database/seeds/022_helen_toeic_part1_vocabulary.sql';
if(!is_file($csv)||!is_file($sql)){fwrite(STDERR,"FAIL: HELEN source/seed missing\n");exit(1);} 
$h=fopen($csv,'rb');$head=fgetcsv($h);$rows=[];$groups=[];$terms=[];while(($r=fgetcsv($h))!==false){if(count($r)<6)continue;$rows[]=$r;$groups[$r[0]]=1;$terms[strtolower(trim($r[2]))]=1;}fclose($h);
if(count($rows)!==141){fwrite(STDERR,"FAIL: expected 141 source rows, got ".count($rows)."\n");exit(1);} 
if(count($groups)!==7){fwrite(STDERR,"FAIL: expected 7 source sheets, got ".count($groups)."\n");exit(1);} $expectedGroups=['Eye-controlled action'=>12,'Manual operation'=>33,'Movement, Sports & Posture'=>20,'Clothing & Daily Life'=>15,'Objects & Equipment'=>28,'Scenes & Surroundings'=>13,'Object States & Arrangements'=>20];$counts=[];foreach($rows as $r)$counts[$r[0]]=($counts[$r[0]]??0)+1;foreach($expectedGroups as $g=>$n)if(($counts[$g]??0)!==$n){fwrite(STDERR,"FAIL: source group $g expected $n got ".($counts[$g]??0)."\n");exit(1);} 
if(count($terms)!==140){fwrite(STDERR,"FAIL: expected 140 unique normalized terms (Fasten occurs twice), got ".count($terms)."\n");exit(1);} 
$s=file_get_contents($sql)?:'';
if(substr_count($s,"'VOCABULARY_RECALL'")!==141){fwrite(STDERR,"FAIL: expected 141 practice items\n");exit(1);} 
if(substr_count($s,"INSERT INTO learning_handbook_sections")!==7){fwrite(STDERR,"FAIL: expected 7 handbook sections\n");exit(1);} 
if(substr_count($s,"INSERT INTO global_learning_items")!==141){fwrite(STDERR,"FAIL: expected 141 dedupe-aware knowledge candidates\n");exit(1);} 
if(substr_count($s,"INSERT IGNORE INTO handbook_section_items")!==141){fwrite(STDERR,"FAIL: expected 141 knowledge links\n");exit(1);} 
foreach(['Review','Safety helmet / Hard hat','Be cordoned off','Chardeliers are suspended from the high ceiling.'] as $needle)if(!str_contains($s,$needle)&&!str_contains(file_get_contents($csv)?:'',$needle)){fwrite(STDERR,"FAIL: source row missing: $needle\n");exit(1);} 
echo "HELEN PART1 VOCAB OK: rows=141, unique_terms=140, sheets=7, practice=141, dedupe_knowledge_candidates=141\n";
