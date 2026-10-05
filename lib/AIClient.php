<?php
final class AIClient {
    public function __construct(private array $config) {}
    public function enabled(): bool { return trim((string)($this->config['openrouter_api_key']??''))!==''; }
    public function model(): string { return (string)($this->config['openrouter_model']??'openrouter/free'); }
    public function chat(array $messages,float $temperature=.5,int $maxTokens=1400): string {
        if(!$this->enabled()) throw new RuntimeException('Tính năng AI chưa được cấu hình. Hãy thêm API key trong cấu hình server.');
        $payload=json_encode(['model'=>$this->model(),'messages'=>$messages,'temperature'=>$temperature,'max_tokens'=>$maxTokens],JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
        $headers=['Content-Type: application/json','Authorization: Bearer '.$this->config['openrouter_api_key'],'X-Title: '.($this->config['app_name']??'YangLingo')];$appUrl=trim((string)($this->config['app_url']??''));if($appUrl!=='')$headers[]='HTTP-Referer: '.$appUrl;
        $ctx=stream_context_create(['http'=>['method'=>'POST','header'=>implode("\r\n",$headers),'content'=>$payload,'timeout'=>55,'ignore_errors'=>true]]);
        $raw=@file_get_contents('https://openrouter.ai/api/v1/chat/completions',false,$ctx);
        if($raw===false) throw new RuntimeException('Không kết nối được OpenRouter. Kiểm tra Internet hoặc cấu hình allow_url_fopen/cURL.');
        $j=json_decode($raw,true); if(!isset($j['choices'][0]['message']['content'])) throw new RuntimeException($j['error']['message']??'OpenRouter trả về phản hồi không hợp lệ.');
        return trim((string)$j['choices'][0]['message']['content']);
    }
    public function tutorPrompt(string $mode,string $level): string {
        $base="Bạn là YangLingo AI, gia sư tiếng Anh cá nhân cho người Việt. Trình độ học viên: {$level}. Luôn dạy có mục tiêu, sửa lỗi rõ ràng, giải thích ngắn gọn bằng tiếng Việt khi cần và khuyến khích học viên tự trả lời. Không bịa kiến thức.";
        return match($mode){
            'grammar'=>$base.' Tập trung ngữ pháp: chỉ ra lỗi, quy tắc, ví dụ đúng/sai và cho 1 câu luyện tiếp.',
            'writing'=>$base.' Tập trung Writing: sửa tự nhiên, giữ ý người học, đánh dấu lỗi quan trọng, cho phiên bản tốt hơn và 2 điểm cần cải thiện.',
            'speaking'=>$base.' Đóng vai giáo viên hội thoại. Trả lời chủ yếu bằng tiếng Anh phù hợp trình độ, sửa lỗi ngắn gọn sau câu của học viên và duy trì hội thoại tự nhiên.',
            default=>$base.' Dạy theo phong cách Socratic: giải thích, ví dụ, rồi hỏi lại một câu ngắn để kiểm tra hiểu bài.'
        };
    }
    public function generateCards(string $topic,int $count,string $level): array {
        $count=max(3,min(100,$count));
        if(!$this->enabled()) throw new RuntimeException('AI tạo flashcard chưa được cấu hình trên server.');
        $out=$this->chat([['role'=>'system','content'=>'Bạn tạo flashcard tiếng Anh chất lượng cao cho người Việt. CHỈ trả JSON array hợp lệ, không markdown.'],['role'=>'user','content'=>"Tạo {$count} flashcard chủ đề '{$topic}', CEFR {$level}. Mỗi object có đúng các field: term, definition (nghĩa Việt), ipa, part_of_speech, cefr, example_en, example_vi, notes. Ưu tiên từ/cụm từ thực tế, tránh trùng."]],.35,3000);
        return $this->decodeCards($out,$count);
    }
    public function extractCardsFromText(string $text,int $max=100): array {
        $max=max(3,min(150,$max)); if(!$this->enabled()) return [];$text=mb_substr($text,0,24000);
        $out=$this->chat([['role'=>'system','content'=>'Bạn trích xuất từ vựng tiếng Anh hữu ích cho người Việt. CHỈ trả JSON array hợp lệ.'],['role'=>'user','content'=>"Từ nội dung sau, chọn tối đa {$max} từ/cụm từ đáng học. Mỗi object: term, definition, ipa, part_of_speech, cefr, example_en, example_vi, notes. Nếu nội dung đã là danh sách từ thì ưu tiên giữ đúng danh sách.\n\n{$text}"]],.2,3200);
        return $this->decodeCards($out,$max);
    }
    public function speakingFeedback(string $target,string $transcript,float $score,string $level): string {
        if(!$this->enabled()) return $score>=80?'Speech-to-text khớp tốt với câu mục tiêu. Đây chỉ là đối chiếu transcript, không phải chấm phát âm IPA.':'Transcript chưa khớp nhiều với câu mục tiêu. Hãy nói chậm hơn và thử lại; đây chỉ là đối chiếu speech-to-text, không phải chấm phát âm IPA.';
        return $this->chat([['role'=>'system','content'=>'Bạn là huấn luyện viên phát âm tiếng Anh cho người Việt. Phản hồi cực ngắn, thực tế, không khẳng định đo được âm vị nếu chỉ có transcript.'],['role'=>'user','content'=>"Mục tiêu: {$target}\nSpeech-to-text nghe được: {$transcript}\nĐiểm khớp ước lượng: {$score}/100\nTrình độ: {$level}\nCho 2-3 câu hướng dẫn phát âm/trọng âm cụ thể bằng tiếng Việt."]],.3,350);
    }
    private function decodeCards(string $text,int $count): array {$text=trim(preg_replace('/^```(?:json)?\s*|\s*```$/u','',trim($text)));$d=json_decode($text,true);if(!is_array($d))throw new RuntimeException('AI chưa trả JSON flashcard hợp lệ. Hãy thử lại.');$out=[];foreach($d as $c){if(!is_array($c)||empty($c['term'])||empty($c['definition']))continue;$out[]=$c;if(count($out)>=$count)break;}return $out;}
}
