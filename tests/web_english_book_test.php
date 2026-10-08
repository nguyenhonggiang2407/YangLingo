<?php
declare(strict_types=1);
require_once dirname(__DIR__).'/lib/compat.php';require_once dirname(__DIR__).'/lib/Repository.php';
$root=dirname(__DIR__);$checks=0;
$check=static function(bool $ok,string $name)use(&$checks):void{if(!$ok)throw new RuntimeException('FAIL '.$name);$checks++;};
$class=new ReflectionClass(Repository::class);$repo=$class->newInstanceWithoutConstructor();
$call=static function(string $method,...$args)use($class,$repo){$m=$class->getMethod($method);$m->setAccessible(true);return $m->invoke($repo,...$args);};
$seed=json_decode(file_get_contents($root.'/assets/flashbooks/english-for-web-a2-b1/english-for-web-a2-b1.json'),true,512,JSON_THROW_ON_ERROR);
$prompts=json_decode(file_get_contents($root.'/assets/flashbooks/english-for-web-a2-b1/practice-prompts.json'),true,512,JSON_THROW_ON_ERROR);
$book=$call('webEnglishFlashbook');$rows=$call('webEnglishFlashbookRows');
$check(count($rows)===48&&count($book['lessons'])===6,'48/6 structure');
$check($book['source_type']==='english_for_web_a2_b1_book'&&strlen($book['source_type'])===26,'new separate identity fits original width');
$prior=[];foreach(['everydayEnglishFlashbookRows','studentLifeFlashbookRows','dailyEssentialsFlashbookRows'] as $method)foreach($call($method) as $card)$prior[mb_strtolower(trim($card['term']))]=true;
$expected=[];$keys=[];$ipa=0;$types=[];$topics=[];
foreach($seed['lessons'] as $i=>$lesson)foreach($lesson['cards'] as $card){
    $key=($i+1).'|'.mb_strtolower(trim($card['term']));$prompt=$book['sentence_prompts'][$key];
    $expected[]=array_merge(['ipa'=>'','part_of_speech'=>'','card_type'=>'VOCABULARY','difficulty'=>$card['cefr']==='B1'?2:1,'pattern'=>'','collocations'=>'','word_family'=>''],$card,[
        'category'=>$lesson['title'],'topic'=>'English for Web','subtopic'=>$lesson['title'],'toeic_part'=>'','notes'=>'Bài '.($i+1).' · '.$lesson['objective'],
        'explanation'=>$card['explanation']."\n\nThử dùng từ: ".$prompt,'audio_text'=>$card['example_en'],'tags'=>'english-for-web,a2-b1,lesson-'.($i+1),'source'=>'YangLingo English for Web · A2–B1']);
    $term=mb_strtolower(trim($card['term']));$check(!isset($keys[$term])&&!isset($prior[$term]),'new/complementary term '.$card['term']);$keys[$term]=true;
    if(isset($card['ipa']))$ipa++;$types[$card['card_type']]=($types[$card['card_type']]??0)+1;$topics[$lesson['title']]=($topics[$lesson['title']]??0)+1;
}
$check($rows===$expected,'every row matches independently assembled seed+prompt mapping');
$check(count($prompts['prompts'])===48&&count($book['sentence_prompts'])===48,'48 consumed companion prompts');
$check($ipa===20&&count($topics)===6&&array_unique(array_values($topics))===[8],'20 sourced word IPA/6x8 topics');
foreach(['manual'=>['size'=>30,'lessons'=>[]],'everyday_english_a1_a2_book'=>10,'student_life_work_a2_b1_book'=>10,'daily_essentials_a1_a2_book'=>8] as $source=>$expectedSettings){
    $settings=$call('flashbookLessonSettings',['source_type'=>$source],30);
    $check(is_array($expectedSettings)?$settings===$expectedSettings:$settings['size']===$expectedSettings&&!isset($settings['estimated_minutes']),'existing grouping/minutes fallback '.$source);
}
$settings=$call('flashbookLessonSettings',['source_type'=>$book['source_type']],20);$specs=$call('flashcardBookSpecs');
$check($settings['size']===8&&count($settings['lessons'])===6&&$settings['estimated_minutes']===10,'new grouping and estimated minutes');
$check($specs[$book['code']]['lesson_count']===6&&$specs[$book['code']]['estimated_minutes']===10,'catalog metadata');
$phpArgs=json_decode((string)(getenv('YL_TEST_PHP_ARGS')?:'[]'),true,512,JSON_THROW_ON_ERROR);
if(!is_array($phpArgs)||!array_is_list($phpArgs)||count(array_filter($phpArgs,'is_string'))!==count($phpArgs))throw new RuntimeException('Invalid PHP arguments.');
foreach(['bad-json','duplicate-term','orphan-prompt','duplicate-prompt','bad-minutes','phrase-ipa','missing-target','missing-speaking','missing-seed','missing-prompts','invalid-utf8','associative-lessons','associative-cards','associative-prompts','wrong-string-type','oversized-title','oversized-lesson','oversized-definition','oversized-example-en','oversized-example-vi','oversized-explanation','unsupported-card-field'] as $case){
    $pipes=[];$proc=proc_open([PHP_BINARY,...$phpArgs,__DIR__.'/web_english_loader_fixture_worker.php',$case],[0=>['pipe','r'],1=>['pipe','w'],2=>['pipe','w']],$pipes,null,null,['bypass_shell'=>true]);
    if(!is_resource($proc))throw new RuntimeException('Cannot create fixture subprocess.');fclose($pipes[0]);$out=stream_get_contents($pipes[1]);$err=stream_get_contents($pipes[2]);fclose($pipes[1]);fclose($pipes[2]);$exit=proc_close($proc);
    if($exit!==0)throw new RuntimeException('Loader fixture failed: '.$case.' '.$err);
    $answer=json_decode(trim($out),true,512,JSON_THROW_ON_ERROR);$check($answer['case']===$case&&$answer['rejected']&&$answer['cleanup']&&$answer['seed_unchanged'],'reject invalid fixture '.$case);
}
echo 'WEB ENGLISH CONTENT/LOADER PASS: '.$checks.' checks; '.json_encode($types,JSON_THROW_ON_ERROR).PHP_EOL;
