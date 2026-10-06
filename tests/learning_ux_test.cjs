'use strict';
// Offline interaction checks: no application server or database is contacted.
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, '../assets/app.js'), 'utf8');
const reviewSource = source.slice(source.indexOf('async function reviewView('), source.indexOf('function localDateString('));
const clozeSource = source.slice(source.indexOf('function clozeWord('), source.indexOf('async function reviewView('));
const normalizeSource = source.slice(source.indexOf('function normalize('), source.indexOf('\n', source.indexOf('function normalize(')));
const statSource = source.slice(source.indexOf('function stat('), source.indexOf('\n', source.indexOf('function stat(')));
const navSource = source.slice(source.indexOf('function handleNavClick('), source.indexOf('\n', source.indexOf('function handleNavClick(')));
const focusSource = source.slice(source.indexOf('function focusSession('), source.indexOf('\n', source.indexOf('function focusSession(')));
const nextLessonSource=source.slice(source.indexOf('function nextLesson('),source.indexOf('\n',source.indexOf('function nextLesson(')));
const lessonPlanSource=source.slice(source.indexOf('function lessonPlanHtml('),source.indexOf('function startPlanLesson('));
const cards = [{id:7,set_title:'Original book',term:'preserve',definition:'giữ nguyên',ipa:'/prɪˈzɜːv/'},{id:8,set_title:'Original book',term:'learn',definition:'học'}];
const nodes = new Map(), listeners = new Map(), storage = new Map(), sessions = new Map(), calls = [];
let html = '',renders=0;
function element(attrs='') {
  const el = {dataset:{}, value:'', disabled:/(?:^|\s)disabled(?:\s|$)/.test(attrs), classList:{toggle(){},add(){},remove(){}}, handlers:{}, setAttribute(name,value){this[name]=value;}, addEventListener(name,handler){this.handlers[name]=handler;}, click(){if(!this.disabled)return this.onclick?.({target:this,currentTarget:this});}};
  for (const m of attrs.matchAll(/([\w-]+)="([^"]*)"/g)) {
    if (m[1].startsWith('data-')) el.dataset[m[1].slice(5).replace(/-([a-z])/g,(_,c)=>c.toUpperCase())] = m[2];
    else el[m[1]] = m[2];
  }
  return el;
}
const sandbox = {
  console, setTimeout(){},
  window:{addEventListener(name,handler){listeners.set(name,handler);}, removeEventListener(name){listeners.delete(name);}},
  localStorage:{getItem(key){return storage.get(key)||null;},setItem(key,value){storage.set(key,value);}},
  sessionStorage:{getItem(key){return sessions.get(key)||null;},removeItem(key){sessions.delete(key);}},
  state:{user:{id:9}},
  routeName:()=> 'review', routeArg:()=> '', studySetQuery:()=> '', studyLessonQuery:()=> null,
  lessonQuery:()=> ({}), lessonPlanHtml:()=> '', bindLessonPlan(){}, speak(){}, toast(){}, loadSideStats:async()=> {},
  esc:(value='')=>String(value).replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c])),
  fmt:value=>String(value||0),
  ipaHtml:require('../assets/pronunciation.js').render,
  api:async(action,options)=>{calls.push({action,options});if(action==='study_cards')return cards;if(action==='review_rate')return {};throw new Error('Unexpected API '+action);},
  setView(markup){
    html=markup;renders++;nodes.clear();nodes.set('#modal-root',{firstElementChild:null});
    for(const m of markup.matchAll(/<([\w-]+)\b([^>]*)>/g)) {
      const el=element(m[2]);el.tagName=m[1].toUpperCase();
      if(el.id)nodes.set('#'+el.id,el);
      for(const [key,value] of Object.entries(el.dataset))nodes.set('[data-'+key.replace(/[A-Z]/g,c=>'-'+c.toLowerCase())+'="'+value+'"]',el);
    }
    nodes.set('.flash-face.front',element());nodes.set('.flash-face.back',element());
  },
  $:selector=>nodes.get(selector)||null,
  $$:selector=>selector.startsWith('[data-')?[...nodes.entries()].filter(([key])=>key.startsWith(selector.slice(0,-1)+'=')).map(([,el])=>el):[]
};
vm.createContext(sandbox);
vm.runInContext(normalizeSource+'\n'+statSource+'\n'+navSource+'\n'+focusSource+'\n'+nextLessonSource+'\n'+lessonPlanSource+'\n'+clozeSource+'\n'+reviewSource, sandbox);
(async()=>{
  const sixLessons=Array.from({length:6},(_,i)=>({key:'unit:'+(i+1),kind:'unit',value:i+1,title:'Bài '+(i+1),status:'new',card_count:10}));
  const unfinishedPlan=sandbox.lessonPlanHtml(sixLessons,sixLessons[0],'review');
  assert.match(unfinishedPlan,/0\/6 bài đã hoàn thành/);
  assert.doesNotMatch(unfinishedPlan,/✓ Hoàn thành lộ trình/,'an unfinished current lesson cannot imply that the whole book is complete');
  assert.match(unfinishedPlan,/Hoàn thành bài hiện tại/);
  const completedPlan=sandbox.lessonPlanHtml(sixLessons.map(x=>({...x,status:'done'})),null,'review');
  assert.match(completedPlan,/✓ Hoàn thành lộ trình/,'book completion requires all six lessons to be done');
  let sidebarCloses=0;nodes.set('#sidebar',{classList:{remove(){sidebarCloses++;}}});nodes.set('#scrim',{classList:{remove(){}}});
  sandbox.handleNavClick({target:{closest:()=>null}});
  assert.equal(sidebarCloses,0,'expanding a mobile nav group keeps the drawer open');
  sandbox.handleNavClick({target:{closest:()=>({href:'#sets'})}});
  assert.equal(sidebarCloses,1,'following a navigation link closes the drawer');
  sessions.set('ylDailySession',JSON.stringify({mode:'quick',userId:9,startedAt:Date.now()}));
  assert.ok(sandbox.focusSession(),'a current session belongs to the signed-in learner');
  sessions.set('ylDailySession',JSON.stringify({mode:'quick',userId:8,startedAt:Date.now()}));
  assert.equal(sandbox.focusSession(),null,'another account does not inherit a learner session');
  sessions.set('ylDailySession',JSON.stringify({mode:'quick',userId:9,startedAt:Date.now()+60000}));
  assert.equal(sandbox.focusSession(),null,'a future timestamp cannot inflate the fifteen-minute countdown');
  sessions.clear();
  assert.match(sandbox.stat('','Retention','75%',''),/<strong>75%<\/strong>/,'percentage statistics retain their display unit');
  assert.match(sandbox.stat('','Retention',null,''),/<strong>—<\/strong>/,'missing evidence is not displayed as a zero score');
  await sandbox.reviewView();
  assert.equal(calls[0].options.query.limit,10,'unselected review requests a small batch');
  assert.match(html,/Nhớ từ tiếng Anh/);
  assert.doesNotMatch(html,/prɪˈzɜːv|>preserve</,'recall does not put answer IPA or the hidden answer term in the DOM');
  assert.equal(nodes.get('[data-rate="3"]').disabled,true,'rating requires revealing the answer');
  // Invoking the handler directly must also honor the reveal guard.
  await nodes.get('[data-rate="3"]').onclick();
  assert.equal(calls.filter(x=>x.action==='review_rate').length,0);
  nodes.get('#recall-attempt').value='preserve';
  nodes.get('#recall-attempt').handlers.input({target:nodes.get('#recall-attempt')});
  nodes.get('#recall-attempt').handlers.keydown({key:'Enter',preventDefault(){}});
  assert.equal(nodes.get('[data-rate="3"]').disabled,false);
  assert.match(nodes.get('#recall-feedback').innerHTML,/Bạn đã viết đúng từ/,'recall uses the actual source answer');
  assert.equal(nodes.get('#flashcard')['aria-pressed'],'true');
  assert.match(nodes.get('.flash-face.back').innerHTML,/<h2>preserve<\/h2>\s*<span class="yl-ipa">/,'revealed IPA is placed below the term');
  await nodes.get('[data-rate="3"]').click();
  assert.equal(calls.filter(x=>x.action==='review_rate').length,1);
  assert.equal(calls.find(x=>x.action==='review_rate').options.data.card_id,7,'source card identity is retained');
  assert.equal(nodes.get('[data-rate="3"]').disabled,true,'saved rating cannot be submitted twice');
  nodes.get('#review-next').click();
  assert.equal(nodes.get('[data-rate="3"]').disabled,true,'each next card starts without revealing its answer');
  // Shortcuts must leave modal dialogs and typing controls alone.
  nodes.get('#modal-root').firstElementChild={};
  listeners.get('keydown')({key:'1',target:{tagName:'DIV'},preventDefault(){throw new Error('Modal key intercepted');}});
  nodes.get('#modal-root').firstElementChild=null;
  listeners.get('keydown')({key:'1',target:{tagName:'INPUT'},preventDefault(){throw new Error('Input key intercepted');}});
  const setsSource=source.slice(source.indexOf('async function setsView('),source.indexOf('function setsHtml('));
  const booksSource=source.slice(source.indexOf('async function flashcardBooksView('),source.indexOf('function handbookBodyHtml('));
  assert.ok(!setsSource.includes('syncBundledFlashcardBooks()'),'opening library cannot silently sync English source records');
  assert.ok(!booksSource.includes('syncBundledFlashcardBooks()'),'opening catalog cannot silently sync English source records');
  sandbox.studySetQuery=()=> '42';sandbox.studyLessonQuery=()=> ({kind:'unit',value:1});sandbox.lessonQuery=lesson=>({unit:lesson.value});
  cards[0].set_title='';
  sandbox.api=async(action,options)=>{calls.push({action,options});if(action==='study_lessons')return [{kind:'unit',value:1,key:'unit:1',title:'Chào hỏi mỗi ngày',status:'new'}];if(action==='study_cards')return cards;throw new Error('Unexpected API '+action);};
  await sandbox.reviewView();
  assert.match(html,/Chào hỏi mỗi ngày/,'lesson selections restore the original named lesson after route navigation');
  assert.doesNotMatch(html,/ ·\s*·/,'a missing book title leaves only one separator before the lesson name');
  assert.equal(calls.at(-1).options.query.mode,'lesson','named lesson still uses full lesson API');
  assert.equal(calls.at(-1).options.query.unit,1);
  let finishRating;
  const previousApi=sandbox.api;
  sandbox.api=async(action,options)=>action==='review_rate'?new Promise(resolve=>{finishRating=resolve;}):previousApi(action,options);
  nodes.get('#reveal-card').click();
  const pendingSave=nodes.get('[data-rate="3"]').click();
  await sandbox.reviewView();
  const latestRenders=renders;
  finishRating({});await pendingSave;
  assert.equal(renders,latestRenders,'a pending rating cannot redraw an old review after a new lesson is loaded');
  assert.ok(booksSource.includes('Number(!!b.is_new)-Number(!!a.is_new)'),'new books are discoverable before source books');
  for(const mode of ['cloze','audio']){
    storage.set('yl_recall_mode',mode);await sandbox.reviewView();
    assert.doesNotMatch(html,/prɪˈzɜːv|>preserve</,mode+' keeps answer IPA and hidden answer out of the prompt DOM');
    nodes.get('#reveal-card').click();
    assert.match(nodes.get('.flash-face.back').innerHTML,/prɪˈzɜːv/,mode+' shows stored IPA after reveal');
  }
  storage.set('yl_recall_mode','flip');await sandbox.reviewView();
  assert.match(html,/prɪˈzɜːv/,'word-to-meaning mode may show IPA with the visible word');
  console.log('PASS: recall, rating guards, named routing, async navigation, session ownership, mobile navigation, new book priority, read-only library');
})().catch(error=>{console.error(error);process.exitCode=1;});
