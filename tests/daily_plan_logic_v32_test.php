<?php
declare(strict_types=1);
if(!function_exists('mb_strtoupper')){function mb_strtoupper(string $v,?string $enc=null): string{return strtoupper($v);}}

final class Database {
    public function one(string $sql,array $params=[]): ?array {
        if(str_contains($sql,'FROM learning_preferences WHERE user_id=?'))return ['new_words_goal'=>12,'grammar_goal'=>4,'listening_goal'=>8,'toeic_goal'=>10,'mistake_review_goal'=>5,'backlog_pause_threshold'=>60];
        if(str_contains($sql,"p.state='relearning' AND p.due_at<=NOW()"))return ['n'=>2];
        if(str_contains($sql,"COALESCE(p.difficulty,1)>=4"))return ['n'=>3];
        if(str_contains($sql,"COALESCE(p.difficulty,1)<4"))return ['n'=>4];
        if(str_contains($sql,"p.state<>'mastered' AND p.due_at<CURDATE()"))return ['n'=>1];
        if(str_contains($sql,'p.card_id IS NULL')&&str_contains($sql,'flashcards c'))return ['n'=>30];
        if(str_contains($sql,"mastery_status='RECURRED'"))return ['n'=>1];
        if(str_contains($sql,"mastery_status<>'RESOLVED'"))return ['n'=>5];
        if(str_contains($sql,"item_type='COLLOCATION'"))return ['n'=>260];
        return ['n'=>0];
    }
    public function all(string $sql,array $params=[]): array {
        if(str_contains($sql,'AVG(result)*100'))return [
            ['mode'=>'review','attempts'=>10,'accuracy'=>68.0],
            ['mode'=>'listening','attempts'=>8,'accuracy'=>62.5],
            ['mode'=>'toeic','attempts'=>10,'accuracy'=>70.0],
            ['mode'=>'grammar','attempts'=>6,'accuracy'=>66.7],
        ];
        if(str_contains($sql,'created_at>=CURDATE()')&&str_contains($sql,'GROUP BY mode'))return [
            ['mode'=>'review','n'=>1],['mode'=>'vocabulary','n'=>2],['mode'=>'grammar','n'=>1],['mode'=>'listening','n'=>2],['mode'=>'toeic','n'=>3],['mode'=>'mistake_review','n'=>1],['mode'=>'matching','n'=>1]
        ];
        if(str_contains($sql,'FROM mistake_book_v2')&&str_contains($sql,'GROUP BY error_type'))return [
            ['error_type'=>'PREPOSITIONS','topic'=>'Grammar','open_items'=>2,'wrongs'=>3,'recurred'=>1,'last_wrong_at'=>'2026-08-30 20:00:00']
        ];
        if(str_contains($sql,'GROUP BY q.part'))return [
            ['part'=>5,'attempts'=>10,'correct'=>5,'last_attempt_at'=>'2026-08-30 20:00:00']
        ];
        if(str_contains($sql,'GROUP BY TRIM(q.grammar_category)'))return [
            ['grammar_category'=>'Prepositions','attempts'=>8,'correct'=>4,'last_attempt_at'=>'2026-08-30 20:00:00']
        ];
        return [];
    }
    public function run(string $sql,array $params=[]): int { return 1; }
    public function lastId(): int { return 1; }
}

final class AdaptiveLearningService {
    public static function workloadPolicy(int $due,?float $retention,int $goal): array {
        if($due>50)return ['new_goal'=>0,'backlog_level'=>'HIGH','reason'=>'Backlog cao'];
        if($due>=20)return ['new_goal'=>min(5,$goal),'backlog_level'=>'MEDIUM','reason'=>'Backlog vừa'];
        $new=$retention!==null&&$retention<70?min(8,$goal):$goal;
        return ['new_goal'=>$new,'backlog_level'=>'LOW','reason'=>'Review trước, sau đó học mới'];
    }
    public static function reason(string $type,array $ctx=[]): string { return 'reason:'.$type; }
    public static function priorityScore(array $x): float { return (float)(($x['error_frequency']??0)*5+($x['recurrence_count']??0)*8+($x['weakness_severity']??0)/4+($x['recency_weight']??0)); }
}

require_once dirname(__DIR__).'/lib/Repository.php';
$repo=new Repository(new Database());
$plan=$repo->dailyPlan(1);
$expected=['srs','relearning','mistake_review','weak_skill','hard_cards','listening','toeic','collocation','sentence_pattern','new_knowledge'];
$actual=array_column($plan['items'],'key');
$checks=[
    'exact priority order'=>$actual===$expected,
    'due queues disjoint total'=>(int)$plan['due']===9&&(int)$plan['due_srs']===4&&(int)$plan['relearning']===2&&(int)$plan['hard_cards']===3,
    'retention reduces new goal'=>(int)$plan['new_goal']===8,
    'toeic daily done excludes Aptis'=>(int)array_values(array_filter($plan['items'],fn($x)=>$x['key']==='toeic'))[0]['done']===3,
    'collocation daily target exists'=>(int)array_values(array_filter($plan['items'],fn($x)=>$x['key']==='collocation'))[0]['goal']>0,
    'weakness has measured accuracy'=>count(array_filter($repo->weaknesses(1,30),fn($x)=>$x['accuracy']!==null))>=1,
    'next action is highest pending'=>$plan['next_action']['key']==='srs',
];
$bad=[];foreach($checks as $name=>$ok){echo ($ok?'PASS ':'FAIL ').$name."\n";if(!$ok)$bad[]=$name;}
if($bad)exit(1);
echo "DAILY PLAN LOGIC V32 OK\n";
