<?php
final class Auth {
    private int $maxFailures;
    private int $lockMinutes;
    private const DUMMY_HASH = '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.';

    public function __construct(private Database $db, array $config=[]) {
        $this->maxFailures = max(3, min(20, (int)($config['login_max_failures'] ?? 5)));
        $this->lockMinutes = max(5, min(120, (int)($config['login_lock_minutes'] ?? 15)));
    }

    public function user(): ?array {
        $id = (int)($_SESSION['user_id'] ?? 0);
        if (!$id) return null;
        $u = $this->db->one('SELECT id,name,email,role,is_active,english_level,daily_goal,bio,created_at,last_login_at FROM users WHERE id=?', [$id]);
        if (!$u || !(int)$u['is_active']) {
            unset($_SESSION['user_id']);
            return null;
        }
        return $u;
    }

    public function requireUser(): array {
        $u = $this->user();
        if (!$u) throw new AuthException('Bạn cần đăng nhập.', 401);
        return $u;
    }

    public function requireAdmin(): array {
        $u = $this->requireUser();
        if (($u['role'] ?? '') !== 'admin') throw new AuthException('Bạn không có quyền quản trị.', 403);
        return $u;
    }

    public function register(string $name, string $email, string $password): array {
        $name = trim($name);
        $email = strtolower(trim($email));
        if (mb_strlen($name) < 2 || mb_strlen($name) > 120) throw new InvalidArgumentException('Tên cần từ 2 đến 120 ký tự.');
        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 190) throw new InvalidArgumentException('Email không hợp lệ.');
        if (strlen($password) < 8 || strlen($password) > 200) throw new InvalidArgumentException('Mật khẩu cần từ 8 đến 200 ký tự.');
        if ($this->db->one('SELECT id FROM users WHERE email=?', [$email])) throw new InvalidArgumentException('Email này đã được sử dụng.');
        $this->db->run('INSERT INTO users(name,email,password_hash) VALUES(?,?,?)', [$name,$email,password_hash($password,PASSWORD_DEFAULT)]);
        $_SESSION['user_id'] = $this->db->lastId();
        session_regenerate_id(true);
        return $this->user();
    }

    public function login(string $email, string $password, string $ip=''): array {
        $email = strtolower(trim($email));
        if (!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 190) {
            // Preserve a generic response and similar password verification cost.
            password_verify($password, self::DUMMY_HASH);
            throw new AuthException('Email hoặc mật khẩu không đúng.', 401);
        }
        $key = $this->throttleKey($email, $ip);
        $this->assertNotThrottled($key);

        $u = $this->db->one('SELECT id,name,email,password_hash,role,is_active,english_level,daily_goal,bio,created_at,last_login_at FROM users WHERE email=?', [$email]);
        $valid = $u ? password_verify($password, (string)$u['password_hash']) : password_verify($password, self::DUMMY_HASH);
        if (!$u || !$valid) {
            $this->recordFailure($key);
            throw new AuthException('Email hoặc mật khẩu không đúng.', 401);
        }
        if (!(int)$u['is_active']) throw new AuthException('Tài khoản đang bị khóa.', 403);

        $this->clearThrottle($key);
        $_SESSION['user_id'] = (int)$u['id'];
        session_regenerate_id(true);
        $this->db->run('UPDATE users SET last_login_at=NOW() WHERE id=?', [$u['id']]);
        return $this->user();
    }

    public function logout(): void {
        $_SESSION = [];
        if (ini_get('session.use_cookies')) {
            $p = session_get_cookie_params();
            setcookie(session_name(), '', [
                'expires' => time() - 42000,
                'path' => $p['path'] ?: '/',
                'domain' => $p['domain'] ?? '',
                'secure' => (bool)($p['secure'] ?? false),
                'httponly' => true,
                'samesite' => 'Lax',
            ]);
        }
        session_destroy();
    }

    private function throttleKey(string $email, string $ip): string {
        $ip = trim($ip);
        if ($ip === '') $ip = 'unknown';
        return hash('sha256', $email . '|' . $ip);
    }

    private function assertNotThrottled(string $key): void {
        $row = $this->db->one('SELECT failures,locked_until FROM auth_login_throttle WHERE throttle_key=?', [$key]);
        if (!$row || empty($row['locked_until'])) return;
        $locked = strtotime((string)$row['locked_until']);
        if ($locked !== false && $locked > time()) {
            $minutes = max(1, (int)ceil(($locked - time()) / 60));
            throw new AuthException("Đăng nhập tạm khóa do thử sai nhiều lần. Hãy thử lại sau khoảng {$minutes} phút.", 429);
        }
        $this->clearThrottle($key);
    }

    private function recordFailure(string $key): void {
        $row = $this->db->one('SELECT failures,first_failure_at FROM auth_login_throttle WHERE throttle_key=?', [$key]);
        $failures = 1;
        if ($row && !empty($row['first_failure_at']) && strtotime((string)$row['first_failure_at']) >= time() - ($this->lockMinutes * 60)) {
            $failures = (int)$row['failures'] + 1;
        }
        $lock = $failures >= $this->maxFailures ? date('Y-m-d H:i:s', time() + $this->lockMinutes * 60) : null;
        $this->db->run(
            'INSERT INTO auth_login_throttle(throttle_key,failures,first_failure_at,last_failure_at,locked_until) VALUES(?,?,NOW(),NOW(),?) ON DUPLICATE KEY UPDATE failures=VALUES(failures),first_failure_at=IF(?=1,NOW(),first_failure_at),last_failure_at=NOW(),locked_until=VALUES(locked_until)',
            [$key,$failures,$lock,$failures]
        );
    }

    private function clearThrottle(string $key): void {
        $this->db->run('DELETE FROM auth_login_throttle WHERE throttle_key=?', [$key]);
    }
}

class AuthException extends RuntimeException {
    public function __construct(string $message, public int $status=401) { parent::__construct($message); }
}
