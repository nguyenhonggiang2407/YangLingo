<?php
declare(strict_types=1);

try {
    require dirname(__DIR__) . '/lib/bootstrap.php';

    $user = $auth->user();
    if (!$user || ($user['role'] ?? '') !== 'admin') {
        http_response_code(403);
        exit('Forbidden');
    }

    header('Content-Type: text/html; charset=utf-8');
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: DENY');
    header('Referrer-Policy: no-referrer');
    header("Content-Security-Policy: default-src 'none'; style-src 'unsafe-inline'; img-src 'self'; base-uri 'none'; form-action 'self'; frame-ancestors 'none'");

    $pdo = $db->pdo();

    $tableExists = static function (PDO $pdo, string $table): bool {
        if (!preg_match('/^[a-z0-9_]+$/i', $table)) return false;
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?');
        $stmt->execute([$table]);
        return (int)$stmt->fetchColumn() > 0;
    };

    $safeCount = static function (PDO $pdo, string $table, string $where = '') use ($tableExists): string {
        if (!$tableExists($pdo, $table)) return 'missing';
        if (!preg_match('/^[a-z0-9_]+$/i', $table)) return 'invalid';
        // $where is never user supplied. Only fixed clauses from the allow-listed checks below are used.
        try {
            return (string)$pdo->query("SELECT COUNT(*) FROM `{$table}` {$where}")->fetchColumn();
        } catch (Throwable) {
            return 'error';
        }
    };

    $driverList = class_exists('PDO') ? PDO::getAvailableDrivers() : [];
    $smoke = 'FAIL';
    try {
        $smoke = ((int)$pdo->query('SELECT 1')->fetchColumn() === 1) ? 'PASS' : 'FAIL';
    } catch (Throwable) {
        $smoke = 'FAIL';
    }

    $databaseName = (string)($pdo->query('SELECT DATABASE()')->fetchColumn() ?: 'unknown');
    $charset = 'unknown';
    $collation = 'unknown';
    try {
        $charset = (string)$pdo->query('SELECT @@character_set_database')->fetchColumn();
        $collation = (string)$pdo->query('SELECT @@collation_database')->fetchColumn();
    } catch (Throwable) {
        // Keep diagnostic read-only and fail closed to an "unknown" value.
    }

    $latestMigration = 'not tracked';
    if ($tableExists($pdo, 'schema_migrations')) {
        $row = $pdo->query('SELECT migration, applied_at FROM schema_migrations ORDER BY applied_at DESC, migration DESC LIMIT 1')->fetch(PDO::FETCH_ASSOC);
        if ($row) $latestMigration = (string)$row['migration'] . ' @ ' . (string)$row['applied_at'];
    }

    $latestSeed = 'not tracked';
    if ($tableExists($pdo, 'content_seeds')) {
        $row = $pdo->query('SELECT seed, applied_at FROM content_seeds ORDER BY applied_at DESC, seed DESC LIMIT 1')->fetch(PDO::FETCH_ASSOC);
        if ($row) $latestSeed = (string)$row['seed'] . ' @ ' . (string)$row['applied_at'];
    }

    $coreTables = [
        'users', 'flashcards', 'srs_progress', 'mistake_book_v2', 'global_learning_items',
        'knowledge_item_links', 'toeic_questions', 'aptis_questions',
        'connected_speech_examples', 'schema_migrations', 'content_seeds',
    ];

    $contentChecks = [
        ['Global Knowledge', 'global_learning_items', ''],
        ['Connected Speech', 'connected_speech_examples', ''],
        ['TOEIC total (incl. legacy starter)', 'toeic_questions', ''],
        ['TOEIC adaptive pack', 'toeic_questions', "WHERE tags LIKE '%adaptive%'"],
        ['Aptis active', 'aptis_questions', "WHERE is_active=1"],
        ['Aptis retired', 'aptis_questions', "WHERE is_active=0"],
    ];

    $esc = static fn(string $value): string => htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');

    echo '<!doctype html><html lang="vi"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>YangLingo DB Check</title>';
    echo '<style>body{font-family:system-ui,-apple-system,Segoe UI,sans-serif;max-width:980px;margin:40px auto;padding:0 18px;background:#0b1110;color:#e9f3ef}h1,h2{line-height:1.2}table{width:100%;border-collapse:collapse;background:#111a18;margin:14px 0 28px}td,th{padding:10px;border:1px solid #2a3935;text-align:left;vertical-align:top}code{color:#7be0ba}.ok{color:#7be0ba}.warn{color:#ffd27a}.muted{color:#9fb2aa}.pill{display:inline-block;padding:3px 8px;border-radius:999px;background:#20352f}.actions{display:flex;gap:12px;flex-wrap:wrap;margin:18px 0}a{color:#7be0ba}small{color:#9fb2aa}</style></head><body>';
    echo '<h1>YangLingo · Database self-check</h1>';
    echo '<p class="muted">Admin-only, read-only diagnostic. It never prints database passwords, API keys, session IDs or a full DSN, and it cannot execute arbitrary SQL.</p>';
    echo '<div class="actions"><a href="../index.php#admin">← Admin</a><a href="db-check.php">Run smoke test again</a></div>';

    echo '<h2>Environment</h2><table><tr><th>Check</th><th>Value</th></tr>';
    $environment = [
        'PHP version' => PHP_VERSION,
        'PDO extension' => class_exists('PDO') ? 'available' : 'missing',
        'pdo_mysql' => extension_loaded('pdo_mysql') ? 'available' : 'missing',
        'PDO drivers' => $driverList ? implode(', ', $driverList) : 'none',
        'SELECT 1 smoke test' => $smoke,
        'Database connection' => 'connected',
        'Current database' => $databaseName,
        'Database charset' => $charset,
        'Database collation' => $collation,
        'Latest migration' => $latestMigration,
        'Latest content seed' => $latestSeed,
    ];
    foreach ($environment as $key => $value) {
        $class = in_array($value, ['PASS','available','connected'], true) ? 'ok' : '';
        echo '<tr><td>'.$esc((string)$key).'</td><td class="'.$class.'">'.$esc((string)$value).'</td></tr>';
    }
    echo '</table>';

    echo '<h2>Core tables</h2><table><tr><th>Table</th><th>Status</th></tr>';
    foreach ($coreTables as $table) {
        $exists = $tableExists($pdo, $table);
        echo '<tr><td><code>'.$esc($table).'</code></td><td class="'.($exists?'ok':'warn').'">'.($exists?'present':'missing').'</td></tr>';
    }
    echo '</table>';

    echo '<h2>Seed/content counts</h2><table><tr><th>Dataset</th><th>Rows</th></tr>';
    foreach ($contentChecks as [$label,$table,$where]) {
        echo '<tr><td>'.$esc($label).'</td><td>'.$esc($safeCount($pdo, $table, $where)).'</td></tr>';
    }
    echo '<tr><td>Applied migrations</td><td>'.$esc($safeCount($pdo, 'schema_migrations')).'</td></tr>';
    echo '<tr><td>Applied content seeds</td><td>'.$esc($safeCount($pdo, 'content_seeds')).'</td></tr>';
    echo '</table>';

    echo '<p><span class="pill">Read-only</span> <small>After HelioHost validation, keep this page admin-only or remove <code>admin/db-check.php</code> if you do not need ongoing diagnostics.</small></p>';
    echo '</body></html>';
} catch (SetupRequiredException) {
    header('Location: ../setup.php');
    exit;
} catch (Throwable $e) {
    if (function_exists('yl_log')) yl_log($e);
    http_response_code(503);
    header('Content-Type: text/plain; charset=utf-8');
    echo 'Database diagnostic unavailable.';
}
