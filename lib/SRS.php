<?php
final class SRS {
    /** Adaptive SRS: 1=Again, 2=Hard, 3=Good, 4=Easy. */
    public static function review(?array $p, int $rating, ?DateTimeImmutable $now=null): array {
        $rating=max(1,min(4,$rating)); $now=$now??new DateTimeImmutable('now');
        $state=$p['state']??'new'; $stability=max(0.25,(float)($p['stability_days']??0.3)); $difficulty=min(10,max(1,(float)($p['difficulty']??5)));
        $ease=max(1.3,min(3.2,(float)($p['ease_factor']??2.5))); $reps=(int)($p['repetitions']??0); $lapses=(int)($p['lapses']??0);
        $correctStreak=(int)($p['correct_streak']??0); $total=(int)($p['total_reviews']??0)+1; $correct=(int)($p['correct_reviews']??0);
        $elapsed=0.0; if(!empty($p['last_reviewed_at'])){$last=new DateTimeImmutable($p['last_reviewed_at']);$elapsed=max(0,($now->getTimestamp()-$last->getTimestamp())/86400);}
        $retrievability=pow(0.9,$elapsed/max($stability,0.25));
        $interval=0.0;
        if($rating===1){
            $difficulty=min(10,$difficulty+0.8); $ease=max(1.3,$ease-0.2); $stability=max(0.25,$stability*(0.45+0.15*$retrievability)); $lapses++; $correctStreak=0; $state='relearning'; $due=$now->modify('+10 minutes');
        } elseif($rating===2){
            $difficulty=min(10,$difficulty+0.18); $ease=max(1.3,$ease-0.12); $stability=max(0.7,$stability*(1.18+(1-$retrievability)*0.25)); $interval=max(1.0,$stability*0.8); $correct++; $correctStreak++; $state=$reps<1?'learning':'review'; $due=$now->modify('+'.max(1,(int)round($interval)).' days');
        } elseif($rating===3){
            $difficulty=max(1,$difficulty-0.06); $gain=1.55+(1-$retrievability)*1.2+(10-$difficulty)*0.035; $stability=$reps===0?1.2:max(1.0,$stability*$gain); $interval=max(1.0,$stability); $reps++; $correct++; $correctStreak++; $state=($stability>=30&&$reps>=5&&$correctStreak>=3)?'mastered':'review'; $due=$now->modify('+'.max(1,(int)round($interval)).' days');
        } else {
            $difficulty=max(1,$difficulty-0.3); $ease=min(3.2,$ease+0.12); $gain=2.1+(1-$retrievability)*1.4+(10-$difficulty)*0.05; $stability=$reps===0?4.0:max(2.0,$stability*$gain); $interval=max(4.0,$stability*1.25); $reps++; $correct++; $correctStreak++; $state=($stability>=30&&$reps>=5&&$correctStreak>=3)?'mastered':'review'; $due=$now->modify('+'.max(1,(int)round($interval)).' days');
        }
        return ['state'=>$state,'due_at'=>$due->format('Y-m-d H:i:s'),'last_reviewed_at'=>$now->format('Y-m-d H:i:s'),'interval_days'=>round($interval,2),'ease_factor'=>round($ease,2),'stability_days'=>round($stability,2),'difficulty'=>round($difficulty,2),'repetitions'=>$reps,'lapses'=>$lapses,'correct_streak'=>$correctStreak,'total_reviews'=>$total,'correct_reviews'=>$correct,'last_rating'=>$rating];
    }
}
