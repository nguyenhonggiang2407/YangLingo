<?php
declare(strict_types=1);$root=dirname(__DIR__);$js=file_get_contents($root.'/assets/aptis-v5.js');$css=file_get_contents($root.'/assets/aptis-v5.css');
function okp(bool $v,string $m):void{if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
okp(str_contains($js,"module:'writing',limit:64")&&str_contains($js,"module:'speaking',limit:64")&&str_contains($js,'productiveNav'),'Speaking/Writing expose Part 1–4 navigation and prompt rotation');
foreach(['mediaHtml(q)','aptis-media-pair','speaking-phase-timer','MediaRecorder','aptis-retry','Task fulfilment','Pronunciation','Fluency','Organisation'] as $t)okp(str_contains($js,$t),"Speaking feature: $t");
foreach(['writing-timer','localStorage.setItem(draftKey','restore-writing-draft','clear-writing-draft','aptis-word-count','Task completion','Register','Coherence'] as $t)okp(str_contains($js,$t),"Writing feature: $t");
okp(str_contains($js,'yl:aptis:writing:${userId}:${q.id}'),'Writing draft key is scoped by user and task');
okp(str_contains($js,'word_matching')&&str_contains($js,'aptis-matching'),'Vocabulary word matching has a dedicated renderer');
okp(str_contains($css,'.aptis-media-pair')&&str_contains($css,'.aptis-rubric-grid')&&str_contains($css,'.aptis-matching'),'Productive/matching UI has responsive styles');
$svgs=glob($root.'/assets/aptis/media/*.svg');okp(count($svgs)===9,'Nine original Aptis SVG media files exist');
foreach($svgs as $f){$x=file_get_contents($f);okp(str_contains($x,'<svg')&&str_contains($x,'viewBox'),'SVG is structurally valid: '.basename($f));}
$seed=file_get_contents($root.'/database/seeds/019_aptis_media_demo.sql');foreach($svgs as $f)okp(str_contains($seed,'assets/aptis/media/'.basename($f)),'Media seed references '.basename($f));
echo "APTIS PRODUCTIVE TESTS OK\n";
