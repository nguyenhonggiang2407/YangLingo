<?php
declare(strict_types=1);
try {
    require dirname(__DIR__) . '/lib/bootstrap.php';
    $u = $auth->user();
    if (!$u) {
        header('Location: ../index.php', true, 302);
        exit;
    }
    if (($u['role'] ?? '') !== 'admin') {
        http_response_code(403);
        header('Content-Type: text/html; charset=utf-8');
        echo '<!doctype html><html lang="vi"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>403 · YangLingo</title><body style="font-family:system-ui;background:#08110f;color:#eef7f3;padding:40px"><main style="max-width:650px;margin:auto"><h1>403 · Không có quyền truy cập</h1><p style="color:#9fb2aa">Khu vực này chỉ dành cho ADMIN.</p><a href="../index.php" style="color:#7be0ba">Quay lại YangLingo</a></main></body></html>';
        exit;
    }
    header('Location: ../index.php#admin', true, 302);
    exit;
} catch (SetupRequiredException $e) {
    header('Location: ../setup.php', true, 302);
    exit;
} catch (Throwable $e) {
    if (function_exists('yl_log')) yl_log($e);
    http_response_code(503);
    echo 'Service unavailable';
}
