<?php
declare(strict_types=1);

require_once __DIR__ . '/compat.php';

final class SetupRequiredException extends RuntimeException {}

function yl_is_https(): bool {
    if (!empty($_SERVER['HTTPS']) && strtolower((string)$_SERVER['HTTPS']) !== 'off') return true;
    if (isset($_SERVER['SERVER_PORT']) && (int)$_SERVER['SERVER_PORT'] === 443) return true;
    return false;
}

function yl_log(Throwable $e): void {
    $dir = __DIR__ . '/../storage/logs';
    if (!is_dir($dir)) @mkdir($dir, 0755, true);
    $line = sprintf("[%s] %s: %s in %s:%d\n", date('c'), get_class($e), $e->getMessage(), $e->getFile(), $e->getLine());
    @file_put_contents($dir . '/app.log', $line, FILE_APPEND | LOCK_EX);
}

$config = require __DIR__ . '/../config.php';
date_default_timezone_set($config['timezone'] ?? 'Asia/Ho_Chi_Minh');

$dbCfg = $config['db'] ?? [];
if (trim((string)($dbCfg['host'] ?? '')) === '' || trim((string)($dbCfg['name'] ?? '')) === '' || trim((string)($dbCfg['user'] ?? '')) === '') {
    throw new SetupRequiredException('YangLingo chưa được cấu hình database.');
}

require_once __DIR__ . '/Database.php';
$db = new Database($dbCfg, __DIR__ . '/../database/schema.sql', __DIR__ . '/../database/migrations', __DIR__ . '/../database/seeds');
$db->ensureSchema();

require_once __DIR__ . '/DbSessionHandler.php';
DbSessionHandler::ensureTable($db->pdo());

if (session_status() !== PHP_SESSION_ACTIVE) {
    $lifetime = max(1800, (int)($config['session_lifetime'] ?? 604800));
    session_name('YLANGSESSID');
    @ini_set('session.use_only_cookies', '1');
    @ini_set('session.use_strict_mode', '1');
    @ini_set('session.gc_maxlifetime', (string)$lifetime);
    @ini_set('session.cookie_httponly', '1');
    @ini_set('session.use_trans_sid', '0');
    session_set_save_handler(new DbSessionHandler($db->pdo(), $lifetime), true);
    session_set_cookie_params([
        'lifetime' => $lifetime,
        'path' => '/',
        'domain' => '',
        'secure' => yl_is_https(),
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_cache_limiter('nocache');
    if (!session_start()) throw new RuntimeException('Không thể khởi tạo phiên đăng nhập.');
}

if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32));

require_once __DIR__ . '/Auth.php';
require_once __DIR__ . '/SRS.php';
require_once __DIR__ . '/AdaptiveLearningService.php';
require_once __DIR__ . '/AIClient.php';
require_once __DIR__ . '/ZipReader.php';
require_once __DIR__ . '/DocxReader.php';
require_once __DIR__ . '/XlsxReader.php';
require_once __DIR__ . '/Importer.php';
require_once __DIR__ . '/Repository.php';

$auth = new Auth($db, $config);
$repo = new Repository($db);
$ai = new AIClient($config);
