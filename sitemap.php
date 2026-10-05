<?php
declare(strict_types=1);
$config=require __DIR__.'/config.php';
$base=rtrim((string)($config['app_url']??''),'/');
if($base===''){http_response_code(404);exit;}
header('Content-Type: application/xml; charset=utf-8');
echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc><?=htmlspecialchars($base.'/',ENT_XML1|ENT_QUOTES,'UTF-8')?></loc></url>
</urlset>
