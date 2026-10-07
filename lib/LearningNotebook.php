<?php
declare(strict_types=1);

final class LearningNotebookException extends RuntimeException {
    public function __construct(string $message, public int $status) { parent::__construct($message); }
}

/** Private, plain-text learning notes; every query is scoped to the signed-in user. */
final class LearningNotebook {
    public const MAX_NOTES = 500;
    private const FIELDS = 'id,title,body,own_sentence,kind,is_pinned,is_archived,created_at,updated_at';
    private const KINDS = ['word','phrase','grammar','listening','other'];
    public function __construct(private Database $db) {}

    private function text(array $data, string $key, int $max, bool $required=false): string {
        $value=array_key_exists($key,$data)?$data[$key]:'';
        if(!is_string($value)||!mb_check_encoding($value,'UTF-8')||str_contains($value,"\0"))throw new InvalidArgumentException('Nội dung ghi chú không hợp lệ.');
        $value=preg_replace('/^[\s\p{Z}]+|[\s\p{Z}]+$/u','',$value)??'';
        if(($required&&$value==='')||mb_strlen($value,'UTF-8')>$max)throw new InvalidArgumentException('Kiểm tra nội dung và độ dài ghi chú.');
        return $value;
    }
    private function id(mixed $value): int {
        if(!is_int($value)&&(!is_string($value)||!preg_match('/^[1-9][0-9]*$/D',$value)))throw new InvalidArgumentException('Mã ghi chú không hợp lệ.');
        $id=filter_var($value,FILTER_VALIDATE_INT);
        if($id===false||$id<1)throw new InvalidArgumentException('Mã ghi chú không hợp lệ.');
        return $id;
    }
    private function flag(mixed $value): int {
        if(!in_array($value,[true,false,0,1,'0','1'],true))throw new InvalidArgumentException('Trạng thái ghi chú không hợp lệ.');
        return $value===true||$value===1||$value==='1'?1:0;
    }
    private function user(int $uid): void {
        if($uid<1)throw new InvalidArgumentException('Tài khoản không hợp lệ.');
    }
    private function allowed(array $data, array $keys): void {
        if(array_diff(array_keys($data),$keys))throw new InvalidArgumentException('Trường ghi chú không hợp lệ.');
    }
    public function get(int $uid, mixed $id): array {
        $this->user($uid);
        $row=$this->db->one('SELECT '.self::FIELDS.' FROM learning_notebook_notes WHERE user_id=? AND id=?',[$uid,$this->id($id)]);
        if(!$row)throw new LearningNotebookException('Không tìm thấy ghi chú của bạn.',404);
        return $row;
    }
    public function list(int $uid, array $query=[]): array {
        $this->user($uid);$this->allowed($query,['q','archived','kind','page']);
        $search=$this->text($query,'q',160);
        $archived=$this->flag(array_key_exists('archived',$query)?$query['archived']:0);
        $kind=array_key_exists('kind',$query)?$query['kind']:'';
        if(!is_string($kind)||($kind!==''&&!in_array($kind,self::KINDS,true)))throw new InvalidArgumentException('Nhóm ghi chú không hợp lệ.');
        $page=$this->id(array_key_exists('page',$query)?$query['page']:1);
        if($page>1000)throw new InvalidArgumentException('Trang ghi chú không hợp lệ.');
        $where='user_id=? AND is_archived=?';$params=[$uid,$archived];
        if($kind!==''){$where.=' AND kind=?';$params[]=$kind;}
        if($search!==''){
            // Literal search: %, _ and ! in a learner's text are not SQL wildcards.
            $where.=" AND (title LIKE ? ESCAPE '!' OR body LIKE ? ESCAPE '!' OR own_sentence LIKE ? ESCAPE '!')";
            $needle='%'.str_replace(['!','%','_'],['!!','!%','!_'],$search).'%';
            array_push($params,$needle,$needle,$needle);
        }
        $total=(int)$this->db->one("SELECT COUNT(*) n FROM learning_notebook_notes WHERE {$where}",$params)['n'];
        $pages=max(1,(int)ceil($total/20));$page=min($page,$pages);$offset=($page-1)*20;
        $rows=$this->db->all('SELECT '.self::FIELDS." FROM learning_notebook_notes WHERE {$where} ORDER BY is_pinned DESC,updated_at DESC,id DESC LIMIT 20 OFFSET {$offset}",$params);
        $saved=(int)$this->db->one('SELECT COUNT(*) n FROM learning_notebook_notes WHERE user_id=?',[$uid])['n'];
        return ['notes'=>$rows,'total'=>$total,'page'=>$page,'pages'=>$pages,'saved_count'=>$saved,'max_notes'=>self::MAX_NOTES];
    }
    public function save(int $uid, array $data): array {
        $this->user($uid);$this->allowed($data,['id','title','body','own_sentence','kind','is_pinned']);
        $title=$this->text($data,'title',160,true);$body=$this->text($data,'body',2500);$sentence=$this->text($data,'own_sentence',500);
        $kind=array_key_exists('kind',$data)?$data['kind']:'word';
        if(!is_string($kind)||!in_array($kind,self::KINDS,true))throw new InvalidArgumentException('Nhóm ghi chú không hợp lệ.');
        $pinned=$this->flag(array_key_exists('is_pinned',$data)?$data['is_pinned']:0);$id=$data['id']??null;
        if($id!==null){
            $row=$this->get($uid,$id);$id=(int)$row['id'];
            $this->db->run('UPDATE learning_notebook_notes SET title=?,body=?,own_sentence=?,kind=?,is_pinned=?,updated_at=NOW() WHERE user_id=? AND id=?',[$title,$body,$sentence,$kind,$pinned,$uid,$id]);
        }else{
            $pdo=$this->db->pdo();$ownsTransaction=!$pdo->inTransaction();
            if($ownsTransaction)$pdo->beginTransaction();
            try{
                // Serialize per-user creates so concurrent tabs cannot bypass the size cap.
                if(!$this->db->one('SELECT id FROM users WHERE id=? FOR UPDATE',[$uid]))throw new LearningNotebookException('Không tìm thấy tài khoản.',404);
                // A locking read sees current rows even if an outer REPEATABLE READ
                // transaction has already established an older snapshot. At most 500 rows.
                $count=count($this->db->all('SELECT id FROM learning_notebook_notes WHERE user_id=? FOR UPDATE',[$uid]));
                if($count>=self::MAX_NOTES)throw new LearningNotebookException('Sổ tay đã có 500 ghi chú. Hãy bổ sung vào ghi chú đang có.',409);
                $this->db->run('INSERT INTO learning_notebook_notes(user_id,title,body,own_sentence,kind,is_pinned) VALUES(?,?,?,?,?,?)',[$uid,$title,$body,$sentence,$kind,$pinned]);$id=$this->db->lastId();
                if($ownsTransaction)$pdo->commit();
            }catch(Throwable $e){if($ownsTransaction&&$pdo->inTransaction())$pdo->rollBack();throw $e;}
        }
        return $this->get($uid,$id);
    }
    public function archive(int $uid, mixed $id, mixed $archived): array {
        $row=$this->get($uid,$id);$flag=$this->flag($archived);
        $this->db->run('UPDATE learning_notebook_notes SET is_archived=?,updated_at=NOW() WHERE user_id=? AND id=?',[$flag,$uid,(int)$row['id']]);
        return $this->get($uid,$row['id']);
    }
    public function pin(int $uid, mixed $id, mixed $pinned): array {
        $row=$this->get($uid,$id);$flag=$this->flag($pinned);
        $this->db->run('UPDATE learning_notebook_notes SET is_pinned=?,updated_at=NOW() WHERE user_id=? AND id=?',[$flag,$uid,(int)$row['id']]);
        return $this->get($uid,$row['id']);
    }
}
