'use strict';
// Synthetic, offline rendering and interaction tests. No database or host access.
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const pronunciation = require('../assets/pronunciation.js');
const esc = (value = '') => String(value).replace(/[&<>'"]/g, c => ({
  '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;'
}[c]));

assert.equal(pronunciation.render(null), '');
assert.equal(pronunciation.render('  '), '');
for (const value of ['/ˈmeɪ.dʒɚ/', 'US /ˈmeɪ.dʒɚ/', 'UK /ˈmeɪ.dʒə/']) {
  const html = pronunciation.render(value);
  assert.ok(html.includes(value), 'stored notation is preserved');
  assert.equal((html.match(/\//g) || []).length, 5, 'two source slashes and three closing tags only');
  assert.equal((html.match(/US/g) || []).length, value.startsWith('US ') ? 1 : 0, 'no inferred or duplicate dialect label');
}
const malicious = 'US /x/ <img src=x onerror="alert(1)"> & \' <script>bad()</script>';
assert.ok(pronunciation.render(malicious).includes('&lt;img'));
assert.ok(pronunciation.render(malicious).includes('&quot;alert(1)&quot;'));
assert.ok(!pronunciation.render(malicious).includes('<img'));
assert.ok(!pronunciation.render(malicious).includes('<script>'));

const appSource = fs.readFileSync(path.join(__dirname, '../assets/app.js'), 'utf8');
const fillSource = appSource.slice(appSource.indexOf('async function randomFillView('), appSource.indexOf('function normalize('));
const normalizeSource = appSource.slice(appSource.indexOf('function normalize('), appSource.indexOf('\n', appSource.indexOf('function normalize(')));
async function testFill() {
  const card = { id:17, set_id:9, term:'preserve', definition:'giữ nguyên', ipa:malicious, example_en:'We preserve these notes.' };
  let html = ''; const nodes = new Map(); const calls = [];
  const sandbox = { esc, ipaHtml:pronunciation.render, shuffle:items=>items, getPracticeCards:async()=>[card],
    noCards(){throw Error('unexpected empty');}, resultHtml:()=>'',setTimeout(){},
    api:async(action,options)=>{calls.push({action,options});},
    $:selector=>nodes.get(selector),setView(markup){html=markup;nodes.clear();for(const m of markup.matchAll(/id="([^"]+)"/g))nodes.set('#'+m[1],{value:'',innerHTML:'',focus(){}});}
  };
  vm.createContext(sandbox);vm.runInContext(normalizeSource+'\n'+fillSource,sandbox);
  await sandbox.randomFillView();
  assert.ok(html.includes('__________'));
  assert.ok(!html.includes('preserve') && !html.includes('US /x/'), 'fill prompt has neither target spelling nor IPA');
  nodes.get('#fill-answer').value='preserve';await nodes.get('#check-fill').onclick();
  const feedback=nodes.get('#fill-feedback').innerHTML;
  assert.match(feedback,/<p class="fill-target"><b>preserve<\/b><\/p><span class="yl-ipa">/);
  assert.ok(feedback.includes('&lt;img') && !feedback.includes('<img'));
  assert.equal(calls[0].options.data.card_id,17, 'feedback changes preserve card identity');
}

const practiceSource=fs.readFileSync(path.join(__dirname,'../assets/practice-lab.js'),'utf8');
function practiceEnvironment(mode) {
  const views=[],nodes=new Map(),values=new Map();
  values.set('ylPractice:v1:7',JSON.stringify({version:1,selection:{method:mode}}));
  const cards=Array.from({length:5},(_,i)=>({id:i+1,term:'targetword'+i,definition:'Nghĩa '+i,ipa:malicious,example_en:'The targetword'+i+' is useful.'}));
  const setView=html=>{views.push(html);nodes.clear();for(const hit of html.matchAll(/id="([^"]+)"/g))nodes.set('#'+hit[1],{value:'',innerHTML:'',textContent:'',isConnected:true,focus(){},addEventListener(name,fn){this['on'+name]=fn;}});};
  const speechSynthesis={cancel(){},speak(){},getVoices:()=>[]};
  const SpeechSynthesisUtterance=function(text){this.text=text;};
  const window={YLPronunciation:pronunciation,speechSynthesis,SpeechSynthesisUtterance,addEventListener(){},YLCore:{esc,state:{user:{id:7}},setView,routeArg:()=>'',api:async action=>action==='sets'?[{id:9,title:'Synthetic book'}]:action==='study_lessons'?[{kind:'unit',value:1,title:'Synthetic lesson',card_count:5}]:{cards}}};
  const sandbox={window,document:{querySelector:s=>nodes.get(s)||null,querySelectorAll:()=>[]},location:{hash:'#practice'},localStorage:{getItem:k=>values.get(k)||null,setItem:(k,v)=>values.set(k,v)},sessionStorage:{setItem(){}},requestAnimationFrame:fn=>fn(),setInterval,clearInterval,speechSynthesis,SpeechSynthesisUtterance,console};
  vm.runInNewContext(practiceSource,sandbox);
  return {window,views,nodes,values};
}
async function testPractice(mode,reveal) {
  const env=practiceEnvironment(mode);await env.window.YLPractice.view();
  env.nodes.get('#pl-form').onsubmit({preventDefault(){}});
  await new Promise(resolve=>setImmediate(resolve));await new Promise(resolve=>setImmediate(resolve));
  const prompt=env.views.at(-1);
  assert.ok(!prompt.includes('targetword')&&!prompt.includes('US /x/'),mode+' prompt has no spelling or IPA');
  if(reveal)env.nodes.get('#pl-reveal').onclick();
  else {const session=JSON.parse(env.values.get('ylPractice:v1:7')).session;env.nodes.get('#pl-answer').value=session.cards[session.queue[0].index].term;env.nodes.get('#pl-answer-form').onsubmit({preventDefault(){}});}
  const feedback=env.nodes.get('#pl-feedback').innerHTML;
  assert.match(feedback,/<\/p><span class="yl-ipa">/,'practice IPA follows the target term');
  assert.ok(feedback.includes('US /x/ &lt;img')&&!feedback.includes('<img'));
  env.window.YLPractice.dispose();
}
(async()=>{
  await testFill();
  for(const mode of ['recall','context','listen'])for(const reveal of [false,true])await testPractice(mode,reveal);
  console.log('PASS: stored notation/dialect preservation, escaping, fill guard, and recall/context/listen IPA only after check or reveal');
})().catch(error=>{console.error(error);process.exitCode=1;});
