const fs=require('fs');const vm=require('vm');const assert=require('assert/strict');
const source=fs.readFileSync(__dirname+'/../assets/practice-lab.js','utf8');
const results=[];const esc=(v='')=>String(v).replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));
const deferred=()=>{let resolve,reject;const promise=new Promise((a,b)=>{resolve=a;reject=b;});return{promise,resolve,reject};};
function environment({uid=7,hash='#practice',storage={},handler=()=>[]}={}){
  const views=[],calls=[],reads=[],writes=[],elements=new Map(),events={};const values=new Map(Object.entries(storage));
  const state={user:{id:uid}};const location={hash};
  const doc={querySelector:s=>elements.get(s)||null,querySelectorAll:()=>[]};
  const setView=html=>{views.push(html);for(const element of elements.values())element.isConnected=false;elements.clear();for(const hit of html.matchAll(/id="([^"]+)"/g))elements.set('#'+hit[1],{value:'',textContent:'',innerHTML:'',isConnected:true,focus(){},addEventListener(name,fn){this['on'+name]=fn;}});};
  const localStorage={getItem:k=>{reads.push(k);return values.get(k)||null;},setItem:(k,v)=>{writes.push(k);values.set(k,v);}};
  const core={state,esc,setView,routeArg:()=>location.hash.slice(1).split('/')[1]||'',api:(action,options)=>{calls.push({action,options});return Promise.resolve(handler(action,options));}};
  const window={YLPronunciation:require('../assets/pronunciation.js'),YLCore:core,addEventListener:(name,fn)=>events[name]=fn};
  const sandbox={window,document:doc,location,localStorage,sessionStorage:{setItem(){}},requestAnimationFrame:fn=>fn(),setInterval,clearInterval,console};
  vm.runInNewContext(source,sandbox,{filename:'practice-lab.js'});
  return{window,state,location,views,calls,reads,writes,values,elements,events,flush:async()=>{await new Promise(r=>setImmediate(r));await new Promise(r=>setImmediate(r));}};
}
const lessons=[{kind:'unit',value:1,title:'Synthetic lesson',card_count:5,status:'new'}];
const sets=[{id:11,title:'First synthetic book'},{id:22,title:'Second synthetic book'}];
async function check(name,test){try{await test();results.push({name,passed:true});console.log('PASS '+name);}catch(error){results.push({name,passed:false});console.log('FAIL '+name+': '+error.message);}}
(async()=>{
  await check('all 120 authored examples support cloze after boundary hardening',async()=>{const logic=require(__dirname+'/../assets/practice-lab.js'),book=JSON.parse(fs.readFileSync(__dirname+'/../assets/flashbooks/student-life-work-a2-b1.json','utf8'));const cards=book.lessons.flatMap(l=>l.cards);assert.equal(cards.length,120);assert(cards.every(c=>logic.makeCloze(c.term,c.example_en)?.includes('________')));});
  await check('documented spelling alias is accepted without weakening word identity',async()=>{const {answerMatches}=require(__dirname+'/../assets/practice-lab.js');assert(answerMatches('prioritise','prioritize'));assert(answerMatches('Prioritize!','prioritise'));assert(!answerMatches('priority','prioritize'));assert(!answerMatches('prioritizes','prioritize'));assert(!answerMatches('deadlines','deadline'));});
  await check('linked book overrides saved book after ownership validation',async()=>{const e=environment({hash:'#practice/22',storage:{'ylPractice:v1:7':JSON.stringify({version:1,selection:{setId:'11',unit:'3'}})},handler:a=>a==='sets'?sets:lessons});await e.window.YLPractice.view();assert.equal(e.calls.find(x=>x.action==='study_lessons').options.query.set_id,'22');});
  await check('foreign linked book never sent to lesson endpoint',async()=>{const e=environment({hash:'#practice/999',handler:a=>a==='sets'?sets:lessons});await e.window.YLPractice.view();assert.equal(e.calls.find(x=>x.action==='study_lessons').options.query.set_id,'11');});
  await check('logout disposal suppresses late set response',async()=>{const d=deferred(),e=environment({handler:()=>d.promise});const loading=e.window.YLPractice.view();e.window.YLPractice.dispose();e.state.user=null;d.resolve(sets);await loading;assert.equal(e.views.length,0);});
  await check('account change suppresses late response without relying on navigation',async()=>{const d=deferred(),e=environment({handler:()=>d.promise});const loading=e.window.YLPractice.view();e.state.user={id:8};d.resolve(sets);await loading;assert.equal(e.views.length,0);});
  await check('route change suppresses late lesson response',async()=>{const d=deferred(),e=environment({handler:a=>a==='sets'?sets:d.promise});const loading=e.window.YLPractice.view();await e.flush();const renders=e.views.length;e.location.hash='#sets';e.window.YLPractice.dispose();d.resolve(lessons);await loading;assert.equal(e.views.length,renders);});
  await check('storage reads stay within the signed-in account namespace',async()=>{const e=environment({uid:8,storage:{'ylPractice:v1:7':JSON.stringify({version:1,last:{setTitle:'OTHER_ACCOUNT_PRIVATE_MARKER'}})},handler:a=>a==='sets'?sets:lessons});await e.window.YLPractice.view();assert.deepEqual(e.reads,['ylPractice:v1:8']);assert(!e.views.join('').includes('OTHER_ACCOUNT_PRIVATE_MARKER'));});
  await check('corrupt saved JSON falls back to setup',async()=>{const e=environment({storage:{'ylPractice:v1:7':'{broken'},handler:a=>a==='sets'?sets:lessons});await e.window.YLPractice.view();assert(e.views.at(-1).includes('id="pl-form"'));});
  await check('API error text is escaped and retry remains reachable',async()=>{const e=environment({handler:()=>{throw Error('<img src=x onerror=alert(1)>');}});await e.window.YLPractice.view();assert(e.views.at(-1).includes('&lt;img'));assert(!e.views.at(-1).includes('<img'));assert.equal(typeof e.elements.get('#pl-retry').onclick,'function');});
  await check('book and card text are escaped with no target leak before answering',async()=>{
    const cards=Array.from({length:5},(_,i)=>({id:i+1,term:'uniqueTarget'+i,definition:'<img src=x onerror=alert(1)> Nghĩa '+i,example_en:'The uniqueTarget'+i+' is useful.',example_vi:'Câu ví dụ.'}));
    const e=environment({storage:{'ylPractice:v1:7':JSON.stringify({version:1,selection:{method:'recall'}})},handler:a=>a==='sets'?[{id:11,title:'<script>bookTitle</script>'}]:a==='study_lessons'?lessons:{cards}});
    await e.window.YLPractice.view();assert(e.views.at(-1).includes('&lt;script&gt;bookTitle'));e.elements.get('#pl-form').onsubmit({preventDefault(){}});await e.flush();const prompt=e.views.at(-1);assert(prompt.includes('&lt;img'));assert(!prompt.includes('<img'));assert(cards.every(c=>!prompt.includes(c.term)));
    const session=JSON.parse(e.values.get('ylPractice:v1:7')).session;const answer=session.cards[session.queue[0].index].term;e.elements.get('#pl-answer').value=answer;e.elements.get('#pl-answer-form').onsubmit({preventDefault(){}});assert(e.elements.get('#pl-feedback').innerHTML.includes(answer));assert(e.elements.get('#pl-feedback').innerHTML.includes('pl-correct'));assert(e.writes.every(k=>k==='ylPractice:v1:7'));
    assert(e.calls.every(c=>['sets','study_lessons','study_lesson_cards'].includes(c.action)&&(!c.options||!c.options.method||c.options.method==='GET')));
  });
  process.exitCode=results.every(r=>r.passed)?0:1;
})();
