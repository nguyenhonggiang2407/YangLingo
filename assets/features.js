(() => {
  'use strict';

  const $ = (selector, root = document) => root.querySelector(selector);
  const esc = (value = '') => String(value).replace(/[&<>'"]/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[char]));
  const toast = (message, type = 'success') => {
    const node = document.createElement('div');
    node.className = 'toast ' + type;
    node.textContent = message;
    $('#toast-root')?.appendChild(node);
    setTimeout(() => node.remove(), 3200);
  };
  const navigate = hash => { location.hash = hash.startsWith('#') ? hash : '#' + hash; };
  const setHeader = (title, subtitle) => {
    const titleNode = $('#page-title'), subtitleNode = $('#page-subtitle');
    if (titleNode) titleNode.textContent = title;
    if (subtitleNode) subtitleNode.textContent = subtitle;
  };
  const setView = html => { const view = $('#view'); if (view) view.innerHTML = html; };
  const api = async (action, {method = 'GET', data = null, query = {}} = {}) => {
    let url = 'api.php?action=' + encodeURIComponent(action);
    Object.entries(query).forEach(([key, value]) => { if (value !== null && value !== undefined && value !== '') url += '&' + encodeURIComponent(key) + '=' + encodeURIComponent(value); });
    const options = {method, headers: {}};
    if (method !== 'GET') {
      if (data instanceof FormData) {
        if (!data.has('csrf')) data.append('csrf', window.__YL_CSRF__ || window.__BOOT_CSRF__ || '');
        options.body = data;
      } else {
        options.headers['Content-Type'] = 'application/json';
        options.body = JSON.stringify(Object.assign({}, data || {}, {csrf: window.__YL_CSRF__ || window.__BOOT_CSRF__ || ''}));
      }
    }
    const response = await fetch(url, options);
    let json;
    try { json = await response.json(); } catch { throw new Error('Server trả về dữ liệu không hợp lệ.'); }
    if (!response.ok || !json.ok) throw new Error(json.message || 'Có lỗi xảy ra.');
    return json.data;
  };
  const fetchJson = async (url, timeout = 12000) => {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), timeout);
    try {
      const response = await fetch(url, {headers: {Accept: 'application/json'}, signal: controller.signal});
      if (!response.ok) throw new Error('HTTP ' + response.status);
      return await response.json();
    } finally { clearTimeout(timer); }
  };
  const copyText = async text => {
    try { await navigator.clipboard.writeText(text); }
    catch {
      const area = document.createElement('textarea');
      area.value = text; document.body.appendChild(area); area.select(); document.execCommand('copy'); area.remove();
    }
    toast('Đã sao chép kết quả.');
  };
  const speak = (text, language = 'en') => {
    if (!('speechSynthesis' in window)) return toast('Trình duyệt không hỗ trợ phát âm.', 'error');
    speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = language === 'vi' ? 'vi-VN' : language === 'ja' ? 'ja-JP' : language === 'ko' ? 'ko-KR' : 'en-US';
    utterance.rate = .92;
    speechSynthesis.speak(utterance);
  };
  const googleUrl = (text, source, target) => 'https://translate.google.com/?sl=' + encodeURIComponent(source || 'auto') + '&tl=' + encodeURIComponent(target || 'vi') + '&text=' + encodeURIComponent(text || '') + '&op=translate';
  const oxfordUrl = text => 'https://www.oxfordlearnersdictionaries.com/search/english/?q=' + encodeURIComponent(text || '');
  const formatBytes = bytes => {
    if (!bytes) return '0 B';
    const units = ['B', 'KB', 'MB']; let value = bytes, index = 0;
    while (value >= 1024 && index < units.length - 1) { value /= 1024; index++; }
    return (index ? value.toFixed(1) : Math.round(value)) + ' ' + units[index];
  };
  const loadCatalog = async () => {
    const [folders, sets] = await Promise.all([api('folders'), api('sets')]);
    return {folders, sets};
  };

  async function importView() {
    setHeader('Import dữ liệu', 'TXT, DOCX, CSV hoặc XLSX.');
    const catalog = await loadCatalog();
    const folderOptions = catalog.folders.map(folder => '<option value="' + folder.id + '">' + esc(folder.icon) + ' ' + esc(folder.name) + '</option>').join('');
    const setOptions = catalog.sets.map(set => '<option value="' + set.id + '">' + esc(set.title) + '</option>').join('');
    setView('<div class="page-head"><div><h1>Import dữ liệu</h1><p>Chọn file rõ ràng, kéo-thả tùy ý, rồi nhập hàng loạt flashcard.</p></div></div><div class="import-grid"><section class="panel"><form id="extra-import-form" class="form-stack"><div class="dropzone" id="extra-dropzone" role="button" tabindex="0" aria-label="Chọn file để import"><input id="extra-import-file" name="file" type="file" accept=".txt,.docx,.csv,.xlsx"><span class="up">⇧</span><h3>Chọn hoặc thả file vào đây</h3><p>TXT · DOCX · CSV · XLSX, tối đa 10 MB</p><button class="btn soft file-picker" id="extra-choose-file" type="button">Chọn file từ máy</button><div class="file-status" aria-live="polite"><b id="extra-file-name">Chưa chọn file</b><small id="extra-file-size">Bạn có thể kéo file vào vùng này.</small></div></div><div class="form-grid"><label class="field">Thêm vào bộ có sẵn<select name="set_id"><option value="">Tạo bộ mới</option>' + setOptions + '</select></label><label class="field">Tên bộ mới<input name="title" placeholder="Tự lấy từ tên file"></label><label class="field">Folder<select name="folder_id"><option value="">Chưa phân loại</option>' + folderOptions + '</select></label><label class="field">Tối đa từ AI<input type="number" name="max_cards" value="80" min="5" max="150"></label></div><label class="switch-row"><input type="checkbox" name="ai_extract" value="1"><span><b>AI trích từ vựng từ bài đọc</b><small style="display:block;color:var(--muted)">Dùng khi DOCX/TXT là bài văn thay vì danh sách từ + nghĩa.</small></span></label><button class="btn primary large" type="submit">⇧ Import flashcard</button></form></section><aside class="panel"><h3>Importer V2 + tương thích cũ</h3><div class="format-box">term | definition | ipa | part_of_speech | example_en | example_vi | cefr | notes<br><br>CSV/XLSX V2 có thêm: card_type, topic, subtopic, toeic_part, difficulty, pattern, collocations, word_family, explanation, tags, audio_text, source.</div><p style="color:var(--muted);font-size:10px;line-height:1.6">File cũ vẫn import bình thường và mặc định thành VOCABULARY. Dùng template V2 khi muốn học Collocation, Grammar, Listening Chunk hoặc TOEIC metadata.</p><a class="btn soft" href="templates/learning-content-import-template.csv" download>Tải template Learning V2</a><div class="import-help"><b>Nút chọn file luôn hiển thị</b><span>Nếu không muốn kéo-thả, bấm nút “Chọn file từ máy” màu xám bên trên.</span></div></aside></div>');
    const form = $('#extra-import-form'), dropzone = $('#extra-dropzone'), input = $('#extra-import-file'), choose = $('#extra-choose-file'), fileName = $('#extra-file-name'), fileSize = $('#extra-file-size');
    let picked = null;
    const clear = message => { picked = null; input.value = ''; fileName.textContent = 'Chưa chọn file'; fileSize.textContent = message || 'Bạn có thể kéo file vào vùng này.'; dropzone.classList.remove('has-file'); };
    const pick = file => {
      if (!file) return false;
      const extension = (file.name.split('.').pop() || '').toLowerCase();
      if (!['txt','docx','csv','xlsx'].includes(extension)) { toast('Chỉ hỗ trợ TXT, CSV, DOCX và XLSX.', 'error'); clear('Hãy chọn đúng định dạng được hỗ trợ.'); return false; }
      if (file.size > 10 * 1024 * 1024) { toast('File quá lớn. Giới hạn 10 MB.', 'error'); clear('Hãy chọn file nhỏ hơn 10 MB.'); return false; }
      picked = file;
      try { const transfer = new DataTransfer(); transfer.items.add(file); input.files = transfer.files; } catch {}
      fileName.textContent = file.name; fileSize.textContent = formatBytes(file.size) + ' · Sẵn sàng import'; dropzone.classList.add('has-file'); return true;
    };
    const openPicker = event => { event?.preventDefault(); event?.stopPropagation(); input.click(); };
    choose.onclick = openPicker;
    dropzone.onclick = event => { if (!event.target.closest('button')) openPicker(event); };
    dropzone.onkeydown = event => { if ((event.key === 'Enter' || event.key === ' ') && !event.target.closest('button')) openPicker(event); };
    ['dragenter','dragover'].forEach(type => dropzone.addEventListener(type, event => { event.preventDefault(); dropzone.classList.add('drag'); }));
    ['dragleave','drop'].forEach(type => dropzone.addEventListener(type, event => { event.preventDefault(); dropzone.classList.remove('drag'); }));
    dropzone.ondrop = event => pick(event.dataTransfer?.files?.[0]);
    input.onchange = () => pick(input.files?.[0]);
    form.onsubmit = async event => {
      event.preventDefault();
      const file = picked || input.files?.[0];
      if (!pick(file)) return toast('Hãy chọn file trước khi import.', 'error');
      const data = new FormData(form);
      if (!data.get('file')) data.set('file', file);
      const button = event.submitter; button.disabled = true; button.textContent = 'Đang import...';
      try { const result = await api('import_file', {method: 'POST', data}); toast('Đã nhập ' + result.count + ' flashcard.'); navigate('sets/' + result.set_id); }
      catch (error) { toast(error.message, 'error'); button.disabled = false; button.textContent = '⇧ Import flashcard'; }
    };
  }

  async function translateText(text, source, target) {
    const google = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=' + encodeURIComponent(source || 'auto') + '&tl=' + encodeURIComponent(target) + '&dt=t&dj=1&q=' + encodeURIComponent(text);
    try {
      const data = await fetchJson(google);
      const result = Array.isArray(data?.sentences) ? data.sentences.map(item => item.trans || '').join('').trim() : '';
      if (result) return {text: result, provider: 'Google Translate'};
    } catch {}
    if (source !== 'auto') {
      try {
        const fallback = await fetchJson('https://api.mymemory.translated.net/get?q=' + encodeURIComponent(text) + '&langpair=' + encodeURIComponent(source + '|' + target));
        const result = fallback?.responseData?.translatedText?.trim();
        if (result) return {text: result, provider: 'Dịch dự phòng'};
      } catch {}
    }
    throw new Error('Google Translate không phản hồi. Hãy bấm nút mở Google Dịch để tiếp tục.');
  }

  const languageOptions = [['auto','Tự động'],['en','English'],['vi','Tiếng Việt'],['zh-CN','中文'],['ja','日本語'],['ko','한국어'],['fr','Français'],['de','Deutsch'],['es','Español']].map(item => '<option value="' + item[0] + '">' + item[1] + '</option>').join('');
  async function dictionaryView() {
    setHeader('Dịch & Tra từ', 'Dịch nhanh, nghe phát âm và tra từ điển tiếng Anh.');
    setView('<div class="page-head"><div><h1>Dịch &amp; Tra từ</h1><p>Dịch câu nhanh bằng Google Translate và tra định nghĩa, IPA, ví dụ, phát âm.</p></div><div class="page-actions"><a class="btn soft" id="extra-google" target="_blank" rel="noopener">↗ Mở Google Dịch</a><a class="btn soft" id="extra-oxford" target="_blank" rel="noopener">↗ Mở Oxford</a></div></div><div class="language-tools"><section class="panel tool-panel"><div class="tool-heading"><span class="tool-icon">文</span><div><h3>Dịch nhanh</h3><p>Không cần cấu hình API key.</p></div></div><form id="extra-translate-form" class="form-stack"><div class="form-grid"><label class="field">Ngôn ngữ gốc<select id="extra-source">' + languageOptions + '</select></label><label class="field">Dịch sang<select id="extra-target"><option value="vi" selected>Tiếng Việt</option>' + languageOptions.replace('<option value="auto">Tự động</option>', '') + '</select></label></div><label class="field">Nội dung cần dịch<textarea id="extra-translate-input" placeholder="Ví dụ: I have been learning English for three years."></textarea></label><div class="tool-actions"><button class="btn primary" type="submit">Dịch ngay</button><button class="btn soft" type="button" id="extra-swap">⇄ Đổi chiều</button><a class="btn ghost" id="extra-google-link" target="_blank" rel="noopener">Google Dịch ↗</a></div></form><div id="extra-translate-result" class="tool-result" aria-live="polite"><div class="result-empty">Kết quả dịch sẽ hiển thị ở đây.</div></div></section><section class="panel tool-panel"><div class="tool-heading"><span class="tool-icon">Aa</span><div><h3>Tra từ điển tiếng Anh</h3><p>Định nghĩa, từ loại, IPA, ví dụ và âm thanh.</p></div></div><form id="extra-dictionary-form" class="form-stack"><label class="field">Từ hoặc cụm từ tiếng Anh<input id="extra-dictionary-input" autocomplete="off" placeholder="Ví dụ: acquire, figure out"></label><div class="tool-actions"><button class="btn primary" type="submit" id="extra-dictionary-submit">Tra từ</button><a class="btn ghost" id="extra-oxford-link" target="_blank" rel="noopener">Tra Oxford ↗</a></div></form><div id="extra-dictionary-result" class="tool-result" aria-live="polite"><div class="result-empty">Nhập một từ để bắt đầu tra cứu.</div></div></section></div><div class="panel tool-note"><b>Mẹo học nhanh</b><span>Tra xong có thể lưu ngay vào một bộ flashcard đang có hoặc tạo bộ mới.</span></div>');
    const translateInput = $('#extra-translate-input'), source = $('#extra-source'), target = $('#extra-target'), dictionaryInput = $('#extra-dictionary-input'), google = $('#extra-google'), googleLink = $('#extra-google-link'), oxford = $('#extra-oxford'), oxfordLink = $('#extra-oxford-link');
    const updateLinks = () => { const text = translateInput.value.trim(), word = dictionaryInput.value.trim(); const g = googleUrl(text, source.value, target.value), o = oxfordUrl(word || text); google.href = g; googleLink.href = g; oxford.href = o; oxfordLink.href = o; };
    source.value = 'en'; translateInput.oninput = updateLinks; dictionaryInput.oninput = updateLinks; source.onchange = updateLinks; target.onchange = updateLinks; updateLinks();
    $('#extra-swap').onclick = () => { if (source.value === 'auto') source.value = 'en'; const old = source.value; source.value = target.value; target.value = old; updateLinks(); };
    $('#extra-translate-form').onsubmit = async event => {
      event.preventDefault(); const text = translateInput.value.trim(); if (!text) return toast('Hãy nhập nội dung cần dịch.', 'error');
      const result = $('#extra-translate-result'), button = event.submitter; button.disabled = true; button.textContent = 'Đang dịch...'; result.innerHTML = '<div class="tool-loading"><span class="spinner"></span>Đang lấy bản dịch...</div>';
      try { const translated = await translateText(text, source.value, target.value); result.innerHTML = '<div class="result-label">' + esc(translated.provider) + '</div><div class="translation-text">' + esc(translated.text) + '</div><div class="tool-actions"><button class="btn tiny soft" id="extra-copy" type="button">Sao chép</button><button class="btn tiny soft" id="extra-speak" type="button">🔊 Nghe</button></div>'; $('#extra-copy').onclick = () => copyText(translated.text); $('#extra-speak').onclick = () => speak(translated.text, target.value); }
      catch (error) { result.innerHTML = '<div class="result-error">' + esc(error.message) + '</div>'; }
      finally { button.disabled = false; button.textContent = 'Dịch ngay'; }
    };
    $('#extra-dictionary-form').onsubmit = async event => {
      event.preventDefault(); const word = dictionaryInput.value.trim(); if (!word) return toast('Hãy nhập từ cần tra.', 'error');
      const result = $('#extra-dictionary-result'), button = $('#extra-dictionary-submit'); button.disabled = true; button.textContent = 'Đang tra...'; result.innerHTML = '<div class="tool-loading"><span class="spinner"></span>Đang tra từ điển...</div>';
      try { const data = await fetchJson('https://api.dictionaryapi.dev/api/v2/entries/en/' + encodeURIComponent(word)); renderDictionary(data?.[0] || {}, result); }
      catch { result.innerHTML = '<div class="result-error">Chưa tìm thấy dữ liệu miễn phí cho từ này. Hãy mở Oxford để xem các kết quả phù hợp.</div><a class="btn tiny soft" href="' + oxfordUrl(word) + '" target="_blank" rel="noopener">Mở Oxford</a>'; }
      finally { button.disabled = false; button.textContent = 'Tra từ'; }
    };
  }

  function renderDictionary(entry, result) {
    const word = entry.word || '', phonetic = entry.phonetic || (entry.phonetics || []).map(item => item.text || '').find(Boolean) || '', audio = (entry.phonetics || []).map(item => item.audio || '').find(Boolean) || '', meanings = Array.isArray(entry.meanings) ? entry.meanings : [], definitions = [];
    meanings.forEach(meaning => (meaning.definitions || []).slice(0, 3).forEach(definition => definitions.push({pos: meaning.partOfSpeech || '', definition: definition.definition || '', example: definition.example || '', synonyms: definition.synonyms || []})));
    const synonyms = [...new Set(meanings.flatMap(item => item.synonyms || []).concat(definitions.flatMap(item => item.synonyms || [])))].slice(0, 12);
    const first = definitions[0] || {};
    result.innerHTML = '<div class="dictionary-summary"><div><span class="result-label">' + esc(word.toUpperCase()) + '</span><strong>' + esc(phonetic || 'Chưa có IPA') + '</strong></div><button class="icon-btn" id="extra-audio" type="button">🔊</button></div>' + definitions.map((definition, index) => '<article class="definition-item"><span class="definition-pos">' + esc(definition.pos || 'definition') + ' ' + (index + 1) + '</span><p>' + esc(definition.definition) + '</p>' + (definition.example ? '<small>“' + esc(definition.example) + '”</small>' : '') + '</article>').join('') + (synonyms.length ? '<div class="synonyms"><b>Từ liên quan</b><span>' + synonyms.map(esc).join(' · ') + '</span></div>' : '') + '<div class="tool-actions"><button class="btn tiny primary" id="extra-save-word" type="button">＋ Lưu vào flashcard</button><a class="btn tiny soft" href="' + oxfordUrl(word) + '" target="_blank" rel="noopener">Mở Oxford ↗</a></div>';
    $('#extra-audio').onclick = () => { if (audio) { const player = new Audio(audio); player.play().catch(() => speak(word)); } else speak(word); };
    $('#extra-save-word').onclick = () => saveDictionaryCard({word, phonetic, definition: first.definition || '', partOfSpeech: first.pos || '', example: first.example || ''});
  }

  async function saveDictionaryCard(card) {
    const catalog = await loadCatalog();
    const options = catalog.sets.map(set => '<option value="' + set.id + '">' + esc(set.title) + '</option>').join('');
    const root = $('#modal-root');
    root.innerHTML = '<div class="modal-backdrop"><section class="modal"><header class="modal-head"><h3>Lưu từ vào flashcard</h3><button class="icon-btn" data-extra-close type="button">×</button></header><div class="modal-body"><form id="extra-save-form" class="form-stack"><label class="field">Bộ từ<select name="set_id" id="extra-set"><option value="new">＋ Tạo bộ mới</option>' + options + '</select></label><label class="field hidden" id="extra-title-wrap">Tên bộ mới<input name="title" value="Từ tra cứu"></label><label class="field">Nghĩa / định nghĩa<textarea name="definition" required>' + esc(card.definition) + '</textarea></label><div class="form-grid"><label class="field">IPA<input name="ipa" value="' + esc(card.phonetic) + '"></label><label class="field">Từ loại<input name="part_of_speech" value="' + esc(card.partOfSpeech) + '"></label></div><label class="field">Ví dụ<textarea name="example_en">' + esc(card.example) + '</textarea></label></form></div><footer class="modal-foot"><button class="btn ghost" data-extra-close type="button">Hủy</button><button class="btn primary" id="extra-save-card" type="button">Lưu flashcard</button></footer></section></div>';
    root.onclick = event => { if (event.target.matches('.modal-backdrop,[data-extra-close]')) root.innerHTML = ''; };
    const setSelect = $('#extra-set'), titleWrap = $('#extra-title-wrap'); setSelect.onchange = () => titleWrap.classList.toggle('hidden', setSelect.value !== 'new');
    $('#extra-save-card').onclick = async () => {
      const values = Object.fromEntries(new FormData($('#extra-save-form')).entries());
      try {
        let setId = values.set_id;
        if (setId === 'new') { const created = await api('set_create', {method: 'POST', data: {title: values.title || 'Từ tra cứu', description: 'Tạo từ công cụ Dịch & Tra từ', source_type: 'dictionary'}}); setId = created.id; }
        await api('card_create', {method: 'POST', data: {set_id: setId, term: card.word, definition: values.definition, ipa: values.ipa, part_of_speech: values.part_of_speech, example_en: values.example_en, example_vi: '', notes: 'Tra từ điển YangLingo'}});
        root.innerHTML = ''; toast('Đã lưu từ vào flashcard.'); navigate('sets/' + setId);
      } catch (error) { toast(error.message, 'error'); }
    };
  }

  window.YLExtraViews = {importView, dictionaryView};
})();
