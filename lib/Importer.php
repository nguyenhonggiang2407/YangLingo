<?php
final class Importer {
    private const TYPES=['VOCABULARY','COLLOCATION','SENTENCE_PATTERN','GRAMMAR','LISTENING_CHUNK','MISTAKE_CARD'];
    public static function fromFile(string $path,string $name): array {
        $ext=strtolower(pathinfo($name,PATHINFO_EXTENSION));return match($ext){
            'txt'=>self::parseStructured((string)file_get_contents($path)),
            'csv'=>self::parseRows(self::csvRows($path)),
            'docx'=>self::parseStructured(DocxReader::extractText($path)),
            'xlsx'=>self::parseRows(XlsxReader::rows($path)),
            default=>throw new InvalidArgumentException('Chỉ hỗ trợ TXT, CSV, DOCX và XLSX.')
        };
    }
    public static function parseStructured(string $text): array {$lines=preg_split('/\R/u',trim($text));$cards=[];foreach($lines as $line){$line=trim($line);if($line===''||str_starts_with($line,'#'))continue;$parts=preg_split('/\s*(?:\||\t|;|=>|—)\s*/u',$line);if(count($parts)<2)continue;$card=self::card($parts);if($card)$cards[]=$card;if(count($cards)>=1000)break;}return $cards;}
    public static function parseRows(array $rows): array {
        if(!$rows)return[];$start=0;
        $fields=['term','definition','ipa','part_of_speech','example_en','example_vi','cefr','notes','card_type','topic','subtopic','toeic_part','difficulty','pattern','collocations','word_family','explanation','tags','audio_text','source'];
        $map=[];foreach($fields as $i=>$f)$map[$f]=$i;
        $headers=array_map(fn($v)=>self::normHeader((string)$v),array_values($rows[0]??[]));
        $aliases=[
          'term'=>['term','word','từ','tu','english','title','pattern_title'],'definition'=>['definition','meaning','nghĩa','nghia','vietnamese','meaning_vi'],'ipa'=>['ipa','phonetic'],'part_of_speech'=>['part_of_speech','pos','type','từ_loại','tu_loai'],'example_en'=>['example_en','example','ví_dụ','vi_du'],'example_vi'=>['example_vi','translation','dịch_ví_dụ','dich_vi_du'],'cefr'=>['cefr','level'],'notes'=>['notes','note','ghi_chú','ghi_chu'],
          'card_type'=>['card_type','content_type','loại_thẻ','loai_the'],'topic'=>['topic','chủ_đề','chu_de','category'],'subtopic'=>['subtopic','chủ_đề_phụ','chu_de_phu'],'toeic_part'=>['toeic_part','part'],'difficulty'=>['difficulty','độ_khó','do_kho'],'pattern'=>['pattern','sentence_pattern','cấu_trúc','cau_truc'],'collocations'=>['collocations','collocation'],'word_family'=>['word_family','family'],'explanation'=>['explanation','giải_thích','giai_thich','grammar_note'],'tags'=>['tags','tag'],'audio_text'=>['audio_text','listening_text','transcript'],'source'=>['source','nguồn','nguon']
        ];
        $headerDetected=false;$mapped=[];foreach($aliases as $key=>$list){foreach($headers as $i=>$h){if(in_array($h,$list,true)){$map[$key]=$i;$mapped[$key]=true;$headerDetected=true;break;}}}if($headerDetected){$start=1;foreach($fields as $field)if(!isset($mapped[$field]))$map[$field]=-1;}
        $headerIndex=[];foreach($headers as $i=>$h)$headerIndex[$h]=$i;
        $patternDataset=$headerDetected&&in_array('pattern',$headers,true)&&(in_array('meaning_vi',$headers,true)||in_array('grammar_note',$headers,true)||in_array('title',$headers,true));
        $cards=[];for($r=$start;$r<count($rows)&&count($cards)<1000;$r++){
            $row=$rows[$r];$parts=[];foreach($map as $k=>$i)$parts[$k]=trim((string)($row[$i]??''));
            if($patternDataset){
                if(($parts['card_type']??'')==='')$parts['card_type']='SENTENCE_PATTERN';
                if(($parts['term']??'')===''&&($parts['pattern']??'')!=='')$parts['term']=$parts['pattern'];
                if(($parts['audio_text']??'')===''&&($parts['example_en']??'')!=='')$parts['audio_text']=$parts['example_en'];
                if(($parts['source']??'')==='')$parts['source']='sentence_pattern_import';
                $cloze=trim((string)($row[$headerIndex['cloze_question']??-1]??''));
                $answer=trim((string)($row[$headerIndex['correct_answer']??-1]??''));
                $distractors=trim((string)($row[$headerIndex['distractors']??-1]??''));
                if(($parts['notes']??'')===''&&($cloze!==''||$answer!==''||$distractors!=='')){
                    $note=[];if($cloze!=='')$note[]='Cloze: '.$cloze;if($answer!=='')$note[]='Đáp án: '.$answer;if($distractors!=='')$note[]='Nhiễu: '.str_replace('||','; ',$distractors);$parts['notes']=implode("\n",$note);
                }
            }
            if(($parts['term']??'')===''||($parts['definition']??'')==='')continue;$cards[]=self::validate($parts);
        }return $cards;
    }
    private static function normHeader(string $v): string {$v=preg_replace('/^\xEF\xBB\xBF/','',trim($v));return mb_strtolower(preg_replace('/\s+/u','_',$v));}
    private static function validate(array $c): array {$type=strtoupper(trim((string)($c['card_type']??'VOCABULARY')));if($type==='')$type='VOCABULARY';if(!in_array($type,self::TYPES,true))throw new InvalidArgumentException('card_type không hợp lệ: '.$type);$part=trim((string)($c['toeic_part']??''));if($part!==''&&((int)$part<1||(int)$part>7))throw new InvalidArgumentException('toeic_part chỉ nhận giá trị 1–7.');$diff=trim((string)($c['difficulty']??''));if($diff!==''&&((int)$diff<1||(int)$diff>5))throw new InvalidArgumentException('difficulty chỉ nhận giá trị 1–5.');$c['card_type']=$type;$c['toeic_part']=$part;$c['difficulty']=$diff===''?'1':$diff;return $c;}
    private static function csvRows(string $path): array {$fh=fopen($path,'rb');if(!$fh)throw new RuntimeException('Không đọc được CSV.');$sample=fgets($fh)?:'';rewind($fh);$delims=[','=>substr_count($sample,','),';'=>substr_count($sample,';'),"\t"=>substr_count($sample,"\t")];arsort($delims);$delimiter=(string)array_key_first($delims);$rows=[];while(($r=fgetcsv($fh,0,$delimiter))!==false){$rows[]=$r;if(count($rows)>1001)break;}fclose($fh);return $rows;}
    private static function card(array $p): ?array {if(isset($p['term']))return self::validate($p);$term=trim((string)($p[0]??''));$definition=trim((string)($p[1]??''));if($term===''||$definition==='')return null;return self::validate(['term'=>$term,'definition'=>$definition,'ipa'=>trim((string)($p[2]??'')),'part_of_speech'=>trim((string)($p[3]??'')),'example_en'=>trim((string)($p[4]??'')),'example_vi'=>trim((string)($p[5]??'')),'cefr'=>trim((string)($p[6]??'')),'notes'=>trim((string)($p[7]??'')),'card_type'=>trim((string)($p[8]??'VOCABULARY')),'topic'=>trim((string)($p[9]??'')),'subtopic'=>trim((string)($p[10]??'')),'toeic_part'=>trim((string)($p[11]??'')),'difficulty'=>trim((string)($p[12]??'1')),'pattern'=>trim((string)($p[13]??'')),'collocations'=>trim((string)($p[14]??'')),'word_family'=>trim((string)($p[15]??'')),'explanation'=>trim((string)($p[16]??'')),'tags'=>trim((string)($p[17]??'')),'audio_text'=>trim((string)($p[18]??'')),'source'=>trim((string)($p[19]??''))]);}
}
