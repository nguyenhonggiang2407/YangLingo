<?php
declare(strict_types=1);
try { require __DIR__.'/lib/bootstrap.php'; }
catch(SetupRequiredException $e){ http_response_code(503); header('Content-Type: application/json; charset=utf-8'); echo json_encode(['ok'=>false,'message'=>'YangLingo chưa được cài đặt. Hãy mở setup.php.','setup_required'=>true],JSON_UNESCAPED_UNICODE); exit; }
catch(Throwable $e){ if(function_exists('yl_log')) yl_log($e); http_response_code(503); header('Content-Type: application/json; charset=utf-8'); echo json_encode(['ok'=>false,'message'=>'Máy chủ chưa thể kết nối dịch vụ. Vui lòng thử lại sau.','setup_required'=>false],JSON_UNESCAPED_UNICODE); exit; }

header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
header('Pragma: no-cache');
header('Expires: 0');
header('Vary: Cookie');

function respond(mixed $data=null,string $message=''): never { header('Content-Type: application/json; charset=utf-8'); echo json_encode(['ok'=>true,'data'=>$data,'message'=>$message],JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES); exit; }
function fail(string $message,int $code=400): never { http_response_code($code);header('Content-Type: application/json; charset=utf-8');echo json_encode(['ok'=>false,'message'=>$message],JSON_UNESCAPED_UNICODE);exit; }
function input(): array {$ct=$_SERVER['CONTENT_TYPE']??'';if(str_contains($ct,'application/json')){$d=json_decode(file_get_contents('php://input'),true);return is_array($d)?$d:[];}return $_POST;}
function csrf(array $d=[]): void {$token=(string)($d['csrf']??($_SERVER['HTTP_X_CSRF_TOKEN']??''));if(!hash_equals((string)($_SESSION['csrf']??''),$token))fail('Phiên bảo mật đã hết hạn. Hãy tải lại trang.',419);}
function i(mixed $v): ?int {if($v===null||$v==='')return null;return (int)$v;}
function clientIp(): string { return trim((string)($_SERVER['REMOTE_ADDR']??'')); }
function notebookPayload(array $allowed): array {
    $data=input();csrf($data);unset($data['csrf']);
    if(array_diff(array_keys($data),$allowed))throw new InvalidArgumentException('Trường ghi chú không hợp lệ.');
    return $data;
}
function enforceMethod(string $action): void {
    if(in_array($action,['notebook_notes','notebook_get'],true)){
        if(($_SERVER['REQUEST_METHOD']??'GET')!=='GET')fail('Phương thức HTTP không hợp lệ.',405);
        return;
    }
    $getActions=['bootstrap','dashboard','profile','learning_preferences','stats','leaderboard','mistakes','folders','sets','set_get','export_set','study_lessons','study_lesson_cards','study_cards','threads','thread_get','pronunciation_recent','quizzes','quiz_get','daily_assignment','practice_packs','practice_pack_get','daily_plan','weaknesses','course_catalog','sentence_patterns','connected_speech','toeic_questions','aptis_summary','aptis_questions','adaptive_summary','adaptive_library','learner_profile','knowledge_map','collocation_challenge','mistake_lesson','flashcard_books','handbooks','handbook_get','handbook_section','handbook_practice','handbook_related','admin_stats','admin_aptis_stats','admin_users','admin_card_bank','admin_toeic_questions','admin_toeic_get','admin_quizzes','admin_quiz_get','admin_daily_sets','admin_daily_get','admin_practice_packs','admin_practice_get'];
    if(in_array($action,$getActions,true)) return;
    if(($_SERVER['REQUEST_METHOD']??'GET')!=='POST') fail('Phương thức HTTP không hợp lệ.',405);
}
function exportSet(Repository $repo,int $uid,int $setId,string $format): never {
    $set=$repo->exportSetData($uid,$setId);$safe=preg_replace('/[^\pL\pN_-]+/u','-',mb_strtolower($set['title']));$safe=trim($safe,'-')?:'flashcards';
    if($format==='json'){header('Content-Type: application/json; charset=utf-8');header("Content-Disposition: attachment; filename=\"{$safe}.json\"");echo json_encode(['title'=>$set['title'],'description'=>$set['description'],'cards'=>$set['cards']],JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE);exit;}
    if($format==='txt'){header('Content-Type: text/plain; charset=utf-8');header("Content-Disposition: attachment; filename=\"{$safe}.txt\"");foreach($set['cards'] as $c)echo implode(' | ',[$c['term'],$c['definition'],$c['ipa'],$c['part_of_speech'],$c['example_en'],$c['example_vi'],$c['cefr']])."\n";exit;}
    header('Content-Type: text/csv; charset=utf-8');header("Content-Disposition: attachment; filename=\"{$safe}.csv\"");$out=fopen('php://output','wb');fwrite($out,"\xEF\xBB\xBF");fputcsv($out,['term','definition','ipa','part_of_speech','example_en','example_vi','cefr','notes','card_type','topic','subtopic','toeic_part','difficulty','pattern','collocations','word_family','explanation','tags','audio_text','source']);foreach($set['cards'] as $c)fputcsv($out,[$c['term'],$c['definition'],$c['ipa'],$c['part_of_speech'],$c['example_en'],$c['example_vi'],$c['cefr'],$c['notes'],$c['card_type']??'VOCABULARY',$c['topic']??'',$c['subtopic']??'',$c['toeic_part']??'',$c['difficulty']??1,$c['pattern']??'',$c['collocations']??'',$c['word_family']??'',$c['explanation']??'',$c['tags']??'',$c['audio_text']??'',$c['source']??'']);fclose($out);exit;
}

function practiceUploadErrorMessage(array $f): ?string {
    $err=(int)($f['error']??UPLOAD_ERR_OK);
    if($err===UPLOAD_ERR_OK)return null;
    return match($err){
        UPLOAD_ERR_INI_SIZE,UPLOAD_ERR_FORM_SIZE=>'File vượt quá giới hạn upload của hosting/PHP.',
        UPLOAD_ERR_PARTIAL=>'File chỉ được tải lên một phần. Hãy thử lại.',
        UPLOAD_ERR_NO_FILE=>'Chưa nhận được file tải lên.',
        UPLOAD_ERR_NO_TMP_DIR=>'Hosting thiếu thư mục tạm để nhận file.',
        UPLOAD_ERR_CANT_WRITE=>'Hosting không ghi được file tạm.',
        UPLOAD_ERR_EXTENSION=>'PHP extension trên hosting đã chặn file upload.',
        default=>'Upload file thất bại (mã lỗi '.$err.').'
    };
}
function practiceCsvRows(string $path): array {
    $fh=fopen($path,'rb');if(!$fh)throw new RuntimeException('Không đọc được CSV.');$sample=fgets($fh)?:'';rewind($fh);$delims=[','=>substr_count($sample,','),';'=>substr_count($sample,';'),"\t"=>substr_count($sample,"\t")];arsort($delims);$delimiter=(string)array_key_first($delims);$rows=[];while(($row=fgetcsv($fh,0,$delimiter))!==false){$rows[]=$row;if(count($rows)>401)break;}fclose($fh);return $rows;
}
function practiceStructuredRows(string $text): array {
    $rows=[];foreach(preg_split('/\R/u',trim($text)) as $line){$line=trim($line);if($line===''||str_starts_with($line,'#'))continue;$rows[]=preg_split('/\s*(?:\||\t|;|=>|—)\s*/u',$line);if(count($rows)>401)break;}return $rows;
}
function practiceUploadRows(string $path,string $name): array {
    $ext=strtolower(pathinfo($name,PATHINFO_EXTENSION));return match($ext){
        'txt'=>practiceStructuredRows((string)file_get_contents($path)),
        'csv'=>practiceCsvRows($path),
        'docx'=>practiceStructuredRows(DocxReader::extractText($path)),
        'xlsx'=>XlsxReader::rows($path),
        default=>throw new InvalidArgumentException('Chỉ hỗ trợ TXT, CSV, DOCX và XLSX.')
    };
}
function practiceHeader(string $v): string {$v=preg_replace('/^\xEF\xBB\xBF/','',trim($v));return mb_strtolower(preg_replace('/\s+/u','_',$v));}
function practiceImportItems(string $type,array $rows): array {
    $type=strtolower(trim($type));if(!in_array($type,['quiz','listening','fill','matching','speaking'],true))throw new InvalidArgumentException('Loại nội dung import không hợp lệ.');if(!$rows)return[];
    $spec=[
        'quiz'=>[
            'fields'=>['question','correct_answer','wrong_answer_1','wrong_answer_2','wrong_answer_3','explanation'],
            'aliases'=>['question'=>['question','câu_hỏi','cau_hoi','prompt'],'correct_answer'=>['correct_answer','answer','đáp_án_đúng','dap_an_dung'],'wrong_answer_1'=>['wrong_answer_1','wrong1','đáp_án_nhiễu_1','dap_an_nhieu_1'],'wrong_answer_2'=>['wrong_answer_2','wrong2','đáp_án_nhiễu_2','dap_an_nhieu_2'],'wrong_answer_3'=>['wrong_answer_3','wrong3','đáp_án_nhiễu_3','dap_an_nhieu_3'],'explanation'=>['explanation','giải_thích','giai_thich','note']],
            'required'=>['question','correct_answer'],'limit'=>300],
        'listening'=>[
            'fields'=>['audio_text','correct_answer','wrong_answer_1','wrong_answer_2','wrong_answer_3','prompt','explanation'],
            'aliases'=>['audio_text'=>['audio_text','audio','text','word','sentence','nội_dung_nghe','noi_dung_nghe'],'correct_answer'=>['correct_answer','answer','đáp_án_đúng','dap_an_dung','meaning'],'wrong_answer_1'=>['wrong_answer_1','wrong1','đáp_án_nhiễu_1','dap_an_nhieu_1'],'wrong_answer_2'=>['wrong_answer_2','wrong2','đáp_án_nhiễu_2','dap_an_nhieu_2'],'wrong_answer_3'=>['wrong_answer_3','wrong3','đáp_án_nhiễu_3','dap_an_nhieu_3'],'prompt'=>['prompt','question','câu_hỏi','cau_hoi'],'explanation'=>['explanation','giải_thích','giai_thich','note']],
            'required'=>['audio_text','correct_answer'],'limit'=>300],
        'fill'=>[
            'fields'=>['prompt','correct_answer','hint','explanation'],
            'aliases'=>['prompt'=>['prompt','question','sentence','câu_hỏi','cau_hoi','câu','cau'],'correct_answer'=>['correct_answer','answer','đáp_án_đúng','dap_an_dung','word'],'hint'=>['hint','gợi_ý','goi_y','meaning'],'explanation'=>['explanation','giải_thích','giai_thich','note']],
            'required'=>['prompt','correct_answer'],'limit'=>300],
        'matching'=>[
            'fields'=>['left_text','right_text'],
            'aliases'=>['left_text'=>['left_text','left','term','word','từ','tu','cột_a','cot_a'],'right_text'=>['right_text','right','definition','meaning','nghĩa','nghia','cột_b','cot_b']],
            'required'=>['left_text','right_text'],'limit'=>300],
        'speaking'=>[
            'fields'=>['target_text','hint'],
            'aliases'=>['target_text'=>['target_text','target','sentence','câu_mục_tiêu','cau_muc_tieu','prompt'],'hint'=>['hint','translation','meaning','gợi_ý','goi_y','dịch','dich']],
            'required'=>['target_text'],'limit'=>300],
    ][$type];
    $headers=array_map(fn($v)=>practiceHeader((string)$v),array_values($rows[0]??[]));$map=[];$detected=false;
    foreach($spec['aliases'] as $field=>$aliases){foreach($headers as $i=>$h){if(in_array($h,$aliases,true)){$map[$field]=$i;$detected=true;break;}}}
    if(!$detected){foreach($spec['fields'] as $i=>$field)$map[$field]=$i;$start=0;}else{$start=1;}
    $items=[];for($r=$start;$r<count($rows)&&count($items)<$spec['limit'];$r++){$row=array_values($rows[$r]);$item=[];foreach($spec['fields'] as $field)$item[$field]=trim((string)($row[$map[$field]??-1]??''));$ok=true;foreach($spec['required'] as $field)if(($item[$field]??'')===''){$ok=false;break;}if(!$ok)continue;
        if($type==='quiz')$items[]=['card_id'=>null,'question'=>$item['question'],'correct_answer'=>$item['correct_answer'],'wrong_answer_1'=>$item['wrong_answer_1'],'wrong_answer_2'=>$item['wrong_answer_2'],'wrong_answer_3'=>$item['wrong_answer_3'],'explanation'=>$item['explanation']];
        elseif($type==='listening')$items[]=['prompt'=>$item['prompt']?:'Nghe và chọn đáp án đúng.','answer'=>$item['correct_answer'],'wrong_answer_1'=>$item['wrong_answer_1'],'wrong_answer_2'=>$item['wrong_answer_2'],'wrong_answer_3'=>$item['wrong_answer_3'],'audio_text'=>$item['audio_text'],'hint'=>'','explanation'=>$item['explanation']];
        elseif($type==='fill')$items[]=['prompt'=>$item['prompt'],'answer'=>$item['correct_answer'],'wrong_answer_1'=>'','wrong_answer_2'=>'','wrong_answer_3'=>'','audio_text'=>'','hint'=>$item['hint'],'explanation'=>$item['explanation']];
        elseif($type==='matching')$items[]=['prompt'=>$item['left_text'],'answer'=>$item['right_text'],'wrong_answer_1'=>'','wrong_answer_2'=>'','wrong_answer_3'=>'','audio_text'=>'','hint'=>'','explanation'=>''];
        else $items[]=['prompt'=>$item['target_text'],'answer'=>$item['hint'],'wrong_answer_1'=>'','wrong_answer_2'=>'','wrong_answer_3'=>'','audio_text'=>'','hint'=>$item['hint'],'explanation'=>''];
    }
    return $items;
}

$action=(string)($_GET['action']??'');
enforceMethod($action);
try {
    if($action==='bootstrap'){ $u=$auth->user();respond(['user'=>$u,'csrf'=>$_SESSION['csrf'],'ai_enabled'=>$ai->enabled(),'ai_model'=>$ai->model()]); }
    if($action==='register'){ $d=input();$u=$auth->register((string)($d['name']??''),(string)($d['email']??''),(string)($d['password']??''));$_SESSION['csrf']=bin2hex(random_bytes(32));respond(['user'=>$u,'csrf'=>$_SESSION['csrf']]); }
    if($action==='login'){ $d=input();$u=$auth->login((string)($d['email']??''),(string)($d['password']??''),clientIp());$_SESSION['csrf']=bin2hex(random_bytes(32));respond(['user'=>$u,'csrf'=>$_SESSION['csrf']]); }
    if($action==='logout'){ $d=input();csrf($d);$auth->logout();respond(null,'Đã đăng xuất.'); }

    $user=$auth->requireUser();$uid=(int)$user['id'];
    if(in_array($action,['notebook_notes','notebook_get','notebook_save','notebook_archive','notebook_pin'],true)){
        require_once __DIR__.'/lib/LearningNotebook.php';$notebook=new LearningNotebook($db);
        if($action==='notebook_notes'){
            $query=$_GET;unset($query['action']);respond($notebook->list($uid,$query));
        }
        if($action==='notebook_get')respond($notebook->get($uid,$_GET['id']??null));
        if($action==='notebook_save')respond($notebook->save($uid,notebookPayload(['id','title','body','own_sentence','kind','is_pinned'])),'Đã lưu ghi chú.');
        if($action==='notebook_archive'){
            $d=notebookPayload(['id','archived']);respond($notebook->archive($uid,$d['id']??null,$d['archived']??null),'Đã cập nhật lưu trữ.');
        }
        if($action==='notebook_pin'){
            $d=notebookPayload(['id','pinned']);respond($notebook->pin($uid,$d['id']??null,$d['pinned']??null),'Đã cập nhật ghim ghi chú.');
        }
    }
    if($action==='dashboard')respond($repo->dashboard($uid));
    if($action==='profile')respond($repo->profile($uid));
    if($action==='learning_preferences')respond($repo->learningPreferences($uid));
    if($action==='learning_preferences_update'){ $d=input();csrf($d);respond($repo->updateLearningPreferences($uid,$d),'Đã cập nhật mục tiêu học.'); }
    if($action==='profile_update'){ $d=input();csrf($d);respond($repo->updateProfile($uid,$d),'Đã cập nhật hồ sơ.'); }
    if($action==='password_change'){ $d=input();csrf($d);$repo->changePassword($uid,(string)($d['current']??''),(string)($d['next']??''));respond(null,'Đã đổi mật khẩu.'); }
    if($action==='stats')respond($repo->stats($uid,(int)($_GET['days']??14)));
    if($action==='leaderboard')respond($repo->leaderboard($uid,(string)($_GET['period']??'week')));
    if($action==='mistakes')respond($repo->mistakes($uid,!empty($_GET['all']),(int)($_GET['limit']??100),isset($_GET['error_type'])?(string)$_GET['error_type']:null,(string)($_GET['q']??'')));
    if($action==='mistake_resolve'){ $d=input();csrf($d);$repo->resolveMistake($uid,(int)($d['id']??0));respond(null,'Đã đánh dấu đã ôn.'); }
    if($action==='mistake_reopen'){ $d=input();csrf($d);$repo->reopenMistake($uid,(int)($d['id']??0));respond(null,'Đã chuyển lại vào danh sách cần ôn.'); }

    if($action==='folders')respond($repo->folders($uid));
    if($action==='folder_create'){ $d=input();csrf($d);respond($repo->createFolder($uid,(string)($d['name']??''),(string)($d['icon']??'📁')),'Đã tạo thư mục.'); }
    if($action==='folder_update'){ $d=input();csrf($d);respond($repo->updateFolder($uid,(int)($d['id']??0),(string)($d['name']??''),(string)($d['icon']??'📁')),'Đã cập nhật thư mục.'); }
    if($action==='folder_delete'){ $d=input();csrf($d);$repo->deleteFolder($uid,(int)($d['id']??0));respond(null,'Đã xóa thư mục. Các bộ từ vẫn được giữ lại.'); }

    if($action==='sets')respond($repo->sets($uid,(string)($_GET['q']??''),i($_GET['folder_id']??null)));
    if($action==='set_get')respond($repo->getSet($uid,(int)($_GET['id']??0),(int)($_GET['page']??1),(int)($_GET['limit']??100),(string)($_GET['q']??''),isset($_GET['card_type'])?(string)$_GET['card_type']:null));
    if($action==='set_create'){ $d=input();csrf($d);respond($repo->createSet($uid,(string)($d['title']??''),(string)($d['description']??''),i($d['folder_id']??null),(string)($d['source_type']??'manual')),'Đã tạo bộ từ.'); }
    if($action==='set_update'){ $d=input();csrf($d);respond($repo->updateSet($uid,(int)($d['id']??0),$d),'Đã cập nhật bộ từ.'); }
    if($action==='set_delete'){ $d=input();csrf($d);$repo->deleteSet($uid,(int)($d['id']??0));respond(null,'Đã xóa bộ từ.'); }
    if($action==='export_set')exportSet($repo,$uid,(int)($_GET['id']??0),(string)($_GET['format']??'csv'));

    if($action==='card_create'){ $d=input();csrf($d);respond($repo->createCard($uid,(int)($d['set_id']??0),$d),'Đã thêm flashcard.'); }
    if($action==='card_update'){ $d=input();csrf($d);respond($repo->updateCard($uid,(int)($d['id']??0),$d),'Đã lưu flashcard.'); }
    if($action==='card_delete'){ $d=input();csrf($d);$repo->deleteCard($uid,(int)($d['id']??0));respond(null,'Đã xóa flashcard.'); }
    if($action==='sentence_pattern_create'){ $d=input();csrf($d);respond($repo->createSentencePattern($uid,$d),'Đã thêm cấu trúc câu.'); }
    if($action==='sentence_pattern_update'){ $d=input();csrf($d);respond($repo->updateSentencePattern($uid,(int)($d['id']??0),$d),'Đã cập nhật cấu trúc câu.'); }
    if($action==='sentence_pattern_delete'){ $d=input();csrf($d);$card=$repo->ownCard($uid,(int)($d['id']??0));if(($card['card_type']??'')!=='SENTENCE_PATTERN')throw new InvalidArgumentException('Flashcard này không phải cấu trúc câu.');$repo->deleteCard($uid,(int)$card['id']);respond(null,'Đã xóa cấu trúc câu.'); }
    if($action==='sentence_pattern_import'){
        csrf($_POST);if(empty($_FILES['file']))throw new InvalidArgumentException('Hãy chọn file cấu trúc câu để import.');$f=$_FILES['file'];if($msg=practiceUploadErrorMessage($f))throw new InvalidArgumentException($msg);if(empty($f['tmp_name'])||!is_uploaded_file($f['tmp_name']))throw new InvalidArgumentException('Server không nhận được file tạm. Hãy chọn lại file.');if((int)$f['size']>(int)$config['max_upload_bytes'])throw new InvalidArgumentException('File quá lớn. Giới hạn '.round($config['max_upload_bytes']/1048576).' MB.');$ext=strtolower(pathinfo((string)$f['name'],PATHINFO_EXTENSION));if(!in_array($ext,['txt','csv','docx','xlsx'],true))throw new InvalidArgumentException('Import cấu trúc hỗ trợ TXT, CSV, DOCX và XLSX.');
        $cards=Importer::fromFile($f['tmp_name'],$f['name']);if(!$cards)throw new InvalidArgumentException('Không tìm thấy cấu trúc hợp lệ. Hãy dùng template Cấu trúc câu hoặc file sentence_patterns_v2.');
        foreach($cards as &$card){$card['card_type']='SENTENCE_PATTERN';if(trim((string)($card['pattern']??''))==='')$card['pattern']=(string)($card['term']??'');}$setId=i($_POST['set_id']??null)??0;$result=$repo->bulkInsertSentencePatterns($uid,$setId,$cards);$repo->logImport($uid,(string)$f['name'],$ext,(int)$result['count']);respond($result,'Đã import '.$result['count'].' cấu trúc câu.');
    }

    if($action==='study_lessons')respond($repo->studyLessons($uid,(int)($_GET['set_id']??0),(int)($_GET['size']??20)));
    if($action==='study_lesson_cards')respond($repo->studyLessonCards($uid,(int)($_GET['set_id']??0),(int)($_GET['unit']??1),(int)($_GET['size']??20)));
    if($action==='study_cards'){ $mode=(string)($_GET['mode']??'review');$set=i($_GET['set_id']??null);$limit=(int)($_GET['limit']??30);$unit=i($_GET['unit']??null);if(in_array($mode,['due','relearning','hard','new'],true))respond($repo->priorityCards($uid,$mode,$limit));if($mode==='lesson'){if(!$set||!$unit)throw new InvalidArgumentException('Thiếu bộ từ hoặc bài học.');$lesson=$repo->studyLessonCards($uid,$set,$unit,20);respond($lesson['cards']??[]);}respond($mode==='review'?$repo->dueCards($uid,$set,$limit,$unit):$repo->randomCards($uid,$set,$limit)); }
    if($action==='review_rate'){ $d=input();csrf($d);respond($repo->review($uid,(int)($d['card_id']??0),(int)($d['rating']??3))); }
    if($action==='study_event'){ $d=input();csrf($d);$context=is_array($d['context']??null)?$d['context']:[];$repo->recordEvent($uid,(string)($d['mode']??'quiz'),i($d['set_id']??null),i($d['card_id']??null),isset($d['result'])?(int)$d['result']:null,isset($d['score'])?(float)$d['score']:null,(int)($d['xp']??0),(int)($d['duration']??0),$context);respond(null); }

    if($action==='import_file'){
        csrf($_POST);if(empty($_FILES['file'])||!is_uploaded_file($_FILES['file']['tmp_name']))throw new InvalidArgumentException('Hãy chọn file để tải lên.');$f=$_FILES['file'];if((int)$f['size']>(int)$config['max_upload_bytes'])throw new InvalidArgumentException('File quá lớn. Giới hạn '.round($config['max_upload_bytes']/1048576).' MB.');$ext=strtolower(pathinfo($f['name'],PATHINFO_EXTENSION));if(!in_array($ext,['txt','csv','docx','xlsx'],true))throw new InvalidArgumentException('Chỉ hỗ trợ TXT, CSV, DOCX, XLSX.');
        $cards=Importer::fromFile($f['tmp_name'],$f['name']);$extract=!empty($_POST['ai_extract']);if(!$cards&&$extract){$text=$ext==='docx'?DocxReader::extractText($f['tmp_name']):($ext==='txt'?(string)file_get_contents($f['tmp_name']):'');if($text!=='')$cards=$ai->extractCardsFromText($text,(int)($_POST['max_cards']??80));}
        if(!$cards)throw new InvalidArgumentException('Không tìm thấy cặp từ + nghĩa trong file. Với bài đọc DOCX/TXT, bật “AI trích từ vựng”.');$setId=i($_POST['set_id']??null);if(!$setId){$title=trim((string)($_POST['title']??pathinfo($f['name'],PATHINFO_FILENAME)));$set=$repo->createSet($uid,$title,'Nhập từ '.$f['name'],i($_POST['folder_id']??null),'import');$setId=(int)$set['id'];}$count=$repo->bulkInsertCards($uid,$setId,$cards);$repo->logImport($uid,$f['name'],$ext,$count);respond(['set_id'=>$setId,'count'=>$count],'Đã nhập '.$count.' flashcard.');
    }
    if($action==='ai_generate'){ $d=input();csrf($d);$topic=trim((string)($d['topic']??''));if($topic==='')throw new InvalidArgumentException('Hãy nhập chủ đề.');$cards=$ai->generateCards($topic,(int)($d['count']??20),strtoupper((string)($d['level']??$user['english_level'])));$set=$repo->createSet($uid,(string)($d['title']??$topic),'Tạo bởi YangLingo AI',i($d['folder_id']??null),'ai');$count=$repo->bulkInsertCards($uid,(int)$set['id'],$cards);respond(['set_id'=>(int)$set['id'],'count'=>$count,'ai_enabled'=>$ai->enabled()],'Đã tạo bộ từ AI.'); }

    if($action==='threads')respond($repo->threads($uid));
    if($action==='thread_get')respond($repo->thread($uid,(string)($_GET['id']??'')));
    if($action==='thread_create'){ $d=input();csrf($d);respond($repo->newThread($uid,(string)($d['mode']??'tutor'))); }
    if($action==='tutor_message'){
        $d=input();csrf($d);$threadId=(string)($d['thread_id']??'');$mode=(string)($d['mode']??'tutor');$message=trim((string)($d['message']??''));if($message==='')throw new InvalidArgumentException('Tin nhắn đang trống.');if($threadId==='')$threadId=$repo->newThread($uid,$mode)['id'];$repo->addThreadMessage($uid,$threadId,'user',$message);$thread=$repo->thread($uid,$threadId);$msgs=[['role'=>'system','content'=>$ai->tutorPrompt($mode,(string)$user['english_level'])]];foreach(array_slice($thread['messages'],-16) as $m)$msgs[]=['role'=>$m['role'],'content'=>$m['content']];$reply=$ai->chat($msgs,$mode==='speaking'?.75:.45,1200);$repo->addThreadMessage($uid,$threadId,'assistant',$reply);$repo->recordEvent($uid,'tutor',null,null,null,null,2,0);respond(['thread_id'=>$threadId,'reply'=>$reply,'ai_enabled'=>$ai->enabled()]);
    }
    if($action==='pronunciation_feedback'){ $d=input();csrf($d);$target=trim((string)($d['target']??''));$trans=trim((string)($d['transcript']??''));$score=max(0,min(100,(float)($d['score']??0)));if($target===''||$trans==='')throw new InvalidArgumentException('Thiếu câu mục tiêu hoặc transcript.');$feedback=$ai->speakingFeedback($target,$trans,$score,(string)$user['english_level']);$repo->savePronunciation($uid,$target,$trans,$score,$feedback);respond(['feedback'=>$feedback,'ai_enabled'=>$ai->enabled()]); }
    if($action==='pronunciation_recent')respond($repo->recentPronunciation($uid));

    if($action==='quizzes')respond($repo->publishedQuizzes());
    if($action==='quiz_get')respond($repo->publishedQuiz((int)($_GET['id']??0)));
    if($action==='daily_assignment')respond($repo->dailyAssignment((string)($_GET['date']??date('Y-m-d'))));
    if($action==='practice_packs')respond($repo->publishedPracticePacks((string)($_GET['type']??'')));
    if($action==='practice_pack_get')respond($repo->publishedPracticePack((int)($_GET['id']??0),(string)($_GET['type']??'')));
    if($action==='daily_plan')respond($repo->dailyPlan($uid));
    if($action==='weaknesses')respond($repo->weaknesses($uid,(int)($_GET['days']??7)));
    if($action==='course_catalog')respond($repo->courseCatalog());
    if($action==='sentence_patterns')respond($repo->sentencePatterns($uid,(string)($_GET['q']??''),(string)($_GET['topic']??'')));
    if($action==='connected_speech')respond($repo->connectedSpeechExamples());
    if($action==='toeic_questions')respond($repo->toeicQuestions((int)($_GET['part']??5),(int)($_GET['limit']??10)));
    if($action==='toeic_attempt'){ $d=input();csrf($d);respond($repo->recordToeicAttempt($uid,(int)($d['question_id']??0),(string)($d['selected_answer']??''),(int)($d['duration']??0))); }

    if($action==='adaptive_summary')respond($repo->globalLearningSummary());
    if($action==='adaptive_library')respond($repo->globalLearningItems((string)($_GET['type']??''),(string)($_GET['q']??''),(string)($_GET['topic']??''),(int)($_GET['limit']??60)));
    if($action==='learner_profile')respond($repo->learnerProfile($uid,(int)($_GET['days']??30)));
    if($action==='knowledge_map')respond($repo->knowledgeMap($uid,(int)($_GET['days']??30)));
    if($action==='collocation_challenge')respond($repo->collocationChallenge($uid));
    if($action==='collocation_attempt'){ $d=input();csrf($d);respond($repo->recordCollocationAttempt($uid,(int)($d['item_id']??0),(string)($d['selected_answer']??''))); }
    if($action==='mistake_lesson')respond($repo->mistakeMicroLesson($uid,(int)($_GET['id']??0)));
    if($action==='mistake_remedial_attempt'){ $d=input();csrf($d);respond($repo->recordRemedialAttempt($uid,(int)($d['mistake_id']??0),(string)($d['question_source']??'fallback'),(int)($d['question_id']??0),(string)($d['selected_answer']??''),(string)($d['prompt']??''),(string)($d['correct_answer']??''),(string)($d['explanation']??''))); }
    if($action==='adaptive_save_to_srs'){ $d=input();csrf($d);respond($repo->saveGlobalItemToSrs($uid,(int)($d['item_id']??0)),'Đã thêm vào SRS cá nhân.'); }

    if($action==='flashcard_books')respond($repo->flashcardBooks($uid));
    if($action==='flashcard_books_sync'){ $d=input();csrf($d);respond($repo->ensureFlashcardBooksInstalled($uid),'Đã đồng bộ các Bộ Flashcard TOEIC vào Thư viện.'); }
    if($action==='flashcard_book_install'){ $d=input();csrf($d);respond($repo->installFlashcardBook($uid,(string)($d['code']??'')),'Đã tạo Flashcard Book cá nhân.'); }

    if($action==='handbooks')respond($repo->handbooks($uid));
    if($action==='handbook_get')respond($repo->handbook($uid,(string)($_GET['code']??'')));
    if($action==='handbook_section')respond($repo->handbookSection($uid,(int)($_GET['id']??0)));
    if($action==='handbook_practice')respond($repo->handbookPractice($uid,(int)($_GET['section_id']??0),(int)($_GET['limit']??120)));
    if($action==='handbook_related')respond($repo->handbookRelatedItems($uid,(int)($_GET['section_id']??0),(string)($_GET['q']??''),(int)($_GET['limit']??40)));
    if($action==='handbook_mark'){ $d=input();csrf($d);respond($repo->markHandbookSection($uid,(int)($d['section_id']??0),!empty($d['completed'])),'Đã cập nhật tiến độ handbook.'); }

    if($action==='aptis_summary')respond($repo->aptisSummary($uid));
    if($action==='aptis_questions')respond($repo->aptisQuestions((string)($_GET['module']??'grammar'),(int)($_GET['limit']??10)));
    if($action==='aptis_attempt'){ $d=input();csrf($d);respond($repo->recordAptisAttempt($uid,(int)($d['question_id']??0),(string)($d['selected_answer']??''),(int)($d['duration']??0),(string)($d['mode']??'practice'))); }
    if($action==='aptis_writing_submit'){ $d=input();csrf($d);respond($repo->saveAptisWriting($uid,(int)($d['question_id']??0),(string)($d['response_text']??''),(int)($d['self_score']??0),(string)($d['notes']??''))); }
    if($action==='aptis_speaking_submit'){ $d=input();csrf($d);respond($repo->saveAptisSpeaking($uid,(int)($d['question_id']??0),(int)($d['duration_seconds']??0),(int)($d['self_score']??0),(string)($d['notes']??''))); }

    if(str_starts_with($action,'admin_')){
        $admin=$auth->requireAdmin();
        if($action==='admin_stats')respond($repo->adminStats());
        if($action==='admin_aptis_stats')respond($repo->adminAptisStats());
        if($action==='admin_aptis_import'){
            csrf($_POST);if(empty($_FILES['file'])||!is_uploaded_file($_FILES['file']['tmp_name']))throw new InvalidArgumentException('Hãy chọn file CSV Aptis.');$f=$_FILES['file'];if((int)$f['size']<=0||(int)$f['size']>(int)$config['max_upload_bytes'])throw new InvalidArgumentException('File CSV trống hoặc vượt giới hạn upload.');if(strtolower(pathinfo((string)$f['name'],PATHINFO_EXTENSION))!=='csv')throw new InvalidArgumentException('Aptis import hiện nhận file CSV.');
            $h=fopen($f['tmp_name'],'rb');if(!$h)throw new RuntimeException('Không đọc được file CSV.');$head=fgetcsv($h);if(!$head){fclose($h);throw new InvalidArgumentException('CSV không có header.');}$head=array_map(fn($v)=>strtolower(trim((string)$v)),$head);$count=0;$skipped=0;$rowsRead=0;$maxRows=2000;
            while(($row=fgetcsv($h))!==false){if(++$rowsRead>$maxRows){fclose($h);throw new InvalidArgumentException('CSV Aptis vượt giới hạn 2.000 dòng mỗi lần import.');}$d=[];foreach($head as $k=>$name)if($name!=='')$d[$name]=$row[$k]??'';if(trim((string)($d['prompt']??''))===''){$skipped++;continue;}try{$repo->adminSaveAptisQuestion((int)$admin['id'],$d);$count++;}catch(InvalidArgumentException $e){$skipped++;}}fclose($h);respond(['imported'=>$count,'skipped'=>$skipped],'Đã import ngân hàng Aptis.');
        }
        if($action==='admin_users')respond($repo->adminUsers((string)($_GET['q']??'')));
        if($action==='admin_user_update'){ $d=input();csrf($d);$repo->adminUpdateUser((int)$admin['id'],(int)($d['id']??0),$d);respond(null,'Đã cập nhật tài khoản.'); }
        if($action==='admin_card_bank')respond($repo->adminCardBank((string)($_GET['q']??''),i($_GET['set_id']??null),(int)($_GET['limit']??50),(int)($_GET['offset']??0)));
        if($action==='admin_card_update'){ $d=input();csrf($d);respond($repo->adminUpdateAnyCard((int)($d['id']??0),$d),'Đã cập nhật flashcard.'); }
        if($action==='admin_toeic_questions')respond($repo->adminToeicQuestions(i($_GET['part']??null),(int)($_GET['limit']??100)));
        if($action==='admin_toeic_get')respond($repo->adminToeicQuestion((int)($_GET['id']??0)));
        if($action==='admin_toeic_save'){ $d=input();csrf($d);respond($repo->adminSaveToeicQuestion((int)$admin['id'],$d),'Đã lưu câu TOEIC.'); }
        if($action==='admin_toeic_delete'){ $d=input();csrf($d);$repo->adminDeleteToeicQuestion((int)($d['id']??0));respond(null,'Đã ẩn câu TOEIC.'); }
        if($action==='admin_quizzes')respond($repo->adminQuizzes());
        if($action==='admin_quiz_get')respond($repo->adminQuiz((int)($_GET['id']??0)));
        if($action==='admin_quiz_save'){ $d=input();csrf($d);respond($repo->adminSaveQuiz((int)$admin['id'],$d),'Đã lưu đề.'); }
        if($action==='admin_quiz_save_begin'){ $d=input();csrf($d);respond($repo->adminBeginQuizSave((int)$admin['id'],$d),'Đã tạo phiên lưu đề.'); }
        if($action==='admin_quiz_save_chunk'){ $d=input();csrf($d);respond($repo->adminAppendQuizSave((int)$admin['id'],$d),'Đã lưu một phần câu hỏi.'); }
        if($action==='admin_quiz_save_finish'){ $d=input();csrf($d);respond($repo->adminFinishQuizSave((int)$admin['id'],$d),'Đã lưu đề hoàn chỉnh.'); }
        if($action==='admin_quiz_delete'){ $d=input();csrf($d);$repo->adminDeleteQuiz((int)($d['id']??0));respond(null,'Đã xóa đề.'); }
        if($action==='admin_daily_sets')respond($repo->adminDailySets());
        if($action==='admin_daily_get')respond($repo->adminDailySet((int)($_GET['id']??0)));
        if($action==='admin_daily_save'){ $d=input();csrf($d);respond($repo->adminSaveDaily((int)$admin['id'],$d),'Đã lưu flashcard theo ngày.'); }
        if($action==='admin_daily_delete'){ $d=input();csrf($d);$repo->adminDeleteDaily((int)($d['id']??0));respond(null,'Đã xóa lịch flashcard.'); }
        if($action==='admin_practice_packs')respond($repo->adminPracticePacks(isset($_GET['type'])?(string)$_GET['type']:null));
        if($action==='admin_practice_get')respond($repo->adminPracticePack((int)($_GET['id']??0)));
        if($action==='admin_practice_save'){ $d=input();csrf($d);respond($repo->adminSavePractice((int)$admin['id'],$d),'Đã lưu bài luyện tập.'); }
        if($action==='admin_practice_delete'){ $d=input();csrf($d);$repo->adminDeletePractice((int)($d['id']??0));respond(null,'Đã xóa bài luyện tập.'); }
        if($action==='admin_listening_audio_upload'){
            csrf($_POST);
            if(empty($_FILES['file'])||!is_uploaded_file($_FILES['file']['tmp_name']))throw new InvalidArgumentException('Hãy chọn file âm thanh để tải lên.');
            $f=$_FILES['file'];
            $max=(int)($config['max_upload_bytes']??10485760);
            if((int)$f['size']<=0)throw new InvalidArgumentException('File âm thanh đang trống.');
            if((int)$f['size']>$max)throw new InvalidArgumentException('File âm thanh quá lớn. Giới hạn '.round($max/1048576).' MB trên cấu hình hiện tại.');
            $ext=strtolower(pathinfo((string)$f['name'],PATHINFO_EXTENSION));
            $allowed=['mp3'=>'audio/mpeg','wav'=>'audio/wav','m4a'=>'audio/mp4','ogg'=>'audio/ogg','webm'=>'audio/webm'];
            if(!isset($allowed[$ext]))throw new InvalidArgumentException('Chỉ hỗ trợ MP3, WAV, M4A, OGG hoặc WEBM.');
            if(function_exists('finfo_open')){
                $fi=finfo_open(FILEINFO_MIME_TYPE);$mime=$fi?finfo_file($fi,$f['tmp_name']):'';if($fi)finfo_close($fi);
                $okMimes=['audio/mpeg','audio/mp3','audio/wav','audio/x-wav','audio/wave','audio/mp4','video/mp4','audio/x-m4a','audio/ogg','application/ogg','audio/webm','video/webm','application/octet-stream'];
                if($mime&&!in_array($mime,$okMimes,true))throw new InvalidArgumentException('File tải lên không được nhận diện là âm thanh hợp lệ.');
            }
            $dir=__DIR__.'/uploads/listening';if(!is_dir($dir)&&!mkdir($dir,0755,true)&&!is_dir($dir))throw new RuntimeException('Không tạo được thư mục uploads/listening.');
            $name=date('Ymd-His').'-'.bin2hex(random_bytes(8)).'.'.$ext;$dest=$dir.'/'.$name;
            if(!move_uploaded_file($f['tmp_name'],$dest))throw new RuntimeException('Không lưu được file âm thanh trên hosting.');
            respond(['path'=>'uploads/listening/'.$name,'name'=>$f['name'],'size'=>(int)$f['size']],'Đã upload file nghe.');
        }
        if($action==='admin_practice_import'){
            csrf($_POST);$type=(string)($_POST['type']??'');if(empty($_FILES['file']))throw new InvalidArgumentException('Hãy chọn file để tải lên.');$f=$_FILES['file'];if($msg=practiceUploadErrorMessage($f))throw new InvalidArgumentException($msg);if(empty($f['tmp_name'])||!is_uploaded_file($f['tmp_name']))throw new InvalidArgumentException('Server không nhận được file tạm. Hãy chọn lại file và thử lại.');if((int)$f['size']>(int)$config['max_upload_bytes'])throw new InvalidArgumentException('File quá lớn. Giới hạn '.round($config['max_upload_bytes']/1048576).' MB.');$ext=strtolower(pathinfo((string)$f['name'],PATHINFO_EXTENSION));if(!in_array($ext,['txt','csv','docx','xlsx'],true))throw new InvalidArgumentException('Chỉ hỗ trợ TXT, CSV, DOCX, XLSX.');$items=practiceImportItems($type,practiceUploadRows($f['tmp_name'],$f['name']));if(!$items)throw new InvalidArgumentException('Không tìm thấy dòng dữ liệu hợp lệ. Hãy tải file mẫu và kiểm tra đúng tên cột.');respond(['type'=>$type,'filename'=>$f['name'],'count'=>count($items),'limit'=>$type==='quiz'?300:300,'items'=>$items],'Đã đọc '.count($items).' mục từ file.');
        }
    }
    fail('API action không tồn tại.',404);
} catch(AuthException $e){fail($e->getMessage(),$e->status);} catch(LearningNotebookException $e){fail($e->getMessage(),$e->status);} catch(InvalidArgumentException $e){fail($e->getMessage(),422);} catch(Throwable $e){if(function_exists('yl_log'))yl_log($e);$debug=!empty($config['debug']);fail($debug?$e->getMessage():'Đã xảy ra lỗi máy chủ. Vui lòng thử lại.',500);}
