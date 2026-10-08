<?php
declare(strict_types=1);
// Test only: corrupt private copies, never the seed supplied to an installer.
$root=dirname(__DIR__);require_once $root.'/lib/compat.php';
$case=(string)($argv[1]??'');
if(!in_array($case,['bad-json','duplicate-term','orphan-prompt','duplicate-prompt','bad-minutes','phrase-ipa','missing-target','missing-speaking','missing-seed','missing-prompts','invalid-utf8','associative-lessons','associative-cards','associative-prompts','wrong-string-type','oversized-title','oversized-lesson','oversized-definition','oversized-example-en','oversized-example-vi','oversized-explanation','unsupported-card-field'],true))throw new RuntimeException('Unknown fixture case.');
$dir=$root.'/assets/flashbooks/english-for-web-a2-b1/';
$originalSeed=file_get_contents($dir.'english-for-web-a2-b1.json');$originalPrompts=file_get_contents($dir.'practice-prompts.json');
$seed=json_decode($originalSeed,true,512,JSON_THROW_ON_ERROR);$prompts=json_decode($originalPrompts,true,512,JSON_THROW_ON_ERROR);
switch($case){
    case 'duplicate-term':$seed['lessons'][0]['cards'][1]=$seed['lessons'][0]['cards'][0];break;
    case 'orphan-prompt':$prompts['prompts'][0]['lesson']=2;break;
    case 'duplicate-prompt':$prompts['prompts'][1]=$prompts['prompts'][0];break;
    case 'bad-minutes':$seed['estimated_minutes']=61;break;
    case 'phrase-ipa':$seed['lessons'][0]['cards'][6]['ipa']='US /made.up/';break;
    case 'missing-target':$seed['lessons'][0]['cards'][0]['example_en']='The app opens a file.';break;
    case 'missing-speaking':unset($seed['lessons'][0]['speaking_model']);break;
    case 'associative-lessons':$seed['lessons']=array_combine(['one','two','three','four','five','six'],$seed['lessons']);break;
    case 'associative-cards':$seed['lessons'][0]['cards']=array_combine(['a','b','c','d','e','f','g','h'],$seed['lessons'][0]['cards']);break;
    case 'associative-prompts':$prompts['prompts']=array_combine(array_map(fn($n)=>'p'.$n,range(1,48)),$prompts['prompts']);break;
    case 'wrong-string-type':$seed['lessons'][0]['cards'][0]['definition']=['bad'=>'value'];break;
    case 'oversized-title':$seed['title']=str_repeat('x',181);break;
    case 'oversized-lesson':$seed['lessons'][0]['title']=str_repeat('x',121);break;
    case 'oversized-definition':$seed['lessons'][0]['cards'][0]['definition']=str_repeat('x',1501);break;
    case 'oversized-example-en':$seed['lessons'][0]['cards'][0]['example_en']='documentation '.str_repeat('x',1001);break;
    case 'oversized-example-vi':$seed['lessons'][0]['cards'][0]['example_vi']=str_repeat('x',1001);break;
    case 'oversized-explanation':$seed['lessons'][0]['cards'][0]['explanation']=str_repeat('x',2501);break;
    case 'unsupported-card-field':$seed['lessons'][0]['cards'][0]['owner_id']=17;break;
}
$temp=rtrim(sys_get_temp_dir(),'/\\').'/yanglingo-web48-loader-'.bin2hex(random_bytes(6));
$created=[];$files=[];$rejected=false;
try{
    foreach(['','/lib','/assets','/assets/flashbooks','/assets/flashbooks/english-for-web-a2-b1'] as $suffix){mkdir($temp.$suffix);$created[]=$temp.$suffix;}
    $files=[$temp.'/lib/Repository.php',$temp.'/assets/flashbooks/english-for-web-a2-b1/english-for-web-a2-b1.json',$temp.'/assets/flashbooks/english-for-web-a2-b1/practice-prompts.json'];
    copy($root.'/lib/Repository.php',$files[0]);
    if($case!=='missing-seed')file_put_contents($files[1],$case==='bad-json'?'{':($case==='invalid-utf8'?"{\"bad\":\"\xFF\"}":json_encode($seed,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR)));
    if($case!=='missing-prompts')file_put_contents($files[2],json_encode($prompts,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR));
    require_once $files[0];$class=new ReflectionClass(Repository::class);$repo=$class->newInstanceWithoutConstructor();$method=$class->getMethod('webEnglishFlashbook');$method->setAccessible(true);
    try{$method->invoke($repo);}catch(RuntimeException $error){$rejected=true;}
    if(!$rejected)throw new RuntimeException('Invalid fixture was accepted: '.$case);
    if(file_get_contents($dir.'english-for-web-a2-b1.json')!==$originalSeed||file_get_contents($dir.'practice-prompts.json')!==$originalPrompts)throw new RuntimeException('Original seed changed.');
}finally{
    $resolved=realpath($temp);$parent=realpath(sys_get_temp_dir());
    if($resolved!==false&&$parent!==false&&strtolower(dirname($resolved))===strtolower($parent)&&preg_match('/^yanglingo-web48-loader-[a-f0-9]{12}$/D',basename($resolved))){
        foreach($files as $file)if(is_file($file))unlink($file);
        foreach(array_reverse($created) as $directory)if(is_dir($directory))rmdir($directory);
    }
}
if(is_dir($temp))throw new RuntimeException('Private loader fixture cleanup failed.');
echo json_encode(['case'=>$case,'rejected'=>$rejected,'seed_unchanged'=>true,'cleanup'=>true],JSON_THROW_ON_ERROR).PHP_EOL;
