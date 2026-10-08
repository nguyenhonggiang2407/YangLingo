const CACHE='yanglingo-static-v62';
const STATIC=[
  './offline.html','./manifest.webmanifest','./assets/app.css','./assets/tools.css','./assets/features.js','./assets/app.js','./assets/design-system.css','./assets/interface.js','./assets/pronunciation.js','./assets/practice-lab.js','./assets/practice-lab.css',
  './assets/aptis-v5.js','./assets/adaptive.js','./assets/aptis-v5.css','./assets/quiz-navigation-v1.css','./assets/review-navigation-v1.css','./assets/review-navigation-v2.css','./assets/plan-lessons-v1.css',
  './assets/learning-notebook.js','./assets/learning-notebook.css','./assets/icons/icon-192.png','./assets/icons/icon-512.png'
];
self.addEventListener('install',event=>event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(STATIC)).then(()=>self.skipWaiting())));
self.addEventListener('activate',event=>event.waitUntil((async()=>{for(const key of await caches.keys())if(key!==CACHE)await caches.delete(key);await self.clients.claim();})()));
self.addEventListener('fetch',event=>{
  const req=event.request;
  if(req.method!=='GET')return;
  const url=new URL(req.url);
  if(url.origin!==self.location.origin)return;
  if(url.pathname.endsWith('/api.php')||url.pathname.includes('/api.php?'))return;
  if(req.mode==='navigate'){
    event.respondWith(fetch(req).catch(()=>caches.match('./offline.html')));
    return;
  }
  if(['style','script','image','font'].includes(req.destination)){
    event.respondWith((async()=>{
      const cached=await caches.match(req);
      const fresh=fetch(req).then(async res=>{if(res.ok){const c=await caches.open(CACHE);c.put(req,res.clone());}return res;}).catch(()=>cached);
      return cached||fresh;
    })());
  }
});
