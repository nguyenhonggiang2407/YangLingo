<?php
final class Database {
    private PDO $pdo;

    public function __construct(
        private array $config,
        private string $schemaPath,
        private ?string $migrationsDir = null,
        private ?string $seedsDir = null
    ) {
        if (!class_exists('PDO') || !in_array('mysql', PDO::getAvailableDrivers(), true)) {
            throw new RuntimeException('Máy chủ PHP chưa bật extension pdo_mysql. Hãy bật PDO MySQL trong cấu hình hosting.');
        }
        $host = trim((string)($config['host'] ?? ''));
        $port = (int)($config['port'] ?? 3306);
        $name = trim((string)($config['name'] ?? ''));
        $user = (string)($config['user'] ?? '');
        $pass = (string)($config['pass'] ?? '');
        $charset = (string)($config['charset'] ?? 'utf8mb4');
        if ($host === '' || $name === '' || $user === '') {
            throw new RuntimeException('Thiếu thông tin kết nối MySQL.');
        }
        $dsn = "mysql:host={$host};port={$port};dbname={$name};charset={$charset}";
        $this->pdo = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
            PDO::ATTR_STRINGIFY_FETCHES => false,
        ]);
        $this->pdo->exec("SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci");
    }

    public function pdo(): PDO { return $this->pdo; }

    public function ensureSchema(): void {
        $this->pdo->exec("CREATE TABLE IF NOT EXISTS app_meta (
            meta_key VARCHAR(80) NOT NULL PRIMARY KEY,
            meta_value VARCHAR(255) NOT NULL,
            updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

        if (!is_file($this->schemaPath)) throw new RuntimeException('Không tìm thấy database/schema.sql.');
        $hash = sha1_file($this->schemaPath);
        if ($hash === false) throw new RuntimeException('Không đọc được database/schema.sql.');
        $check = $this->pdo->prepare("SELECT meta_value FROM app_meta WHERE meta_key='schema_hash'");
        $check->execute();
        if ($check->fetchColumn() !== $hash) {
            $sql = file_get_contents($this->schemaPath);
            if ($sql === false) throw new RuntimeException('Không đọc được database/schema.sql.');
            foreach ($this->splitSql($sql) as $stmt) $this->pdo->exec($stmt);
            $this->legacyColumnMigrations();
            $save = $this->pdo->prepare("INSERT INTO app_meta(meta_key,meta_value) VALUES('schema_hash',?) ON DUPLICATE KEY UPDATE meta_value=VALUES(meta_value),updated_at=NOW()");
            $save->execute([$hash]);
        }
        $this->runMigrations();
        $this->runContentSeeds();
    }

    private function splitSql(string $sql): array {
        $sql = preg_replace('/^\s*--.*$/m', '', $sql) ?? $sql;
        $out = [];
        $buf = '';
        $inSingle = $inDouble = false;
        $len = strlen($sql);
        for ($i=0; $i<$len; $i++) {
            $ch = $sql[$i];
            $prev = $i > 0 ? $sql[$i-1] : '';
            if ($ch === "'" && !$inDouble && $prev !== '\\') $inSingle = !$inSingle;
            if ($ch === '"' && !$inSingle && $prev !== '\\') $inDouble = !$inDouble;
            if ($ch === ';' && !$inSingle && !$inDouble) {
                $stmt = trim($buf);
                if ($stmt !== '') $out[] = $stmt;
                $buf = '';
            } else {
                $buf .= $ch;
            }
        }
        $stmt = trim($buf);
        if ($stmt !== '') $out[] = $stmt;
        return $out;
    }

    private function legacyColumnMigrations(): void {
        $this->addColumnIfMissing('admin_practice_items', 'audio_path', "ALTER TABLE admin_practice_items ADD COLUMN audio_path VARCHAR(255) NOT NULL DEFAULT '' AFTER audio_text");
        $this->addColumnIfMissing('admin_quizzes', 'save_state', "ALTER TABLE admin_quizzes ADD COLUMN save_state VARCHAR(20) NOT NULL DEFAULT 'ready' AFTER is_published");
        $this->addColumnIfMissing('admin_quizzes', 'expected_count', "ALTER TABLE admin_quizzes ADD COLUMN expected_count INT NOT NULL DEFAULT 0 AFTER save_state");

        // Preserve the V10 quiz recovery path used by previous public builds.
        $v10Exists = $this->pdo->query("SHOW TABLES LIKE 'quiz_packs_v10'")->fetchColumn();
        $legacyExists = $this->pdo->query("SHOW TABLES LIKE 'admin_quizzes'")->fetchColumn();
        if ($v10Exists && $legacyExists) {
            $legacyRows = $this->pdo->query("SELECT q.* FROM admin_quizzes q ORDER BY q.id")->fetchAll(PDO::FETCH_ASSOC);
            foreach ($legacyRows as $q) {
                $legacyId = (int)$q['id'];
                $check = $this->pdo->prepare('SELECT id FROM quiz_packs_v10 WHERE legacy_source_id=?');
                $check->execute([$legacyId]);
                if ($check->fetchColumn()) continue;
                $batch = hash('sha256', 'legacy-quiz-v10-' . $legacyId);
                $batch = substr($batch, 0, 32);
                $ins = $this->pdo->prepare("INSERT INTO quiz_packs_v10(owner_user_id,legacy_source_id,title,description,available_date,is_published,pending_publish,save_state,expected_count,active_batch_id) VALUES(?,?,?,?,?,?,?,'ready',0,?)");
                $ins->execute([(int)$q['created_by'],$legacyId,(string)$q['title'],(string)($q['description']??''),$q['available_date']?:null,(int)$q['is_published'],(int)$q['is_published'],$batch]);
                $newId = (int)$this->pdo->lastInsertId();
                $copy = $this->pdo->prepare("INSERT INTO quiz_items_v10(quiz_id,batch_id,position,card_id,question,correct_answer,wrong_answer_1,wrong_answer_2,wrong_answer_3,explanation) SELECT ?,?,position,card_id,question,correct_answer,wrong_answer_1,wrong_answer_2,wrong_answer_3,explanation FROM admin_quiz_questions WHERE quiz_id=? ORDER BY position,id");
                $copy->execute([$newId,$batch,$legacyId]);
            }
        }
    }

    private function addColumnIfMissing(string $table, string $column, string $sql): void {
        $s = $this->pdo->prepare('SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? AND COLUMN_NAME=? LIMIT 1');
        $s->execute([$table, $column]);
        if (!$s->fetch()) $this->pdo->exec($sql);
    }

    private function runMigrations(): void {
        if (!$this->migrationsDir || !is_dir($this->migrationsDir)) return;
        $this->pdo->exec("CREATE TABLE IF NOT EXISTS schema_migrations (
            migration VARCHAR(190) NOT NULL PRIMARY KEY,
            checksum CHAR(40) NOT NULL,
            applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        $files = glob(rtrim($this->migrationsDir, '/\\') . '/*.sql') ?: [];
        sort($files, SORT_STRING);
        foreach ($files as $file) {
            $name = basename($file);
            $sum = sha1_file($file) ?: '';
            $s = $this->pdo->prepare('SELECT checksum FROM schema_migrations WHERE migration=?');
            $s->execute([$name]);
            $existing = $s->fetchColumn();
            if ($existing !== false) {
                if (!hash_equals((string)$existing, $sum)) {
                    throw new RuntimeException("Migration {$name} đã được áp dụng nhưng checksum đã thay đổi.");
                }
                continue;
            }
            $sql = file_get_contents($file);
            if ($sql === false) throw new RuntimeException("Không đọc được migration {$name}.");
            // MySQL DDL performs implicit commits, so schema migrations are intentionally
            // executed statement-by-statement instead of inside a PDO transaction. Migrations
            // must remain idempotent so a failed run can be retried safely.
            foreach ($this->splitSql($sql) as $stmt) $this->pdo->exec($stmt);
            $this->run('INSERT INTO schema_migrations(migration,checksum) VALUES(?,?)', [$name,$sum]);
        }
    }


    private function runContentSeeds(): void {
        if (!$this->seedsDir || !is_dir($this->seedsDir)) return;
        $this->pdo->exec("CREATE TABLE IF NOT EXISTS content_seeds (
            seed VARCHAR(190) NOT NULL PRIMARY KEY,
            checksum CHAR(40) NOT NULL,
            applied_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
        $files = glob(rtrim($this->seedsDir, '/\\') . '/*.sql') ?: [];
        sort($files, SORT_STRING);
        foreach ($files as $file) {
            $name = basename($file);
            $sum = sha1_file($file) ?: '';
            $s = $this->pdo->prepare('SELECT checksum FROM content_seeds WHERE seed=?');
            $s->execute([$name]);
            $existing = $s->fetchColumn();
            if ($existing !== false) {
                if (!hash_equals((string)$existing, $sum)) {
                    throw new RuntimeException("Content seed {$name} đã được áp dụng nhưng checksum đã thay đổi.");
                }
                continue;
            }
            $sql = file_get_contents($file);
            if ($sql === false) throw new RuntimeException("Không đọc được content seed {$name}.");
            $this->pdo->beginTransaction();
            try {
                foreach ($this->splitSql($sql) as $stmt) $this->pdo->exec($stmt);
                $this->run('INSERT INTO content_seeds(seed,checksum) VALUES(?,?)', [$name,$sum]);
                $this->pdo->commit();
            } catch (Throwable $e) {
                if ($this->pdo->inTransaction()) $this->pdo->rollBack();
                throw $e;
            }
        }
    }

    public function one(string $sql, array $params=[]): ?array { $s=$this->pdo->prepare($sql); $s->execute($params); $r=$s->fetch(); return $r===false?null:$r; }
    public function all(string $sql, array $params=[]): array { $s=$this->pdo->prepare($sql); $s->execute($params); return $s->fetchAll(); }
    public function run(string $sql, array $params=[]): PDOStatement { $s=$this->pdo->prepare($sql); $s->execute($params); return $s; }
    public function lastId(): int { return (int)$this->pdo->lastInsertId(); }
    public function tx(callable $fn): mixed {
        $this->pdo->beginTransaction();
        try { $v=$fn($this); $this->pdo->commit(); return $v; }
        catch(Throwable $e){ if($this->pdo->inTransaction())$this->pdo->rollBack(); throw $e; }
    }
}
