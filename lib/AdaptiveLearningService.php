<?php
final class AdaptiveLearningService {
    /** Deterministic workload policy. No random selection or ML is used. */
    public static function workloadPolicy(int $due, ?float $retention, int $baseNew = 12): array {
        $due=max(0,$due); $baseNew=max(0,min(30,$baseNew));
        if ($due>50) { $level='HIGH'; $new=min(3,$baseNew); $reason='Backlog trên 50: ưu tiên review, chỉ giữ tối đa 0–3 nội dung mới.'; }
        elseif ($due>=20) { $level='MEDIUM'; $new=min(8,max(0,min($baseNew, max(5,(int)round($baseNew*.55))))); $reason='Backlog 20–50: giảm nội dung mới để tránh nợ SRS tăng.'; }
        else { $level='LOW'; $new=min(15,max(0,$baseNew)); if($baseNew>0)$new=max(min(10,$baseNew),$new); $reason='Backlog dưới 20: có thể học lượng nội dung mới bình thường.'; }
        if ($retention!==null) {
            if ($retention<70) { $new=(int)floor($new*.5); $reason.=' Retention dưới 70% nên workload mới được giảm thêm.'; }
            elseif ($retention>85 && $due<20) { $new=min(15,$new+2); $reason.=' Retention trên 85% và backlog thấp nên tăng nhẹ nội dung mới.'; }
        }
        return ['backlog_level'=>$level,'new_goal'=>max(0,$new),'reason'=>$reason];
    }

    /** Explainable priority score for a weak concept/skill. */
    public static function priorityScore(array $s): float {
        $errors=max(0,(float)($s['error_frequency']??0));
        $recurrence=max(0,(float)($s['recurrence_count']??0));
        $weakness=max(0,min(100,(float)($s['weakness_severity']??0)));
        $overdue=max(0,(float)($s['overdue_weight']??0));
        $relearning=max(0,(float)($s['relearning_weight']??0));
        $exam=max(0,min(3,(float)($s['exam_relevance']??0)));
        $recency=max(0,min(3,(float)($s['recency_weight']??0)));
        $mastery=max(0,min(100,(float)($s['mastery']??0)));
        return round($errors*3 + $recurrence*4 + $weakness*.08 + $overdue*2 + $relearning*3 + $exam + $recency - $mastery*.04,2);
    }

    public static function reason(string $kind,array $s=[]): string {
        return match($kind){
            'srs' => sprintf('%d thẻ đang đến hạn; review luôn đứng trước kiến thức mới.',(int)($s['due']??0)),
            'mistake' => sprintf('%d lỗi chưa xử lý%s.',(int)($s['open']??0),((int)($s['recurred']??0)>0?' · '.(int)$s['recurred'].' lỗi tái diễn được tăng ưu tiên':'')),
            'weak' => !empty($s['label']) ? sprintf('%s được ưu tiên vì tín hiệu hiện tại cho thấy đây là vùng yếu nhất%s.',(string)$s['label'],isset($s['accuracy'])&&$s['accuracy']!==null?' ('.round((float)$s['accuracy']).'% đúng)':'') : 'Ưu tiên vùng yếu gần đây.',
            'listening' => 'Listening được duy trì đều để tăng khả năng nhận diện keyword, paraphrase và connected speech.',
            'exam' => 'Bài thi được chọn sau review/weakness để tái sử dụng cùng Mistake Book và SRS.',
            'grammar' => 'Grammar/pattern củng cố kiến thức gốc trước khi quay lại bài thi.',
            'vocabulary' => (string)($s['policy_reason']??'Nội dung mới chỉ xuất hiện sau khi review backlog đã được kiểm soát.'),
            default => 'Nội dung được chọn bằng adaptive rule-based priority.'
        };
    }
}
