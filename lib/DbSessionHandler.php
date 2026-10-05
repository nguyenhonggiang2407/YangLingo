<?php
declare(strict_types=1);

/**
 * MySQL-backed PHP sessions for shared/free hosting.
 * This avoids depending on the host's local session files, which may not be
 * shared consistently between requests/backend workers.
 */
final class DbSessionHandler implements SessionHandlerInterface {
    public function __construct(private PDO $pdo, private int $lifetime = 604800) {}

    public static function ensureTable(PDO $pdo): void {
        $pdo->exec("CREATE TABLE IF NOT EXISTS app_sessions (
            session_id VARCHAR(128) NOT NULL,
            session_data MEDIUMBLOB NOT NULL,
            expires_at DATETIME NOT NULL,
            updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (session_id),
            KEY idx_app_sessions_expires (expires_at)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");
    }

    public function open(string $path, string $name): bool { return true; }
    public function close(): bool { return true; }

    public function read(string $id): string|false {
        $s=$this->pdo->prepare('SELECT session_data FROM app_sessions WHERE session_id=? AND expires_at>NOW() LIMIT 1');
        $s->execute([$id]);
        $v=$s->fetchColumn();
        return $v===false ? '' : (string)$v;
    }

    public function write(string $id, string $data): bool {
        $expires=date('Y-m-d H:i:s', time()+$this->lifetime);
        $s=$this->pdo->prepare('INSERT INTO app_sessions(session_id,session_data,expires_at) VALUES(?,?,?) ON DUPLICATE KEY UPDATE session_data=VALUES(session_data),expires_at=VALUES(expires_at),updated_at=NOW()');
        return $s->execute([$id,$data,$expires]);
    }

    public function destroy(string $id): bool {
        $s=$this->pdo->prepare('DELETE FROM app_sessions WHERE session_id=?');
        return $s->execute([$id]);
    }

    public function gc(int $max_lifetime): int|false {
        return $this->pdo->exec('DELETE FROM app_sessions WHERE expires_at<=NOW()');
    }
}
