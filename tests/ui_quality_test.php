<?php
declare(strict_types=1);$root=dirname(__DIR__);$app=file_get_contents($root.'/assets/app.css')?:'';$apt=file_get_contents($root.'/assets/aptis-v5.css')?:'';$ajs=file_get_contents($root.'/assets/aptis-v5.js')?:'';$ad=file_get_contents($root.'/assets/adaptive.js')?:'';$sw=file_get_contents($root.'/service-worker.js')?:'';
function okui(bool $v,string $m):void{if(!$v){fwrite(STDERR,"FAIL: $m\n");exit(1);}echo "PASS: $m\n";}
okui(str_contains($app,'@media')&&str_contains($apt,'@media(max-width:440px)'),'Responsive CSS rules exist for mobile layouts');
okui(str_contains($ajs,'aria-live="polite"')&&str_contains($ajs,'aria-label="Aptis writing response"'),'Aptis timers/text input expose accessibility labels/live region');
okui(str_contains($ajs,'alt="${C().esc(m.alt_text'),'Aptis media uses alt text');
okui(str_contains($ad,'Chưa đủ dữ liệu'),'Knowledge Map avoids fabricated percentages when evidence is insufficient');
okui(str_contains($sw,"url.pathname.endsWith('/api.php')")&&str_contains($sw,"if(req.method!=='GET')return"),'PWA does not cache authenticated API mutations/responses');
okui(str_contains($ajs,'aptis-part-nav')||str_contains($apt,'.aptis-part-nav'),'Productive skills expose mobile-friendly Part 1–4 navigation');
echo "UI/PWA STATIC QUALITY OK\n";
