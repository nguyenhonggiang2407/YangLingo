<?php
final class Repository {
    public function __construct(private Database $db) {}

    public function dashboard(int $uid): array {
        $stats=$this->db->one("SELECT
            (SELECT COUNT(*) FROM flashcard_sets WHERE user_id=?) sets_count,
            (SELECT COUNT(*) FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE s.user_id=?) cards_count,
            (SELECT COUNT(*) FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.due_at<=NOW()) due_count,
            (SELECT COUNT(*) FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.due_at<CURDATE()) overdue_count,
            (SELECT COUNT(*) FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE s.user_id=? AND p.card_id IS NULL) new_count,
            (SELECT COUNT(*) FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.state='mastered') mastered_count,
            (SELECT COALESCE(SUM(xp),0) FROM study_events WHERE user_id=? AND DATE(created_at)=CURDATE()) today_xp,
            (SELECT COUNT(*) FROM study_events WHERE user_id=? AND DATE(created_at)=CURDATE()) today_actions",
            [$uid,$uid,$uid,$uid,$uid,$uid,$uid,$uid,$uid,$uid,$uid,$uid]);
        $recent=$this->db->all("SELECT s.*,f.name folder_name,COUNT(c.id) card_count FROM flashcard_sets s LEFT JOIN folders f ON f.id=s.folder_id LEFT JOIN flashcards c ON c.set_id=s.id WHERE s.user_id=? GROUP BY s.id ORDER BY s.updated_at DESC LIMIT 6",[$uid]);
        $user=$this->db->one('SELECT daily_goal FROM users WHERE id=?',[$uid]);
        return ['stats'=>$stats,'recent_sets'=>$recent,'streak'=>$this->streak($uid),'daily_goal'=>(int)($user['daily_goal']??20),'today_studied'=>$this->todayStudied($uid),'daily_plan'=>$this->dailyPlan($uid),'weaknesses'=>$this->weaknesses($uid,7)];
    }
    public function todayStudied(int $uid): int {
        $r=$this->db->one("SELECT COUNT(*) n FROM study_events WHERE user_id=? AND created_at>=CURDATE() AND created_at<DATE_ADD(CURDATE(),INTERVAL 1 DAY) AND mode IN ('review','vocabulary','grammar','toeic','mistake_review','quiz','listening','fill','matching','speaking')",[$uid]);
        return (int)($r['n']??0);
    }

    public function streak(int $uid): int {
        $rows=$this->db->all("SELECT DISTINCT DATE(created_at) d FROM study_events WHERE user_id=? AND created_at>=DATE_SUB(CURDATE(),INTERVAL 370 DAY) ORDER BY d DESC",[$uid]);
        $days=array_fill_keys(array_column($rows,'d'),true); if(!$days) return 0;
        $d=new DateTimeImmutable('today'); if(!isset($days[$d->format('Y-m-d')]))$d=$d->modify('-1 day');
        $n=0; while(isset($days[$d->format('Y-m-d')])){$n++;$d=$d->modify('-1 day');} return $n;
    }

    public function folders(int $uid): array {
        return $this->db->all("SELECT f.*,COUNT(s.id) set_count FROM folders f LEFT JOIN flashcard_sets s ON s.folder_id=f.id WHERE f.user_id=? GROUP BY f.id ORDER BY f.updated_at DESC,f.name",[$uid]);
    }
    public function createFolder(int $uid,string $name,string $icon='📁'): array {
        $name=trim($name); if($name==='')throw new InvalidArgumentException('Hãy nhập tên thư mục.');
        $this->db->run('INSERT INTO folders(user_id,name,icon) VALUES(?,?,?)',[$uid,mb_substr($name,0,120),mb_substr(trim($icon)?:'📁',0,16)]); return $this->folder($uid,$this->db->lastId());
    }
    public function folder(int $uid,int $id): array {
        $r=$this->db->one('SELECT * FROM folders WHERE id=? AND user_id=?',[$id,$uid]); if(!$r)throw new RuntimeException('Không tìm thấy thư mục.'); return $r;
    }
    public function updateFolder(int $uid,int $id,string $name,string $icon): array { $this->folder($uid,$id);$this->db->run('UPDATE folders SET name=?,icon=? WHERE id=? AND user_id=?',[mb_substr(trim($name),0,120),mb_substr(trim($icon)?:'📁',0,16),$id,$uid]);return $this->folder($uid,$id); }
    public function deleteFolder(int $uid,int $id): void { $this->folder($uid,$id);$this->db->run('DELETE FROM folders WHERE id=? AND user_id=?',[$id,$uid]); }

    public function sets(int $uid,string $search='',?int $folderId=null): array {
        $where=['s.user_id=?'];$params=[$uid];
        if(trim($search)!==''){$where[]='(s.title LIKE ? OR s.description LIKE ?)';$q='%'.trim($search).'%';$params[]=$q;$params[]=$q;}
        if($folderId){$where[]='s.folder_id=?';$params[]=$folderId;}
        return $this->db->all("SELECT s.*,f.name folder_name,f.icon folder_icon,COUNT(c.id) card_count,
          SUM(CASE WHEN p.card_id IS NULL OR p.due_at<=NOW() THEN 1 ELSE 0 END) due_count,
          SUM(CASE WHEN p.state='mastered' THEN 1 ELSE 0 END) mastered_count
          FROM flashcard_sets s LEFT JOIN folders f ON f.id=s.folder_id LEFT JOIN flashcards c ON c.set_id=s.id LEFT JOIN srs_progress p ON p.user_id=s.user_id AND p.card_id=c.id
          WHERE ".implode(' AND ',$where)." GROUP BY s.id ORDER BY s.updated_at DESC",$params);
    }
    public function ownSet(int $uid,int $setId): array { $s=$this->db->one('SELECT s.*,f.name folder_name FROM flashcard_sets s LEFT JOIN folders f ON f.id=s.folder_id WHERE s.id=? AND s.user_id=?',[$setId,$uid]); if(!$s)throw new RuntimeException('Không tìm thấy bộ từ.'); return $s; }
    public function getSet(int $uid,int $setId,int $page=1,int $perPage=100,string $search='',?string $cardType=null): array {
        $s=$this->ownSet($uid,$setId);$page=max(1,$page);$perPage=max(20,min(100,$perPage));$search=trim($search);$where='c.set_id=?';$params=[$setId];
        if($search!==''){$where.=' AND (c.term LIKE ? OR c.definition LIKE ? OR c.example_en LIKE ? OR c.collocations LIKE ? OR c.pattern LIKE ?)';$q='%'.$search.'%';array_push($params,$q,$q,$q,$q,$q);}
        if($cardType!==null&&trim($cardType)!==''){$where.=' AND c.card_type=?';$params[]=strtoupper(trim($cardType));}
        $total=(int)($this->db->one("SELECT COUNT(*) n FROM flashcards c WHERE {$where}",$params)['n']??0);$pages=max(1,(int)ceil($total/$perPage));$page=min($page,$pages);$offset=($page-1)*$perPage;
        $s['cards']=$this->db->all("SELECT c.*,p.state,p.due_at,p.interval_days,p.stability_days,p.difficulty,p.repetitions,p.correct_reviews,p.total_reviews FROM flashcards c LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE {$where} ORDER BY c.id LIMIT {$perPage} OFFSET {$offset}",[$uid,...$params]);
        $s['card_total']=$total;$s['page']=$page;$s['per_page']=$perPage;$s['pages']=$pages;$s['search']=$search;$s['card_type']=$cardType;return $s;
    }
    public function exportSetData(int $uid,int $setId): array {
        $s=$this->ownSet($uid,$setId);
        $s['cards']=$this->db->all('SELECT c.* FROM flashcards c WHERE c.set_id=? ORDER BY c.id',[$setId]);
        return $s;
    }
    public function createSet(int $uid,string $title,string $description='',?int $folderId=null,string $source='manual'): array {
        $title=trim($title); if($title==='')throw new InvalidArgumentException('Hãy nhập tên bộ từ.'); if($folderId)$this->folder($uid,$folderId);
        $this->db->run('INSERT INTO flashcard_sets(user_id,folder_id,title,description,source_type) VALUES(?,?,?,?,?)',[$uid,$folderId,mb_substr($title,0,180),mb_substr(trim($description),0,1000),$source]);return $this->ownSet($uid,$this->db->lastId());
    }
    public function updateSet(int $uid,int $setId,array $d): array {
        $this->ownSet($uid,$setId); $title=trim((string)($d['title']??'')); if($title==='')throw new InvalidArgumentException('Tên bộ từ không được trống.');
        $folder=isset($d['folder_id'])&&$d['folder_id']!==''?(int)$d['folder_id']:null; if($folder)$this->folder($uid,$folder);
        $this->db->run('UPDATE flashcard_sets SET title=?,description=?,folder_id=? WHERE id=? AND user_id=?',[mb_substr($title,0,180),mb_substr(trim((string)($d['description']??'')),0,1000),$folder,$setId,$uid]); return $this->ownSet($uid,$setId);
    }
    public function deleteSet(int $uid,int $setId): void { $this->ownSet($uid,$setId); $this->db->run('DELETE FROM flashcard_sets WHERE id=? AND user_id=?',[$setId,$uid]); }

    public function ownCard(int $uid,int $cardId): array {
        $c=$this->db->one('SELECT c.*,s.user_id FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE c.id=? AND s.user_id=?',[$cardId,$uid]); if(!$c)throw new RuntimeException('Không tìm thấy flashcard.'); return $c;
    }
    public function createCard(int $uid,int $setId,array $d): array {
        $this->ownSet($uid,$setId);$term=trim((string)($d['term']??''));$def=trim((string)($d['definition']??''));if($term===''||$def==='')throw new InvalidArgumentException('Từ và nghĩa không được để trống.');
        $m=$this->normalizeCardMeta($d);
        $this->db->run('INSERT INTO flashcards(set_id,term,definition,ipa,part_of_speech,cefr,example_en,example_vi,notes,card_type,topic,subtopic,toeic_part,difficulty,pattern,collocations,word_family,explanation,audio_text,tags,source) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[$setId,mb_substr($term,0,255),$def,(string)($d['ipa']??''),(string)($d['part_of_speech']??''),(string)($d['cefr']??''),(string)($d['example_en']??''),(string)($d['example_vi']??''),(string)($d['notes']??''),...$m]);
        $id=$this->db->lastId();$this->db->run('UPDATE flashcard_sets SET updated_at=NOW() WHERE id=?',[$setId]);return $this->ownCard($uid,$id);
    }
    public function updateCard(int $uid,int $cardId,array $d): array {
        $c=$this->ownCard($uid,$cardId);$term=trim((string)($d['term']??''));$def=trim((string)($d['definition']??''));if($term===''||$def==='')throw new InvalidArgumentException('Từ và nghĩa không được để trống.');$m=$this->normalizeCardMeta($d);
        $this->db->run('UPDATE flashcards SET term=?,definition=?,ipa=?,part_of_speech=?,cefr=?,example_en=?,example_vi=?,notes=?,card_type=?,topic=?,subtopic=?,toeic_part=?,difficulty=?,pattern=?,collocations=?,word_family=?,explanation=?,audio_text=?,tags=?,source=? WHERE id=?',[mb_substr($term,0,255),$def,(string)($d['ipa']??''),(string)($d['part_of_speech']??''),(string)($d['cefr']??''),(string)($d['example_en']??''),(string)($d['example_vi']??''),(string)($d['notes']??''),...$m,$cardId]);$this->db->run('UPDATE flashcard_sets SET updated_at=NOW() WHERE id=?',[$c['set_id']]);return $this->ownCard($uid,$cardId);
    }
    private function normalizeCardMeta(array $d): array {
        $types=['VOCABULARY','COLLOCATION','SENTENCE_PATTERN','GRAMMAR','LISTENING_CHUNK','MISTAKE_CARD'];$type=strtoupper(trim((string)($d['card_type']??'VOCABULARY')));if(!in_array($type,$types,true))$type='VOCABULARY';
        $part=isset($d['toeic_part'])&&$d['toeic_part']!==''?(int)$d['toeic_part']:null;if($part!==null&&($part<1||$part>7))$part=null;$difficulty=max(1,min(5,(int)($d['difficulty']??1)));
        return [$type,mb_substr(trim((string)($d['topic']??'')),0,120)?:null,mb_substr(trim((string)($d['subtopic']??'')),0,120)?:null,$part,$difficulty,(string)($d['pattern']??''),(string)($d['collocations']??''),(string)($d['word_family']??''),(string)($d['explanation']??''),(string)($d['audio_text']??''),mb_substr(trim((string)($d['tags']??'')),0,500)?:null,mb_substr(trim((string)($d['source']??'')),0,120)?:null];
    }
    public function deleteCard(int $uid,int $cardId): void { $c=$this->ownCard($uid,$cardId);$this->db->run('DELETE FROM flashcards WHERE id=?',[$cardId]);$this->db->run('UPDATE flashcard_sets SET updated_at=NOW() WHERE id=?',[$c['set_id']]); }
    public function bulkInsertCards(int $uid,int $setId,array $cards): int {
        $this->ownSet($uid,$setId);$count=0;$stmt=$this->db->pdo()->prepare('INSERT INTO flashcards(set_id,term,definition,ipa,part_of_speech,cefr,example_en,example_vi,notes,card_type,topic,subtopic,toeic_part,difficulty,pattern,collocations,word_family,explanation,audio_text,tags,source) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)');
        $this->db->tx(function()use($stmt,$setId,$cards,&$count){foreach(array_slice($cards,0,1000) as $c){$term=trim((string)($c['term']??''));$def=trim((string)($c['definition']??''));if($term===''||$def==='')continue;$stmt->execute([$setId,mb_substr($term,0,255),$def,(string)($c['ipa']??''),(string)($c['part_of_speech']??''),(string)($c['cefr']??''),(string)($c['example_en']??''),(string)($c['example_vi']??''),(string)($c['notes']??''),...$this->normalizeCardMeta($c)]);$count++;}});$this->db->run('UPDATE flashcard_sets SET updated_at=NOW() WHERE id=?',[$setId]);return $count;
    }
    private function flashbookLessonSettings(array $set,int $size): array {
        $settings=['size'=>max(5,min(100,$size)),'lessons'=>[]];
        if(($set['source_type']??'')==='everyday_english_a1_a2_book'){
            $book=$this->everydayEnglishFlashbook();
            $settings['size']=(int)$book['lesson_size'];$settings['lessons']=$book['lessons'];
        }
        if(($set['source_type']??'')==='student_life_work_a2_b1_book'){
            $book=$this->studentLifeFlashbook();
            $settings['size']=(int)$book['lesson_size'];$settings['lessons']=$book['lessons'];
        }
        return $settings;
    }
    private function lessonCardIds(int $uid,int $setId,int $unit,int $size=20): array {
        $set=$this->ownSet($uid,$setId);$unit=max(1,$unit);$size=$this->flashbookLessonSettings($set,$size)['size'];$offset=($unit-1)*$size;
        $rows=$this->db->all("SELECT id FROM flashcards WHERE set_id=? ORDER BY id LIMIT {$size} OFFSET {$offset}",[$setId]);return array_map('intval',array_column($rows,'id'));
    }
    public function studyLessons(int $uid,int $setId,int $size=20): array {
        $set=$this->ownSet($uid,$setId);$settings=$this->flashbookLessonSettings($set,$size);
        $size=$settings['size'];
        $rows=$this->db->all(
            'SELECT c.id,p.card_id progress_card,p.state,p.due_at FROM flashcards c LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE c.set_id=? ORDER BY c.id',
            [$uid,$setId]
        );
        if(!$rows)return[];
        $now=time();$out=[];
        foreach(array_chunk($rows,$size) as $i=>$chunk){
            $introduced=0;$mastered=0;$due=0;
            foreach($chunk as $r){
                if(!empty($r['progress_card']))$introduced++;
                if(($r['state']??'')==='mastered')$mastered++;
                if(!empty($r['progress_card'])&&!empty($r['due_at'])&&strtotime((string)$r['due_at'])<=$now)$due++;
            }
            $count=count($chunk);
            $progress=(int)round($mastered/max(1,$count)*100);
            $status=$mastered>=$count?'done':($introduced>0?'learning':'new');
            $n=$i+1;
            $lesson=[
                'key'=>'unit:'.$n,'kind'=>'unit','value'=>$n,'title'=>'Bài '.$n,
                'card_count'=>$count,'learned_count'=>$introduced,'mastered_count'=>$mastered,
                'due_count'=>$due,'progress'=>$progress,'status'=>$status
            ];
            if(isset($settings['lessons'][$i])){
                $lesson['title']=$settings['lessons'][$i]['title'];
                $lesson['objective']=$settings['lessons'][$i]['objective'];
                $lesson['estimated_minutes']=8;
            }
            $out[]=$lesson;
        }
        return $out;
    }
    public function studyLessonCards(int $uid,int $setId,int $unit,int $size=20): array {
        $set=$this->ownSet($uid,$setId);$unit=max(1,$unit);$settings=$this->flashbookLessonSettings($set,$size);$size=$settings['size'];
        $ids=$this->lessonCardIds($uid,$setId,$unit,$size);
        if(!$ids)return ['unit'=>$unit,'cards'=>[],'count'=>0,'learned_count'=>0,'mastered_count'=>0];
        $marks=implode(',',array_fill(0,count($ids),'?'));
        $rows=$this->db->all(
            "SELECT c.*,p.card_id progress_card,p.state,p.due_at,p.repetitions FROM flashcards c LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE c.id IN ({$marks}) ORDER BY FIELD(c.id,{$marks})",
            [$uid,...$ids,...$ids]
        );
        $learned=0;$mastered=0;
        foreach($rows as &$r){
            $r['learned']=!empty($r['progress_card']);
            $r['mastered']=($r['state']??'')==='mastered';
            if($r['learned'])$learned++;
            if($r['mastered'])$mastered++;
            unset($r['progress_card']);
        }
        $count=count($rows);
        $lesson=['unit'=>$unit,'title'=>'Bài '.$unit,'cards'=>$rows,'count'=>$count,'learned_count'=>$learned,'mastered_count'=>$mastered,'new_count'=>max(0,$count-$learned)];
        if(isset($settings['lessons'][$unit-1])){
            $lesson['title']=$settings['lessons'][$unit-1]['title'];
            $lesson['objective']=$settings['lessons'][$unit-1]['objective'];
            $lesson['estimated_minutes']=8;
            foreach(['speaking_prompt','speaking_model'] as $field){
                if(isset($settings['lessons'][$unit-1][$field]))$lesson[$field]=(string)$settings['lessons'][$unit-1][$field];
            }
        }
        return $lesson;
    }
    public function priorityCards(int $uid,string $mode,int $limit=60): array {
        $mode=strtolower(trim($mode));if(!in_array($mode,['due','relearning','hard','new'],true))throw new InvalidArgumentException('Hàng đợi SRS không hợp lệ.');$limit=max(1,min(120,$limit));
        $condition=match($mode){
            'due'=>"p.card_id IS NOT NULL AND p.due_at<=NOW() AND p.state NOT IN ('relearning','mastered') AND COALESCE(p.difficulty,1)<4",
            'relearning'=>"p.card_id IS NOT NULL AND p.due_at<=NOW() AND p.state='relearning'",
            'hard'=>"p.card_id IS NOT NULL AND p.due_at<=NOW() AND p.state NOT IN ('relearning','mastered') AND COALESCE(p.difficulty,1)>=4",
            'new'=>'p.card_id IS NULL'
        };
        $rows=$this->db->all("SELECT c.*,s.title set_title,p.card_id progress_card,p.state,p.due_at,p.interval_days,p.stability_days,p.difficulty srs_difficulty,p.repetitions,p.lapses,p.last_rating FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE s.user_id=? AND {$condition} ORDER BY CASE WHEN p.due_at<CURDATE() THEN 1 WHEN p.last_rating=1 THEN 2 WHEN p.last_rating=2 THEN 3 ELSE 4 END,COALESCE(p.due_at,NOW()),c.id LIMIT {$limit}",[$uid,$uid]);
        if($mode==='new'){
            $plan=$this->dailyPlan($uid);$newGoal=(int)($plan['new_goal']??0);$newDone=0;foreach(($plan['items']??[]) as $item)if(($item['key']??'')==='new_knowledge'){$newDone=(int)($item['done']??0);break;}$rows=array_slice($rows,0,max(0,$newGoal-$newDone));
        }
        foreach($rows as &$row)unset($row['progress_card']);unset($row);return $rows;
    }

    public function dueCards(int $uid,?int $setId=null,int $limit=60,?int $unit=null): array {
        $params=[$uid,$uid];$where='s.user_id=?';
        if($setId){
            $this->ownSet($uid,$setId);$where.=' AND s.id=?';$params[]=$setId;
            if($unit){$ids=$this->lessonCardIds($uid,$setId,$unit);if(!$ids)return[];$where.=' AND c.id IN ('.implode(',',array_fill(0,count($ids),'?')).')';array_push($params,...$ids);}
        }
        $limit=max(1,min(200,$limit));
        $rows=$this->db->all(
            "SELECT c.*,s.title set_title,p.card_id progress_card,p.state,p.due_at,p.interval_days,p.stability_days,p.difficulty srs_difficulty,p.repetitions,p.lapses,p.last_rating
             FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id
             LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id
             WHERE {$where} AND (p.card_id IS NULL OR p.due_at<=NOW())
             ORDER BY CASE
                WHEN p.card_id IS NULL THEN 5
                WHEN p.due_at<CURDATE() THEN 1
                WHEN p.state='relearning' OR p.last_rating=1 THEN 3
                WHEN p.last_rating=2 THEN 4
                ELSE 2 END,
                COALESCE(p.due_at,NOW()),c.id
             LIMIT {$limit}",
            $params
        );
        $plan=$this->dailyPlan($uid);$newGoal=(int)($plan['new_goal']??0);$newDone=0;
        foreach(($plan['items']??[]) as $item)if(($item['key']??'')==='new_knowledge'){$newDone=(int)($item['done']??0);break;}
        $newRemaining=max(0,$newGoal-$newDone);$kept=[];$newSeen=0;
        foreach($rows as $row){
            $isNew=empty($row['progress_card']);unset($row['progress_card']);
            if($isNew){if($newSeen>=$newRemaining)continue;$newSeen++;}
            $kept[]=$row;
        }
        return $kept;
    }
    public function randomCards(int $uid,?int $setId=null,int $limit=20): array {
        $params=[$uid];$where='s.user_id=?';if($setId){$this->ownSet($uid,$setId);$where.=' AND s.id=?';$params[]=$setId;}$limit=max(1,min(60,$limit)); return $this->db->all("SELECT c.*,s.title set_title FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE {$where} ORDER BY id LIMIT {$limit}",$params);
    }
    public function review(int $uid,int $cardId,int $rating): array {
        $c=$this->ownCard($uid,$cardId);$p=$this->db->one('SELECT * FROM srs_progress WHERE user_id=? AND card_id=?',[$uid,$cardId]);$n=SRS::review($p,$rating);$this->db->run("INSERT INTO srs_progress(user_id,card_id,state,due_at,last_reviewed_at,interval_days,ease_factor,stability_days,difficulty,repetitions,lapses,correct_streak,total_reviews,correct_reviews,last_rating) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE state=VALUES(state),due_at=VALUES(due_at),last_reviewed_at=VALUES(last_reviewed_at),interval_days=VALUES(interval_days),ease_factor=VALUES(ease_factor),stability_days=VALUES(stability_days),difficulty=VALUES(difficulty),repetitions=VALUES(repetitions),lapses=VALUES(lapses),correct_streak=VALUES(correct_streak),total_reviews=VALUES(total_reviews),correct_reviews=VALUES(correct_reviews),last_rating=VALUES(last_rating)",[$uid,$cardId,$n['state'],$n['due_at'],$n['last_reviewed_at'],$n['interval_days'],$n['ease_factor'],$n['stability_days'],$n['difficulty'],$n['repetitions'],$n['lapses'],$n['correct_streak'],$n['total_reviews'],$n['correct_reviews'],$n['last_rating']]);
        $xp=[1=>2,2=>5,3=>9,4=>12][$rating];$mode=$p?'review':'vocabulary';$this->recordEvent($uid,$mode,(int)$c['set_id'],$cardId,$rating>1?1:0,$rating*25,$xp,0);return $n;
    }

    public function recordEvent(int $uid,string $mode,?int $setId,?int $cardId,?int $result,?float $score,int $xp,int $duration=0,array $context=[]): void {
        $allowed=['review','vocabulary','grammar','toeic','mistake_review','quiz','listening','fill','matching','speaking','tutor'];if(!in_array($mode,$allowed,true))$mode='quiz';$xp=max(0,min(200,$xp));$duration=max(0,min(7200,$duration));
        if($cardId!==null){$owned=$this->ownCard($uid,$cardId);$setId=(int)$owned['set_id'];}
        elseif($setId!==null){$this->ownSet($uid,$setId);}
        $this->db->run('INSERT INTO study_events(user_id,set_id,card_id,mode,result,score,xp,duration_seconds) VALUES(?,?,?,?,?,?,?,?)',[$uid,$setId,$cardId,$mode,$result,$score,$xp,$duration]);
        $trackMistake=!array_key_exists('track_mistake',$context)||!empty($context['track_mistake']);
        if($trackMistake&&$result===0)$this->recordMistakeV2($uid,$mode,$cardId,$context);
        elseif($trackMistake&&$result===1)$this->resolveMistakeBySource($uid,$mode,$cardId,$context);
    }
    private function defaultErrorType(string $mode): string {return match($mode){'listening'=>'LISTENING_RECOGNITION','grammar'=>'WORD_FORM','toeic'=>'UNKNOWN','fill','matching','quiz','vocabulary','review'=>'VOCABULARY',default=>'UNKNOWN'};}
    private function sourceKey(string $mode,?int $cardId,array $context): string {$key=trim((string)($context['source_key']??''));if($key!=='')return mb_substr($key,0,190);if($cardId!==null)return 'card:'.$cardId;return 'question:'.sha1($mode.'|'.trim((string)($context['question']??'')).'|'.trim((string)($context['correct_answer']??'')));}
    private function recordMistakeV2(int $uid,string $mode,?int $cardId,array $context): void {
        $card=$cardId!==null?$this->db->one('SELECT c.*,s.title set_title FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE c.id=? AND s.user_id=?',[$cardId,$uid]):null;
        $sourceKey=$this->sourceKey($mode,$cardId,$context);
        $error=strtoupper(trim((string)($context['error_type']??$this->defaultErrorType($mode))));
        $errorTypes=['VOCABULARY','PARTS_OF_SPEECH','WORD_FORM','WORD_FORMS','TENSE','TENSES','PASSIVE','PASSIVE_VOICE','PREPOSITION','PREPOSITIONS','CONJUNCTION','CONJUNCTIONS','GERUND_INFINITIVE','GERUNDS','INFINITIVES','RELATIVE_CLAUSE','RELATIVE_CLAUSES','PARTICIPLE','PARTICIPLES','PRONOUN','PRONOUNS','COLLOCATION','LISTENING_RECOGNITION','CONNECTED_SPEECH','DISTRACTOR','READING_COMPREHENSION','INFERENCE','PARAPHRASE','TIME_MANAGEMENT','CARELESS','SUBJECT_VERB_AGREEMENT','COMPARATIVES','CONDITIONALS','NOUN_CLAUSES','ADVERB_CLAUSES','UNKNOWN'];
        if(!in_array($error,$errorTypes,true))$error='UNKNOWN';
        $question=trim((string)($context['question']??($card['term']??'')));
        $correct=trim((string)($context['correct_answer']??($card['definition']??'')));
        $userAnswer=trim((string)($context['user_answer']??''));
        $explanation=trim((string)($context['explanation']??($card['explanation']??$card['example_en']??'')));
        $topic=trim((string)($context['topic']??($card['topic']??'')))?:null;
        $part=(int)($context['toeic_part']??($card['toeic_part']??0));if($part<1||$part>7)$part=null;
        $this->db->run("INSERT INTO mistake_book_v2(user_id,source_type,source_key,source_id,card_id,question,user_answer,correct_answer,explanation,error_type,topic,toeic_part,wrong_count,first_wrong_at,last_wrong_at,resolved_at,mastery_status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,1,NOW(),NOW(),NULL,'NEW') ON DUPLICATE KEY UPDATE user_answer=VALUES(user_answer),correct_answer=VALUES(correct_answer),explanation=VALUES(explanation),error_type=VALUES(error_type),topic=VALUES(topic),toeic_part=VALUES(toeic_part),wrong_count=wrong_count+1,last_wrong_at=NOW(),resolved_at=NULL,mastery_status=IF(mastery_status='RESOLVED','RECURRED',IF(mastery_status='NEW','LEARNING',mastery_status))",[$uid,$mode,$sourceKey,(string)($context['source_id']??($cardId??'')),$cardId,$question,$userAnswer,$correct,$explanation,$error,$topic,$part]);
    }
    private function resolveMistakeBySource(int $uid,string $mode,?int $cardId,array $context): void {
        $key=$this->sourceKey($mode,$cardId,$context);
        $this->db->run("UPDATE mistake_book_v2 SET resolved_at=COALESCE(resolved_at,NOW()),mastery_status='RESOLVED' WHERE user_id=? AND source_type=? AND source_key=?",[$uid,$mode,$key]);
    }
    public function mistakes(int $uid,bool $includeResolved=false,int $limit=100,?string $errorType=null,string $search=''): array {
        $limit=max(1,min(200,$limit));$where=['m.user_id=?'];$params=[$uid];
        if(!$includeResolved)$where[]='m.resolved_at IS NULL';
        if($errorType!==null&&trim($errorType)!==''){$where[]='m.error_type=?';$params[]=strtoupper(trim($errorType));}
        if(trim($search)!==''){$where[]='(m.question LIKE ? OR m.correct_answer LIKE ? OR m.user_answer LIKE ? OR m.explanation LIKE ? OR c.term LIKE ? OR c.definition LIKE ?)';$q='%'.trim($search).'%';array_push($params,$q,$q,$q,$q,$q,$q);}
        $w=implode(' AND ',$where);
        return $this->db->all("SELECT m.id,m.source_type module,m.source_key,m.source_id,m.error_type,m.topic,m.toeic_part,m.question,m.user_answer,m.correct_answer,m.explanation,m.wrong_count,m.first_wrong_at,m.last_wrong_at,m.resolved_at,m.mastery_status,m.card_id,COALESCE(c.term,m.question) term,COALESCE(c.definition,m.correct_answer) definition,COALESCE(c.ipa,'') ipa,COALESCE(c.part_of_speech,'') part_of_speech,COALESCE(c.cefr,'') cefr,COALESCE(c.example_en,m.explanation) example_en,COALESCE(c.example_vi,'') example_vi,COALESCE(c.pattern,'') pattern,COALESCE(c.collocations,'') collocations,COALESCE(c.word_family,'') word_family,COALESCE(s.title,'Câu hỏi độc lập') set_title FROM mistake_book_v2 m LEFT JOIN flashcards c ON c.id=m.card_id LEFT JOIN flashcard_sets s ON s.id=c.set_id WHERE {$w} ORDER BY (m.resolved_at IS NULL) DESC,m.wrong_count DESC,m.last_wrong_at DESC LIMIT {$limit}",$params);
    }
    public function resolveMistake(int $uid,int $id): void {$st=$this->db->run("UPDATE mistake_book_v2 SET resolved_at=NOW(),mastery_status='RESOLVED' WHERE id=? AND user_id=?",[$id,$uid]);if($st->rowCount()===0)throw new RuntimeException('Không tìm thấy câu sai.');}
    public function reopenMistake(int $uid,int $id): void {$st=$this->db->run("UPDATE mistake_book_v2 SET resolved_at=NULL,mastery_status='REVIEWING' WHERE id=? AND user_id=?",[$id,$uid]);if($st->rowCount()===0)throw new RuntimeException('Không tìm thấy câu sai.');}
    public function profile(int $uid): array { $u=$this->db->one('SELECT id,name,email,role,english_level,daily_goal,bio,created_at,last_login_at FROM users WHERE id=?',[$uid]);$u['streak']=$this->streak($uid);$u['total_xp']=(int)($this->db->one('SELECT COALESCE(SUM(xp),0) xp FROM study_events WHERE user_id=?',[$uid])['xp']??0);$u['learning_preferences']=$this->learningPreferences($uid);return $u; }
    public function updateProfile(int $uid,array $d): array {
        $name=trim((string)($d['name']??''));if(mb_strlen($name)<2)throw new InvalidArgumentException('Tên cần ít nhất 2 ký tự.');$level=strtoupper(trim((string)($d['english_level']??'A2')));if(!in_array($level,['A1','A2','B1','B2','C1','C2'],true))$level='A2';$goal=max(5,min(200,(int)($d['daily_goal']??20)));$bio=mb_substr(trim((string)($d['bio']??'')),0,500);$this->db->run('UPDATE users SET name=?,english_level=?,daily_goal=?,bio=? WHERE id=?',[$name,$level,$goal,$bio,$uid]);return $this->profile($uid);
    }
    public function updateLearningPreferences(int $uid,array $d): array {
        $new=max(0,min(30,(int)($d['new_words_goal']??15)));$grammar=max(0,min(20,(int)($d['grammar_goal']??5)));$listening=max(0,min(50,(int)($d['listening_goal']??10)));$toeic=max(0,min(100,(int)($d['toeic_goal']??10)));$mistakes=max(0,min(30,(int)($d['mistake_review_goal']??5)));$pause=max(30,min(300,(int)($d['backlog_pause_threshold']??60)));
        $this->db->run("INSERT INTO learning_preferences(user_id,new_words_goal,grammar_goal,listening_goal,toeic_goal,mistake_review_goal,backlog_pause_threshold) VALUES(?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE new_words_goal=VALUES(new_words_goal),grammar_goal=VALUES(grammar_goal),listening_goal=VALUES(listening_goal),toeic_goal=VALUES(toeic_goal),mistake_review_goal=VALUES(mistake_review_goal),backlog_pause_threshold=VALUES(backlog_pause_threshold)",[$uid,$new,$grammar,$listening,$toeic,$mistakes,$pause]);return $this->learningPreferences($uid);
    }
    public function changePassword(int $uid,string $current,string $next): void {$u=$this->db->one('SELECT password_hash FROM users WHERE id=?',[$uid]);if(!$u||!password_verify($current,$u['password_hash']))throw new InvalidArgumentException('Mật khẩu hiện tại không đúng.');if(strlen($next)<8)throw new InvalidArgumentException('Mật khẩu mới cần ít nhất 8 ký tự.');$this->db->run('UPDATE users SET password_hash=? WHERE id=?',[password_hash($next,PASSWORD_DEFAULT),$uid]);}

    public function stats(int $uid,int $days=14): array {
        $days=max(7,min(90,$days));
        $timeline=$this->db->all("SELECT DATE(created_at) day,COUNT(*) actions,COALESCE(SUM(xp),0) xp,ROUND(AVG(CASE WHEN score IS NULL THEN NULL ELSE score END),1) avg_score FROM study_events WHERE user_id=? AND created_at>=DATE_SUB(CURDATE(),INTERVAL {$days} DAY) GROUP BY DATE(created_at) ORDER BY day",[$uid]);
        $modes=$this->db->all("SELECT mode,COUNT(*) attempts,ROUND(AVG(CASE WHEN result IS NULL THEN NULL ELSE result*100 END),1) accuracy,COALESCE(SUM(xp),0) xp FROM study_events WHERE user_id=? AND created_at>=DATE_SUB(CURDATE(),INTERVAL {$days} DAY) GROUP BY mode ORDER BY attempts DESC",[$uid]);
        $top=$this->db->all("SELECT s.title,COUNT(e.id) actions,COALESCE(SUM(e.xp),0) xp FROM study_events e LEFT JOIN flashcard_sets s ON s.id=e.set_id WHERE e.user_id=? AND e.created_at>=DATE_SUB(CURDATE(),INTERVAL {$days} DAY) GROUP BY e.set_id,s.title ORDER BY actions DESC LIMIT 5",[$uid]);
        $srs=$this->db->one("SELECT SUM(state='new') new_count,SUM(state='learning') learning_count,SUM(state='review') review_count,SUM(state='relearning') relearning_count,SUM(state='mastered') mastered_count FROM srs_progress WHERE user_id=?",[$uid]);
        $retention=$this->db->one('SELECT ROUND(CASE WHEN SUM(total_reviews)>0 THEN SUM(correct_reviews)/SUM(total_reviews)*100 ELSE NULL END,1) retention FROM srs_progress WHERE user_id=?',[$uid]); return ['timeline'=>$timeline,'modes'=>$modes,'top_sets'=>$top,'srs'=>$srs,'streak'=>$this->streak($uid),'today'=>$this->todayStudied($uid),'retention'=>$retention['retention']??null,'weaknesses'=>$this->weaknesses($uid,$days),'daily_plan'=>$this->dailyPlan($uid)];
    }

    public function learningPreferences(int $uid): array {
        $r=$this->db->one('SELECT * FROM learning_preferences WHERE user_id=?',[$uid]);if($r)return $r;$this->db->run('INSERT IGNORE INTO learning_preferences(user_id) VALUES(?)',[$uid]);return $this->db->one('SELECT * FROM learning_preferences WHERE user_id=?',[$uid])??[];
    }
    private function learningSignals(int $uid,int $days=7): array {
        $days=max(3,min(30,$days));
        $rows=$this->db->all("SELECT mode,COUNT(*) attempts,ROUND(AVG(result)*100,1) accuracy FROM study_events WHERE user_id=? AND result IS NOT NULL AND created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY mode",[$uid]);
        $by=[];foreach($rows as $r)$by[(string)$r['mode']]=['attempts'=>(int)$r['attempts'],'accuracy'=>$r['accuracy']===null?null:(float)$r['accuracy']];
        $metric=function(array $modes)use($by): array {$attempts=0;$weighted=0.0;foreach($modes as $mode){$row=$by[$mode]??null;if(!$row||$row['accuracy']===null)continue;$attempts+=(int)$row['attempts'];$weighted+=(float)$row['accuracy']*(int)$row['attempts'];}return ['attempts'=>$attempts,'accuracy'=>$attempts>0?round($weighted/$attempts,1):null];};
        $recall=$metric(['review','vocabulary','fill','matching','quiz']);$listening=$metric(['listening']);$grammar=$metric(['grammar']);$toeic=$metric(['toeic','quiz']);
        return ['days'=>$days,'recall_attempts'=>$recall['attempts'],'recall_accuracy'=>$recall['accuracy'],'listening_attempts'=>$listening['attempts'],'listening_accuracy'=>$listening['accuracy'],'grammar_attempts'=>$grammar['attempts'],'grammar_accuracy'=>$grammar['accuracy'],'toeic_attempts'=>$toeic['attempts'],'toeic_accuracy'=>$toeic['accuracy']];
    }
    public function dailyPlan(int $uid): array {
        $pref=$this->learningPreferences($uid);$signals=$this->learningSignals($uid,7);
        // Review queues are deliberately disjoint so the Daily Plan can follow the requested
        // Due SRS -> Relearning -> Mistakes -> Weakness -> Hard -> Listening -> TOEIC ->
        // Collocation -> Sentence Pattern -> New Knowledge order without double-counting cards.
        $dueRegular=(int)($this->db->one("SELECT COUNT(*) n FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.due_at<=NOW() AND p.state NOT IN ('relearning','mastered') AND COALESCE(p.difficulty,1)<4",[$uid,$uid])['n']??0);
        $relearning=(int)($this->db->one("SELECT COUNT(*) n FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.state='relearning' AND p.due_at<=NOW()",[$uid,$uid])['n']??0);
        $hard=(int)($this->db->one("SELECT COUNT(*) n FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.due_at<=NOW() AND p.state NOT IN ('relearning','mastered') AND COALESCE(p.difficulty,1)>=4",[$uid,$uid])['n']??0);
        $due=$dueRegular+$relearning+$hard;
        $overdue=(int)($this->db->one("SELECT COUNT(*) n FROM srs_progress p JOIN flashcards c ON c.id=p.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE p.user_id=? AND s.user_id=? AND p.state<>'mastered' AND p.due_at<CURDATE()",[$uid,$uid])['n']??0);
        $newAvailable=(int)($this->db->one('SELECT COUNT(*) n FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE s.user_id=? AND p.card_id IS NULL',[$uid,$uid])['n']??0);
        $retention=$signals['recall_accuracy']===null?null:(float)$signals['recall_accuracy'];
        $policy=AdaptiveLearningService::workloadPolicy($due,$retention,(int)($pref['new_words_goal']??12));
        $today=['review'=>0,'vocabulary'=>0,'grammar'=>0,'listening'=>0,'toeic'=>0,'quiz'=>0,'mistake_review'=>0,'matching'=>0];
        foreach($this->db->all("SELECT mode,COUNT(*) n FROM study_events WHERE user_id=? AND created_at>=CURDATE() AND created_at<DATE_ADD(CURDATE(),INTERVAL 1 DAY) GROUP BY mode",[$uid]) as $r)if(array_key_exists((string)$r['mode'],$today))$today[(string)$r['mode']]=(int)$r['n'];
        // Keep the configured new-item allowance stable during the day: cards learned today are
        // no longer in newAvailable, so add today's new-card events back before applying the cap.
        $newGoal=min((int)$policy['new_goal'],$newAvailable+(int)$today['vocabulary']);
        $open=(int)($this->db->one("SELECT COUNT(*) n FROM mistake_book_v2 WHERE user_id=? AND mastery_status<>'RESOLVED'",[$uid])['n']??0);
        $recurred=(int)($this->db->one("SELECT COUNT(*) n FROM mistake_book_v2 WHERE user_id=? AND mastery_status='RECURRED'",[$uid])['n']??0);
        $weak=$this->weaknesses($uid,30);$topWeak=$weak[0]??null;
        $weakGoal=$topWeak?min(8,max(3,(int)ceil(((float)($topWeak['priority_score']??3))/3))):0;
        $weakHref='#toeic';$weakDone=0;
        if($topWeak){
            $e=mb_strtoupper((string)($topWeak['error_type']??''));
            if(str_contains($e,'LISTENING')||$e==='INFERENCE'||$e==='PARAPHRASE'){$weakHref='#listening';$weakDone=$today['listening'];}
            elseif(str_contains($e,'VOCAB')||str_contains($e,'COLLOCATION')){$weakHref='#adaptive';$weakDone=$today['matching']+$today['vocabulary'];}
            elseif(str_contains($e,'GRAMMAR')||str_contains($e,'WORD_FORM')||str_contains($e,'PREPOSITION')||str_contains($e,'TENSE')||str_contains($e,'PASSIVE')){$weakHref='#patterns';$weakDone=$today['grammar'];}
            else {$weakHref='#toeic';$weakDone=$today['toeic'];}
        }
        $collocationAvailable=(int)($this->db->one("SELECT COUNT(*) n FROM global_learning_items WHERE is_active=1 AND item_type='COLLOCATION'")['n']??0);
        $collocationGoal=$collocationAvailable>0?min($collocationAvailable,($topWeak&&str_contains(mb_strtoupper((string)($topWeak['error_type']??'')),'COLLOCATION'))?5:3):0;
        $patternGoal=max(0,(int)($pref['grammar_goal']??4));
        $toeicGoal=max(0,(int)($pref['toeic_goal']??10));
        $mistakeGoal=min($open+(int)$today['mistake_review'],max(0,(int)($pref['mistake_review_goal']??5)));
        $items=[
          ['key'=>'srs','label'=>'SRS đến hạn','done'=>0,'goal'=>$dueRegular,'href'=>'#review/due','priority'=>100,'pending_only'=>true,'reason'=>AdaptiveLearningService::reason('srs',['due'=>$due]),'meta'=>['overdue'=>$overdue]],
          ['key'=>'relearning','label'=>'Relearning','done'=>0,'goal'=>$relearning,'href'=>'#review/relearning','priority'=>95,'pending_only'=>true,'reason'=>$relearning?'Các thẻ bạn vừa quên cần được gọi lại sớm trước khi học mới.':'Không có thẻ Relearning đến hạn.'],
          ['key'=>'mistake_review','label'=>'Lỗi cần sửa','done'=>$today['mistake_review'],'goal'=>$mistakeGoal,'href'=>'#mistakes','priority'=>90,'reason'=>AdaptiveLearningService::reason('mistake',['open'=>$open,'recurred'=>$recurred])],
          ['key'=>'weak_skill','label'=>$topWeak?'Điểm yếu · '.str_replace('_',' ',(string)$topWeak['error_type']):'Luyện điểm yếu','done'=>$weakDone,'goal'=>$weakGoal,'href'=>$weakHref,'priority'=>85,'reason'=>AdaptiveLearningService::reason('weak',['label'=>$topWeak['error_type']??'','accuracy'=>$topWeak['accuracy']??null])],
          ['key'=>'hard_cards','label'=>'Hard Cards đến hạn','done'=>0,'goal'=>$hard,'href'=>'#review/hard','priority'=>80,'pending_only'=>true,'reason'=>$hard?'Thẻ difficulty cao được ôn sau lỗi/điểm yếu và trước nội dung mới.':'Không có Hard Card đến hạn.'],
          ['key'=>'listening','label'=>'Listening Recognition','done'=>$today['listening'],'goal'=>max(0,(int)($pref['listening_goal']??8)),'href'=>'#listening','priority'=>70,'reason'=>AdaptiveLearningService::reason('listening')],
          ['key'=>'toeic','label'=>'TOEIC Practice','done'=>$today['toeic'],'goal'=>$toeicGoal,'href'=>'#toeic','priority'=>60,'reason'=>'Luyện TOEIC sau review để áp dụng kiến thức vừa củng cố vào câu hỏi thực tế.'],
          ['key'=>'collocation','label'=>'Collocation','done'=>$today['matching'],'goal'=>$collocationGoal,'href'=>'#adaptive','priority'=>50,'reason'=>'Học từ theo cụm giúp tăng khả năng nhận diện paraphrase và dùng từ đúng ngữ cảnh TOEIC.'],
          ['key'=>'sentence_pattern','label'=>'Cấu trúc câu / Grammar','done'=>$today['grammar'],'goal'=>$patternGoal,'href'=>'#patterns','priority'=>40,'reason'=>AdaptiveLearningService::reason('grammar')],
          ['key'=>'new_knowledge','label'=>'Kiến thức mới','done'=>$today['vocabulary'],'goal'=>$newGoal,'href'=>'#review/new','priority'=>30,'reason'=>AdaptiveLearningService::reason('vocabulary',['policy_reason'=>$policy['reason']])]
        ];
        usort($items,fn($a,$b)=>$b['priority']<=>$a['priority']);
        // Review queues are live pending counts; use the aggregate SRS total for progress so the
        // three disjoint review queues do not distort the daily completion percentage.
        $totalGoal=$due+(int)$today['review'];$totalDone=(int)$today['review'];
        foreach($items as $it){
            if(in_array($it['key'],['srs','relearning','hard_cards','weak_skill'],true))continue;
            $totalGoal+=(int)$it['goal'];$totalDone+=min((int)$it['done'],(int)$it['goal']);
        }
        $pending=array_values(array_filter($items,fn($it)=>(int)$it['goal']>(int)$it['done']));$next=$pending[0]??null;
        $estimated=0;foreach($pending as $it){$left=max(0,(int)$it['goal']-(int)$it['done']);$estimated+=match($it['key']){'srs','relearning','hard_cards'=>min(15,$left),'mistake_review'=>min(6,$left)*3,'weak_skill'=>min(6,$left)*2,'listening'=>min(8,$left)*2,'toeic'=>min(10,$left)*2,'collocation'=>min(5,$left),'sentence_pattern'=>min(5,$left)*2,default=>min(10,$left)};}
        return ['due'=>$due,'due_srs'=>$dueRegular,'overdue'=>$overdue,'relearning'=>$relearning,'hard_cards'=>$hard,'new_available'=>$newAvailable,'new_goal'=>$newGoal,'backlog_level'=>$policy['backlog_level'],'message'=>$policy['reason'],'signals'=>$signals,'items'=>$items,'overall_percent'=>$totalGoal?min(100,(int)round($totalDone/$totalGoal*100)):100,'next_action'=>$next,'estimated_minutes'=>max(5,min(90,$estimated)),'top_weakness'=>$topWeak,'priority_order'=>array_column($items,'key')];
    }

    public function weaknesses(int $uid,int $days=30): array {
        $days=max(7,min(90,$days));$rows=[];
        $mistakes=$this->db->all("SELECT error_type,COALESCE(NULLIF(topic,''),'General') topic,COUNT(*) open_items,SUM(wrong_count) wrongs,SUM(mastery_status='RECURRED') recurred,MAX(last_wrong_at) last_wrong_at FROM mistake_book_v2 WHERE user_id=? AND mastery_status<>'RESOLVED' AND last_wrong_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY error_type,COALESCE(NULLIF(topic,''),'General')",[$uid]);
        foreach($mistakes as $r){
            $severity=min(100,(int)$r['wrongs']*12+(int)$r['recurred']*15);$score=AdaptiveLearningService::priorityScore(['error_frequency'=>(int)$r['wrongs'],'recurrence_count'=>(int)$r['recurred'],'weakness_severity'=>$severity,'recency_weight'=>2]);
            $r['weakness_severity']=$severity;$r['priority_score']=$score;$r['priority']=$score>=25?'HIGH':($score>=12?'MEDIUM':'MAINTENANCE');$r['accuracy']=null;$r['attempts']=null;$r['source_dimension']='MISTAKE_PATTERN';$rows[]=$r;
        }
        // Add real TOEIC performance dimensions. Unlike mistake-only rows these can report
        // accuracy because both correct and incorrect attempts are available in toeic_attempts.
        $parts=$this->db->all("SELECT q.part,COUNT(*) attempts,SUM(a.is_correct) correct,MAX(a.created_at) last_attempt_at FROM toeic_attempts a JOIN toeic_questions q ON q.id=a.question_id WHERE a.user_id=? AND a.created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY q.part HAVING COUNT(*)>=3",[$uid]);
        foreach($parts as $r){
            $attempts=(int)$r['attempts'];$correct=(int)($r['correct']??0);$wrongs=max(0,$attempts-$correct);$accuracy=$attempts?round($correct/$attempts*100,1):null;if($wrongs===0||$accuracy===null||$accuracy>=90)continue;
            $severity=(int)round(100-$accuracy);$score=AdaptiveLearningService::priorityScore(['error_frequency'=>$wrongs,'recurrence_count'=>0,'weakness_severity'=>$severity,'recency_weight'=>2]);
            $rows[]=['error_type'=>'TOEIC_PART_'.(int)$r['part'],'topic'=>'TOEIC Part '.(int)$r['part'],'open_items'=>$wrongs,'wrongs'=>$wrongs,'recurred'=>0,'last_wrong_at'=>$r['last_attempt_at'],'weakness_severity'=>$severity,'priority_score'=>$score,'priority'=>$score>=25?'HIGH':($score>=12?'MEDIUM':'MAINTENANCE'),'accuracy'=>$accuracy,'attempts'=>$attempts,'source_dimension'=>'TOEIC_PART'];
        }
        $grammar=$this->db->all("SELECT TRIM(q.grammar_category) grammar_category,COUNT(*) attempts,SUM(a.is_correct) correct,MAX(a.created_at) last_attempt_at FROM toeic_attempts a JOIN toeic_questions q ON q.id=a.question_id WHERE a.user_id=? AND a.created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) AND TRIM(COALESCE(q.grammar_category,''))<>'' GROUP BY TRIM(q.grammar_category) HAVING COUNT(*)>=3",[$uid]);
        foreach($grammar as $r){
            $attempts=(int)$r['attempts'];$correct=(int)($r['correct']??0);$wrongs=max(0,$attempts-$correct);$accuracy=$attempts?round($correct/$attempts*100,1):null;if($wrongs===0||$accuracy===null||$accuracy>=90)continue;
            $label=trim((string)$r['grammar_category']);$slug=trim((string)preg_replace('/[^\pL\pN]+/u','_',mb_strtoupper($label)),'_');$severity=(int)round(100-$accuracy);$score=AdaptiveLearningService::priorityScore(['error_frequency'=>$wrongs,'recurrence_count'=>0,'weakness_severity'=>$severity,'recency_weight'=>2]);
            $rows[]=['error_type'=>'GRAMMAR_'.$slug,'topic'=>$label,'open_items'=>$wrongs,'wrongs'=>$wrongs,'recurred'=>0,'last_wrong_at'=>$r['last_attempt_at'],'weakness_severity'=>$severity,'priority_score'=>$score,'priority'=>$score>=25?'HIGH':($score>=12?'MEDIUM':'MAINTENANCE'),'accuracy'=>$accuracy,'attempts'=>$attempts,'source_dimension'=>'TOEIC_GRAMMAR'];
        }
        usort($rows,fn($a,$b)=>(float)$b['priority_score']<=>(float)$a['priority_score']);return array_slice($rows,0,16);
    }

    public function courseCatalog(): array {$courses=$this->db->all('SELECT * FROM learning_courses WHERE is_active=1 ORDER BY sort_order,id');foreach($courses as &$c){$c['modules']=$this->db->all('SELECT * FROM learning_modules WHERE course_id=? ORDER BY sort_order,id',[$c['id']]);foreach($c['modules'] as &$m)$m['lessons']=$this->db->all('SELECT * FROM learning_lessons WHERE module_id=? ORDER BY sort_order,id',[$m['id']]);}return $courses;}
    private function normalizePatternKey(string $value): string {
        $value=mb_strtolower(trim(preg_replace('/\s+/u',' ',$value)));
        return $value;
    }
    public function ensureSentencePatternSet(int $uid): array {
        $set=$this->db->one("SELECT id FROM flashcard_sets WHERE user_id=? AND source_type='sentence_patterns' ORDER BY id LIMIT 1",[$uid]);
        if($set)return $this->ownSet($uid,(int)$set['id']);
        return $this->createSet($uid,'Cấu trúc câu TOEIC','Bộ cấu trúc câu cá nhân để học, sửa, import và ôn bằng SRS.',null,'sentence_patterns');
    }
    public function createSentencePattern(int $uid,array $d): array {
        $pattern=trim((string)($d['pattern']??''));$meaning=trim((string)($d['meaning_vi']??$d['definition']??''));$exampleEn=trim((string)($d['example_en']??''));$exampleVi=trim((string)($d['example_vi']??''));
        if($pattern===''||$meaning==='')throw new InvalidArgumentException('Cấu trúc và nghĩa tiếng Việt không được để trống.');
        if($exampleEn===''||$exampleVi==='')throw new InvalidArgumentException('Hãy thêm ví dụ tiếng Anh và bản dịch tiếng Việt để học cấu trúc theo ngữ cảnh.');
        $setId=(int)($d['set_id']??0);if($setId<=0)$setId=(int)$this->ensureSentencePatternSet($uid)['id'];else$this->ownSet($uid,$setId);
        $payload=$d;$payload['term']=trim((string)($d['title']??''))?:$pattern;$payload['definition']=$meaning;$payload['card_type']='SENTENCE_PATTERN';$payload['pattern']=$pattern;$payload['explanation']=(string)($d['grammar_note']??$d['explanation']??'');$payload['audio_text']=$exampleEn;$payload['source']=trim((string)($d['source']??''))?:'sentence_patterns';
        return $this->createCard($uid,$setId,$payload);
    }
    public function updateSentencePattern(int $uid,int $cardId,array $d): array {
        $current=$this->ownCard($uid,$cardId);if(($current['card_type']??'')!=='SENTENCE_PATTERN')throw new InvalidArgumentException('Flashcard này không phải cấu trúc câu.');
        $pattern=trim((string)($d['pattern']??''));$meaning=trim((string)($d['meaning_vi']??$d['definition']??''));$exampleEn=trim((string)($d['example_en']??''));$exampleVi=trim((string)($d['example_vi']??''));
        if($pattern===''||$meaning==='')throw new InvalidArgumentException('Cấu trúc và nghĩa tiếng Việt không được để trống.');
        if($exampleEn===''||$exampleVi==='')throw new InvalidArgumentException('Hãy giữ ví dụ tiếng Anh và bản dịch tiếng Việt cho cấu trúc này.');
        // Preserve imported cloze notes and metadata that the compact pattern editor does not expose.
        $payload=array_merge($current,$d);$payload['term']=trim((string)($d['title']??$current['term']??''))?:$pattern;$payload['definition']=$meaning;$payload['card_type']='SENTENCE_PATTERN';$payload['pattern']=$pattern;$payload['explanation']=(string)($d['grammar_note']??$d['explanation']??$current['explanation']??'');$payload['audio_text']=$exampleEn;$payload['source']=trim((string)($d['source']??$current['source']??''))?:'sentence_patterns';
        return $this->updateCard($uid,$cardId,$payload);
    }
    public function bulkInsertSentencePatterns(int $uid,int $setId,array $cards): array {
        if($setId<=0)$setId=(int)$this->ensureSentencePatternSet($uid)['id'];else$this->ownSet($uid,$setId);
        $rows=$this->db->all("SELECT c.pattern,c.term FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE s.user_id=? AND c.card_type='SENTENCE_PATTERN'",[$uid]);$existing=[];
        foreach($rows as $row){$key=$this->normalizePatternKey((string)($row['pattern']?:$row['term']));if($key!=='')$existing[$key]=true;}
        $ready=[];$skippedDuplicate=0;$skippedInvalid=0;
        foreach($cards as $card){$pattern=trim((string)($card['pattern']??$card['term']??''));$meaning=trim((string)($card['definition']??''));$exampleEn=trim((string)($card['example_en']??''));$exampleVi=trim((string)($card['example_vi']??''));$key=$this->normalizePatternKey($pattern);
            if($key===''||$meaning===''||$exampleEn===''||$exampleVi===''){$skippedInvalid++;continue;}if(isset($existing[$key])){$skippedDuplicate++;continue;}$existing[$key]=true;
            $card['term']=trim((string)($card['term']??''))?:$pattern;$card['definition']=$meaning;$card['card_type']='SENTENCE_PATTERN';$card['pattern']=$pattern;$card['audio_text']=trim((string)($card['audio_text']??''))?:$exampleEn;$card['source']=trim((string)($card['source']??''))?:'sentence_pattern_import';$ready[]=$card;
        }
        $count=$ready?$this->bulkInsertCards($uid,$setId,$ready):0;return ['set_id'=>$setId,'count'=>$count,'skipped_duplicate'=>$skippedDuplicate,'skipped_invalid'=>$skippedInvalid];
    }

    public function sentencePatterns(int $uid,string $search='',string $topic=''): array {
        $search=trim($search);$topic=trim($topic);$where=['is_active=1'];$params=[];
        if($search!==''){$where[]='(pattern LIKE ? OR meaning_vi LIKE ? OR grammar_note LIKE ? OR example_en LIKE ? OR example_vi LIKE ?)';$q='%'.$search.'%';array_push($params,$q,$q,$q,$q,$q);}
        if($topic!==''){$where[]='topic=?';$params[]=$topic;}
        $library=$this->db->all('SELECT id,pattern_key,pattern,meaning_vi,grammar_note,example_en,example_vi,topic,toeic_part,difficulty FROM sentence_pattern_library WHERE '.implode(' AND ',$where).' ORDER BY sort_order,id LIMIT 200',$params);
        $personalWhere=["s.user_id=?","c.card_type='SENTENCE_PATTERN'"];$personalParams=[$uid];
        if($search!==''){$personalWhere[]='(c.pattern LIKE ? OR c.term LIKE ? OR c.definition LIKE ? OR c.example_en LIKE ? OR c.example_vi LIKE ?)';$q='%'.$search.'%';array_push($personalParams,$q,$q,$q,$q,$q);}
        if($topic!==''){$personalWhere[]='c.topic=?';$personalParams[]=$topic;}
        $personal=$this->db->all("SELECT c.id,c.set_id,c.term,c.definition,c.pattern,c.example_en,c.example_vi,c.explanation,c.topic,c.toeic_part,c.difficulty,c.tags,c.notes,s.title set_title,p.state,p.due_at FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE ".implode(' AND ',$personalWhere)." ORDER BY COALESCE(c.topic,''),c.id DESC LIMIT 200",[$uid,...$personalParams]);
        $topicCounts=[];
        foreach($this->db->all("SELECT topic,COUNT(*) n FROM sentence_pattern_library WHERE is_active=1 AND topic IS NOT NULL AND topic<>'' GROUP BY topic") as $row)$topicCounts[(string)$row['topic']]=(int)$row['n'];
        foreach($this->db->all("SELECT c.topic,COUNT(*) n FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE s.user_id=? AND c.card_type='SENTENCE_PATTERN' AND c.topic IS NOT NULL AND c.topic<>'' GROUP BY c.topic",[$uid]) as $row)$topicCounts[(string)$row['topic']]=($topicCounts[(string)$row['topic']]??0)+(int)$row['n'];
        ksort($topicCounts,SORT_NATURAL|SORT_FLAG_CASE);$topics=[];foreach($topicCounts as $name=>$n)$topics[]=['topic'=>$name,'n'=>$n];
        return ['library'=>$library,'personal'=>$personal,'topics'=>$topics];
    }

    public function connectedSpeechExamples(): array { return $this->db->all('SELECT id,pattern_key,title,explanation,phrase,spoken_form,category FROM connected_speech_examples WHERE is_active=1 ORDER BY sort_order,id'); }
    public function toeicQuestions(int $part,int $limit=10): array {$part=max(1,min(7,$part));$limit=max(1,min(50,$limit));return $this->db->all("SELECT id,part,question_type,difficulty,question,option_a,option_b,option_c,option_d,audio_url,passage,image_url,topic,grammar_category,tags FROM toeic_questions WHERE part=? AND is_published=1 ORDER BY id LIMIT {$limit}",[$part]);}
    public function recordToeicAttempt(int $uid,int $questionId,string $selected,int $duration=0): array {
        $selected=strtoupper(trim($selected));if(!in_array($selected,['A','B','C','D'],true))throw new InvalidArgumentException('Đáp án TOEIC không hợp lệ.');
        $q=$this->db->one('SELECT * FROM toeic_questions WHERE id=? AND is_published=1',[$questionId]);if(!$q)throw new RuntimeException('Không tìm thấy câu TOEIC.');
        $correct=trim((string)($q['correct_option']??''));$ok=$correct!==''&&strtoupper(trim($selected))===strtoupper($correct);
        $this->db->run('INSERT INTO toeic_attempts(user_id,question_id,selected_answer,is_correct,duration_seconds) VALUES(?,?,?,?,?)',[$uid,$questionId,$selected,$ok?1:0,max(0,min(7200,$duration))]);
        $ctx=['source_key'=>'toeic:'.$questionId,'source_id'=>(string)$questionId,'question'=>$q['question'],'user_answer'=>$selected,'correct_answer'=>$correct,'explanation'=>(string)($q['explanation']??''),'error_type'=>(string)($q['grammar_category']??'UNKNOWN'),'topic'=>(string)($q['topic']??''),'toeic_part'=>(int)$q['part']];
        $this->recordEvent($uid,'toeic',null,null,$ok?1:0,$ok?100:0,$ok?8:2,$duration,$ctx);
        if((int)$q['part']===5&&trim((string)($q['grammar_category']??''))!=='')$this->recordEvent($uid,'grammar',null,null,$ok?1:0,$ok?100:0,0,$duration,$ctx+['source_key'=>'grammar:toeic:'.$questionId,'track_mistake'=>false]);
        $part5=null;
        if((int)$q['part']===5){
            $opts=['A'=>(string)($q['option_a']??''),'B'=>(string)($q['option_b']??''),'C'=>(string)($q['option_c']??''),'D'=>(string)($q['option_d']??'')];
            $category=trim((string)($q['grammar_category']??''));$topic=trim((string)($q['topic']??''));$tags=trim((string)($q['tags']??''));$explanation=trim((string)($q['explanation']??''));
            $part5=[
                'step1'=>['title'=>'Blank cần loại kiến thức gì?','text'=>$category!==''?$category:'Xác định từ loại / cấu trúc ngữ pháp từ vị trí chỗ trống.'],
                'step2'=>['title'=>'Signal nào đáng chú ý?','text'=>$tags!==''?$tags:($topic!==''?$topic:'Quan sát từ đứng trước/sau chỗ trống và cấu trúc của cả câu.')],
                'step3'=>['title'=>'Rule áp dụng','text'=>$explanation!==''?$explanation:'Dùng quan hệ ngữ pháp và nghĩa trong câu để chọn phương án phù hợp.'],
                'step4'=>['title'=>'Loại đáp án sai','text'=>'Đối chiếu từng lựa chọn với rule ở trên. YangLingo chỉ hiển thị lý do riêng cho distractor khi dữ liệu nguồn có cung cấp.'],
                'final'=>['option'=>$correct,'text'=>$opts[$correct]??(string)($q['correct_answer']??'')]
            ];
        }
        return ['correct'=>$ok,'correct_option'=>$correct,'correct_answer'=>$q['correct_answer']??null,'explanation'=>$q['explanation']??'','transcript'=>$q['transcript']??null,'part5_analysis'=>$part5];
    }

    public function leaderboard(int $uid,string $period='week'): array {
        $cond=$period==='all'?'1=1':($period==='month'?"e.created_at>=DATE_SUB(NOW(),INTERVAL 30 DAY)":"e.created_at>=DATE_SUB(NOW(),INTERVAL 7 DAY)");
        $rows=$this->db->all("SELECT u.id,u.name,u.english_level,COALESCE(SUM(e.xp),0) xp,COUNT(e.id) activities FROM users u LEFT JOIN study_events e ON e.user_id=u.id AND {$cond} WHERE u.is_active=1 GROUP BY u.id ORDER BY xp DESC,activities DESC,u.name LIMIT 50");
        foreach($rows as $i=>&$r){$r['rank']=$i+1;$r['is_me']=(int)$r['id']===$uid;} return $rows;
    }

    public function newThread(int $uid,string $mode='tutor',string $title='Cuộc trò chuyện mới'): array {$id=bin2hex(random_bytes(16));$this->db->run('INSERT INTO ai_threads(id,user_id,mode,title) VALUES(?,?,?,?)',[$id,$uid,$mode,mb_substr($title,0,180)]);return $this->thread($uid,$id);}
    public function threads(int $uid): array {return $this->db->all('SELECT id,mode,title,created_at,updated_at FROM ai_threads WHERE user_id=? ORDER BY updated_at DESC LIMIT 60',[$uid]);}
    public function thread(int $uid,string $id): array {$t=$this->db->one('SELECT * FROM ai_threads WHERE id=? AND user_id=?',[$id,$uid]);if(!$t)throw new RuntimeException('Không tìm thấy cuộc trò chuyện.');$t['messages']=$this->db->all('SELECT role,content,created_at FROM ai_messages WHERE thread_id=? ORDER BY id',[$id]);return $t;}
    public function addThreadMessage(int $uid,string $id,string $role,string $content): void {$t=$this->thread($uid,$id);$role=in_array($role,['user','assistant'],true)?$role:'user';$this->db->run('INSERT INTO ai_messages(thread_id,role,content) VALUES(?,?,?)',[$id,$role,$content]);if($role==='user'&&$t['title']==='Cuộc trò chuyện mới')$this->db->run('UPDATE ai_threads SET title=?,updated_at=NOW() WHERE id=?',[mb_substr(trim(preg_replace('/\s+/u',' ',$content)),0,70),$id]);else$this->db->run('UPDATE ai_threads SET updated_at=NOW() WHERE id=?',[$id]);}

    public function savePronunciation(int $uid,string $target,string $transcript,float $score,string $feedback): void {$this->db->run('INSERT INTO pronunciation_attempts(user_id,target_text,transcript,score,feedback) VALUES(?,?,?,?,?)',[$uid,$target,$transcript,max(0,min(100,$score)),$feedback]);$this->recordEvent($uid,'speaking',null,null,$score>=70?1:0,$score,(int)round($score/8),0);}
    public function recentPronunciation(int $uid): array {return $this->db->all('SELECT target_text,transcript,score,feedback,created_at FROM pronunciation_attempts WHERE user_id=? ORDER BY id DESC LIMIT 10',[$uid]);}
    public function logImport(int $uid,string $filename,string $format,int $count): void {$this->db->run('INSERT INTO imports(user_id,filename,format,cards_imported) VALUES(?,?,?,?)',[$uid,mb_substr($filename,0,255),$format,$count]);}

    // ---------- Aptis learning module v5 ----------
    private function aptisModule(string $module,bool $allowMock=false): string {
        $module=strtolower(trim($module));$allowed=['grammar','vocabulary','reading','listening','speaking','writing'];
        if($allowMock)$allowed[]='mock';
        if(!in_array($module,$allowed,true))throw new InvalidArgumentException('Kỹ năng Aptis không hợp lệ.');
        return $module;
    }
    public function aptisSummary(int $uid): array {
        $rows=$this->db->all("SELECT module,COUNT(*) attempts,SUM(is_correct) correct,ROUND(100*SUM(is_correct)/NULLIF(COUNT(*),0),1) accuracy FROM aptis_attempts WHERE user_id=? GROUP BY module ORDER BY module",[$uid]);
        $modules=[];foreach($rows as $r)$modules[(string)$r['module']]=['attempts'=>(int)$r['attempts'],'correct'=>(int)$r['correct'],'accuracy'=>(float)$r['accuracy']];
        $bank=$this->db->all("SELECT module,COUNT(*) n FROM aptis_questions WHERE is_active=1 GROUP BY module ORDER BY module");$counts=[];foreach($bank as $r)$counts[(string)$r['module']]=(int)$r['n'];
        $recent=$this->db->all("SELECT a.id,a.module,a.mode,a.is_correct,a.duration_seconds,a.created_at,q.topic,q.prompt FROM aptis_attempts a JOIN aptis_questions q ON q.id=a.question_id WHERE a.user_id=? ORDER BY a.id DESC LIMIT 12",[$uid]);
        $writing=(int)($this->db->one('SELECT COUNT(*) n FROM aptis_writing_submissions WHERE user_id=?',[$uid])['n']??0);
        $speaking=(int)($this->db->one('SELECT COUNT(*) n FROM aptis_speaking_sessions WHERE user_id=?',[$uid])['n']??0);
        return ['modules'=>$modules,'bank_counts'=>$counts,'recent'=>$recent,'writing_submissions'=>$writing,'speaking_sessions'=>$speaking];
    }
    public function aptisQuestions(string $module,int $limit=10): array {
        $module=$this->aptisModule($module,true);$limit=max(1,min(100,$limit));
        $select="id,module,type,topic,difficulty,prompt,passage,options_json,audio_text,time_limit_seconds";
        if($module==='mock')$rows=$this->db->all("SELECT {$select} FROM aptis_questions WHERE is_active=1 AND module IN ('grammar','vocabulary','reading','listening') ORDER BY id LIMIT {$limit}");
        else $rows=$this->db->all("SELECT {$select} FROM aptis_questions WHERE is_active=1 AND module=? ORDER BY id LIMIT {$limit}",[$module]);
        foreach($rows as &$r){$opts=[];if(!empty($r['options_json'])){$x=json_decode((string)$r['options_json'],true);if(is_array($x))$opts=array_is_list($x)?array_values(array_map('strval',$x)):$x;}$r['options']=$opts;unset($r['options_json']);$r['media']=$this->db->all('SELECT media_role,media_path,alt_text,sort_order FROM aptis_question_media WHERE question_id=? ORDER BY sort_order,id',[(int)$r['id']]);}
        return $rows;
    }
    private function canonicalJson(mixed $value): mixed {if(!is_array($value))return $value;if(array_is_list($value))return array_map(fn($v)=>$this->canonicalJson($v),$value);ksort($value);foreach($value as $k=>$v)$value[$k]=$this->canonicalJson($v);return $value;}
    public function recordAptisAttempt(int $uid,int $questionId,string $selected,int $duration=0,string $mode='practice'): array {
        $q=$this->db->one('SELECT * FROM aptis_questions WHERE id=? AND is_active=1',[$questionId]);if(!$q)throw new RuntimeException('Không tìm thấy câu Aptis.');
        if(!in_array((string)$q['module'],['grammar','vocabulary','reading','listening'],true))throw new InvalidArgumentException('Câu này không chấm theo đáp án tự động.');
        $selected=trim($selected);if($selected==='')throw new InvalidArgumentException('Hãy chọn hoặc nhập đáp án.');$correct=trim((string)($q['correct_answer']??''));
        $norm=static fn(string $v): string=>mb_strtolower(trim(preg_replace('/\s+/u',' ',$v)??$v));$type=(string)$q['type'];
        if($type==='sentence_ordering'){$a=json_decode($selected,true);$b=json_decode($correct,true);$ok=is_array($a)&&is_array($b)&&array_values($a)===array_values($b);}
        elseif($type==='word_matching'){$a=json_decode($selected,true);$b=json_decode($correct,true);$ok=is_array($a)&&is_array($b)&&$this->canonicalJson($a)===$this->canonicalJson($b);}
        else $ok=$correct!==''&&$norm($selected)===$norm($correct);
        $mode=$mode==='mock'?'mock':'practice';$duration=max(0,min(7200,$duration));
        $this->db->run('INSERT INTO aptis_attempts(user_id,question_id,module,mode,selected_answer,is_correct,duration_seconds) VALUES(?,?,?,?,?,?,?)',[$uid,$questionId,$q['module'],$mode,$selected,$ok?1:0,$duration]);
        $studyMode=match((string)$q['module']){'grammar'=>'grammar','vocabulary'=>'vocabulary','listening'=>'listening',default=>'quiz'};
        $topic=strtoupper((string)($q['topic']??''));$error=match((string)$q['module']){'vocabulary'=>str_contains($topic,'COLLOCATION')?'COLLOCATION':'VOCABULARY','reading'=>str_contains($topic,'INFERENCE')?'INFERENCE':'READING_COMPREHENSION','listening'=>str_contains($topic,'INFERENCE')?'INFERENCE':(str_contains($topic,'PARAPHRASE')?'PARAPHRASE':'LISTENING_RECOGNITION'),default=>str_contains($topic,'PREPOSITION')?'PREPOSITIONS':'UNKNOWN'};
        $ctx=['source_key'=>'aptis:'.$questionId,'source_id'=>(string)$questionId,'question'=>(string)$q['prompt'],'user_answer'=>$selected,'correct_answer'=>$correct,'explanation'=>(string)($q['explanation']??''),'error_type'=>$error,'topic'=>(string)($q['topic']??'')];
        $this->recordEvent($uid,$studyMode,null,null,$ok?1:0,$ok?100:0,$ok?7:2,$duration,$ctx);
        return ['correct'=>$ok,'correct_answer'=>$correct,'explanation'=>(string)($q['explanation']??''),'module'=>(string)$q['module']];
    }
    public function saveAptisWriting(int $uid,int $questionId,string $response,int $selfScore=0,string $notes=''): array {
        $q=$this->db->one("SELECT id,prompt,explanation FROM aptis_questions WHERE id=? AND module='writing' AND is_active=1",[$questionId]);if(!$q)throw new RuntimeException('Không tìm thấy đề Writing Aptis.');
        $response=trim($response);if(mb_strlen($response)<5)throw new InvalidArgumentException('Bài viết quá ngắn.');$words=preg_split('/\s+/u',$response,-1,PREG_SPLIT_NO_EMPTY)?:[];$wc=count($words);$selfScore=max(0,min(5,$selfScore));
        $this->db->run('INSERT INTO aptis_writing_submissions(user_id,question_id,response_text,word_count,self_score,notes) VALUES(?,?,?,?,?,?)',[$uid,$questionId,$response,$wc,$selfScore,mb_substr(trim($notes),0,3000)]);$id=$this->db->lastId();
        $this->recordEvent($uid,'quiz',null,null,$selfScore>=3?1:0,$selfScore*20,max(1,$selfScore*2),0,['track_mistake'=>false]);
        return ['id'=>$id,'word_count'=>$wc,'rubric'=>(string)($q['explanation']??'')];
    }
    public function saveAptisSpeaking(int $uid,int $questionId,int $duration,int $selfScore=0,string $notes=''): array {
        $q=$this->db->one("SELECT id,prompt,explanation FROM aptis_questions WHERE id=? AND module='speaking' AND is_active=1",[$questionId]);if(!$q)throw new RuntimeException('Không tìm thấy đề Speaking Aptis.');$duration=max(0,min(600,$duration));$selfScore=max(0,min(5,$selfScore));
        $this->db->run('INSERT INTO aptis_speaking_sessions(user_id,question_id,duration_seconds,self_score,notes) VALUES(?,?,?,?,?)',[$uid,$questionId,$duration,$selfScore,mb_substr(trim($notes),0,3000)]);$id=$this->db->lastId();
        $this->recordEvent($uid,'speaking',null,null,$selfScore>=3?1:0,$selfScore*20,max(1,$selfScore*2),$duration,['track_mistake'=>false]);
        return ['id'=>$id,'rubric'=>(string)($q['explanation']??'')];
    }
    public function adminAptisStats(): array {
        $rows=$this->db->all('SELECT module,COUNT(*) n FROM aptis_questions GROUP BY module ORDER BY module');$out=[];foreach($rows as $r)$out[(string)$r['module']]=(int)$r['n'];return ['counts'=>$out,'total'=>array_sum($out)];
    }
    public function adminSaveAptisQuestion(int $adminId,array $d): array {
        $module=$this->aptisModule((string)($d['module']??''));$type=mb_substr(trim((string)($d['type']??(($module==='speaking'||$module==='writing')?$module:'mcq'))),0,40)?:'mcq';$prompt=trim((string)($d['prompt']??''));if($prompt==='')throw new InvalidArgumentException('Prompt Aptis không được để trống.');
        $difficulty=strtoupper(trim((string)($d['difficulty']??'B1')));if(!in_array($difficulty,['A1','A2','B1','B2','C1','C2'],true))$difficulty='B1';$options=$d['options']??($d['options_json']??[]);if(is_string($options)){if(str_starts_with(trim($options),'[')){$decoded=json_decode($options,true);$options=is_array($decoded)?$decoded:[];}else $options=array_map('trim',explode('|',$options));}$options=is_array($options)?array_values(array_filter(array_map('strval',$options),fn($x)=>trim($x)!=='')):[];
        $opts=$options?json_encode($options,JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES):null;$vals=[mb_substr(trim((string)($d['topic']??'')),0,120)?:null,$difficulty,$prompt,trim((string)($d['passage']??''))?:null,$opts,trim((string)($d['correct_answer']??''))?:null,trim((string)($d['explanation']??''))?:null,trim((string)($d['audio_text']??''))?:null,max(0,(int)($d['time_limit_seconds']??0))?:null,mb_substr(trim((string)($d['source_note']??'Admin import')),0,255)?:'Admin import',array_key_exists('is_active',$d)?(!empty($d['is_active'])?1:0):1];
        $existing=$this->db->one('SELECT id FROM aptis_questions WHERE module=? AND prompt=?',[$module,$prompt]);
        if($existing){$id=(int)$existing['id'];$this->db->run('UPDATE aptis_questions SET type=?,topic=?,difficulty=?,prompt=?,passage=?,options_json=?,correct_answer=?,explanation=?,audio_text=?,time_limit_seconds=?,source_note=?,is_active=?,updated_at=NOW() WHERE id=?',[$type,...$vals,$id]);}
        else {$this->db->run('INSERT INTO aptis_questions(created_by,module,type,topic,difficulty,prompt,passage,options_json,correct_answer,explanation,audio_text,time_limit_seconds,source_note,is_active) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[$adminId,$module,$type,...$vals]);$id=$this->db->lastId();}
        return ['id'=>$id,'module'=>$module,'prompt'=>$prompt];
    }

    public function adminToeicQuestions(?int $part=null,int $limit=100): array {
        $where='1=1';$params=[];
        if($part!==null){$part=max(1,min(7,$part));$where='part=?';$params[]=$part;}
        $limit=max(10,min(300,$limit));
        return $this->db->all("SELECT * FROM toeic_questions WHERE {$where} ORDER BY part,id DESC LIMIT {$limit}",$params);
    }
    public function adminToeicQuestion(int $id): array {
        $q=$this->db->one('SELECT * FROM toeic_questions WHERE id=?',[$id]);
        if(!$q)throw new RuntimeException('Không tìm thấy câu TOEIC.');
        return $q;
    }
    private function normalizeMediaUrl(mixed $value): ?string {
        $url=trim((string)$value);if($url==='')return null;
        if(mb_strlen($url)>500)throw new InvalidArgumentException('URL media quá dài.');
        if(preg_match('~^https?://~i',$url)){
            if(!filter_var($url,FILTER_VALIDATE_URL))throw new InvalidArgumentException('URL media không hợp lệ.');
            return $url;
        }
        if(str_starts_with($url,'/')||preg_match('~^[A-Za-z0-9][A-Za-z0-9._/\-]*$~',$url))return $url;
        throw new InvalidArgumentException('Media chỉ chấp nhận URL http(s) hoặc đường dẫn file nội bộ an toàn.');
    }

    public function adminSaveToeicQuestion(int $adminId,array $d): array {
        $id=(int)($d['id']??0);$part=max(1,min(7,(int)($d['part']??5)));$difficulty=max(1,min(5,(int)($d['difficulty']??1)));
        $question=trim((string)($d['question']??''));if($question==='')throw new InvalidArgumentException('Câu hỏi TOEIC không được để trống.');
        $type=mb_substr(trim((string)($d['question_type']??'multiple_choice')),0,40)?:'multiple_choice';
        $a=trim((string)($d['option_a']??''));$b=trim((string)($d['option_b']??''));$c=trim((string)($d['option_c']??''));$dd=trim((string)($d['option_d']??''));
        $correct=strtoupper(trim((string)($d['correct_option']??'')));
        if($type==='multiple_choice'){
            if(!in_array($correct,['A','B','C','D'],true))throw new InvalidArgumentException('Đáp án đúng phải là A, B, C hoặc D.');
            $opts=['A'=>$a,'B'=>$b,'C'=>$c,'D'=>$dd];if(($opts[$correct]??'')==='')throw new InvalidArgumentException('Đáp án đúng đang để trống.');
        }
        $values=[
            $part,$type,$difficulty,$question,$a?:null,$b?:null,$c?:null,$dd?:null,$correct?:null,
            trim((string)($d['correct_answer']??''))?:null,trim((string)($d['explanation']??''))?:null,
            trim((string)($d['transcript']??''))?:null,$this->normalizeMediaUrl($d['audio_url']??''),
            trim((string)($d['passage']??''))?:null,$this->normalizeMediaUrl($d['image_url']??''),
            mb_substr(trim((string)($d['topic']??'')),0,120)?:null,mb_substr(trim((string)($d['grammar_category']??'')),0,120)?:null,
            mb_substr(trim((string)($d['tags']??'')),0,500)?:null,!empty($d['is_published'])?1:0
        ];
        if($id){
            if(!$this->db->one('SELECT id FROM toeic_questions WHERE id=?',[$id]))throw new RuntimeException('Không tìm thấy câu TOEIC.');
            $this->db->run('UPDATE toeic_questions SET part=?,question_type=?,difficulty=?,question=?,option_a=?,option_b=?,option_c=?,option_d=?,correct_option=?,correct_answer=?,explanation=?,transcript=?,audio_url=?,passage=?,image_url=?,topic=?,grammar_category=?,tags=?,is_published=?,updated_at=NOW() WHERE id=?',[...$values,$id]);
        }else{
            $this->db->run('INSERT INTO toeic_questions(created_by,part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,correct_answer,explanation,transcript,audio_url,passage,image_url,topic,grammar_category,tags,is_published) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[$adminId,...$values]);
            $id=$this->db->lastId();
        }
        return $this->adminToeicQuestion($id);
    }
    public function adminDeleteToeicQuestion(int $id): void {
        if(!$this->db->one('SELECT id FROM toeic_questions WHERE id=?',[$id]))throw new RuntimeException('Không tìm thấy câu TOEIC.');
        // Soft archive keeps historical toeic_attempts intact.
        $this->db->run('UPDATE toeic_questions SET is_published=0,updated_at=NOW() WHERE id=?',[$id]);
    }

    public function adminCardBank(string $search='',?int $setId=null,int $limit=50,int $offset=0): array {
        $where=['1=1'];$params=[];$search=trim($search);
        if($search!==''){
            $where[]='(c.term LIKE ? OR c.definition LIKE ? OR c.ipa LIKE ? OR c.topic LIKE ? OR c.tags LIKE ? OR s.title LIKE ?)';
            $q='%'.$search.'%';array_push($params,$q,$q,$q,$q,$q,$q);
        }
        if($setId){$where[]='s.id=?';$params[]=$setId;}
        $limit=max(20,min(100,$limit));$offset=max(0,$offset);$w=implode(' AND ',$where);
        $total=(int)($this->db->one("SELECT COUNT(*) n FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE {$w}",$params)['n']??0);
        $cards=$this->db->all("SELECT c.*,s.title set_title,u.name owner_name FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id JOIN users u ON u.id=s.user_id WHERE {$w} ORDER BY c.term,c.id LIMIT {$limit} OFFSET {$offset}",$params);
        $sets=$this->db->all("SELECT s.id,s.title,u.name owner_name,COUNT(c.id) card_count FROM flashcard_sets s JOIN users u ON u.id=s.user_id JOIN flashcards c ON c.set_id=s.id GROUP BY s.id ORDER BY s.title LIMIT 500");
        return ['cards'=>$cards,'sets'=>$sets,'total'=>$total,'limit'=>$limit,'offset'=>$offset];
    }

    public function adminUpdateAnyCard(int $cardId,array $d): array {
        $c=$this->db->one('SELECT c.*,s.title set_title FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE c.id=?',[$cardId]);
        if(!$c)throw new RuntimeException('Không tìm thấy flashcard.');
        $term=trim((string)($d['term']??''));$def=trim((string)($d['definition']??''));
        if($term===''||$def==='')throw new InvalidArgumentException('Từ và nghĩa không được để trống.');
        $m=$this->normalizeCardMeta($d+$c);
        $this->db->run(
            'UPDATE flashcards SET term=?,definition=?,ipa=?,part_of_speech=?,cefr=?,example_en=?,example_vi=?,notes=?,card_type=?,topic=?,subtopic=?,toeic_part=?,difficulty=?,pattern=?,collocations=?,word_family=?,explanation=?,audio_text=?,tags=?,source=? WHERE id=?',
            [mb_substr($term,0,255),$def,(string)($d['ipa']??$c['ipa']??''),(string)($d['part_of_speech']??$c['part_of_speech']??''),(string)($d['cefr']??$c['cefr']??''),(string)($d['example_en']??$c['example_en']??''),(string)($d['example_vi']??$c['example_vi']??''),(string)($d['notes']??$c['notes']??''),...$m,$cardId]
        );
        $this->db->run('UPDATE flashcard_sets SET updated_at=NOW() WHERE id=?',[(int)$c['set_id']]);
        return $this->db->one('SELECT c.*,s.title set_title FROM flashcards c JOIN flashcard_sets s ON s.id=c.set_id WHERE c.id=?',[$cardId])??[];
    }

    // ---------- Quiz storage V10 ----------
    // V10 isolates quizzes from the legacy admin_quizzes/staging tables. A Book row is
    // created immediately and each save has its own batch id. The public/admin list reads
    // only this store, so deleting a legacy quiz cannot make newly uploaded Books disappear.
    public function adminQuizzes(): array {
        return $this->db->all("SELECT q.*,COALESCE(u.name,'Admin') creator_name,CASE WHEN q.save_state='ready' AND q.active_batch_id IS NOT NULL THEN (SELECT COUNT(*) FROM quiz_items_v10 i WHERE i.quiz_id=q.id AND i.batch_id=q.active_batch_id) WHEN q.pending_batch_id IS NOT NULL THEN (SELECT COUNT(*) FROM quiz_items_v10 i WHERE i.quiz_id=q.id AND i.batch_id=q.pending_batch_id) ELSE 0 END question_count FROM quiz_packs_v10 q LEFT JOIN users u ON u.id=q.owner_user_id ORDER BY q.updated_at DESC,q.id DESC");
    }
    public function adminQuiz(int $id): array {
        $q=$this->db->one("SELECT q.*,COALESCE(u.name,'Admin') creator_name FROM quiz_packs_v10 q LEFT JOIN users u ON u.id=q.owner_user_id WHERE q.id=?",[$id]);
        if(!$q)throw new RuntimeException('Không tìm thấy đề.');
        $batch=(string)((($q['save_state']??'ready')!=='ready' && !empty($q['pending_batch_id']))?$q['pending_batch_id']:($q['active_batch_id']??''));
        if($batch==='')$batch=(string)($q['pending_batch_id']??'');
        $q['questions']=$batch===''?[]:$this->db->all('SELECT i.*,c.term source_term,c.definition source_definition,c.set_id,s.title set_title FROM quiz_items_v10 i LEFT JOIN flashcards c ON c.id=i.card_id LEFT JOIN flashcard_sets s ON s.id=c.set_id WHERE i.quiz_id=? AND i.batch_id=? ORDER BY i.position,i.id',[$id,$batch]);
        return $q;
    }
    private function quizWrongAnswers(string $correct,array $provided): array {
        $out=[];foreach($provided as $v){$v=trim((string)$v);if($v!==''&&$v!==$correct&&!in_array($v,$out,true))$out[]=$v;}
        if(count($out)<3){$rows=$this->db->all('SELECT DISTINCT definition FROM flashcards WHERE definition<>? ORDER BY id LIMIT 200',[$correct]);foreach($rows as $r){$v=trim((string)$r['definition']);if($v!==''&&!in_array($v,$out,true))$out[]=$v;if(count($out)>=3)break;}}
        if(count($out)<3)throw new InvalidArgumentException('Cần ít nhất 4 nghĩa khác nhau trong kho từ để tạo đáp án nhiễu.');return array_slice($out,0,3);
    }
    public function adminSaveQuiz(int $adminId,array $d): array {
        $questions=is_array($d['questions']??null)?$d['questions']:[];
        $d['expected_count']=count($questions);
        $job=$this->adminBeginQuizSave($adminId,$d);
        foreach(array_chunk($questions,50,true) as $chunkIndex=>$chunk){
            $rows=array_values($chunk);
            $this->adminAppendQuizSave($adminId,['upload_id'=>$job['upload_id'],'offset'=>$chunkIndex*50,'questions'=>$rows]);
        }
        return $this->adminFinishQuizSave($adminId,['upload_id'=>$job['upload_id']]);
    }
    public function adminBeginQuizSave(int $adminId,array $d): array {
        $targetId=(int)($d['id']??0);$title=trim((string)($d['title']??''));if($title==='')throw new InvalidArgumentException('Hãy nhập tên đề.');
        $desc=mb_substr(trim((string)($d['description']??'')),0,1000);$date=trim((string)($d['available_date']??''));if($date!==''&&!preg_match('/^\d{4}-\d{2}-\d{2}$/',$date))throw new InvalidArgumentException('Ngày mở đề không hợp lệ.');$date=$date?:null;
        $published=!empty($d['is_published'])?1:0;$expected=(int)($d['expected_count']??0);if($expected<1)throw new InvalidArgumentException('Đề cần ít nhất 1 câu hỏi.');if($expected>300)throw new InvalidArgumentException('Mỗi đề tối đa 300 câu.');
        $uploadId=bin2hex(random_bytes(16));
        if($targetId){
            $q=$this->db->one('SELECT id FROM quiz_packs_v10 WHERE id=?',[$targetId]);if(!$q)throw new RuntimeException('Không tìm thấy đề cần sửa.');
            // Remove an abandoned pending batch for this Book only; never touch another Book.
            $old=$this->db->one('SELECT pending_batch_id FROM quiz_packs_v10 WHERE id=?',[$targetId]);
            if(!empty($old['pending_batch_id']))$this->db->run('DELETE FROM quiz_items_v10 WHERE quiz_id=? AND batch_id=?',[$targetId,$old['pending_batch_id']]);
            $this->db->run("UPDATE quiz_packs_v10 SET title=?,description=?,available_date=?,pending_publish=?,is_published=0,save_state='saving',expected_count=?,pending_batch_id=?,updated_at=NOW() WHERE id=?",[mb_substr($title,0,180),$desc,$date,$published,$expected,$uploadId,$targetId]);
        }else{
            $this->db->run("INSERT INTO quiz_packs_v10(owner_user_id,title,description,available_date,is_published,pending_publish,save_state,expected_count,pending_batch_id) VALUES(?,?,?,?,0,?,'saving',?,?)",[$adminId,mb_substr($title,0,180),$desc,$date,$published,$expected,$uploadId]);
            $targetId=$this->db->lastId();
        }
        return ['upload_id'=>$uploadId,'target_quiz_id'=>$targetId,'quiz_id'=>$targetId,'expected_count'=>$expected,'chunk_size'=>50,'save_state'=>'saving','storage'=>'v10'];
    }
    public function adminAppendQuizSave(int $adminId,array $d): array {
        $uploadId=trim((string)($d['upload_id']??''));if(!preg_match('/^[a-f0-9]{32}$/',$uploadId))throw new InvalidArgumentException('Mã phiên lưu đề không hợp lệ.');
        $q=$this->db->one('SELECT * FROM quiz_packs_v10 WHERE pending_batch_id=? AND owner_user_id=?',[$uploadId,$adminId]);if(!$q)throw new RuntimeException('Phiên lưu đề không tồn tại. Book vẫn được giữ trong Admin; hãy mở Sửa và lưu lại.');
        $rows=is_array($d['questions']??null)?$d['questions']:[];if(!$rows)throw new InvalidArgumentException('Lô câu hỏi đang trống.');if(count($rows)>50)throw new InvalidArgumentException('Mỗi lô chỉ được lưu tối đa 50 câu.');
        $offset=max(0,(int)($d['offset']??0));$expected=(int)$q['expected_count'];if($offset>=300||$offset+count($rows)>$expected)throw new InvalidArgumentException('Vị trí lô câu hỏi vượt quá số câu của đề.');
        $pool=array_values(array_filter(array_map(fn($r)=>trim((string)($r['definition']??'')),$this->db->all("SELECT DISTINCT definition FROM flashcards WHERE definition<>'' LIMIT 1200"))));
        $stmt=$this->db->pdo()->prepare('INSERT INTO quiz_items_v10(quiz_id,batch_id,position,card_id,question,correct_answer,wrong_answer_1,wrong_answer_2,wrong_answer_3,explanation) VALUES(?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE card_id=VALUES(card_id),question=VALUES(question),correct_answer=VALUES(correct_answer),wrong_answer_1=VALUES(wrong_answer_1),wrong_answer_2=VALUES(wrong_answer_2),wrong_answer_3=VALUES(wrong_answer_3),explanation=VALUES(explanation)');
        foreach($rows as $i=>$row){if(!is_array($row))throw new InvalidArgumentException('Dữ liệu câu '.($offset+$i+1).' không hợp lệ.');$question=trim((string)($row['question']??''));$correct=trim((string)($row['correct_answer']??''));if($question===''||$correct==='')throw new InvalidArgumentException('Câu '.($offset+$i+1).' đang thiếu câu hỏi hoặc đáp án đúng.');$cardId=!empty($row['card_id'])?(int)$row['card_id']:null;$wrong=[];foreach([$row['wrong_answer_1']??'',$row['wrong_answer_2']??'',$row['wrong_answer_3']??''] as $v){$v=trim((string)$v);if($v!==''&&$v!==$correct&&!in_array($v,$wrong,true))$wrong[]=$v;}if(count($wrong)<3){$base=(($offset+$i)*19)%max(1,count($pool));for($n=0;$n<count($pool)&&count($wrong)<3;$n++){$v=$pool[($base+$n)%count($pool)]??'';if($v!==''&&$v!==$correct&&!in_array($v,$wrong,true))$wrong[]=$v;}}if(count($wrong)<3)throw new InvalidArgumentException('Câu '.($offset+$i+1).' chưa đủ 3 đáp án nhiễu.');$stmt->execute([(int)$q['id'],$uploadId,$offset+$i,$cardId,$question,$correct,$wrong[0],$wrong[1],$wrong[2],trim((string)($row['explanation']??''))]);}
        $saved=(int)($this->db->one('SELECT COUNT(*) n FROM quiz_items_v10 WHERE quiz_id=? AND batch_id=?',[(int)$q['id'],$uploadId])['n']??0);return ['upload_id'=>$uploadId,'quiz_id'=>(int)$q['id'],'saved_count'=>$saved,'expected_count'=>$expected,'storage'=>'v10'];
    }
    public function adminFinishQuizSave(int $adminId,array $d): array {
        $uploadId=trim((string)($d['upload_id']??''));if(!preg_match('/^[a-f0-9]{32}$/',$uploadId))throw new InvalidArgumentException('Mã phiên lưu đề không hợp lệ.');
        $q=$this->db->one('SELECT * FROM quiz_packs_v10 WHERE pending_batch_id=? AND owner_user_id=?',[$uploadId,$adminId]);if(!$q)throw new RuntimeException('Không tìm thấy Book đang lưu.');$quizId=(int)$q['id'];$expected=(int)$q['expected_count'];
        $stats=$this->db->one('SELECT COUNT(*) n,MIN(position) min_pos,MAX(position) max_pos FROM quiz_items_v10 WHERE quiz_id=? AND batch_id=?',[$quizId,$uploadId])??[];$count=(int)($stats['n']??0);
        if($count!==$expected||(int)($stats['min_pos']??-1)!==0||(int)($stats['max_pos']??-1)!==$expected-1){$this->db->run("UPDATE quiz_packs_v10 SET save_state='error',updated_at=NOW() WHERE id=?",[$quizId]);throw new RuntimeException('Server mới lưu '.$count.'/'.$expected.' câu. Book #'.$quizId.' vẫn nằm ngoài Admin để bạn sửa tiếp.');}
        $this->db->tx(function()use($quizId,$uploadId,$q){$this->db->run("UPDATE quiz_packs_v10 SET active_batch_id=?,pending_batch_id=NULL,is_published=pending_publish,save_state='ready',expected_count=0,updated_at=NOW() WHERE id=?",[$uploadId,$quizId]);$this->db->run('DELETE FROM quiz_items_v10 WHERE quiz_id=? AND batch_id<>?',[$quizId,$uploadId]);});
        $quiz=$this->adminQuiz($quizId);$quiz['saved_count']=$expected;$quiz['storage']='v10';return $quiz;
    }
    public function adminDeleteQuiz(int $id): void {
        if(!$this->db->one('SELECT id FROM quiz_packs_v10 WHERE id=?',[$id]))throw new RuntimeException('Không tìm thấy đề.');
        $this->db->tx(function()use($id){$this->db->run('DELETE FROM quiz_items_v10 WHERE quiz_id=?',[$id]);$this->db->run('DELETE FROM quiz_packs_v10 WHERE id=?',[$id]);});
    }
    public function publishedQuizzes(): array {
        return $this->db->all("SELECT q.id,q.title,q.description,q.available_date,q.updated_at,(SELECT COUNT(*) FROM quiz_items_v10 i WHERE i.quiz_id=q.id AND i.batch_id=q.active_batch_id) question_count FROM quiz_packs_v10 q WHERE q.is_published=1 AND q.save_state='ready' AND q.active_batch_id IS NOT NULL AND (q.available_date IS NULL OR q.available_date<=CURDATE()) ORDER BY COALESCE(q.available_date,'9999-12-31') DESC,q.updated_at DESC");
    }
    public function publishedQuiz(int $id): array {
        $q=$this->db->one("SELECT id,title,description,available_date,active_batch_id FROM quiz_packs_v10 WHERE id=? AND is_published=1 AND save_state='ready' AND active_batch_id IS NOT NULL AND (available_date IS NULL OR available_date<=CURDATE())",[$id]);if(!$q)throw new RuntimeException('Đề chưa được mở hoặc không tồn tại.');
        $q['questions']=$this->db->all('SELECT i.id,i.card_id,i.position,i.question,i.correct_answer,i.wrong_answer_1,i.wrong_answer_2,i.wrong_answer_3,i.explanation,c.set_id FROM quiz_items_v10 i LEFT JOIN flashcards c ON c.id=i.card_id WHERE i.quiz_id=? AND i.batch_id=? ORDER BY i.position,i.id',[$id,$q['active_batch_id']]);unset($q['active_batch_id']);return $q;
    }

    public function adminDailySets(): array {return $this->db->all("SELECT d.*,u.name creator_name,COUNT(dc.card_id) card_count FROM admin_daily_sets d JOIN users u ON u.id=d.created_by LEFT JOIN admin_daily_cards dc ON dc.daily_set_id=d.id GROUP BY d.id ORDER BY d.study_date DESC,d.id DESC LIMIT 180");}
    public function adminDailySet(int $id): array {$d=$this->db->one('SELECT d.*,u.name creator_name FROM admin_daily_sets d JOIN users u ON u.id=d.created_by WHERE d.id=?',[$id]);if(!$d)throw new RuntimeException('Không tìm thấy lịch flashcard.');$d['cards']=$this->db->all('SELECT c.*,s.title set_title,dc.position FROM admin_daily_cards dc JOIN flashcards c ON c.id=dc.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE dc.daily_set_id=? ORDER BY dc.position,c.id',[$id]);return $d;}
    public function adminSaveDaily(int $adminId,array $d): array {$id=(int)($d['id']??0);$date=trim((string)($d['study_date']??''));if(!preg_match('/^\d{4}-\d{2}-\d{2}$/',$date))throw new InvalidArgumentException('Hãy chọn ngày học.');$title=trim((string)($d['title']??''));if($title==='')$title='Flashcard ngày '.date('d/m/Y',strtotime($date));$desc=mb_substr(trim((string)($d['description']??'')),0,1000);$published=!empty($d['is_published'])?1:0;$ids=array_values(array_unique(array_filter(array_map('intval',is_array($d['card_ids']??null)?$d['card_ids']:[]))));if(!$ids)throw new InvalidArgumentException('Hãy chọn ít nhất 1 flashcard.');if(count($ids)>300)throw new InvalidArgumentException('Mỗi ngày tối đa 300 flashcard.');
        $this->db->tx(function()use(&$id,$adminId,$date,$title,$desc,$published,$ids){$dup=$this->db->one('SELECT id FROM admin_daily_sets WHERE study_date=? AND id<>?',[$date,$id]);if($dup)throw new InvalidArgumentException('Ngày này đã có một bộ flashcard. Hãy sửa bộ hiện có.');if($id){if(!$this->db->one('SELECT id FROM admin_daily_sets WHERE id=?',[$id]))throw new RuntimeException('Không tìm thấy lịch flashcard.');$this->db->run('UPDATE admin_daily_sets SET study_date=?,title=?,description=?,is_published=?,updated_at=NOW() WHERE id=?',[$date,mb_substr($title,0,180),$desc,$published,$id]);$this->db->run('DELETE FROM admin_daily_cards WHERE daily_set_id=?',[$id]);}else{$this->db->run('INSERT INTO admin_daily_sets(created_by,study_date,title,description,is_published) VALUES(?,?,?,?,?)',[$adminId,$date,mb_substr($title,0,180),$desc,$published]);$id=$this->db->lastId();}$stmt=$this->db->pdo()->prepare('INSERT INTO admin_daily_cards(daily_set_id,card_id,position) SELECT ?,id,? FROM flashcards WHERE id=?');foreach($ids as $pos=>$cardId)$stmt->execute([$id,$pos,$cardId]);$count=(int)($this->db->one('SELECT COUNT(*) n FROM admin_daily_cards WHERE daily_set_id=?',[$id])['n']??0);if($count===0)throw new InvalidArgumentException('Các flashcard đã chọn không còn tồn tại.');});return $this->adminDailySet($id);}
    public function adminDeleteDaily(int $id): void {if(!$this->db->one('SELECT id FROM admin_daily_sets WHERE id=?',[$id]))throw new RuntimeException('Không tìm thấy lịch flashcard.');$this->db->run('DELETE FROM admin_daily_sets WHERE id=?',[$id]);}
    public function dailyAssignment(string $date): ?array {$date=trim($date);if(!preg_match('/^\d{4}-\d{2}-\d{2}$/',$date))$date=date('Y-m-d');$d=$this->db->one('SELECT id,study_date,title,description FROM admin_daily_sets WHERE study_date=? AND is_published=1 AND study_date<=CURDATE()',[$date]);if(!$d)return null;$d['cards']=$this->db->all('SELECT c.*,s.title set_title,dc.position FROM admin_daily_cards dc JOIN flashcards c ON c.id=dc.card_id JOIN flashcard_sets s ON s.id=c.set_id WHERE dc.daily_set_id=? ORDER BY dc.position,c.id',[$d['id']]);return $d;}

    private function practiceType(string $type): string {
        $type=strtolower(trim($type));
        if(!in_array($type,['listening','fill','matching','speaking'],true))throw new InvalidArgumentException('Loại bài luyện tập không hợp lệ.');
        return $type;
    }
    public function adminPracticePacks(?string $type=null): array {
        $params=[];$where='1=1';
        if($type!==null&&trim($type)!==''){$type=$this->practiceType($type);$where='p.practice_type=?';$params[]=$type;}
        return $this->db->all("SELECT p.*,u.name creator_name,COUNT(i.id) item_count FROM admin_practice_packs p JOIN users u ON u.id=p.created_by LEFT JOIN admin_practice_items i ON i.pack_id=p.id WHERE {$where} GROUP BY p.id ORDER BY p.updated_at DESC,p.id DESC LIMIT 300",$params);
    }
    public function adminPracticePack(int $id): array {
        $p=$this->db->one('SELECT p.*,u.name creator_name FROM admin_practice_packs p JOIN users u ON u.id=p.created_by WHERE p.id=?',[$id]);
        if(!$p)throw new RuntimeException('Không tìm thấy bài luyện tập.');
        $p['items']=$this->db->all('SELECT * FROM admin_practice_items WHERE pack_id=? ORDER BY position,id',[$id]);
        return $p;
    }
    private function practiceWrongAnswers(string $correct,array $provided,array $pool=[]): array {
        $out=[];
        foreach(array_merge($provided,$pool) as $v){$v=trim((string)$v);if($v!==''&&$v!==$correct&&!in_array($v,$out,true))$out[]=$v;if(count($out)>=3)break;}
        if(count($out)<3){$rows=$this->db->all('SELECT DISTINCT definition FROM flashcards WHERE definition<>? ORDER BY RAND() LIMIT 30',[$correct]);foreach($rows as $r){$v=trim((string)$r['definition']);if($v!==''&&!in_array($v,$out,true))$out[]=$v;if(count($out)>=3)break;}}
        if(count($out)<3)throw new InvalidArgumentException('Listening cần 1 đáp án đúng và 3 đáp án nhiễu khác nhau. Hãy điền thêm đáp án nhiễu.');
        return array_slice($out,0,3);
    }
    public function adminSavePractice(int $adminId,array $d): array {
        $id=(int)($d['id']??0);$type=$this->practiceType((string)($d['practice_type']??''));$title=trim((string)($d['title']??''));
        if($title==='')throw new InvalidArgumentException('Hãy nhập tên bài luyện tập.');
        $desc=mb_substr(trim((string)($d['description']??'')),0,1000);$date=trim((string)($d['available_date']??''));
        if($date!==''&&!preg_match('/^\d{4}-\d{2}-\d{2}$/',$date))throw new InvalidArgumentException('Ngày mở bài không hợp lệ.');$date=$date?:null;
        $published=!empty($d['is_published'])?1:0;$items=is_array($d['items']??null)?$d['items']:[];
        if(!$items)throw new InvalidArgumentException('Bài luyện tập cần ít nhất 1 nội dung.');if(count($items)>300)throw new InvalidArgumentException('Mỗi bài tối đa 300 mục.');
        $answerPool=[];foreach($items as $row)if(is_array($row)){ $v=trim((string)($row['answer']??$row['correct_answer']??''));if($v!=='')$answerPool[]=$v; }
        $this->db->tx(function()use(&$id,$adminId,$type,$title,$desc,$date,$published,$items,$answerPool){
            if($id){$old=$this->db->one('SELECT id,practice_type FROM admin_practice_packs WHERE id=?',[$id]);if(!$old)throw new RuntimeException('Không tìm thấy bài luyện tập.');$this->db->run('UPDATE admin_practice_packs SET practice_type=?,title=?,description=?,available_date=?,is_published=?,updated_at=NOW() WHERE id=?',[$type,mb_substr($title,0,180),$desc,$date,$published,$id]);$this->db->run('DELETE FROM admin_practice_items WHERE pack_id=?',[$id]);}
            else{$this->db->run('INSERT INTO admin_practice_packs(created_by,practice_type,title,description,available_date,is_published) VALUES(?,?,?,?,?,?)',[$adminId,$type,mb_substr($title,0,180),$desc,$date,$published]);$id=$this->db->lastId();}
            $stmt=$this->db->pdo()->prepare('INSERT INTO admin_practice_items(pack_id,position,prompt,answer,wrong_answer_1,wrong_answer_2,wrong_answer_3,audio_text,audio_path,hint,explanation) VALUES(?,?,?,?,?,?,?,?,?,?,?)');$pos=0;
            foreach($items as $row){if(!is_array($row))continue;$prompt=trim((string)($row['prompt']??$row['question']??$row['left_text']??$row['target_text']??''));$answer=trim((string)($row['answer']??$row['correct_answer']??$row['right_text']??''));$audio=trim((string)($row['audio_text']??''));$audioPath=trim((string)($row['audio_path']??''));if($audioPath!==''&&!preg_match('#^uploads/listening/[A-Za-z0-9._-]+$#',$audioPath))$audioPath='';$hint=trim((string)($row['hint']??''));$explain=trim((string)($row['explanation']??''));$wrong=['','',''];
                if($type==='listening'){$audio=$audio!==''?$audio:$prompt;if($audio===''&&$audioPath==='')continue;if($answer==='')continue;$wrong=$this->practiceWrongAnswers($answer,[$row['wrong_answer_1']??'',$row['wrong_answer_2']??'',$row['wrong_answer_3']??''],$answerPool);if($prompt==='')$prompt='Nghe và chọn đáp án đúng.';}
                elseif($type==='fill'){if($prompt===''||$answer==='')continue;}
                elseif($type==='matching'){if($prompt===''||$answer==='')continue;}
                elseif($type==='speaking'){if($prompt==='')continue;$answer=$answer?:$hint;}
                $stmt->execute([$id,$pos++,$prompt,$answer,$wrong[0],$wrong[1],$wrong[2],$audio,$audioPath,$hint,$explain]);
            }
            if($pos===0)throw new InvalidArgumentException('Không có nội dung hợp lệ để lưu.');
            if($type==='matching'&&$published&&$pos<3)throw new InvalidArgumentException('Matching cần ít nhất 3 cặp trước khi xuất bản.');
        });
        return $this->adminPracticePack($id);
    }
    public function adminDeletePractice(int $id): void {if(!$this->db->one('SELECT id FROM admin_practice_packs WHERE id=?',[$id]))throw new RuntimeException('Không tìm thấy bài luyện tập.');$this->db->run('DELETE FROM admin_practice_packs WHERE id=?',[$id]);}
    public function publishedPracticePacks(string $type): array {$type=$this->practiceType($type);return $this->db->all("SELECT p.id,p.practice_type,p.title,p.description,p.available_date,p.updated_at,COUNT(i.id) item_count FROM admin_practice_packs p JOIN admin_practice_items i ON i.pack_id=p.id WHERE p.practice_type=? AND p.is_published=1 AND (p.available_date IS NULL OR p.available_date<=CURDATE()) GROUP BY p.id ORDER BY COALESCE(p.available_date,'9999-12-31') DESC,p.updated_at DESC",[$type]);}
    public function publishedPracticePack(int $id,?string $type=null): array {$params=[$id];$where='p.id=?';if($type!==null&&trim($type)!==''){$type=$this->practiceType($type);$where.=' AND p.practice_type=?';$params[]=$type;}$p=$this->db->one("SELECT p.id,p.practice_type,p.title,p.description,p.available_date FROM admin_practice_packs p WHERE {$where} AND p.is_published=1 AND (p.available_date IS NULL OR p.available_date<=CURDATE())",$params);if(!$p)throw new RuntimeException('Bài luyện tập chưa được mở hoặc không tồn tại.');$p['items']=$this->db->all('SELECT id,position,prompt,answer,wrong_answer_1,wrong_answer_2,wrong_answer_3,audio_text,audio_path,hint,explanation FROM admin_practice_items WHERE pack_id=? ORDER BY position,id',[$id]);return $p;}


    // ---------- TOEIC 800+ Handbooks ----------
    public function handbooks(int $uid): array {
        $rows=$this->db->all("SELECT h.id,h.code,h.title,h.subtitle,h.description,h.source_pdf_path,h.sort_order,
            (SELECT COUNT(*) FROM learning_handbook_sections s WHERE s.handbook_id=h.id AND s.is_active=1) section_count,
            (SELECT COUNT(*) FROM handbook_practice_items p JOIN learning_handbook_sections s2 ON s2.id=p.section_id WHERE s2.handbook_id=h.id AND s2.is_active=1 AND p.is_active=1) practice_count,
            (SELECT COUNT(*) FROM user_handbook_progress up JOIN learning_handbook_sections s3 ON s3.id=up.section_id WHERE up.user_id=? AND s3.handbook_id=h.id AND s3.is_active=1 AND up.is_completed=1) completed_sections
            FROM learning_handbooks h WHERE h.is_active=1 ORDER BY h.sort_order,h.id",[$uid]);
        foreach($rows as &$r){$total=max(0,(int)$r['section_count']);$done=max(0,(int)$r['completed_sections']);$r['progress_percent']=$total?(int)round(100*$done/$total):0;}
        return $rows;
    }
    public function handbook(int $uid,string $code): array {
        $code=trim($code);if($code===''||!preg_match('/^[a-z0-9-]{2,80}$/',$code))throw new InvalidArgumentException('Mã handbook không hợp lệ.');
        $book=$this->db->one('SELECT id,code,title,subtitle,description,source_pdf_path,sort_order FROM learning_handbooks WHERE code=? AND is_active=1',[$code]);
        if(!$book)throw new RuntimeException('Không tìm thấy handbook.');
        $book['sections']=$this->db->all("SELECT s.id,s.section_key,s.title,s.sort_order,COALESCE(up.is_completed,0) is_completed,up.completed_at,
            (SELECT COUNT(*) FROM handbook_practice_items p WHERE p.section_id=s.id AND p.is_active=1) practice_count,
            (SELECT COUNT(*) FROM handbook_section_items si WHERE si.section_id=s.id) related_count
            FROM learning_handbook_sections s LEFT JOIN user_handbook_progress up ON up.section_id=s.id AND up.user_id=?
            WHERE s.handbook_id=? AND s.is_active=1 ORDER BY s.sort_order,s.id",[$uid,(int)$book['id']]);
        return $book;
    }
    public function handbookSection(int $uid,int $sectionId): array {
        $row=$this->db->one("SELECT s.id,s.section_key,s.title,s.body_text,s.metadata_json,s.sort_order,h.code handbook_code,h.title handbook_title,h.source_pdf_path,
            COALESCE(up.is_completed,0) is_completed,up.completed_at,
            (SELECT COUNT(*) FROM handbook_practice_items p WHERE p.section_id=s.id AND p.is_active=1) practice_count,
            (SELECT COUNT(*) FROM handbook_section_items si WHERE si.section_id=s.id) related_count
            FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id AND h.is_active=1
            LEFT JOIN user_handbook_progress up ON up.section_id=s.id AND up.user_id=?
            WHERE s.id=? AND s.is_active=1",[$uid,$sectionId]);
        if(!$row)throw new RuntimeException('Không tìm thấy chương học.');
        $meta=json_decode((string)($row['metadata_json']??''),true);$row['metadata']=is_array($meta)?$meta:[];unset($row['metadata_json']);return $row;
    }
    public function handbookPractice(int $uid,int $sectionId,int $limit=120): array {
        $this->handbookSection($uid,$sectionId);$limit=max(1,min(150,$limit));
        $rows=$this->db->all("SELECT id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json FROM handbook_practice_items WHERE section_id=? AND is_active=1 ORDER BY sort_order,id LIMIT {$limit}",[$sectionId]);
        foreach($rows as &$r){$m=json_decode((string)($r['metadata_json']??''),true);$r['metadata']=is_array($m)?$m:[];unset($r['metadata_json']);}
        return $rows;
    }
    public function handbookRelatedItems(int $uid,int $sectionId,string $search='',int $limit=40): array {
        $this->handbookSection($uid,$sectionId);$limit=max(1,min(100,$limit));$search=trim($search);$params=[$sectionId];$where='si.section_id=? AND g.is_active=1';
        if($search!==''){$where.=' AND (g.term LIKE ? OR g.meaning_vi LIKE ? OR g.definition_en LIKE ?)';$q='%'.$search.'%';array_push($params,$q,$q,$q);}
        $rows=$this->db->all("SELECT g.id,g.external_key,g.item_type,g.term,g.meaning_vi,g.definition_en,g.example_en,g.example_vi,g.topic,g.level,g.metadata_json FROM handbook_section_items si JOIN global_learning_items g ON g.external_key=si.item_external_key WHERE {$where} ORDER BY si.sort_order,g.term LIMIT {$limit}",$params);
        foreach($rows as &$r){$m=json_decode((string)($r['metadata_json']??''),true);$r['metadata']=is_array($m)?$m:[];unset($r['metadata_json']);}
        return $rows;
    }
    public function markHandbookSection(int $uid,int $sectionId,bool $completed): array {
        $this->handbookSection($uid,$sectionId);$done=$completed?1:0;$at=$completed?date('Y-m-d H:i:s'):null;
        $this->db->run('INSERT INTO user_handbook_progress(user_id,section_id,is_completed,completed_at) VALUES(?,?,?,?) ON DUPLICATE KEY UPDATE is_completed=VALUES(is_completed),completed_at=VALUES(completed_at),updated_at=NOW()',[$uid,$sectionId,$done,$at]);
        return ['section_id'=>$sectionId,'is_completed'=>$done,'completed_at'=>$at];
    }


    // ---------- Adaptive global learning library ----------
    public function globalLearningSummary(): array {
        $rows=$this->db->all("SELECT item_type,COUNT(*) n FROM global_learning_items WHERE is_active=1 GROUP BY item_type ORDER BY item_type");
        $out=[];foreach($rows as $r)$out[(string)$r['item_type']]=(int)$r['n'];return $out;
    }
    public function globalLearningItems(string $type='',string $search='',string $topic='',int $limit=60): array {
        $limit=max(1,min(200,$limit));$where=['is_active=1'];$params=[];$type=strtoupper(trim($type));$search=trim($search);$topic=trim($topic);
        if($type!==''){$where[]='item_type=?';$params[]=$type;}
        if($topic!==''){$where[]='topic=?';$params[]=$topic;}
        if($search!==''){$where[]='(term LIKE ? OR meaning_vi LIKE ? OR definition_en LIKE ? OR example_en LIKE ?)';$q='%'.$search.'%';array_push($params,$q,$q,$q,$q);}
        $rows=$this->db->all("SELECT id,external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json FROM global_learning_items WHERE ".implode(' AND ',$where)." ORDER BY topic,term LIMIT {$limit}",$params);
        foreach($rows as &$r){$meta=json_decode((string)($r['metadata_json']??''),true);$r['metadata']=is_array($meta)?$meta:[];unset($r['metadata_json']);}
        return $rows;
    }
    public function saveGlobalItemToSrs(int $uid,int $itemId): array {
        $item=$this->db->one('SELECT * FROM global_learning_items WHERE id=? AND is_active=1',[$itemId]);if(!$item)throw new RuntimeException('Không tìm thấy nội dung học.');
        $existing=$this->db->one('SELECT saved_card_id FROM user_global_learning WHERE user_id=? AND item_id=?',[$uid,$itemId]);
        if($existing&&!empty($existing['saved_card_id']))return $this->ownCard($uid,(int)$existing['saved_card_id']);
        $set=$this->db->one("SELECT id FROM flashcard_sets WHERE user_id=? AND source_type='adaptive_library' ORDER BY id LIMIT 1",[$uid]);
        if(!$set)$set=$this->createSet($uid,'YangLingo Knowledge Hub','Nội dung được lưu từ thư viện học thích ứng.',null,'adaptive_library');
        $meta=json_decode((string)($item['metadata_json']??''),true);if(!is_array($meta))$meta=[];
        $type=(string)$item['item_type'];$cardType=match($type){'COLLOCATION'=>'COLLOCATION','SENTENCE_PATTERN'=>'SENTENCE_PATTERN','LISTENING_RECOGNITION'=>'LISTENING_CHUNK','GRAMMAR_LESSON'=>'GRAMMAR','VERB_MASTER'=>'VOCABULARY',default=>'VOCABULARY'};
        $forms='';if($type==='VERB_MASTER'){$parts=[];foreach(['v1'=>'V1','v2'=>'V2','v3'=>'V3'] as $k=>$label){$v=trim((string)($meta[$k]??''));if($v!=='')$parts[]=$label.': '.$v;}$forms=implode(' · ',$parts);}
        $explanation=(string)($item['definition_en']??'');if($type==='VERB_MASTER'&&!empty($meta['ed_pronunciation']))$explanation=trim($explanation.' · Phát âm -ed: '.$meta['ed_pronunciation']);
        $payload=['term'=>$item['term'],'definition'=>$item['meaning_vi'],'example_en'=>$item['example_en']??'','example_vi'=>$item['example_vi']??'','cefr'=>$item['level']??'','card_type'=>$cardType,'topic'=>$item['topic']??'','pattern'=>$type==='SENTENCE_PATTERN'?$item['term']:'','explanation'=>$explanation,'audio_text'=>$meta['audio_text']??($item['example_en']??''),'collocations'=>$meta['collocations']??'','word_family'=>$meta['word_family']??$forms,'tags'=>$meta['tags']??'adaptive-library','source'=>'global_learning:'.$item['external_key']];
        $card=$this->createCard($uid,(int)$set['id'],$payload);
        $this->db->run("INSERT INTO user_global_learning(user_id,item_id,saved_card_id,status,exposures,last_seen_at) VALUES(?,?,?,'ACTIVE',1,NOW()) ON DUPLICATE KEY UPDATE saved_card_id=VALUES(saved_card_id),exposures=exposures+1,last_seen_at=NOW(),updated_at=NOW()",[$uid,$itemId,(int)$card['id']]);
        return $card;
    }
    private function accuracyRow(?array $r,int $minAttempts=3): array {
        $attempts=(int)($r['attempts']??0);$correct=(int)($r['correct']??0);return ['attempts'=>$attempts,'score'=>$attempts>=$minAttempts?(int)round(100*$correct/$attempts):null,'sufficient'=>$attempts>=$minAttempts];
    }
    public function learnerProfile(int $uid,int $days=30): array {
        $days=max(7,min(90,$days));
        $study=$this->db->all("SELECT mode,COUNT(*) attempts,SUM(result=1) correct,ROUND(AVG(score),1) avg_score FROM study_events WHERE user_id=? AND result IS NOT NULL AND created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY mode",[$uid]);$m=[];foreach($study as $r)$m[(string)$r['mode']]=$r;
        $apt=$this->db->all("SELECT module,COUNT(*) attempts,SUM(is_correct) correct FROM aptis_attempts WHERE user_id=? AND created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY module",[$uid]);$am=[];foreach($apt as $r)$am[(string)$r['module']]=$r;
        $toeic=$this->db->one("SELECT COUNT(*) attempts,SUM(is_correct) correct FROM toeic_attempts WHERE user_id=? AND created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY)",[$uid]);
        $combine=function(array $parts): array {$a=0;$c=0;foreach($parts as $r){if(!$r)continue;$a+=(int)($r['attempts']??0);$c+=(int)($r['correct']??0);}return $this->accuracyRow(['attempts'=>$a,'correct'=>$c]);};
        $skills=[
          'vocabulary'=>$combine([$m['vocabulary']??null,$m['review']??null,$am['vocabulary']??null]),
          'collocations'=>$combine([$m['matching']??null]),
          'sentence_patterns'=>$combine([$m['grammar']??null]),
          'grammar'=>$combine([$m['grammar']??null,$am['grammar']??null]),
          'listening'=>$combine([$m['listening']??null,$am['listening']??null]),
          'reading'=>$combine([$am['reading']??null]),
          'toeic'=>$this->accuracyRow($toeic),
          'aptis'=>$combine(array_values($am))
        ];
        $sp=$this->db->one("SELECT COUNT(*) attempts,ROUND(AVG(self_score)*20,1) score FROM aptis_speaking_sessions WHERE user_id=? AND created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY)",[$uid]);
        $wr=$this->db->one("SELECT COUNT(*) attempts,ROUND(AVG(self_score)*20,1) score FROM aptis_writing_submissions WHERE user_id=? AND created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY)",[$uid]);
        $skills['speaking']=['attempts'=>(int)($sp['attempts']??0),'score'=>(int)($sp['attempts']??0)>=2?(int)round((float)($sp['score']??0)):null,'sufficient'=>(int)($sp['attempts']??0)>=2];
        $skills['writing']=['attempts'=>(int)($wr['attempts']??0),'score'=>(int)($wr['attempts']??0)>=2?(int)round((float)($wr['score']??0)):null,'sufficient'=>(int)($wr['attempts']??0)>=2];
        return ['days'=>$days,'skills'=>$skills,'weaknesses'=>$this->weaknesses($uid,$days)];
    }
    public function knowledgeMap(int $uid,int $days=30): array {
        $profile=$this->learnerProfile($uid,$days);$aptBreak=$this->db->all("SELECT q.module,q.topic,COUNT(*) attempts,SUM(a.is_correct) correct,ROUND(100*SUM(a.is_correct)/COUNT(*),1) accuracy FROM aptis_attempts a JOIN aptis_questions q ON q.id=a.question_id WHERE a.user_id=? AND a.created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY q.module,q.topic HAVING COUNT(*)>=2 ORDER BY accuracy ASC,attempts DESC LIMIT 24",[$uid]);
        $toeicBreak=$this->db->all("SELECT q.part,q.grammar_category topic,COUNT(*) attempts,SUM(a.is_correct) correct,ROUND(100*SUM(a.is_correct)/COUNT(*),1) accuracy FROM toeic_attempts a JOIN toeic_questions q ON q.id=a.question_id WHERE a.user_id=? AND a.created_at>=DATE_SUB(NOW(),INTERVAL {$days} DAY) GROUP BY q.part,q.grammar_category HAVING COUNT(*)>=2 ORDER BY accuracy ASC,attempts DESC LIMIT 18",[$uid]);
        return ['profile'=>$profile,'aptis_breakdown'=>$aptBreak,'toeic_breakdown'=>$toeicBreak,'generated_from_days'=>$days];
    }
    private function relatedKnowledgeForMistake(array $m,int $limit=6): array {
        $topic=trim((string)($m['topic']??''));$error=str_replace('_',' ',strtolower((string)($m['error_type']??'')));$rows=[];
        $root=$this->db->one("SELECT id FROM global_learning_items WHERE is_active=1 AND ((topic<>'' AND topic=?) OR LOWER(term) LIKE ? OR LOWER(definition_en) LIKE ?) ORDER BY (topic=?) DESC,id LIMIT 1",[$topic,'%'.$error.'%','%'.$error.'%',$topic]);
        if($root)$rows=$this->db->all("SELECT g.id,g.item_type,g.term,g.meaning_vi,g.example_en,g.topic,l.relation_type,l.weight FROM knowledge_item_links l JOIN global_learning_items g ON g.id=l.target_item_id AND g.is_active=1 WHERE l.source_item_id=? ORDER BY l.weight DESC,g.id LIMIT {$limit}",[(int)$root['id']]);
        if(count($rows)<$limit && $topic!==''){$more=$this->db->all("SELECT id,item_type,term,meaning_vi,example_en,topic,'TOPIC_FALLBACK' relation_type,0.40 weight FROM global_learning_items WHERE is_active=1 AND topic=? ORDER BY FIELD(item_type,'GRAMMAR_LESSON','SENTENCE_PATTERN','COLLOCATION','VOCABULARY','VERB_MASTER','LISTENING_RECOGNITION','PARAPHRASE'),id LIMIT {$limit}",[$topic]);$seen=array_fill_keys(array_map(fn($r)=>(int)$r['id'],$rows),1);foreach($more as $r)if(!isset($seen[(int)$r['id']])){$rows[]=$r;$seen[(int)$r['id']]=1;if(count($rows)>=$limit)break;}}
        return array_slice($rows,0,$limit);
    }
    private function remedialQuestions(array $m,int $limit=3): array {
        $limit=max(1,min(3,$limit));$out=[];$sourceKey=(string)($m['source_key']??'');$sourceId=(int)($m['source_id']??0);
        if(str_starts_with($sourceKey,'toeic:')||($m['source_type']??'')==='toeic'){$rows=$this->db->all("SELECT id,question prompt,option_a,option_b,option_c,option_d,correct_option correct_answer,explanation,'toeic' question_source FROM toeic_questions WHERE is_published=1 AND id<>? AND (grammar_category=? OR topic=?) ORDER BY id LIMIT {$limit}",[$sourceId,$m['error_type']??'',$m['topic']??'']);foreach($rows as $r){$r['options']=array_values(array_filter([$r['option_a'],$r['option_b'],$r['option_c'],$r['option_d']],fn($x)=>trim((string)$x)!==''));unset($r['option_a'],$r['option_b'],$r['option_c'],$r['option_d']);$out[]=$r;}}
        elseif(str_starts_with($sourceKey,'aptis:')){$q=$this->db->one('SELECT module,topic FROM aptis_questions WHERE id=?',[$sourceId]);if($q){$rows=$this->db->all("SELECT id,prompt,options_json,correct_answer,explanation,'aptis' question_source FROM aptis_questions WHERE is_active=1 AND id<>? AND module=? AND (topic=? OR ?='') AND type NOT IN ('speaking_part_1','speaking_part_2','speaking_part_3','speaking_part_4','writing_part_1','writing_part_2','writing_part_3','writing_part_4','word_matching','sentence_ordering') ORDER BY id LIMIT {$limit}",[$sourceId,$q['module'],$q['topic'],$q['topic']]);foreach($rows as $r){$o=json_decode((string)($r['options_json']??''),true);$r['options']=is_array($o)&&array_is_list($o)?$o:[];unset($r['options_json']);$out[]=$r;}}}
        return $out;
    }
    public function mistakeMicroLesson(int $uid,int $id): array {
        $m=$this->db->one('SELECT * FROM mistake_book_v2 WHERE id=? AND user_id=?',[$id,$uid]);if(!$m)throw new RuntimeException('Không tìm thấy câu sai.');
        if($m['mastery_status']==='NEW')$this->db->run("UPDATE mistake_book_v2 SET mastery_status='LEARNING' WHERE id=? AND user_id=?",[$id,$uid]);
        $needle=str_replace('_',' ',strtolower((string)$m['error_type']));$topic=(string)($m['topic']??'');
        $lesson=$this->db->one("SELECT id,term,meaning_vi,definition_en,example_en,example_vi,metadata_json FROM global_learning_items WHERE item_type='GRAMMAR_LESSON' AND is_active=1 AND (LOWER(term) LIKE ? OR LOWER(definition_en) LIKE ? OR topic=?) ORDER BY (topic=?) DESC,id LIMIT 1",['%'.$needle.'%','%'.$needle.'%',$topic,$topic]);
        $lessonOut=null;if($lesson){$meta=json_decode((string)($lesson['metadata_json']??''),true);if(!is_array($meta))$meta=[];$examples=$meta['examples']??array_values(array_filter([$lesson['example_en']??''],fn($v)=>trim((string)$v)!==''));$lessonOut=['id'=>(int)$lesson['id'],'title'=>$lesson['term'],'rule'=>$lesson['definition_en']?:$lesson['meaning_vi'],'examples'=>$examples,'common_mistake'=>$meta['common_mistake']??'Đối chiếu cấu trúc với đáp án đúng trước khi làm lại.','drill_prompts'=>$meta['drills']??[]];}
        return ['mistake'=>$m,'lesson'=>$lessonOut,'related'=>$this->relatedKnowledgeForMistake($m,6),'drills'=>$this->remedialQuestions($m,3),'flow'=>['Error','Classification','Micro lesson','Related knowledge','Remedial practice','SRS','Retest']];
    }
    public function recordRemedialAttempt(int $uid,int $mistakeId,string $source,int $questionId,string $selected,string $fallbackPrompt='',string $fallbackCorrect='',string $fallbackExplanation=''): array {
        $m=$this->db->one('SELECT * FROM mistake_book_v2 WHERE id=? AND user_id=?',[$mistakeId,$uid]);if(!$m)throw new RuntimeException('Không tìm thấy câu sai.');$wasResolved=(($m['mastery_status']??'')==='RESOLVED');$source=in_array($source,['toeic','aptis','fallback'],true)?$source:'fallback';$selected=trim($selected);if($selected==='')throw new InvalidArgumentException('Hãy chọn đáp án remedial.');$prompt=$fallbackPrompt;$correct=$fallbackCorrect;$explanation=$fallbackExplanation;
        if($source==='toeic'){$q=$this->db->one('SELECT question,correct_option,explanation FROM toeic_questions WHERE id=? AND is_published=1',[$questionId]);if(!$q)throw new RuntimeException('Không tìm thấy remedial TOEIC.');$prompt=(string)$q['question'];$correct=(string)$q['correct_option'];$explanation=(string)($q['explanation']??'');$ok=strtoupper($selected)===strtoupper($correct);}
        elseif($source==='aptis'){$q=$this->db->one('SELECT prompt,correct_answer,explanation FROM aptis_questions WHERE id=? AND is_active=1',[$questionId]);if(!$q)throw new RuntimeException('Không tìm thấy remedial Aptis.');$prompt=(string)$q['prompt'];$correct=(string)$q['correct_answer'];$explanation=(string)($q['explanation']??'');$norm=fn($v)=>mb_strtolower(trim(preg_replace('/\s+/u',' ',(string)$v)??(string)$v));$ok=$norm($selected)===$norm($correct);}
        else {$norm=fn($v)=>mb_strtolower(trim((string)$v));$ok=$correct!==''&&$norm($selected)===$norm($correct);}
        $this->db->run('INSERT INTO mistake_remediation_attempts(user_id,mistake_id,question_source,question_id,prompt,selected_answer,correct_answer,explanation,is_correct) VALUES(?,?,?,?,?,?,?,?,?)',[$uid,$mistakeId,$source,$questionId?:null,$prompt,$selected,$correct,$explanation,$ok?1:0]);
        $recent=$this->db->all('SELECT is_correct FROM mistake_remediation_attempts WHERE user_id=? AND mistake_id=? ORDER BY id DESC LIMIT 2',[$uid,$mistakeId]);$two=count($recent)>=2&&(int)$recent[0]['is_correct']===1&&(int)$recent[1]['is_correct']===1;
        if($ok){$this->db->run("UPDATE mistake_book_v2 SET mastery_status=?,resolved_at=? WHERE id=? AND user_id=?",[$two?'RESOLVED':'REVIEWING',$two?date('Y-m-d H:i:s'):null,$mistakeId,$uid]);}
        else {$this->db->run("UPDATE mistake_book_v2 SET mastery_status=IF(mastery_status='RESOLVED','RECURRED','LEARNING'),resolved_at=NULL,wrong_count=wrong_count+1,last_wrong_at=NOW() WHERE id=? AND user_id=?",[$mistakeId,$uid]);}
        $this->recordEvent($uid,'mistake_review',null,null,$ok?1:0,$ok?100:0,$ok?4:1,0,['track_mistake'=>false]);return ['correct'=>$ok,'correct_answer'=>$correct,'explanation'=>$explanation,'status'=>$two?'RESOLVED':($ok?'REVIEWING':($wasResolved?'RECURRED':'LEARNING'))];
    }
    public function collocationChallenge(int $uid): array {
        $row=$this->db->one("SELECT id,term,meaning_vi,example_en,topic FROM global_learning_items WHERE item_type='COLLOCATION' AND is_active=1 ORDER BY RAND() LIMIT 1");if(!$row)throw new RuntimeException('Chưa có collocation.');$parts=preg_split('/\s+/u',trim((string)$row['term']),2);$answer=$parts[0]??'';$tail=$parts[1]??'';if($answer===''||$tail==='')throw new RuntimeException('Collocation chưa phù hợp để luyện.');$distractors=['do','make','take','give','have','reach','meet','provide'];$options=array_values(array_unique([$answer,...$distractors]));shuffle($options);$options=array_slice($options,0,4);if(!in_array($answer,$options,true))$options[0]=$answer;shuffle($options);return ['item_id'=>(int)$row['id'],'prompt'=>'___ '.$tail,'answer'=>$answer,'options'=>$options,'full'=>$row['term'],'meaning_vi'=>$row['meaning_vi'],'example_en'=>$row['example_en'],'topic'=>$row['topic']];
    }
    public function recordCollocationAttempt(int $uid,int $itemId,string $selected): array {
        $row=$this->db->one("SELECT id,term,meaning_vi,example_en,topic FROM global_learning_items WHERE id=? AND item_type='COLLOCATION' AND is_active=1",[$itemId]);if(!$row)throw new RuntimeException('Không tìm thấy collocation.');
        $parts=preg_split('/\s+/u',trim((string)$row['term']),2);$answer=trim((string)($parts[0]??''));$selected=trim($selected);if($answer===''||$selected==='')throw new InvalidArgumentException('Đáp án collocation không hợp lệ.');$ok=mb_strtolower($selected)===mb_strtolower($answer);
        $ctx=['source_key'=>'collocation:'.$itemId,'source_id'=>(string)$itemId,'question'=>'___ '.($parts[1]??''),'user_answer'=>$selected,'correct_answer'=>$answer,'explanation'=>'Collocation đúng: '.$row['term'].($row['example_en']?' · '.$row['example_en']:''),'error_type'=>'COLLOCATION','topic'=>(string)($row['topic']??'Collocation')];
        $this->recordEvent($uid,'matching',null,null,$ok?1:0,$ok?100:0,$ok?5:2,0,$ctx);
        return ['correct'=>$ok,'answer'=>$answer,'full'=>$row['term'],'example_en'=>$row['example_en'],'meaning_vi'=>$row['meaning_vi']];
    }


    private function helenPart1FlashbookRows(): array {
        $path=dirname(__DIR__).'/assets/handbooks/helen-toeic-part1-vocabulary.csv';
        if(!is_file($path))throw new RuntimeException('Không tìm thấy dữ liệu Flashcard Book HELEN Part 1.');
        $h=fopen($path,'rb');if(!$h)throw new RuntimeException('Không đọc được dữ liệu Flashcard Book HELEN Part 1.');
        fgetcsv($h);$rows=[];
        $topicMap=[
            'Eye-controlled action'=>'Quan sát & Hành động bằng mắt',
            'Manual operation'=>'Thao tác bằng tay',
            'Movement, Sports & Posture'=>'Chuyển động & Tư thế',
            'Clothing & Daily Life'=>'Trang phục & Sinh hoạt',
            'Objects & Equipment'=>'Đồ vật & Thiết bị',
            'Scenes & Surroundings'=>'Bối cảnh & Môi trường',
            'Object States & Arrangements'=>'Trạng thái & Sắp xếp đồ vật'
        ];
        while(($r=fgetcsv($h))!==false){
            $r=array_pad($r,6,'');
            $sheet=trim((string)$r[0]);$stt=(int)$r[1];$term=trim((string)$r[2]);$ipa=trim((string)$r[3]);$meaning=trim((string)$r[4]);$example=trim((string)$r[5]);
            if($sheet===''||$term===''||$meaning==='')continue;
            $subtopic=$topicMap[$sheet]??$sheet;
            $pos=in_array($sheet,['Objects & Equipment','Scenes & Surroundings'],true)?'noun / phrase':(str_contains($sheet,'States & Arrangements')?'phrase':'verb / phrase');
            $rows[]=[
                'category'=>$subtopic,'term'=>$term,'definition'=>$meaning,'ipa'=>$ipa,'part_of_speech'=>$pos,'cefr'=>'',
                'example_en'=>$example,'example_vi'=>'','notes'=>'Nguồn Google Sheet HELEN TOEIC Part 1 · '.$sheet.' · STT '.$stt,
                'card_type'=>'VOCABULARY','topic'=>'TOEIC Part 1','subtopic'=>$subtopic,'toeic_part'=>1,'difficulty'=>1,
                'pattern'=>'','collocations'=>'','word_family'=>'','explanation'=>'','audio_text'=>$example?:$term,
                'tags'=>'toeic,part1,helen,flashcard-book','source'=>'HELEN TOEIC Part 1'
            ];
        }
        fclose($h);
        if(count($rows)<140)throw new RuntimeException('Dữ liệu Flashcard Book HELEN Part 1 chưa đầy đủ.');
        return $rows;
    }
    private function packagedFlashbookRows(string $filename,int $minRows=1): array {
        $path=dirname(__DIR__).'/assets/flashbooks/'.$filename;
        if(!is_file($path))throw new RuntimeException('Không tìm thấy dữ liệu Flashcard Book: '.$filename);
        $h=fopen($path,'rb');if(!$h)throw new RuntimeException('Không đọc được dữ liệu Flashcard Book: '.$filename);
        $header=fgetcsv($h);if(!is_array($header)){fclose($h);throw new RuntimeException('Header Flashcard Book không hợp lệ.');}
        $header=array_map(function($v){$v=(string)$v;$v=preg_replace('/^\xEF\xBB\xBF/','',$v)??$v;return trim($v);},$header);$idx=array_flip($header);$rows=[];
        $get=function(array $row,string $key)use($idx):string{$i=$idx[$key]??null;return $i===null?'':trim((string)($row[$i]??''));};
        while(($r=fgetcsv($h))!==false){
            $term=$get($r,'term');$definition=$get($r,'definition');if($term===''||$definition==='')continue;
            $part=$get($r,'toeic_part');
            $rows[]=[
                'category'=>$get($r,'category')?:$get($r,'subtopic'),'term'=>$term,'definition'=>$definition,'ipa'=>$get($r,'ipa'),'part_of_speech'=>$get($r,'part_of_speech'),'cefr'=>'',
                'example_en'=>$get($r,'example_en'),'example_vi'=>$get($r,'example_vi'),'notes'=>'Nguồn học liệu người dùng · '.($get($r,'source')?:$filename),
                'card_type'=>$get($r,'card_type')?:'VOCABULARY','topic'=>$get($r,'topic'),'subtopic'=>$get($r,'subtopic')?:$get($r,'category'),'toeic_part'=>$part===''?'':(int)$part,
                'difficulty'=>(int)($get($r,'difficulty')?:1),'pattern'=>$get($r,'pattern'),'collocations'=>$get($r,'collocations'),'word_family'=>$get($r,'word_family'),'explanation'=>$get($r,'explanation'),
                'audio_text'=>$get($r,'audio_text')?:($get($r,'example_en')?:$term),'tags'=>$get($r,'tags'),'source'=>$get($r,'source')?:'YangLingo PDF Flashcard Book'
            ];
        }
        fclose($h);if(count($rows)<$minRows)throw new RuntimeException('Dữ liệu Flashcard Book chưa đầy đủ: '.$filename);return $rows;
    }
    private function packagedFlashbookRowsByCategories(string $filename,array $categories,int $minRows=1): array {
        $wanted=array_fill_keys($categories,true);
        $rows=array_values(array_filter($this->packagedFlashbookRows($filename,1),function(array $row)use($wanted):bool{
            $category=(string)($row['category']??'');$subtopic=(string)($row['subtopic']??'');
            return isset($wanted[$category])||isset($wanted[$subtopic]);
        }));
        if(count($rows)<$minRows)throw new RuntimeException('Dữ liệu Flashcard Book theo đề mục chưa đầy đủ: '.$filename);
        return $rows;
    }
    private function verbSpecialSectionRows(): array {
        $source='TOEIC 800+ Verb Master PDF';$common=['ipa'=>'','part_of_speech'=>'verb / contrast','cefr'=>'','example_vi'=>'','notes'=>'Nguồn học liệu người dùng · Mục 4 Verb Master','card_type'=>'GRAMMAR','topic'=>'TOEIC Verb Master 800+','subtopic'=>'4. Các động từ/cặp từ đặc biệt cần nhớ','toeic_part'=>'','difficulty'=>2,'collocations'=>'','word_family'=>'','tags'=>'toeic,800-plus,verb-master,section4,pdf-flashbook','source'=>$source];
        $specs=[
            ['read – read – read','Hiện tại thường /riːd/; V2/V3 vẫn viết read nhưng đọc /red/.','read /riːd/ → read /red/ → read /red/','The report was read before the meeting.'],
            ['lead – led – led','lead = dẫn dắt; V2/V3 là led. Rất hay gặp trong business English.','lead → led → led','She led the project team.'],
            ['pay – paid – paid','pay = trả tiền; V2/V3 là paid.','pay → paid → paid','The company paid the invoice on time.'],
            ['bring / buy / catch / teach / think','Nhóm bất quy tắc có dạng -ought/-aught cần nhận diện nhanh khi nghe và đọc.','bring→brought · buy→bought · catch→caught · teach→taught · think→thought','We bought new equipment and brought it to the office.'],
            ['rise vs raise','rise = tự tăng/lên, không cần tân ngữ; raise = làm tăng/nâng, cần tân ngữ.','rise–rose–risen ↔ raise–raised–raised','Sales have risen. / The company raised prices.'],
            ['lie vs lay','lie = nằm; lay = đặt/bày một vật xuống.','lie–lay–lain ↔ lay–laid–laid','He lay on the sofa. / She laid the documents on the desk.'],
            ['find vs found','find = tìm thấy; found = thành lập.','find–found–found ↔ found–founded–founded','They found the file. / The company was founded in 1990.'],
            ['overlook','overlook là động từ QUY TẮC: overlooked – overlooked; không phải động từ bất quy tắc.','overlook → overlooked → overlooked','The reviewer overlooked an important detail.'],
            ['oversee vs overlook','oversee = giám sát và là bất quy tắc; overlook = bỏ sót/nhìn qua và là động từ quy tắc.','oversee–oversaw–overseen ↔ overlook–overlooked–overlooked','The manager oversaw operations but overlooked one minor detail.']
        ];
        $rows=[];foreach($specs as [$term,$definition,$pattern,$example]){$rows[]=array_merge($common,['category'=>$common['subtopic'],'term'=>$term,'definition'=>$definition,'example_en'=>$example,'pattern'=>$pattern,'explanation'=>$pattern,'audio_text'=>$example?:$term]);}return $rows;
    }
    private function everydayEnglishFlashbook(): array {
        static $book=null;
        if($book!==null)return $book;
        $path=dirname(__DIR__).'/assets/flashbooks/everyday-english-a1-a2.json';
        $raw=is_file($path)?file_get_contents($path):false;
        if($raw===false)throw new RuntimeException('Không đọc được book Everyday English.');
        try{$data=json_decode($raw,true,512,JSON_THROW_ON_ERROR);}catch(JsonException $e){throw new RuntimeException('Dữ liệu book Everyday English không hợp lệ.',0,$e);}
        if(!is_array($data)||($data['code']??'')!=='everyday-english-a1-a2'||($data['source_type']??'')!=='everyday_english_a1_a2_book'||($data['lesson_size']??0)!==10||count($data['lessons']??[])!==6)throw new RuntimeException('Cấu trúc book Everyday English không hợp lệ.');
        $terms=[];
        foreach($data['lessons'] as $lesson){
            if(trim((string)($lesson['title']??''))===''||trim((string)($lesson['objective']??''))===''||count($lesson['cards']??[])!==10)throw new RuntimeException('Mỗi bài Everyday English cần đủ 10 thẻ.');
            foreach($lesson['cards'] as $card){
                foreach(['term','definition','example_en','example_vi','explanation','cefr'] as $field)if(trim((string)($card[$field]??''))==='')throw new RuntimeException('Thiếu nội dung thẻ Everyday English: '.$field.'.');
                $key=$this->flashcardBookTermKey($card['term']);if(isset($terms[$key]))throw new RuntimeException('Book Everyday English có thẻ trùng.');$terms[$key]=true;
            }
        }
        $book=$data;return $book;
    }
    private function everydayEnglishFlashbookRows(): array {
        $book=$this->everydayEnglishFlashbook();$rows=[];
        foreach($book['lessons'] as $i=>$lesson){
            foreach($lesson['cards'] as $card){
                $rows[]=array_merge([
                    'ipa'=>'','part_of_speech'=>(($card['card_type']??'VOCABULARY')==='VOCABULARY'?'noun':'phrase'),'card_type'=>'VOCABULARY','difficulty'=>($card['cefr']==='A2'?2:1),
                    'pattern'=>'','collocations'=>'','word_family'=>''
                ],$card,[
                    'category'=>$lesson['title'],'topic'=>'Everyday English','subtopic'=>$lesson['title'],'toeic_part'=>'',
                    'notes'=>'Bài '.($i+1).' · '.$lesson['objective'].' Sau khi nhớ thẻ, hãy tự nói một câu về bản thân.',
                    'audio_text'=>$card['example_en'],'tags'=>'everyday-english,a1-a2,lesson-'.($i+1),
                    'source'=>'YangLingo Everyday English · A1–A2'
                ]);
            }
        }
        return $rows;
    }
    private function studentLifeFlashbook(): array {
        static $book=null;
        if($book!==null)return $book;
        $path=dirname(__DIR__).'/assets/flashbooks/student-life-work-a2-b1.json';
        $raw=is_file($path)?file_get_contents($path):false;
        if($raw===false)throw new RuntimeException('Không đọc được book Student Life & Work.');
        try{$data=json_decode($raw,true,512,JSON_THROW_ON_ERROR);}catch(JsonException $e){throw new RuntimeException('Dữ liệu book Student Life & Work không hợp lệ.',0,$e);}
        if(!is_array($data)||($data['code']??'')!=='student-life-work-a2-b1'||($data['source_type']??'')!=='student_life_work_a2_b1_book'||($data['lesson_size']??0)!==10||count($data['lessons']??[])!==12)throw new RuntimeException('Cấu trúc book Student Life & Work không hợp lệ.');
        $terms=[];
        foreach($data['lessons'] as $lesson){
            if(trim((string)($lesson['title']??''))===''||trim((string)($lesson['objective']??''))===''||count($lesson['cards']??[])!==10)throw new RuntimeException('Mỗi bài Student Life & Work cần đủ 10 thẻ.');
            foreach($lesson['cards'] as $card){
                foreach(['term','definition','example_en','example_vi','explanation','cefr'] as $field)if(trim((string)($card[$field]??''))==='')throw new RuntimeException('Thiếu nội dung thẻ Student Life & Work: '.$field.'.');
                if(!in_array($card['cefr'],['A2','B1'],true))throw new RuntimeException('Cấp độ gợi ý của thẻ không hợp lệ.');
                if(mb_stripos($card['example_en'],$card['term'])===false)throw new RuntimeException('Ví dụ cần chứa đúng từ hoặc cụm từ đang học.');
                $key=$this->flashcardBookTermKey($card['term']);if(isset($terms[$key]))throw new RuntimeException('Book Student Life & Work có thẻ trùng.');$terms[$key]=true;
            }
        }
        $book=$data;return $book;
    }
    private function studentLifeFlashbookRows(): array {
        $book=$this->studentLifeFlashbook();$rows=[];
        foreach($book['lessons'] as $i=>$lesson){
            foreach($lesson['cards'] as $card){
                $rows[]=array_merge([
                    'ipa'=>'','part_of_speech'=>'','card_type'=>'VOCABULARY','difficulty'=>($card['cefr']==='B1'?3:2),
                    'pattern'=>'','collocations'=>'','word_family'=>''
                ],$card,[
                    'category'=>$lesson['title'],'topic'=>'Student Life & Work','subtopic'=>$lesson['title'],'toeic_part'=>'',
                    'notes'=>'Bài '.($i+1).' · '.$lesson['objective'].' Cấp độ A2–B1 là gợi ý học tập. Hãy nói một câu về trải nghiệm của bạn.',
                    'audio_text'=>$card['example_en'],'tags'=>'student-life-work,a2-b1,lesson-'.($i+1),
                    'source'=>'YangLingo Student Life & Work · A2–B1'
                ]);
            }
        }
        return $rows;
    }
    private function flashcardBookSpecs(): array {
        $specs=[
            'helen-part1-flashcards'=>[
                'source_type'=>'helen_part1_book','title'=>'TOEIC Part 1 – Từ vựng mô tả tranh (HELEN)','subtitle'=>'141 thẻ · 7 nhóm Part 1','description'=>'Toàn bộ bộ từ/cụm từ Google Sheet HELEN Part 1, chuyển thành flashcard cá nhân để học bằng Active Recall, Audio First và SRS.','cover'=>'P1','source_handbook_code'=>'helen-part1-vocab'
            ],
            'verb-ed-pronunciation-flashcards'=>[
                'source_type'=>'verb_ed_800_book','title'=>'1. Phát âm đuôi -ed: /t/ · /d/ · /ɪd/','subtitle'=>'42 thẻ · đúng Mục 1 của Verb Master','description'=>'Các động từ luyện -ed theo /t/, /d/, /ɪd/ và nhóm tính từ -ed có cách đọc đặc biệt trong PDF.','cover'=>'1','source_handbook_code'=>'verb-800'
            ],
            'verb-irregular-flashcards'=>[
                'source_type'=>'verb_irregular_800_book','title'=>'3A. Irregular Verbs Core – TOEIC','subtitle'=>'120 động từ · V1 → V2 → V3 · đã chuẩn hóa','description'=>'Các động từ bất quy tắc quan trọng từ Verb Master với V1, V2, V3 và ví dụ. Bộ đã cài được giữ nguyên nội dung, card ID và tiến độ.','cover'=>'3A','source_handbook_code'=>'verb-800','integrity_check'=>true
            ],
            'verb-irregular-extended-flashcards'=>[
                'source_type'=>'verb_irregular_extended_800_book','title'=>'3B. Irregular Verbs Extended – TOEIC','subtitle'=>'40 động từ mở rộng · tổng Core + Extended = 160','description'=>'40 động từ bất quy tắc mở rộng sau Core 120. Ưu tiên các dạng có ích cho Business English/TOEIC và các biến thể Anh–Mỹ thường gặp.','cover'=>'3B','source_handbook_code'=>'verb-800','integrity_check'=>true
            ],
            'verb-special-flashcards'=>[
                'source_type'=>'verb_special_800_book','title'=>'4. TOEIC Verb Traps – Cặp dễ nhầm','subtitle'=>'9 thẻ đối chiếu · có oversee ↔ overlook','description'=>'Các trường hợp đặc biệt và cặp động từ dễ nhầm: read, lead, pay, -ought, rise/raise, lie/lay, find/found, overlook và oversee/overlook.','cover'=>'4','source_handbook_code'=>'verb-800','integrity_check'=>true
            ],
            'verb-5-1-business-flashcards'=>[
                'source_type'=>'verb_5_1_business_book','title'=>'5.1 Kinh doanh & Quản lý','subtitle'=>'109 động từ · nghĩa · -ed · ví dụ TOEIC','description'=>'Đúng nhóm 5.1 của PDF Verb Master: động từ kinh doanh và quản lý, giữ nghĩa, cách đọc -ed và câu ví dụ TOEIC.','cover'=>'5.1','source_handbook_code'=>'verb-800'
            ],
            'verb-5-2-hr-flashcards'=>[
                'source_type'=>'verb_5_2_hr_book','title'=>'5.2 Nhân sự & Giao tiếp','subtitle'=>'38 động từ · nghĩa · -ed · ví dụ TOEIC','description'=>'Đúng nhóm 5.2 của PDF Verb Master: động từ nhân sự và giao tiếp trong ngữ cảnh TOEIC.','cover'=>'5.2','source_handbook_code'=>'verb-800'
            ],
            'verb-5-3-finance-flashcards'=>[
                'source_type'=>'verb_5_3_finance_book','title'=>'5.3 Tài chính & Mua sắm','subtitle'=>'14 động từ · nghĩa · -ed · ví dụ TOEIC','description'=>'Đúng nhóm 5.3 của PDF Verb Master: từ vựng tài chính, thanh toán và mua sắm.','cover'=>'5.3','source_handbook_code'=>'verb-800'
            ],
            'verb-5-4-operations-flashcards'=>[
                'source_type'=>'verb_5_4_ops_book','title'=>'5.4 Vận hành & Hậu cần','subtitle'=>'26 động từ · nghĩa · -ed · ví dụ TOEIC','description'=>'Đúng nhóm 5.4 của PDF Verb Master: vận hành, thiết bị, kho vận và hậu cần.','cover'=>'5.4','source_handbook_code'=>'verb-800'
            ],
            'listening-vocab-800-flashcards'=>[
                'source_type'=>'listening_vocab_800_book','title'=>'TOEIC Listening 800+ – Từ vựng & Cụm nghe','subtitle'=>'Part 1–4 · 85 từ/cụm nghe trọng tâm','description'=>'Các danh sách từ vựng, phản hồi gián tiếp, cụm công việc/lịch trình và mẫu câu thông báo/quảng cáo được nêu trực tiếp trong PDF Listening.','cover'=>'LS','source_handbook_code'=>'listening-800'
            ],
            'grammar-800-flashcards'=>[
                'source_type'=>'grammar_800_book','title'=>'TOEIC Grammar 800+ – Cấu trúc & Từ dễ nhầm','subtitle'=>'Word Forms · Giới từ · Từ nối · V-ing/to V · Confusing Words','description'=>'Chuyển các bảng/cụm/nguyên tắc có tính ghi nhớ trong PDF Grammar thành flashcard: word-form cues, cụm giới từ, verb/adjective + preposition, connectors, gerund/infinitive và từ dễ nhầm.','cover'=>'GR','source_handbook_code'=>'grammar-800'
            ]
        ];
        foreach([$this->everydayEnglishFlashbook(),$this->studentLifeFlashbook()] as $book){
        $specs[$book['code']]=[
            'source_type'=>$book['source_type'],'title'=>$book['title'],'subtitle'=>$book['subtitle'],
            'description'=>$book['description'],'cover'=>$book['cover'],'source_handbook_code'=>'',
            'folder_name'=>$book['folder_name'],'category'=>$book['category'],'level'=>$book['level'],
            'is_new'=>true,'lesson_size'=>$book['lesson_size'],'lesson_count'=>count($book['lessons']),
            'estimated_minutes'=>$book['estimated_minutes']
        ];
        }
        return $specs;
    }
    private function flashcardBookRowsByCode(string $code): array {
        return match($code){
            'helen-part1-flashcards'=>$this->helenPart1FlashbookRows(),
            'verb-ed-pronunciation-flashcards'=>$this->packagedFlashbookRowsByCategories('toeic-verb-master-800-flashcards.csv',['Phát âm -ed /t/','Phát âm -ed /d/','Phát âm -ed /ɪd/','Tính từ -ed phát âm đặc biệt'],42),
            'verb-irregular-flashcards'=>$this->packagedFlashbookRows('toeic-irregular-verbs-core-v33.csv',120),
            'verb-irregular-extended-flashcards'=>$this->packagedFlashbookRows('toeic-irregular-verbs-extended-v33.csv',40),
            'verb-special-flashcards'=>$this->verbSpecialSectionRows(),
            'verb-5-1-business-flashcards'=>$this->packagedFlashbookRowsByCategories('toeic-verb-master-800-flashcards.csv',['Kinh doanh & Quản lý'],109),
            'verb-5-2-hr-flashcards'=>$this->packagedFlashbookRowsByCategories('toeic-verb-master-800-flashcards.csv',['Nhân sự & Giao tiếp'],38),
            'verb-5-3-finance-flashcards'=>$this->packagedFlashbookRowsByCategories('toeic-verb-master-800-flashcards.csv',['Tài chính & Mua sắm'],14),
            'verb-5-4-operations-flashcards'=>$this->packagedFlashbookRowsByCategories('toeic-verb-master-800-flashcards.csv',['Vận hành & Hậu cần'],26),
            'listening-vocab-800-flashcards'=>$this->packagedFlashbookRows('toeic-listening-vocab-800-flashcards.csv',80),
            'grammar-800-flashcards'=>$this->packagedFlashbookRows('toeic-grammar-800-flashcards.csv',220),
            'everyday-english-a1-a2'=>$this->everydayEnglishFlashbookRows(),
            'student-life-work-a2-b1'=>$this->studentLifeFlashbookRows(),
            default=>throw new InvalidArgumentException('Flashcard Book không hợp lệ.')
        };
    }
    private function flashcardBookTermKey(string $term): string {
        $term=mb_strtolower(trim($term));
        $term=preg_replace('/\s+/u',' ',$term)??$term;
        return $term;
    }
    private function flashcardBookIntegrityForSet(array $rows,int $setId): array {
        $sourceKeys=[];foreach($rows as $row){$key=$this->flashcardBookTermKey((string)($row['term']??''));if($key!=='')$sourceKeys[$key]=true;}
        $cards=$this->db->all('SELECT term FROM flashcards WHERE set_id=? ORDER BY id',[$setId]);$existingKeys=[];
        foreach($cards as $card){$key=$this->flashcardBookTermKey((string)($card['term']??''));if($key!=='')$existingKeys[$key]=true;}
        $missing=0;foreach($sourceKeys as $key=>$_)if(!isset($existingKeys[$key]))$missing++;
        $extra=0;foreach($existingKeys as $key=>$_)if(!isset($sourceKeys[$key]))$extra++;
        return ['missing_count'=>$missing,'extra_count'=>$extra,'complete'=>$missing===0,'unique_source_count'=>count($sourceKeys),'unique_existing_count'=>count($existingKeys)];
    }
    private function flashcardBookFolder(int $uid,string $newName='Bộ Flashcard TOEIC 800+'): array {
        $folder=$this->db->one('SELECT id,name FROM folders WHERE user_id=? AND name=? ORDER BY id LIMIT 1',[$uid,$newName]);if($folder)return $folder;
        if($newName==='Bộ Flashcard TOEIC 800+'){
            $old=$this->db->one('SELECT id,name FROM folders WHERE user_id=? AND name=? ORDER BY id LIMIT 1',[$uid,'TOEIC Flashcard Books']);
            if($old)return $old;
        }
        $this->db->run('INSERT INTO folders(user_id,name,icon) VALUES(?,?,?)',[$uid,$newName,'📚']);return ['id'=>$this->db->lastId(),'name'=>$newName];
    }
    private function flashcardBookSourceAlias(string $code,array $spec): string {
        // Old VARCHAR(30) databases truncated this known identifier. Recognize it
        // without changing existing book rows, card IDs or learner progress.
        $source=(string)$spec['source_type'];
        return $code==='verb-irregular-extended-flashcards'?substr($source,0,30):$source;
    }
    public function flashcardBooks(int $uid): array {
        $out=[];foreach($this->flashcardBookSpecs() as $code=>$spec){
            $rows=$this->flashcardBookRowsByCode($code);$topics=[];foreach($rows as $r){$name=trim((string)($r['subtopic']??$r['category']??''))?:'Khác';$topics[$name]=($topics[$name]??0)+1;}
            $set=$this->db->one("SELECT s.id,s.title,COUNT(c.id) card_count,SUM(CASE WHEN p.state='mastered' THEN 1 ELSE 0 END) mastered_count,SUM(CASE WHEN p.card_id IS NULL OR p.due_at<=NOW() THEN 1 ELSE 0 END) due_count FROM flashcard_sets s LEFT JOIN flashcards c ON c.set_id=s.id LEFT JOIN srs_progress p ON p.user_id=? AND p.card_id=c.id WHERE s.user_id=? AND (s.source_type=? OR s.source_type=?) GROUP BY s.id ORDER BY s.id DESC LIMIT 1",[$uid,$uid,$spec['source_type'],$this->flashcardBookSourceAlias($code,$spec)]);
            $integrity=$set&&!empty($spec['integrity_check'])?$this->flashcardBookIntegrityForSet($rows,(int)$set['id']):null;
            $missingCount=$set?($integrity?(int)$integrity['missing_count']:max(0,count($rows)-(int)$set['card_count'])):count($rows);
            $extraCount=$set&&$integrity?(int)$integrity['extra_count']:0;
            $out[]=[
                'code'=>$code,'title'=>$spec['title'],'subtitle'=>$spec['subtitle'],'description'=>$spec['description'],'cover'=>$spec['cover'],'source_handbook_code'=>$spec['source_handbook_code'],
                'source_rows'=>count($rows),'topic_count'=>count($topics),'topics'=>array_map(fn($name,$count)=>['name'=>$name,'count'=>$count],array_keys($topics),array_values($topics)),
                'installed'=>(bool)$set,'set_id'=>$set?(int)$set['id']:null,'card_count'=>$set?(int)$set['card_count']:0,'mastered_count'=>$set?(int)($set['mastered_count']??0):0,'due_count'=>$set?(int)($set['due_count']??0):0,
                'missing_count'=>$missingCount,'extra_count'=>$extraCount,'integrity_status'=>$set?($missingCount===0?'complete':'missing'):'not_installed','append_sync'=>false,
                'is_new'=>!empty($spec['is_new']),'level'=>$spec['level']??'TOEIC','category'=>$spec['category']??'TOEIC 800+',
                'lesson_size'=>(int)($spec['lesson_size']??20),'lesson_count'=>(int)($spec['lesson_count']??ceil(count($rows)/20)),
                'estimated_minutes'=>(int)($spec['estimated_minutes']??10)
            ];
        }return $out;
    }
    public function installFlashcardBook(int $uid,string $code): array {
        $specs=$this->flashcardBookSpecs();if(!isset($specs[$code]))throw new InvalidArgumentException('Flashcard Book không hợp lệ.');$spec=$specs[$code];
        // Serialize installation per learner so double-clicks or parallel requests cannot create duplicate books.
        $lockName='yanglingo:flashbooks:'.$uid;
        $lock=$this->db->one('SELECT GET_LOCK(?,10) acquired',[$lockName]);
        if((int)($lock['acquired']??0)!==1)throw new RuntimeException('Book đang được thêm. Hãy thử lại sau vài giây.');
        try{
            $existing=$this->db->one('SELECT id FROM flashcard_sets WHERE user_id=? AND (source_type=? OR source_type=?) ORDER BY id DESC LIMIT 1',[$uid,$spec['source_type'],$this->flashcardBookSourceAlias($code,$spec)]);
            if($existing){$set=$this->getSet($uid,(int)$existing['id'],1,20);return ['installed'=>true,'already_installed'=>true,'set_id'=>(int)$existing['id'],'card_count'=>(int)($set['card_total']??0)];}
            $rows=$this->flashcardBookRowsByCode($code);$folder=$this->flashcardBookFolder($uid,$spec['folder_name']??'Bộ Flashcard TOEIC 800+');$count=count($rows);
            $description=!empty($spec['is_new'])?$spec['description']:$count.' flashcard từ học liệu nguồn. Dùng Lật thẻ / Active Recall / Cloze / Audio First và SRS để học.';
            $set=$this->createSet($uid,$spec['title'],$description,(int)$folder['id'],$spec['source_type']);
            try{$inserted=$this->bulkInsertCards($uid,(int)$set['id'],$rows);}catch(Throwable $e){$this->db->run('DELETE FROM flashcard_sets WHERE id=? AND user_id=?',[(int)$set['id'],$uid]);throw $e;}
            if($inserted!==$count){$this->db->run('DELETE FROM flashcard_sets WHERE id=? AND user_id=?',[(int)$set['id'],$uid]);throw new RuntimeException('Không thể tạo đầy đủ Flashcard Book.');}
            $topics=[];foreach($rows as $r)$topics[(string)($r['subtopic']??'Khác')]=1;
            return ['installed'=>true,'already_installed'=>false,'set_id'=>(int)$set['id'],'card_count'=>$inserted,'topic_count'=>count($topics)];
        }finally{$this->db->one('SELECT RELEASE_LOCK(?) released',[$lockName]);}
    }
    public function ensureFlashcardBooksInstalled(int $uid): array {
        $created=[];$existing=[];$errors=[];$totalCards=0;
        $updated=[];$addedCards=0;
        foreach($this->flashcardBookSpecs() as $code=>$spec){
            $set=$this->db->one('SELECT id,title FROM flashcard_sets WHERE user_id=? AND (source_type=? OR source_type=?) ORDER BY id DESC LIMIT 1',[$uid,$spec['source_type'],$this->flashcardBookSourceAlias($code,$spec)]);
            if($set){
                // Existing content and progress are learner data. Never refresh or append to a previously installed book.
                $existing[]=['code'=>$code,'set_id'=>(int)$set['id'],'title'=>(string)$set['title']];continue;
            }
            try{
                $result=$this->installFlashcardBook($uid,$code);
                $created[]=['code'=>$code,'set_id'=>(int)($result['set_id']??0),'title'=>$spec['title'],'card_count'=>(int)($result['card_count']??0)];
                $totalCards+=(int)($result['card_count']??0);
            }catch(Throwable $e){
                $errors[]=['code'=>$code,'title'=>$spec['title'],'message'=>$e->getMessage()];
            }
        }
        return ['created_count'=>count($created),'existing_count'=>count($existing),'created_cards'=>$totalCards,'updated_count'=>count($updated),'added_cards'=>$addedCards,'updated'=>$updated,'created'=>$created,'existing'=>$existing,'errors'=>$errors,'complete'=>count($errors)===0];
    }

    public function adminStats(): array {
        return [
            'summary'=>$this->db->one("SELECT (SELECT COUNT(*) FROM users) users,(SELECT COUNT(*) FROM users WHERE last_login_at>=DATE_SUB(NOW(),INTERVAL 7 DAY)) active7,(SELECT COUNT(*) FROM flashcard_sets) sets_count,(SELECT COUNT(*) FROM flashcards) cards,(SELECT COUNT(*) FROM ai_messages) ai_messages,(SELECT COUNT(*) FROM study_events WHERE created_at>=CURDATE()) today_events"),
            'growth'=>$this->db->all("SELECT DATE(created_at) day,COUNT(*) users FROM users WHERE created_at>=DATE_SUB(CURDATE(),INTERVAL 30 DAY) GROUP BY DATE(created_at) ORDER BY day"),
            'recent_imports'=>$this->db->all("SELECT i.*,u.name FROM imports i JOIN users u ON u.id=i.user_id ORDER BY i.id DESC LIMIT 12")
        ];
    }
    public function adminUsers(string $search=''): array {$p=[];$w='1=1';if(trim($search)!==''){$w='(name LIKE ? OR email LIKE ?)';$q='%'.trim($search).'%';$p=[$q,$q];}return $this->db->all("SELECT u.id,u.name,u.email,u.role,u.is_active,u.english_level,u.daily_goal,u.created_at,u.last_login_at,COALESCE(SUM(e.xp),0) xp FROM users u LEFT JOIN study_events e ON e.user_id=u.id WHERE {$w} GROUP BY u.id ORDER BY u.created_at DESC LIMIT 200",$p);}
    public function adminUpdateUser(int $actor,int $userId,array $d): void {if($actor===$userId&&isset($d['is_active'])&&!(int)$d['is_active'])throw new InvalidArgumentException('Bạn không thể tự khóa tài khoản đang quản trị.');$role=($d['role']??'user')==='admin'?'admin':'user';$active=!empty($d['is_active'])?1:0;$this->db->run('UPDATE users SET role=?,is_active=? WHERE id=?',[$role,$active,$userId]);}
}
