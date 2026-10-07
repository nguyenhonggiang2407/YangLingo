'use strict';
// Delayed network responses must not replace a newer page, including error pages.
const assert=require('node:assert/strict'),fs=require('node:fs'),vm=require('node:vm'),path=require('node:path');
const source=fs.readFileSync(path.join(__dirname,'../assets/app.js'),'utf8');
const routing=source.slice(source.indexOf('let routeGeneration=0;'),source.indexOf('async function dashboard(){'));
const dashboard=source.slice(source.indexOf('async function dashboard(){'),source.indexOf('function stat('));
let route='dashboard',html='',resolve,reject;
const sandbox={state:{user:{id:7}},window:{YLPractice:{dispose(){}},YLNotebook:{dispose(){},async view(){html='My private notebook';}}},routeName:()=>route,routeArg:()=>'',setHeader(){},setView(markup){html=markup;},loading:()=> 'Loading',esc:String,api:()=>new Promise((yes,no)=>{resolve=yes;reject=no;})};
vm.createContext(sandbox);vm.runInContext(routing+'\n'+dashboard,sandbox);
(async()=>{
  const previous=sandbox.renderRoute();route='notebook';await sandbox.renderRoute();
  resolve({});await previous;assert.equal(html,'My private notebook','a delayed dashboard does not overwrite a new notebook');
  route='dashboard';const failing=sandbox.renderRoute();route='notebook';await sandbox.renderRoute();
  reject(new Error('Old request failed'));await failing;assert.equal(html,'My private notebook','an old error cannot overwrite the current page');
  route='dashboard';const leaving=sandbox.renderRoute();sandbox.state.user=null;resolve({});await leaving;
  assert.equal(html,'Loading','a late dashboard does not render private content after sign-out');
  console.log('PASS: delayed dashboard success/error and signed-out responses cannot replace the current page');
})().catch(e=>{console.error(e);process.exitCode=1;});
