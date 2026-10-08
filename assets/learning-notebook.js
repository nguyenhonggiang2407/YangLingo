(() => {
  'use strict';
  const kinds = {word:'Từ vựng',phrase:'Cụm & câu',grammar:'Ngữ pháp',listening:'Nghe',other:'Ghi chú khác'};
  const guides = [
    {id:'small-session',title:'Một buổi học nhỏ, có dùng từ',category:'Cách học',text:'Bắt đầu với vài thẻ đến hạn. Thử nhớ trước khi mở đáp án, so với ví dụ rồi tự viết một câu gần với đời sống của bạn. Nếu còn sức, chọn 5–8 từ mới trong một bài; giảm số từ khi thấy quá tải. Đây là gợi ý cách dùng YangLingo, bạn có thể điều chỉnh.',steps:['Ôn từ đến hạn trong Ôn tập.','Nhớ từ hoặc gõ câu trả lời trước khi xem gợi ý.','Đọc nghĩa, ví dụ và ghi chú; nghe giọng đọc nếu cần.','Thử lại từ sai trong Luyện nhớ & dùng từ.','Ghi một lỗi và một câu của mình vào sổ tay.'],question:'Bạn quên một từ. Nên xem đáp án trước hay thử nhớ trước?',answer:'Thử nhớ trước, rồi xem đáp án để sửa lỗi. Khi tự đánh giá trong Ôn tập, chọn mức phản ánh lần thử thật của bạn.',sources:[['Nghiên cứu về tự kiểm tra và học giãn cách (Dunlosky và cộng sự, 2013)','https://www.psychologicalscience.org/journals/pspi/1529100612453266/']]},
    {id:'spaced',title:'Ôn giãn cách và tự kiểm tra',category:'Cách học',text:'Tự kiểm tra và chia việc học qua nhiều lần có cơ sở nghiên cứu rộng. Trong YangLingo, quay lại thẻ đến hạn và đánh giá theo khả năng nhớ thực tế. Không cần học lại cả book mỗi ngày. Chưa có nghiên cứu đo riêng hiệu quả của YangLingo.',steps:['Trả lời trước khi lật thẻ.','Nếu phải nhờ gợi ý mới nhớ, đừng chọn mức dễ nhất.','Ngày bận, ôn một ít thẻ đến hạn; ngày khỏe mới thêm từ.'],question:'Đọc lại đáp án nhiều lần có tương đương tự nhớ được từ không?',answer:'Chưa. Che đáp án và thử gọi lại từ giúp bạn kiểm tra xem mình đã nhớ đến đâu.',sources:[['Dunlosky và cộng sự, 2013','https://www.psychologicalscience.org/journals/pspi/1529100612453266/']]},
    {id:'listen',title:'Nghe → thử viết → xem lại',category:'Cách học',text:'Chọn một bài nhỏ trong Luyện nhớ & dùng từ. Nghe trước, thử viết điều bạn nghe được, rồi đối chiếu đáp án. Giọng đọc trình duyệt khác nhau theo thiết bị; IPA là gợi ý phát âm, không phải bản chép chữ cái.',steps:['Nghe và thử trả lời khi đáp án đang ẩn.','Xem từ, nghĩa và ví dụ sau lần thử.','Ghi cụm khiến bạn nhầm vào sổ tay và đặt một câu.','Thử nghe lại cụm đó trong một lượt khác.'],question:'Bạn muốn tự kiểm tra nghe. Có nên mở chữ trước lần nghe đầu không?',answer:'Hãy thử nghe khi chữ còn ẩn. Sau đó mở đáp án để kiểm tra và học cách dùng. Đây là gợi ý thực hành trong ứng dụng.',sources:[]},
    {id:'notes',title:'Sổ tay ghi lỗi, không chỉ chép từ',category:'Cách học',text:'Mỗi ghi chú chỉ cần một điểm: từ/cụm hay quên, lỗi đã gặp, cách sửa và câu tự viết. Ghim vài điểm cần xem lại; cất ghi chú cũ vào Lưu trữ khi đã quen. Ghi chú do bạn tự viết chưa được kiểm tra đúng sai tự động.',steps:['Tiêu đề: điểm cần nhớ, ví dụ “borrow / lend”.','Ghi chú: mình nhầm gì và cách sửa.','Câu của tôi: một câu gắn với lớp học hoặc đời sống.','Đọc câu không nhìn ghi chú, rồi đối chiếu.'],question:'Một ghi chú dễ ôn lại nên chứa gì?',answer:'Một điểm cụ thể, cách sửa và một ví dụ của bạn. Tránh gom cả chương dài vào một ghi chú.',sources:[]},
    {id:'articles',title:'a / an: nghe âm đầu',category:'Ngữ pháp',text:'Với danh từ đếm được số ít, a hay an phụ thuộc âm đầu của từ ngay sau nó: a trước âm phụ âm, an trước âm nguyên âm. Đừng chỉ nhìn chữ cái đầu.',example:'We have an hour before class.',translation:'Chúng ta còn một giờ trước buổi học.',question:'Điền a hoặc an: I waited for ___ hour.',answer:'an hour. Chữ h trong hour không được phát âm, nên từ bắt đầu bằng âm nguyên âm.',sources:[['ABC Education: a và an','https://www.abc.net.au/education/learn-english/learn-english-a-and-an/7795794']]},
    {id:'uncount',title:'advice / information / equipment',category:'Ngữ pháp',text:'Trong nghĩa thông dụng, advice, information và equipment là danh từ không đếm được: dùng some, không thêm s hay dùng a/an trực tiếp. Khi cần đếm, dùng cách như a piece of advice hoặc two pieces of equipment.',example:'The tutor gave me some useful advice.',translation:'Người hướng dẫn cho tôi vài lời khuyên hữu ích.',question:'Sửa câu: She gave me two advices.',answer:'She gave me two pieces of advice. Hoặc: She gave me some advice.',sources:[['British Council: danh từ không đếm được','https://learnenglish.britishcouncil.org/free-resources/grammar/english-grammar-reference/uncount-nouns']]},
    {id:'say-tell',title:'say / tell: có người nhận không?',category:'Ngữ pháp',text:'Say something; say something to someone. Tell someone something; tell someone to do something. Một số cụm như tell the truth hay tell a story không cần nêu người nghe ngay sau tell.',example:'Mai told me to check the room number.',translation:'Mai bảo tôi kiểm tra số phòng.',question:'Chọn said hoặc told: She ___ me the answer.',answer:'told: She told me the answer. Với say, có thể viết She said the answer to me, nhưng tell me the answer tự nhiên hơn trong ngữ cảnh này.',sources:[['Oxford Learner’s Dictionaries: tell, phần cách dùng say/tell','https://www.oxfordlearnersdictionaries.com/us/definition/english/tell']]},
    {id:'borrow-lend',title:'borrow / lend: ai nhận, ai cho?',category:'Ngữ pháp',text:'Borrow là nhận để dùng tạm: borrow something from someone. Lend là cho người khác dùng tạm: lend someone something hoặc lend something to someone. Quá khứ của lend là lent.',example:'Can I borrow your ruler? — Yes, I can lend it to you.',translation:'Mình mượn thước của bạn được không? — Được, mình có thể cho bạn mượn.',question:'Bạn nhận sách từ Lan để dùng tạm. Điền: I ___ a book from Lan.',answer:'borrowed: I borrowed a book from Lan. Lan lent me a book diễn tả cùng việc từ phía người cho mượn.',sources:[['Oxford Learner’s Dictionaries: lend và phân biệt borrow/lend','https://www.oxfordlearnersdictionaries.com/definition/english/lend']]}
  ];
  function normalizeGuideSearch(value){
    return String(value??'').toLocaleLowerCase('vi').normalize('NFD').replace(/[\u0300-\u036f]/g,'').replace(/đ/g,'d').replace(/\s+/g,' ').trim();
  }
  const guideSearchIndex=guides.map(guide=>({guide,text:normalizeGuideSearch([guide.title,guide.text,guide.category,...(guide.steps||[]),...(guide.example?[guide.example,guide.translation||'']:[]),guide.question||''].join(' '))}));
  let generation = 0, timer = null, pendingCardDraft = null;
  function clip(value,max){let out='';for(const char of value){if(out.length+char.length>max)break;out+=char;}return out;}
  function cardDraft(card){
    if(!card||typeof card!=='object'||Array.isArray(card)||typeof card.term!=='string'||!card.term.trim())return null;
    const text=value=>typeof value==='string'?value.trim():'';
    const parts=[['Thẻ',card.term],['IPA',card.ipa],['Nghĩa',card.definition],['Lưu ý cách dùng',card.explanation],['Ví dụ Anh',card.example_en],['Bản dịch',card.example_vi]].filter(([,value])=>text(value)).map(([label,value])=>label+': '+text(value));
    const type=card.card_type||'VOCABULARY',kind=type==='GRAMMAR'?'grammar':['LISTENING','LISTENING_CHUNK'].includes(type)?'listening':['COLLOCATION','SENTENCE_PATTERN'].includes(type)?'phrase':type==='VOCABULARY'?'word':'other';
    return {title:clip(text(card.term),160),body:clip(parts.join('\n'),2000),own_sentence:'',kind,is_pinned:0};
  }
  function fromCard(card){
    const core=window.YLCore,owner=String(core?.state.user?.id||''),draft=cardDraft(card);
    if(!owner||!draft)return false;
    pendingCardDraft={owner,draft};core.navigate('notebook');return true;
  }
  function dispose(){
    generation++; clearTimeout(timer); timer=null;
    if(pendingCardDraft&&(location.hash!=='#notebook'||pendingCardDraft.owner!==String(window.YLCore?.state.user?.id||'')))pendingCardDraft=null;
  }
  function active(token){return token===generation && window.YLCore.state.user && location.hash.split('/')[0]==='#notebook';}
  async function view(){
    dispose(); const token=generation, core=window.YLCore, {esc,api,setView,toast}=core;
    const owner=String(core.state.user.id),viewRoute=location.hash, stillHere=()=>active(token)&&location.hash===viewRoute&&String(core.state.user?.id)===owner;
    const isGuide=core.routeArg()==='guide';
    const draft=!isGuide&&pendingCardDraft?.owner===owner?pendingCardDraft.draft:null;pendingCardDraft=null;
    setView(`<div class="notebook-page"><div class="page-head"><div><span class="eyebrow">NHỚ MỘT ĐIỂM, DÙNG MỘT CÂU</span><h1>Sổ tay & cách học</h1><p>Ghi điều bạn hay quên và thử dùng trong câu của mình.</p></div><a class="btn soft" href="#practice">Luyện một bài nhỏ →</a></div><nav class="notebook-tabs" aria-label="Sổ tay và hướng dẫn"><a class="btn ${isGuide?'soft':'primary'}" href="#notebook" ${isGuide?'':'aria-current="page"'}>Sổ tay của tôi</a><a class="btn ${isGuide?'primary':'soft'}" href="#notebook/guide" ${isGuide?'aria-current="page"':''}>Cách học & tra nhanh</a></nav><div id="notebook-content"></div></div>`);
    const root=document.querySelector('#notebook-content');
    if(isGuide){
      root.innerHTML=`<label class="field notebook-guide-search">Tìm cách học hoặc ngữ pháp<input id="guide-search" type="search" maxlength="160" placeholder="Ví dụ: nghe, advice, borrow..."></label><p class="practice-note">Bạn có thể tìm bằng tiếng Việt không dấu. Các ví dụ dưới đây được biên soạn cho YangLingo. Nguồn tham khảo nằm ở từng mục.</p><div id="guide-results"></div>`;
      const draw=()=>{
        const q=normalizeGuideSearch(document.querySelector('#guide-search').value);
        const matches=guideSearchIndex.filter(x=>x.text.includes(q)).map(x=>x.guide);
        document.querySelector('#guide-results').innerHTML=`<p class="practice-note" role="status">${matches.length} mục phù hợp</p><div class="notebook-guide-grid">${matches.map(g=>`<article class="notebook-guide"><span class="eyebrow">${esc(g.category)}</span><h2>${esc(g.title)}</h2><p>${esc(g.text)}</p>${g.steps?`<ol>${g.steps.map(s=>`<li>${esc(s)}</li>`).join('')}</ol>`:''}${g.example?`<div class="notebook-example"><b lang="en">${esc(g.example)}</b><p>${esc(g.translation)}</p></div>`:''}<div class="notebook-check"><h3>Tự kiểm tra</h3><p>${esc(g.question)}</p><button class="btn tiny soft" data-answer="${g.id}" aria-expanded="false" aria-controls="answer-${g.id}">Xem cách trả lời</button><p id="answer-${g.id}" hidden></p></div>${g.sources.length?`<p class="notebook-sources">Tham khảo: ${g.sources.map(([label,url])=>`<a href="${esc(url)}" target="_blank" rel="noopener noreferrer">${esc(label)} ↗</a>`).join(' · ')}</p>`:''}</article>`).join('')}</div>${matches.length?'':'<div class="panel"><p>Chưa có mục phù hợp. Thử từ khóa khác.</p></div>'}`;
        root.querySelectorAll('[data-answer]').forEach(b=>b.onclick=()=>{const g=guides.find(x=>x.id===b.dataset.answer),p=document.getElementById('answer-'+g.id),show=b.getAttribute('aria-expanded')==='false';p.textContent=show?g.answer:'';p.hidden=!show;b.setAttribute('aria-expanded',String(show));b.textContent=show?'Ẩn cách trả lời':'Xem cách trả lời';});
      };
      document.querySelector('#guide-search').oninput=draw;draw();return;
    }
    let q='',kind='',archived=0,page=1,request=0;
    root.innerHTML=`<div class="notebook-intro panel"><div><h2>Một lỗi nhỏ. Một câu dễ nhớ.</h2><p>Ghi chú riêng của tài khoản bạn, tối đa 500 mục kể cả lưu trữ. Lưu văn bản ngắn để dễ ôn.</p></div><button class="btn primary" id="note-new">＋ Ghi chú mới</button></div><div class="notebook-toolbar"><label class="field">Tìm ghi chú<input id="note-search" type="search" maxlength="160" placeholder="Từ, lỗi hoặc câu của tôi..."></label><label class="field">Loại<select id="note-kind"><option value="">Tất cả</option>${Object.entries(kinds).map(([k,v])=>`<option value="${k}">${v}</option>`).join('')}</select></label><label class="field">Hiển thị<select id="note-archive"><option value="0">Đang dùng</option><option value="1">Đã lưu trữ</option></select></label></div><div id="note-editor"></div><div id="note-results" aria-busy="false"></div>`;
    const results=root.querySelector('#note-results');
    async function load(){
      const current=++request;results.setAttribute('aria-busy','true');
      try{
        const data=await api('notebook_notes',{query:{q,kind,archived,page}});
        if(!stillHere()||current!==request)return;
        page=Number(data.page||1);
        results.innerHTML=`<p class="practice-note" role="status">${core.fmt(data.total)} kết quả · ${core.fmt(data.saved_count)} / ${core.fmt(data.max_notes)} ghi chú đã lưu</p>${data.notes.length?`<div class="notebook-note-grid">${data.notes.map(n=>`<article class="notebook-note"><div class="notebook-note-head"><span class="eyebrow">${esc(kinds[n.kind]||kinds.other)}</span>${Number(n.is_pinned)?'<span class="notebook-pin">Đã ghim</span>':''}</div><h2>${esc(n.title)}</h2><p class="notebook-text">${esc(n.body)}</p>${n.own_sentence?`<div class="notebook-example"><small>CÂU CỦA TÔI</small><p class="notebook-text">${esc(n.own_sentence)}</p></div>`:''}<div class="notebook-actions"><button class="btn tiny soft" data-edit-note="${n.id}" aria-label="Sửa ${esc(n.title)}">Sửa</button><button class="btn tiny ghost" data-pin-note="${n.id}" aria-pressed="${!!Number(n.is_pinned)}">${Number(n.is_pinned)?'Bỏ ghim':'Ghim'}</button><button class="btn tiny ghost" data-archive-note="${n.id}">${archived?'Khôi phục':'Lưu trữ'}</button></div></article>`).join('')}</div>`:`<div class="panel notebook-empty"><h2>${q||kind?'Chưa tìm thấy ghi chú phù hợp':archived?'Chưa có ghi chú lưu trữ':'Bắt đầu từ một điều hay quên'}</h2><p>${q||kind?'Thử đổi từ khóa hoặc loại ghi chú.':archived?'Ghi chú đã lưu trữ sẽ xuất hiện ở đây.':'Ví dụ: borrow / lend; cách dùng some advice; một câu nghe chưa rõ.'}</p>${archived?'':'<button class="btn soft" id="note-empty-new">Viết ghi chú đầu tiên</button>'}</div>`}<div class="notebook-pager"><button class="btn tiny soft" id="notes-prev" ${page<=1?'disabled':''}>← Trước</button><span>Trang ${core.fmt(page)} / ${core.fmt(data.pages)}</span><button class="btn tiny soft" id="notes-next" ${page>=Number(data.pages)?'disabled':''}>Sau →</button></div>`;
        results.querySelector('#notes-prev').onclick=()=>{page--;load();};results.querySelector('#notes-next').onclick=()=>{page++;load();};
        results.querySelector('#note-empty-new')?.addEventListener('click',()=>edit());
        results.querySelectorAll('[data-edit-note]').forEach(b=>b.onclick=()=>edit(data.notes.find(n=>String(n.id)===b.dataset.editNote)));
        results.querySelectorAll('[data-pin-note]').forEach(b=>b.onclick=()=>mutate(b,'notebook_pin',{id:b.dataset.pinNote,pinned:Number(data.notes.find(n=>String(n.id)===b.dataset.pinNote).is_pinned)?0:1}));
        results.querySelectorAll('[data-archive-note]').forEach(b=>b.onclick=()=>mutate(b,'notebook_archive',{id:b.dataset.archiveNote,archived:archived?0:1}));
      }catch(e){if(stillHere()&&current===request){results.innerHTML=`<div class="panel"><h2>Chưa tải được sổ tay</h2><p>${esc(e.message)}</p><button class="btn soft" id="notes-retry">Thử lại</button></div>`;results.querySelector('#notes-retry').onclick=load;}}
      finally{if(stillHere()&&current===request)results.setAttribute('aria-busy','false');}
    }
    async function mutate(button,action,data){if(!stillHere()||!button.isConnected)return;button.disabled=true;try{await api(action,{method:'POST',data,canRetry:()=>stillHere()&&button.isConnected});if(stillHere()){toast('Đã cập nhật ghi chú.');await load();}}catch(e){if(stillHere())toast(e.message,'error');}finally{if(button.isConnected)button.disabled=false;}}
    function edit(note=null,seed=null){
      if(!stillHere())return;
      const editor=root.querySelector('#note-editor');
      const values=note||seed;
      editor.innerHTML=`<section class="panel notebook-editor"><h2>${note?'Sửa ghi chú':seed?'Viết câu với thẻ này':'Ghi một điểm cần nhớ'}</h2>${seed?'<p class="practice-note">Nội dung thẻ là gợi ý. Thêm câu của bạn rồi nhấn Lưu ghi chú. Hủy hoặc rời trang sẽ bỏ bản nháp chưa lưu.</p>':''}<form id="note-form" class="form-stack"><label class="field">Tiêu đề<input name="title" maxlength="160" value="${esc(values?.title||'')}" required placeholder="Ví dụ: borrow / lend"></label><label class="field">Loại<select name="kind">${Object.entries(kinds).map(([k,v])=>`<option value="${k}" ${values?.kind===k?'selected':''}>${v}</option>`).join('')}</select></label><label class="field">Điều cần nhớ<textarea name="body" maxlength="2500" rows="4" required placeholder="Mình nhầm gì? Cách dùng đúng là gì?">${esc(values?.body||'')}</textarea></label><label class="field">Câu của tôi <span class="practice-note">(tùy chọn)</span><textarea name="own_sentence" maxlength="500" rows="2" placeholder="Một câu gắn với việc học hoặc đời sống của bạn">${esc(values?.own_sentence||'')}</textarea></label><label class="notebook-checkbox"><input type="checkbox" name="is_pinned" ${Number(values?.is_pinned)?'checked':''}> Ghim để xem trước</label><p class="practice-note">Câu tự viết chưa được chấm đúng sai tự động.</p><p id="note-error" role="alert" hidden></p><div class="notebook-actions"><button type="submit" class="btn primary">Lưu ghi chú</button><button type="button" class="btn ghost" id="note-cancel">${seed?'Hủy nháp':'Hủy'}</button></div></form></section>`;
      const form=editor.querySelector('#note-form'),cancel=editor.querySelector('#note-cancel');
      const stillEditing=()=>stillHere()&&form.isConnected&&editor.querySelector('#note-form')===form;
      if(seed)editor.scrollIntoView({block:'start'});
      (seed?form.elements.own_sentence:form.elements.title).focus();
      cancel.onclick=()=>{if(!stillEditing()||cancel.disabled)return;editor.innerHTML='';root.querySelector('#note-new').focus();};
      form.onsubmit=async e=>{
        e.preventDefault();if(!stillEditing()||!form.reportValidity())return;
        const submit=form.querySelector('[type="submit"]'),error=form.querySelector('#note-error');if(submit.disabled)return;submit.disabled=true;error.hidden=true;
        const data={title:form.elements.title.value.trim(),body:form.elements.body.value.trim(),own_sentence:form.elements.own_sentence.value.trim(),kind:form.elements.kind.value,is_pinned:form.elements.is_pinned.checked?1:0};if(note)data.id=note.id;
        const invalid=!data.title?'title':!data.body?'body':[...data.title].length>160?'title':[...data.body].length>2500?'body':[...data.own_sentence].length>500?'own_sentence':null;
        if(invalid){error.textContent='Hãy điền tiêu đề và điều cần nhớ, giữ nội dung trong giới hạn của từng ô.';error.hidden=false;form.elements[invalid].focus();submit.disabled=false;return;}
        cancel.disabled=true;
        try{await api('notebook_save',{method:'POST',data,canRetry:stillEditing});if(!stillEditing())return;editor.innerHTML='';toast('Đã lưu vào sổ tay của bạn.');await load();if(stillHere()&&!editor.querySelector('#note-form'))root.querySelector('#note-new').focus();}
        catch(err){if(stillEditing()){error.textContent=err.message;error.hidden=false;error.scrollIntoView({block:'nearest'});}}
        finally{if(submit.isConnected)submit.disabled=false;if(cancel.isConnected)cancel.disabled=false;}
      };
    }
    root.querySelector('#note-new').onclick=()=>edit();
    root.querySelector('#note-search').oninput=e=>{q=e.target.value.trim();page=1;clearTimeout(timer);++request;timer=setTimeout(load,250);};
    root.querySelector('#note-kind').onchange=e=>{kind=e.target.value;page=1;clearTimeout(timer);load();};
    root.querySelector('#note-archive').onchange=e=>{archived=Number(e.target.value);page=1;clearTimeout(timer);load();};
    if(draft)edit(null,draft);
    await load();
  }
  window.YLNotebook={view,dispose,fromCard};
})();
