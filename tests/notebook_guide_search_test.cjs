'use strict';
// Run the actual notebook route and input handler with no live API or test-only exports.
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path'),vm=require('node:vm');
const source=fs.readFileSync(path.join(__dirname,'../assets/learning-notebook.js'),'utf8');
const input={value:''},results={innerHTML:''},root={innerHTML:'',querySelectorAll:()=>[]};
const nodes={'#notebook-content':root,'#guide-search':input,'#guide-results':results};
const esc=value=>String(value).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
let apiCalls=0;
const window={YLCore:{state:{user:{id:7}},esc,routeArg:()=> 'guide',setView:()=>{},api:()=>{apiCalls++;throw Error('Guide lookup must not call the API');}}};
const context=vm.createContext({window,location:{hash:'#notebook/guide'},document:{querySelector:selector=>nodes[selector]},clearTimeout});
vm.runInContext(source,context);
const cases=[
  ['ON TU DEN HAN',['small-session']],
  // Existing phrase matching does not skip the intervening “từ”.
  ['ON DEN HAN',[]],
  ['  CHUNG TA   CON\tMOT\nGIO  ',['articles']],
  ['Ôn giãn cách'.normalize('NFD'),['spaced']],
  ['NGUOI HUONG DAN CHO TOI',['uncount']],
  ['I waited for ___ hour',['articles']],
  ['Mai told me to check the room number',['say-tell']],
  ['Lan lent me a book',[]],
  ['Dunlosky',[]],
  ['psychologicalscience.org',[]],
  [' ĐẾN\u00a0\u00a0HẠN ',['small-session','spaced']],
  ['   \t\n',['small-session','spaced','listen','notes','articles','uncount','say-tell','borrow-lend']],
];
(async()=>{
  await window.YLNotebook.view();
  assert.ok(root.innerHTML.includes('tiếng Việt không dấu'));
  for(const[query,expected]of cases){
    input.value=query;input.oninput();
    const actual=[...results.innerHTML.matchAll(/data-answer="([^"]+)"/g)].map(match=>match[1]);
    assert.deepEqual(actual,expected,query);
    assert.ok(results.innerHTML.includes(`${expected.length} mục phù hợp`));
  }
  input.value='borrow';input.oninput();
  assert.ok(results.innerHTML.includes('id="answer-borrow-lend" hidden'));
  assert.ok(!results.innerHTML.includes('Lan lent me a book'));
  input.value='<script>';input.oninput();
  assert.ok(!results.innerHTML.includes('<script>'));
  assert.equal(apiCalls,0);
  console.log(`PASS: ${cases.length} real-module guide queries, status counts, hidden answers, literal input and zero API calls.`);
})().catch(error=>{console.error(error);process.exitCode=1;});
