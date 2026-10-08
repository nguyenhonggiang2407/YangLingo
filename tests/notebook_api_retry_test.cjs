'use strict';
// Actual api/refreshSecurityToken fetch flow; every credential/user is fictional.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
const source=fs.readFileSync(path.join(__dirname,'../assets/app.js'),'utf8');
const api=source.slice(source.indexOf('async function refreshSecurityToken('),source.indexOf('function initials('));
let checks=0;
function env({newOwner=7,leaveDuringRefresh=false,replaceDuringRefresh=false,failRetry=false}={}){
  const calls=[],state={user:{id:7},csrf:'fictional-old'},window={},location={hash:'#notebook'};let posted=0,checked=0,currentForm=true;
  const sandbox={state,window,FormData:class{},fetch:async(url,options)=>{calls.push({url,options});if(options.method==='GET')return{status:200,ok:true,json:async()=>{if(leaveDuringRefresh)location.hash='#dashboard';if(replaceDuringRefresh)currentForm=false;return{ok:true,data:{csrf:'fictional-new',user:{id:newOwner}}};}};posted++;return posted===1||failRetry?{status:419,ok:false,json:async()=>({ok:false,message:'Fictional expired token'})}:{status:200,ok:true,json:async()=>({ok:true,data:{id:88}})};}};
  vm.createContext(sandbox);vm.runInContext(api,sandbox);
  return{sandbox,calls,state,guard:()=>{checked++;assert.equal(state.csrf,'fictional-new','guard must run after refresh');return String(state.user?.id)==='7'&&location.hash==='#notebook'&&currentForm;},get posted(){return posted;},get checked(){return checked;}};
}
(async()=>{
  const changed=env({newOwner:8});await assert.rejects(changed.sandbox.api('notebook_save',{method:'POST',data:{title:'awake',body:'Fictional body'},canRetry:changed.guard}),/expired token/);assert.equal(changed.posted,1);assert.equal(changed.checked,1);checks++;
  const same=env();const answer=await same.sandbox.api('notebook_save',{method:'POST',data:{title:'awake',body:'Fictional body'},query:{source:'fixture'},canRetry:same.guard});assert.equal(answer.id,88);assert.equal(same.posted,2);assert.equal(same.checked,1);assert.equal(JSON.parse(same.calls.at(-1).options.body).csrf,'fictional-new');assert.equal(same.calls[0].url,same.calls.at(-1).url);checks++;
  for(const settings of [{leaveDuringRefresh:true},{replaceDuringRefresh:true}]){const invalid=env(settings);await assert.rejects(invalid.sandbox.api('notebook_save',{method:'POST',data:{title:'awake',body:'Fictional body'},canRetry:invalid.guard}),/expired token/);assert.equal(invalid.posted,1,'route/form change during actual bootstrap cannot retry POST');checks++;}
  const repeat=env({failRetry:true});await assert.rejects(repeat.sandbox.api('notebook_save',{method:'POST',data:{title:'awake',body:'Fictional body'},canRetry:repeat.guard}),/expired token/);assert.equal(repeat.posted,2);assert.equal(repeat.calls.filter(c=>c.options.method==='GET').length,1);checks++;
  const legacy=env({newOwner:8});await legacy.sandbox.api('ordinary_action',{method:'POST',data:{fixture:true}});assert.equal(legacy.posted,2,'default retry behavior outside guarded notebook actions is unchanged');checks++;
  console.log(`PASS: ${checks} actual API419/refresh/retry scenarios (same owner, changed owner, invalid form/route, one retry and existing defaults).`);
})().catch(error=>{console.error(error);process.exitCode=1;});
