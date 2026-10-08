'use strict';
// Execute the real notebook module and card modal in a minimal DOM, never a live account.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
const notebook=fs.readFileSync(path.join(__dirname,'../assets/learning-notebook.js'),'utf8');
const app=fs.readFileSync(path.join(__dirname,'../assets/app.js'),'utf8');
const pronunciation=require('../assets/pronunciation.js');
let checks=0;
const check=(value,message)=>{assert.ok(value,message);checks++;};
const decode=s=>s.replace(/&quot;/g,'"').replace(/&#39;/g,"'").replace(/&lt;/g,'<').replace(/&gt;/g,'>').replace(/&amp;/g,'&');
const escape=s=>String(s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const tick=()=>new Promise(resolve=>setImmediate(resolve));
const card={id:17,set_id:9,term:'awake',definition:'thức giấc',ipa:'US /əˈweɪk/',part_of_speech:'verb',card_type:'VOCABULARY',example_en:'I awoke before my alarm rang.',example_vi:'Tôi thức giấc trước khi chuông báo thức reo.',explanation:'Awoke là V2; awoken là V3.',pattern:'awake → awoke → awoken',audio_text:'awake. awoke. awoken.'};
function environment(notes=[]){
  const events=[],observers=new Set();let document;
  class Element{
    constructor(tag,attrs={}){this.tag=tag;this.attrs=attrs;this.children=[];this.parent=null;this._html='';this._text='';this.value=attrs.value||'';this.checked='checked'in attrs;this.disabled='disabled'in attrs;this.hidden='hidden'in attrs;this.isConnected=true;this.inert=false;this.dataset={};this.style={};for(const[k,v]of Object.entries(attrs))if(k.startsWith('data-'))this.dataset[k.slice(5).replace(/-([a-z])/g,(_,c)=>c.toUpperCase())]=v;this.classList={add:value=>this.attrs.class=(this.attrs.class||'')+' '+value};}
    descendants(){return this.children.flatMap(child=>[child,...child.descendants()]);}
    disconnect(){this.isConnected=false;this.children.forEach(child=>child.disconnect());}
    set innerHTML(value){this.children.forEach(child=>child.disconnect());this.children=[];this._text='';this._html=value;const stack=[this];
      for(const m of value.matchAll(/<\/?([a-z][\w-]*)\b([^>]*?)>|([^<]+)/gi)){
        if(m[3]){stack.at(-1)._text+=decode(m[3]);continue;}
        if(m[0][1]==='/'){while(stack.length>1&&stack.at(-1).tag!==m[1].toLowerCase())stack.pop();if(stack.length>1)stack.pop();continue;}
        const attrs={};for(const a of m[2].matchAll(/([\w-]+)(?:="([^"]*)")?/g))attrs[a[1]]=decode(a[2]||'');
        const child=new Element(m[1].toLowerCase(),attrs);child.parent=stack.at(-1);child.parent.children.push(child);
        if(!['input','br','hr','img','meta','link'].includes(child.tag))stack.push(child);
      }
      for(const n of this.descendants()){if(n.tag==='textarea')n.value=n.textContent;if(n.tag==='select'){const options=n.descendants().filter(c=>c.tag==='option');n.value=(options.find(c=>'selected'in c.attrs)||options[0])?.attrs.value||'';}}
      for(const observer of observers)if(observer.target===this)queueMicrotask(()=>{if(observers.has(observer))observer.fn();});
    }
    get innerHTML(){return this._html;}
    get textContent(){return this._text+this.children.map(c=>c.textContent).join('');}
    set textContent(value){this.children.forEach(c=>c.disconnect());this.children=[];this._text=String(value);this._html='';}
    setAttribute(key,value){this.attrs[key]=String(value);}
    getAttribute(key){return this.attrs[key]??null;}
    matches(selector){return selector.split(',').some(part=>{part=part.trim();if(part==='button:not([disabled])')return this.tag==='button'&&!this.disabled;const tag=part.match(/^[\w-]+/)?.[0];if(tag&&tag!==this.tag)return false;const id=part.match(/#([\w-]+)/)?.[1];if(id&&this.attrs.id!==id)return false;const cls=part.match(/\.([\w-]+)/)?.[1];if(cls&&!(this.attrs.class||'').split(' ').includes(cls))return false;for(const a of part.matchAll(/\[([\w-]+)(?:="([^"]*)")?\]/g))if(!(a[1]in this.attrs)||a[2]!==undefined&&this.attrs[a[1]]!==a[2])return false;return true;});}
    querySelector(selector){return this.descendants().find(n=>n.matches(selector))||null;}
    querySelectorAll(selector){return this.descendants().filter(n=>n.matches(selector));}
    get elements(){return Object.fromEntries(this.descendants().filter(n=>n.attrs.name).map(n=>[n.attrs.name,n]));}
    reportValidity(){return this.descendants().every(n=>!('required'in n.attrs)||!!n.value);}
    addEventListener(name,fn){this['on'+name]=fn;}
    focus(){document.activeElement=this;events.push({event:'focus',node:this});}
    scrollIntoView(){events.push({event:'scroll',node:this});}
  }
  const view=new Element('main',{id:'view'}),modal=new Element('div',{id:'modal-root'}),shell=new Element('div',{id:'app'}),opener=new Element('button');
  document={body:{style:{overflow:'auto'}},activeElement:opener,querySelector:selector=>selector==='#modal-root'?modal:selector==='#app'?shell:view.querySelector(selector),querySelectorAll:selector=>view.querySelectorAll(selector),getElementById:id=>view.querySelector('#'+id)};
  const calls=[],navigation=[],toasts=[],listeners=new Map(),location={hash:'#sets/9'},state={user:{id:7},csrf:'fictional-csrf'};
  const response=()=>({notes,total:notes.length,saved_count:notes.length,max_notes:500,page:1,pages:1});
  let handler=async(action,options)=>action==='notebook_notes'?response():{id:88};
  const core={state,esc:escape,fmt:String,setView:html=>view.innerHTML=html,toast:(...args)=>toasts.push(args),routeArg:()=>location.hash.split('/')[1]||'',navigate:target=>{navigation.push(target);location.hash='#'+target;},api:async(action,options={})=>{calls.push({action,options});assert.ok(['notebook_notes','notebook_save','notebook_pin','notebook_archive'].includes(action),'no SRS or other API action');return handler(action,options);}};
  const window={YLCore:core,YLPronunciation:pronunciation,speechSynthesis:{cancel(){}},addEventListener(name,fn){if(!listeners.has(name))listeners.set(name,new Set());listeners.get(name).add(fn);},removeEventListener(name,fn){listeners.get(name)?.delete(fn);}};
  const sandbox={window,document,location,state,toast:core.toast,navigate:core.navigate,MutationObserver:class{constructor(fn){this.fn=fn;}observe(target){this.target=target;observers.add(this);}disconnect(){observers.delete(this);}},requestAnimationFrame:fn=>fn(),setTimeout,clearTimeout,speak(){},localStorage:{setItem(){throw Error('no implicit persistence');}},sessionStorage:{setItem(){throw Error('no progress write');}}};
  vm.createContext(sandbox);vm.runInContext(notebook,sandbox);
  const lines=name=>app.split('\n').find(line=>line.startsWith('function '+name+'('));
  vm.runInContext('const $=(s,r=document)=>r.querySelector(s),$$=(s,r=document)=>r.querySelectorAll(s);\n'+[lines('esc'),lines('cardTypeLabel'),lines('ipaHtml')].join('\n')+'\n'+app.slice(app.indexOf('function modal('),app.indexOf('async function refreshSecurityToken('))+'\n'+app.slice(app.indexOf('function cardDetailHtml('),app.indexOf('async function setDetail(')),sandbox);
  return{module:window.YLNotebook,window,sandbox,document,state,location,view,modal,shell,opener,calls,navigation,toasts,events,response,setHandler:fn=>handler=fn,form:()=>view.querySelector('#note-form'),editor:()=>view.querySelector('#note-editor'),posts:()=>calls.filter(c=>c.options.method==='POST')};
}
const submit=form=>form.onsubmit({preventDefault(){}});
async function open(env,input=card){check(env.module.fromCard(input),'owned card opens draft');env.module.dispose();await env.module.view();return env.form();}
async function draftFlow(){
  const env=environment(),original=JSON.stringify(card);const form=await open(env);
  check(form.elements.title.value==='awake'&&form.elements.body.value.includes(card.example_en)&&form.elements.body.value.includes(card.example_vi),'title and short bilingual reference prefilled');
  check(form.elements.own_sentence.value===''&&form.elements.kind.value==='word','sentence starts empty and vocabulary kind retained');
  check(env.document.activeElement===form.elements.own_sentence,'explicit card action focuses own sentence');
  check(env.events.findIndex(e=>e.event==='scroll')<env.events.findIndex(e=>e.node===form.elements.own_sentence&&e.event==='focus'),'scroll precedes sentence focus');
  check(env.posts().length===0&&JSON.stringify(card)===original,'opening reads only and never mutates original card');
  env.view.querySelector('#note-cancel').onclick();check(!env.form()&&env.posts().length===0,'cancel discards without saving');
  check(env.document.activeElement===env.view.querySelector('#note-new'),'cancel returns focus to new-note button');
  await env.module.view();check(!env.form(),'one-use draft is not replayed after notebook reentry');
  const left=environment();left.module.fromCard(card);left.location.hash='#dashboard';left.module.dispose();left.location.hash='#notebook';await left.module.view();check(!left.form()&&left.posts().length===0,'leaving route discards queued draft');
  const changed=environment();changed.module.fromCard(card);changed.state.user={id:8};changed.module.dispose();await changed.module.view();check(!changed.form()&&changed.posts().length===0,'queued draft does not cross accounts');
  for(const[type,kind]of Object.entries({VOCABULARY:'word',COLLOCATION:'phrase',SENTENCE_PATTERN:'phrase',GRAMMAR:'grammar',LISTENING:'listening',LISTENING_CHUNK:'listening',UNKNOWN:'other'})){const e=environment();const f=await open(e,{...card,card_type:type});check(f.elements.kind.value===kind,'genre maps to existing notebook kind '+type);}
  for(const invalid of [null,{},[],{term:' '},{term:42}]){const e=environment();check(e.module.fromCard(invalid)===false&&e.calls.length===0&&e.navigation.length===0,'invalid card rejected without side effects');}
  const anon=environment();anon.state.user=null;check(anon.module.fromCard(card)===false&&anon.calls.length===0,'anonymous card action denied');
}
async function escapingAndLimits(){
  const attack='</textarea><img src=x onerror="bad()"><script>bad()</script> & \' "';const env=environment(),f=await open(env,{...card,term:attack,definition:attack,example_en:attack,example_vi:attack});
  check(f.elements.title.value===attack&&f.elements.body.value.includes(attack),'escaped fields preserve learner text literally');
  check(!env.view.querySelector('img')&&!env.view.querySelector('script'),'card text cannot inject DOM elements');
  const long=environment(),g=await open(long,{...card,term:'😀'.repeat(200),definition:'長'.repeat(4000),example_en:'X'.repeat(5000)});
  check(g.elements.title.value.length<=160&&g.elements.body.value.length<=2000,'draft fits existing title/body limits with room for edits');
  check(!/[\uD800-\uDBFF]$/.test(g.elements.title.value)&&!/[\uD800-\uDBFF]$/.test(g.elements.body.value),'clipping does not split surrogate pairs');
  for(const[field,value]of [['title','   '],['body','\n '],['title','x'.repeat(161)],['body','x'.repeat(2501)],['own_sentence','x'.repeat(501)]]){const e=environment(),form=await open(e);form.elements[field].value=value;await submit(form);check(e.posts().length===0&&!form.querySelector('#note-error').hidden,'empty or oversized '+field+' blocked before POST');}
}
async function intentionalSaveAndStale(){
  const env=environment(),f=await open(env);f.elements.own_sentence.value='  I awoke early for class.  ';await submit(f);
  const write=env.posts()[0];check(env.posts().length===1&&write.action==='notebook_save','only intentional save creates a note');
  check(write.options.data.own_sentence==='I awoke early for class.'&&write.options.data.title==='awake'&&!('id'in write.options.data)&&!('owner_id'in write.options.data),'new note stores trimmed sentence without card ID or incoming owner');
  check(typeof write.options.canRetry==='function'&&!env.form(),'save is retry-guarded and clears only its own successful editor');
  for(const change of ['owner','route','sibling route','dispose','replacement']){const e=environment(),form=await open(e);if(change==='owner')e.state.user={id:8};if(change==='route')e.location.hash='#dashboard';if(change==='sibling route')e.location.hash='#notebook/guide';if(change==='dispose')e.module.dispose();if(change==='replacement')e.view.querySelector('#note-new').onclick();await submit(form);check(e.posts().length===0,'stale '+change+' form cannot POST');}
  const retry=environment(),retryform=await open(retry);let retried;retry.setHandler(action=>action==='notebook_save'?new Promise(resolve=>retried=resolve):retry.response());const req=submit(retryform),predicate=retry.posts()[0].options.canRetry;check(predicate(),'actual editor retry predicate accepts current owner/form');retry.location.hash='#notebook/guide';check(!predicate(),'actual editor retry predicate rejects sibling route before disposal');retry.location.hash='#notebook';retry.state.user={id:8};check(!predicate(),'actual editor retry predicate rejects refreshed new owner');retry.state.user={id:7};retry.view.querySelector('#note-new').onclick();check(!predicate(),'actual editor retry predicate rejects replaced form');retried({id:99});await req;
  const pending=environment(),p=await open(pending);let finish;pending.setHandler((action)=>action==='notebook_save'?new Promise(r=>finish=r):pending.response());const first=submit(p);await submit(p);check(pending.posts().length===1&&p.querySelector('#note-cancel').disabled,'double submit blocked and cancel disabled during save');finish({id:99});await first;
  const replacement=environment(),r=await open(replacement);let saved;replacement.setHandler(action=>action==='notebook_save'?new Promise(resolve=>saved=resolve):replacement.response());const waiting=submit(r);replacement.view.querySelector('#note-new').onclick();const newer=replacement.form();newer.elements.title.value='New unsaved draft';saved({id:99});await waiting;check(replacement.form()===newer&&newer.elements.title.value==='New unsaved draft','old save completion cannot erase a newer editor');
  const refresh=environment(),s=await open(refresh);let reload;refresh.setHandler(action=>action==='notebook_notes'?new Promise(resolve=>reload=resolve):{id:99});const saving=submit(s);await tick();refresh.view.querySelector('#note-new').onclick();const fresh=refresh.form(),focused=refresh.document.activeElement;reload(refresh.response());await saving;check(refresh.form()===fresh&&refresh.document.activeElement===focused,'save refresh cannot steal focus from a newly opened editor');
  const failed=environment(),errform=await open(failed);failed.setHandler(async action=>{if(action==='notebook_save')throw Error('<img src=x onerror="bad()">');return failed.response();});await submit(errform);check(failed.form()===errform&&!errform.querySelector('#note-error').hidden&&!failed.view.querySelector('img'),'save error is literal text and leaves draft available');
  const getError=environment();getError.setHandler(async action=>{if(action==='notebook_notes')throw Error('Fictional offline failure');return{id:99};});await open(getError);check(!!getError.form()&&getError.posts().length===0,'failed list GET does not drop prefilling or implicitly save');
}
async function mutationsAndIntegration(){
  const notes=[{id:88,title:'Fictional note',body:'Use awake in a sentence.',own_sentence:'',kind:'word',is_pinned:0}];
  for(const action of ['pin','archive']){const e=environment(notes);e.location.hash='#notebook';await e.module.view();const b=e.view.querySelector('[data-'+action+'-note]');e.state.user={id:8};await b.onclick();check(e.posts().length===0,'stale owner cannot '+action+' note');}
  const same=environment(notes);same.location.hash='#notebook';await same.module.view();const b=same.view.querySelector('[data-pin-note]');await b.onclick();const guard=same.posts()[0].options.canRetry;check(typeof guard==='function'&&!guard(),'mutation retry guard rejects detached old button after reload');
  const e=environment();e.sandbox.cardDetailsModal(card,e.opener);e.modal.querySelector('#card-detail-write-sentence').onclick();check(!e.modal.innerHTML&&!e.shell.inert&&e.location.hash==='#notebook'&&e.posts().length===0,'actual detail action closes cleanly and queues draft only');await e.module.view();check(e.form().elements.title.value==='awake'&&e.form().elements.own_sentence.value==='','actual modal/module integration prefills existing composer');
  const stale=environment();stale.sandbox.cardDetailsModal(card,stale.opener);stale.state.user={id:8};stale.modal.querySelector('#card-detail-write-sentence').onclick();check(!stale.modal.innerHTML&&stale.navigation.length===0&&stale.posts().length===0,'stale card modal cannot hand content to another owner');
  const plain=environment();plain.sandbox.cardDetailsModal(card,plain.opener);plain.modal.querySelector('#card-detail-notebook').onclick();await plain.module.view();check(!plain.form()&&plain.posts().length===0,'existing Mở sổ tay still opens no composer and creates nothing');
}
(async()=>{await draftFlow();await escapingAndLimits();await intentionalSaveAndStale();await mutationsAndIntegration();console.log(`PASS: ${checks} real-module card/notebook behavior checks (draft, escaping, validation, ownership, disposal, form races, focus and intentional saves).`);})().catch(error=>{console.error(error);process.exitCode=1;});
