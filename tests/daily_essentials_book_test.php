<?php
declare(strict_types=1);
require_once dirname(__DIR__).'/lib/compat.php';
require_once dirname(__DIR__).'/lib/Repository.php';
function essentialExpect(bool $ok,string $message): void {if(!$ok)throw new RuntimeException('FAIL '.$message);}
$class=new ReflectionClass(Repository::class);$repo=$class->newInstanceWithoutConstructor();
$methods=[];foreach(['dailyEssentialsFlashbook','dailyEssentialsFlashbookRows','everydayEnglishFlashbookRows','studentLifeFlashbookRows','flashbookLessonSettings','flashcardBookSpecs'] as $name){$methods[$name]=$class->getMethod($name);$methods[$name]->setAccessible(true);}
$book=$methods['dailyEssentialsFlashbook']->invoke($repo);$rows=$methods['dailyEssentialsFlashbookRows']->invoke($repo);
essentialExpect(count($rows)===64&&count($book['lessons'])===8,'64 cards in eight lessons');
essentialExpect($book['code']==='daily-essentials-a1-a2'&&$book['source_type']==='daily_essentials_a1_a2_book','separate book identity');
essentialExpect(strlen($book['source_type'])===27&&strlen($book['source_type'])<=30,'source fits original VARCHAR(30)');
essentialExpect($book['description']==='8 bài nhỏ cho lớp học, ở chung, đi chợ, đi xe và nhắn tin. Mỗi bài có 8 từ/cụm, ví dụ Anh–Việt và gợi ý nói. Chọn một bài, thử nhớ rồi dùng trong câu của bạn.','concise learner-facing description');
$oldTerms=[];foreach(['everydayEnglishFlashbookRows','studentLifeFlashbookRows'] as $name)foreach($methods[$name]->invoke($repo) as $r)$oldTerms[mb_strtolower(trim($r['term']))]=true;
$unique=[];$topics=[];$ipa=0;
foreach($rows as $row){
    foreach(['term','definition','part_of_speech','example_en','example_vi','explanation','cefr','notes','audio_text','source'] as $field)essentialExpect(trim((string)($row[$field]??''))!=='','required '.$field.' for '.$row['term']);
    $key=mb_strtolower(trim($row['term']));essentialExpect(!isset($unique[$key])&&!isset($oldTerms[$key]),'unique complementary term '.$row['term']);$unique[$key]=true;
    essentialExpect(in_array($row['cefr'],['A1','A2'],true)&&in_array($row['card_type'],['VOCABULARY','COLLOCATION','SENTENCE_PATTERN','LISTENING_CHUNK'],true),'supported level/type');
    essentialExpect(mb_stripos($row['example_en'],$row['term'])!==false,'example contains target');
    $topics[$row['subtopic']]=($topics[$row['subtopic']]??0)+1;
    if($row['ipa']!==''){$ipa++;essentialExpect((bool)preg_match('/^[A-Za-z]+$/D',$row['term'])&&(bool)preg_match('/^US \/[^\/\r\n]+\/$/u',$row['ipa']),'single-word sourced US IPA retained');}
}
essentialExpect($ipa===39&&count($topics)===8&&array_unique(array_values($topics))===[8],'39 IPA and eight topics of eight');
$settings=$methods['flashbookLessonSettings']->invoke($repo,['source_type'=>$book['source_type']],20);
essentialExpect($settings['size']===8&&count($settings['lessons'])===8,'new lesson grouping');
essentialExpect($methods['flashbookLessonSettings']->invoke($repo,['source_type'=>'manual'],30)===['size'=>30,'lessons'=>[]],'personal grouping unchanged');
essentialExpect($methods['flashbookLessonSettings']->invoke($repo,['source_type'=>'everyday_english_a1_a2_book'],20)['size']===10,'Everyday grouping unchanged');
essentialExpect($methods['flashbookLessonSettings']->invoke($repo,['source_type'=>'student_life_work_a2_b1_book'],20)['size']===10,'Student grouping unchanged');
$specs=$methods['flashcardBookSpecs']->invoke($repo);
essentialExpect(isset($specs[$book['code']])&&$specs[$book['code']]['lesson_size']===8&&$specs[$book['code']]['lesson_count']===8,'catalog metadata');
echo "DAILY ESSENTIALS CONTENT PASS\n";
