<?php
declare(strict_types=1);
$root=dirname(__DIR__);
$file=$root.'/admin/db-check.php';
$src=file_get_contents($file);
if($src===false) throw new RuntimeException('Cannot read admin/db-check.php');
$checks=[
    'ADMIN gate' => str_contains($src,"('role' ?? '')") || str_contains($src,"['role']"),
    'Admin role comparison' => str_contains($src,"!== 'admin'"),
    'No GET query input' => !str_contains($src,'$_GET'),
    'No POST query input' => !str_contains($src,'$_POST'),
    'Read-only smoke test' => str_contains($src,"SELECT 1"),
    'No arbitrary exec endpoint' => !preg_match('/\$_(?:GET|POST|REQUEST).*\b(?:query|exec)\b/is',$src),
    'No password rendering' => !preg_match('/echo[^;]*(?:\$config\[[^;]*[\"\']pass[\"\']|\$dbCfg\[[^;]*[\"\']pass[\"\']|getenv\([^;]*(?:PASS|SECRET|TOKEN))/i',$src),
    'CSP present' => str_contains($src,'Content-Security-Policy'),
    'No CORS wildcard' => !str_contains($src,'Access-Control-Allow-Origin: *'),
];
foreach($checks as $label=>$ok){if(!$ok)throw new RuntimeException('FAIL: '.$label);echo "PASS: {$label}\n";}
echo "DB CHECK SECURITY TEST OK\n";
