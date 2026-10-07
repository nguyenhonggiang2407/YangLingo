'use strict';
// Offline behavior tests execute the actual staged functions with a small DOM adapter.
// No database, authenticated account, browser network, local storage or host access.
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');
const pronunciation=require('../assets/pronunciation.js');
const source=fs.readFileSync(path.join(__dirname,'../assets/app.js'),'utf8');
const line=name=>source.split('\n').find(x=>x.startsWith('function '+name+'('));
const detailSource=source.slice(source.indexOf('function cardDetailHtml('),source.indexOf('async function setDetail('));
const setSource=source.slice(source.indexOf('async function setDetail('),source.indexOf('function cardModal('));
const modalSource=source.slice(source.indexOf('function modal('),source.indexOf('async function refreshSecurityToken('));
let checks=0;
function check(condition,message){assert.ok(condition,message);checks++;}
const decode=v=>v.replace(/&quot;/g,'"').replace(/&#39;/g,"'").replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');

function environment(cards=[]){
  let document;const observers=new Set();
  class Element{
    constructor(tag,attrs={}){this.tag=tag;this.attrs=attrs;this.hidden=false;this.disabled='disabled' in attrs;this.isConnected=true;this.dataset={};this.inert=false;this.classList={add:v=>{this.attrs.class=((this.attrs.class||'')+' '+v).trim();}};for(const[k,v]of Object.entries(attrs))if(k.startsWith('data-'))this.dataset[k.slice(5).replace(/-([a-z])/g,(_,c)=>c.toUpperCase())]=v;}
    addEventListener(name,fn){this['on'+name]=fn;}
    focus(){document.activeElement=this;}
    matches(selector){return selector.split(',').some(part=>{part=part.trim();if(part.startsWith('.'))return(this.attrs.class||'').split(' ').includes(part.slice(1));if(part.startsWith('#'))return this.attrs.id===part.slice(1);if(part.startsWith('['))return part.slice(1,-1) in this.attrs;return this.tag===part;});}
  }
  class Root extends Element{
    constructor(){super('root');this.nodes=[];this.html='';}
    set innerHTML(value){this.nodes.forEach(n=>n.isConnected=false);this.nodes=[];this.html=value;for(const m of value.matchAll(/<(\w+)\b([^>]*)>/g)){const attrs={};for(const a of m[2].matchAll(/([\w-]+)="([^"]*)"/g))attrs[a[1]]=decode(a[2]);if(/\bdisabled(?:\s|$)/.test(m[2]))attrs.disabled='';if(/\bdata-close(?:\s|$)/.test(m[2]))attrs['data-close']='';const node=new Element(m[1],attrs);node.querySelector=s=>this.querySelector(s);node.querySelectorAll=s=>this.querySelectorAll(s);this.nodes.push(node);}for(const observer of observers)if(observer.target===this)queueMicrotask(()=>{if(observers.has(observer))observer.callback();});}
    get innerHTML(){return this.html;}
    querySelector(selector){return this.nodes.find(n=>n.matches(selector))||null;}
    querySelectorAll(selector){if(selector==='button:not([disabled]),a[href],[tabindex="0"]')return this.nodes.filter(n=>(n.tag==='button'&&!n.disabled)||(n.tag==='a'&&'href'in n.attrs)||n.attrs.tabindex==='0');return this.nodes.filter(n=>n.matches(selector));}
  }
  const modalRoot=new Root(),viewRoot=new Root(),app=new Element('div',{id:'app'}),opener=new Element('button');
  document={activeElement:opener,body:{style:{overflow:'auto'}},querySelector:s=>s==='#modal-root'?modalRoot:s==='#app'?app:viewRoot.querySelector(s),querySelectorAll:s=>viewRoot.querySelectorAll(s)};
  const listeners=new Map(),calls=[],spoken=[],navigation=[],progressWrites=[];
  let cancels=0;
  const speech={cancel(){cancels++;},getVoices(){return[{lang:'en-US'}];},speak(u){spoken.push(u.text);}};
  const window={YLPronunciation:pronunciation,speechSynthesis:speech,addEventListener(name,fn){if(!listeners.has(name))listeners.set(name,new Set());listeners.get(name).add(fn);},removeEventListener(name,fn){listeners.get(name)?.delete(fn);}};
  const data={id:9,title:'Fictional test book',folder_name:'QA',description:'Offline fixture',cards,card_total:cards.length,page:1,pages:1};
  const sandbox={window,document,routeGeneration:0,MutationObserver:class{constructor(callback){this.callback=callback;}observe(target){this.target=target;observers.add(this);}disconnect(){observers.delete(this);}},speechSynthesis:speech,SpeechSynthesisUtterance:function(text){this.text=text;},state:{user:{id:7}},location:{hash:'#sets/9'},
    requestAnimationFrame:fn=>fn(),setTimeout(){},clearTimeout(){},fmt:n=>String(n||0),toast(){},
    setView:html=>{viewRoot.innerHTML=html;},navigate:route=>{navigation.push(route);},
    sessionStorage:{setItem(...args){progressWrites.push(args);}},api:async(action,options)=>{calls.push({action,options});assert.equal(action,'set_get');assert.ok(!options.method||options.method==='GET');return data;},
    cardModal(){throw Error('editing not expected');},setModal(){throw Error('editing not expected');},confirm(){throw Error('deleting not expected');}}
  vm.createContext(sandbox);
  vm.runInContext("const $=(s,r=document)=>r.querySelector(s),$$=(s,r=document)=>[...r.querySelectorAll(s)];\n"+[line('esc'),line('cardTypeLabel'),line('ipaHtml'),line('speak'),line('routeName'),line('routeArg')].join('\n')+'\n'+modalSource+detailSource+setSource,sandbox);
  const event=(key,shiftKey=false)=>({key,shiftKey,preventDefault(){this.prevented=true;},stopPropagation(){this.stopped=true;}});
  return{sandbox,document,modalRoot,viewRoot,app,opener,spoken,calls,navigation,progressWrites,listeners,data,event,get cancels(){return cancels;}};
}

const card={id:17,set_id:9,term:'awake',ipa:'US /əˈweɪk/',part_of_speech:'verb',card_type:'VOCABULARY',definition:'thức giấc',cefr:'B2',example_en:'I awoke before my alarm rang.',example_vi:'Tôi thức giấc trước khi chuông báo thức reo.',explanation:'Awoke là V2; awoken là V3.',pattern:'awake → awoke → awoken',collocations:'awake from sleep',word_family:'awake; awaken',audio_text:'awake. awoke. awoken.',state:'review',due_at:'2026-10-09 10:00:00'};

function rendering(){
  const env=environment(),html=env.sandbox.cardDetailHtml(card);
  check(html.includes('<h2 lang="en">awake</h2><span class="yl-ipa">'),'IPA immediately follows the visible term');
  check(html.includes('Dạng động từ')&&html.includes('awake → awoke → awoken'),'conjugation table visible');
  check(html.includes('Động từ')&&html.includes('Từ vựng')&&html.includes('B2'),'category/POS/level displayed');
  check(html.includes('Nghe ví dụ')&&html.includes(card.example_en)&&html.includes(card.example_vi),'bilingual example and separate speech');
  check(html.includes('Cụm từ đi cùng')&&html.includes('Họ từ')&&html.includes(card.explanation),'usage and optional contextual fields');
  check(!/<(?:input|textarea|select|form)\b/.test(html),'reading view has no editing inputs');
  for(const ipa of [null,undefined,'','  '])check(!env.sandbox.cardDetailHtml({...card,ipa}).includes('yl-ipa'),'unavailable IPA omitted without guessed notation');
  const categories={VOCABULARY:'Từ vựng',COLLOCATION:'Cụm từ đi cùng nhau',SENTENCE_PATTERN:'Mẫu câu',GRAMMAR:'Ngữ pháp',LISTENING:'Bài nghe',LISTENING_CHUNK:'Cụm từ luyện nghe',MISTAKE_CARD:'Thẻ lỗi cần ôn',UNKNOWN:'Thẻ học'};
  for(const[type,label]of Object.entries(categories))check(env.sandbox.cardDetailHtml({...card,card_type:type}).includes(label),'category '+type);
  const empty=env.sandbox.cardDetailHtml({...card,example_en:'',example_vi:'',explanation:'',pattern:'',collocations:'',word_family:''});
  check(!empty.includes('card-detail-play-example')&&!empty.includes('card-detail-section'),'blank optional content omitted');
  const onlyVI=env.sandbox.cardDetailHtml({...card,example_en:'',example_vi:'Bản dịch cũ.'});
  check(onlyVI.includes('Bản dịch cũ.')&&!onlyVI.includes('card-detail-play-example'),'VI-only source displayed without invented English or speech');
  const attack='<img src=x onerror="alert(1)"><script>bad()</script> & \' "';
  const dirty={...card};for(const field of ['term','definition','ipa','example_en','example_vi','explanation','pattern','collocations','word_family','part_of_speech','cefr'])dirty[field]=attack;
  const escaped=env.sandbox.cardDetailHtml(dirty);
  check(!escaped.includes('<img')&&!escaped.includes('<script>'),'all learner data cannot inject HTML');
  check((escaped.match(/&lt;img/g)||[]).length===11,'all eleven displayed fields escaped');
  check(escaped.includes('&quot;alert(1)&quot;')&&escaped.includes('&#39;')&&escaped.includes('&amp;'),'quotes and ampersands escaped');
  check(!html.includes(card.audio_text),'stored form-list speech is not substituted for visible example');
}

function interaction(){
  const env=environment(),saved=JSON.stringify(card);
  env.sandbox.cardDetailsModal(card,env.opener);
  check(env.modalRoot.innerHTML.includes('role="dialog"')&&env.modalRoot.innerHTML.includes('aria-modal="true"'),'existing dialog semantics reused');
  check(env.app.inert&&env.document.body.style.overflow==='hidden','background inert and scroll locked while reading');
  env.modalRoot.querySelector('#card-detail-play-term').onclick();env.modalRoot.querySelector('#card-detail-play-example').onclick();
  assert.deepEqual(env.spoken,[card.term,card.example_en]);checks++;
  check(env.calls.length===0&&env.progressWrites.length===0,'reading/speech makes no API or progress writes');
  check(JSON.stringify(card)===saved,'card and scheduling fields not mutated');
  const controls=env.modalRoot.querySelectorAll('button:not([disabled]),a[href],[tabindex="0"]'),first=controls[0],last=controls.at(-1),dialog=env.modalRoot.querySelector('.modal');
  first.focus();let e=env.event('Tab',true);env.modalRoot.onkeydown(e);check(e.prevented&&env.document.activeElement===last,'Shift+Tab from first loops to last');
  e=env.event('Tab');env.modalRoot.onkeydown(e);check(e.prevented&&env.document.activeElement===first,'Tab from last loops to first');
  dialog.focus();e=env.event('Tab');env.modalRoot.onkeydown(e);check(e.prevented&&env.document.activeElement===first,'Tab from initial dialog focus enters first control');
  env.modalRoot.onclick({target:dialog});check(env.modalRoot.innerHTML.length>0,'content click does not close');
  e=env.event('Escape');env.modalRoot.onkeydown(e);check(e.prevented&&e.stopped&&!env.modalRoot.innerHTML,'Escape closes');
  check(!env.app.inert&&env.document.body.style.overflow==='auto'&&env.document.activeElement===env.opener,'Escape restores background, scroll and opener focus');
  check(env.listeners.get('hashchange').size===0&&env.listeners.get('pagehide').size===0,'close removes temporary listeners');
  check(env.cancels===3,'two speech replacements plus close cancel outstanding speech');
  env.sandbox.cardDetailsModal(card,env.opener);env.modalRoot.onclick({target:env.modalRoot.querySelector('.modal-backdrop')});check(!env.modalRoot.innerHTML,'backdrop closes');
  env.sandbox.cardDetailsModal(card,env.opener);env.modalRoot.onclick({target:env.modalRoot.nodes.find(n=>'data-close'in n.attrs)});check(!env.modalRoot.innerHTML,'explicit close works');
  env.sandbox.cardDetailsModal(card,env.opener);env.modalRoot.querySelector('#card-detail-notebook').onclick();check(!env.modalRoot.innerHTML&&env.navigation[0]==='notebook'&&env.calls.length===0,'notebook action only closes and navigates, creating nothing');
  env.sandbox.cardDetailsModal(card,env.opener);env.sandbox.state.user={id:8};env.modalRoot.querySelector('#card-detail-play-example').onclick();check(!env.modalRoot.innerHTML&&env.spoken.length===2,'owner switch prevents stale text speech and closes');
  env.sandbox.state.user=null;check(env.sandbox.cardDetailsModal(card,env.opener)===null,'logged-out state cannot open detail');
  env.sandbox.state.user={id:7};env.sandbox.cardDetailsModal(card,env.opener);for(const fn of [...env.listeners.get('hashchange')])fn();check(!env.modalRoot.innerHTML&&!env.app.inert,'route change closes and releases background');
}

async function library(){
  const second={...card,id:18,term:'sow',example_en:'The club sowed basil seeds.'};const env=environment([card,second]);
  await env.sandbox.setDetail(9);
  check(env.calls.length===1&&env.calls[0].action==='set_get'&&env.calls[0].options.query.id===9,'library only uses existing owned read API');
  const buttons=env.viewRoot.querySelectorAll('[data-view-card]');check(buttons.length===2&&buttons.every(b=>b.tag==='button'&&b.attrs['aria-haspopup']==='dialog'),'terms are native keyboard-accessible buttons');
  buttons[1].onclick();check(env.modalRoot.innerHTML.includes('>sow</h2>')&&!env.modalRoot.innerHTML.includes('>awake</h2>'),'matching owned row opened by exact ID');
  env.modalRoot.querySelector('#card-detail-play-example').onclick();check(env.spoken[0]===second.example_en,'owned row example target selected');
  env.modalRoot.onclick({target:env.modalRoot.nodes.find(n=>'data-close'in n.attrs)});
  buttons[0].dataset.viewCard='999';buttons[0].onclick();check(!env.modalRoot.innerHTML,'unmatched/foreign ID ignored');
  buttons[0].dataset.viewCard='17';env.sandbox.state.user={id:8};buttons[0].onclick();check(!env.modalRoot.innerHTML,'stale owner row trigger ignored');
  check(env.calls.length===1&&env.progressWrites.length===0,'all detail library actions make no POST/SRS/local progress writes');
  for(const changed of ['owner','route']){
    const stale=environment([card]);let resolve;stale.sandbox.api=()=>new Promise(r=>resolve=r);const promise=stale.sandbox.setDetail(9);
    if(changed==='owner')stale.sandbox.state.user={id:8};else stale.sandbox.location.hash='#review';
    resolve(stale.data);await promise;check(!stale.viewRoot.innerHTML,'pending owned response ignored after '+changed+' change');
  }
  const reentry=environment([card]);const oldPending=[];reentry.sandbox.api=()=>new Promise(r=>oldPending.push(r));const oldView=reentry.sandbox.setDetail(9);reentry.sandbox.routeGeneration++;reentry.sandbox.location.hash='#dashboard';reentry.sandbox.routeGeneration++;reentry.sandbox.location.hash='#sets/9';const newView=reentry.sandbox.setDetail(9);oldPending[1]({...reentry.data,title:'Current return to owned book'});await newView;oldPending[0]({...reentry.data,title:'Stale prior route visit'});await oldView;check(reentry.viewRoot.innerHTML.includes('Current return to owned book')&&!reentry.viewRoot.innerHTML.includes('Stale prior route visit'),'leave/reenter same owned book cannot accept old route response');
  const racing=environment([card]);await racing.sandbox.setDetail(9);const pending=[];racing.sandbox.api=()=>new Promise(r=>pending.push(r));
  racing.viewRoot.querySelectorAll('[data-set-type]')[1].onclick();racing.viewRoot.querySelectorAll('[data-set-type]')[2].onclick();
  pending[1]({...racing.data,title:'Newest filter response'});await new Promise(r=>setImmediate(r));
  pending[0]({...racing.data,title:'Stale filter response'});await new Promise(r=>setImmediate(r));
  check(racing.viewRoot.innerHTML.includes('Newest filter response')&&!racing.viewRoot.innerHTML.includes('Stale filter response'),'slow earlier filter cannot replace newer owned view');
}

async function lifecycle(){
  const env=environment();env.sandbox.cardDetailsModal(card,env.opener);env.sandbox.closeModal();await new Promise(r=>setImmediate(r));
  check(!env.app.inert&&env.document.body.style.overflow==='auto'&&env.modalRoot.onkeydown===null,'generic existing closeModal releases detail lock and keyboard handler');
  check(env.listeners.get('hashchange').size===0&&env.listeners.get('pagehide').size===0,'generic close removes listeners');
  env.sandbox.cardDetailsModal(card,env.opener);env.sandbox.modal('Replacement dialog','<p>Other existing modal</p>');const replacementClick=env.modalRoot.onclick,replacementKey=env.modalRoot.onkeydown;await new Promise(r=>setImmediate(r));
  check(env.modalRoot.innerHTML.includes('Replacement dialog')&&env.modalRoot.onclick===replacementClick&&env.modalRoot.onkeydown===replacementKey,'generic modal replacement remains intact with its own handlers');
  check(!env.app.inert&&env.document.body.style.overflow==='auto','replacement restores prior background/scroll state');
  env.sandbox.cardDetailsModal(card,env.opener);env.sandbox.cardDetailsModal({...card,term:'Second detail'},env.opener);await new Promise(r=>setImmediate(r));
  check(env.modalRoot.innerHTML.includes('Second detail')&&env.app.inert&&env.document.body.style.overflow==='hidden','second detail remains locked after first detail cleanup');
  env.modalRoot.onclick({target:env.modalRoot.nodes.find(n=>'data-close'in n.attrs)});
  check(!env.app.inert&&env.document.body.style.overflow==='auto','second detail close fully restores original state');
}

(async()=>{rendering();interaction();await library();await lifecycle();console.log(`PASS: ${checks} offline real-function behavior checks (escaping, categories, visible speech targets, owned rows, no writes, keyboard/focus and stale responses).`);})().catch(e=>{console.error(e);process.exitCode=1;});
