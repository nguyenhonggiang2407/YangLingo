'use strict';
// Real notebook module, deferred fictional saves and a small DOM; no network or accounts.
const assert = require('node:assert/strict');
const fs = require('node:fs'), path = require('node:path'), vm = require('node:vm');
const source = fs.readFileSync(path.join(__dirname, '../assets/learning-notebook.js'), 'utf8');
let checks = 0;
const check = (value, message) => { assert.ok(value, message); checks++; };
const decode = value => value.replace(/&quot;/g, '"').replace(/&#39;/g, "'").replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&amp;/g, '&');
const escape = value => String(value).replace(/[&<>"']/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]));

function environment() {
  let document;
  class Element {
    constructor(tag, attrs = {}) {
      this.tag = tag; this.attrs = attrs; this.children = []; this._text = ''; this._html = '';
      this.value = attrs.value || ''; this.checked = 'checked' in attrs;
      this.disabled = 'disabled' in attrs; this.hidden = 'hidden' in attrs; this.isConnected = true;
      this.dataset = {};
    }
    descendants() { return this.children.flatMap(child => [child, ...child.descendants()]); }
    disconnect() { this.isConnected = false; this.children.forEach(child => child.disconnect()); }
    set innerHTML(value) {
      this.children.forEach(child => child.disconnect()); this.children = []; this._text = ''; this._html = value;
      const stack = [this];
      for (const match of value.matchAll(/<\/?([a-z][\w-]*)\b([^>]*?)>|([^<]+)/gi)) {
        if (match[3]) { stack.at(-1)._text += decode(match[3]); continue; }
        if (match[0][1] === '/') {
          while (stack.length > 1 && stack.at(-1).tag !== match[1].toLowerCase()) stack.pop();
          if (stack.length > 1) stack.pop();
          continue;
        }
        const attrs = {};
        for (const attr of match[2].matchAll(/([\w-]+)(?:="([^"]*)")?/g)) attrs[attr[1]] = decode(attr[2] || '');
        const child = new Element(match[1].toLowerCase(), attrs); stack.at(-1).children.push(child);
        for (const [key, val] of Object.entries(attrs)) if (key.startsWith('data-')) child.dataset[key.slice(5).replace(/-([a-z])/g, (_, c) => c.toUpperCase())] = val;
        if (!['input', 'br', 'hr', 'img', 'meta', 'link'].includes(child.tag)) stack.push(child);
      }
      for (const node of this.descendants()) {
        if (node.tag === 'textarea') node.value = node.textContent;
        if (node.tag === 'select') {
          const options = node.descendants().filter(child => child.tag === 'option');
          node.value = (options.find(child => 'selected' in child.attrs) || options[0])?.attrs.value || '';
        }
      }
    }
    get innerHTML() { return this._html; }
    get textContent() { return this._text + this.children.map(child => child.textContent).join(''); }
    set textContent(value) { this.children.forEach(child => child.disconnect()); this.children = []; this._text = String(value); this._html = ''; }
    matches(selector) {
      const tag = selector.match(/^[\w-]+/)?.[0]; if (tag && tag !== this.tag) return false;
      const id = selector.match(/#([\w-]+)/)?.[1]; if (id && this.attrs.id !== id) return false;
      for (const attr of selector.matchAll(/\[([\w-]+)(?:="([^"]*)")?\]/g)) if (!(attr[1] in this.attrs) || attr[2] !== undefined && this.attrs[attr[1]] !== attr[2]) return false;
      return true;
    }
    querySelector(selector) { return this.descendants().find(node => node.matches(selector)) || null; }
    querySelectorAll(selector) { return this.descendants().filter(node => node.matches(selector)); }
    get elements() { return Object.fromEntries(this.descendants().filter(node => node.attrs.name).map(node => [node.attrs.name, node])); }
    reportValidity() { return this.descendants().every(node => node.disabled || !('required' in node.attrs) || !!node.value); }
    setAttribute(key, value) { this.attrs[key] = String(value); }
    getAttribute(key) { return this.attrs[key] ?? null; }
    addEventListener(name, handler) { this['on' + name] = handler; }
    focus() { document.activeElement = this; }
    scrollIntoView() {}
  }
  const view = new Element('main'), state = {user: {id: 7}}, location = {hash: '#notebook'};
  document = {activeElement: null, querySelector: selector => view.querySelector(selector)};
  const calls = [], toasts = [], notes = []; let pending;
  const core = {
    state, esc: escape, fmt: String, routeArg: () => '', setView: markup => view.innerHTML = markup,
    toast: (...args) => toasts.push(args),
    api: async (action, options = {}) => {
      calls.push({action, options});
      if (action === 'notebook_notes') return {notes, total: notes.length, saved_count: notes.length, max_notes: 500, page: 1, pages: 1};
      assert.equal(action, 'notebook_save', 'only the explicit note save may write');
      assert.equal(options.method, 'POST');
      return new Promise((resolve, reject) => { pending = {
        reject, resolve: () => { notes.push({...options.data, id: 88}); resolve({id: 88}); },
      }; });
    },
  };
  const window = {YLCore: core};
  vm.runInNewContext(source, {window, document, location, setTimeout, clearTimeout,
    localStorage: {setItem() { throw Error('No implicit draft persistence'); }},
    sessionStorage: {setItem() { throw Error('No progress write'); }},
  });
  return {module: window.YLNotebook, view, document, calls, toasts, state, location,
    form: () => view.querySelector('#note-form'), pending: () => pending,
    posts: () => calls.filter(call => call.options.method === 'POST')};
}
const submit = form => form.onsubmit({preventDefault() {}});
const input = (field, value) => { if (!field.disabled) field.value = value; };
const toggle = field => { if (!field.disabled) field.checked = !field.checked; };
const values = form => Object.fromEntries(Object.entries(form.elements).map(([name, field]) => [name, name === 'is_pinned' ? field.checked : field.value]));

(async () => {
  const env = environment(); await env.module.view(); env.view.querySelector('#note-new').onclick();
  const form = env.form(), fields = form.elements, save = form.querySelector('[type="submit"]'), cancel = form.querySelector('#note-cancel');
  fields.title.value = '   '; fields.body.value = 'Fictional grammar reminder';
  await submit(form);
  check(env.posts().length === 0 && Object.values(fields).every(field => !field.disabled), 'invalid draft remains editable without a save');
  fields.title.value = '  Fictional reminder  '; fields.body.value = '  Keep a learner sentence.  ';
  fields.own_sentence.value = '  Tôi viết câu của mình: <b>literal text</b>.  '; fields.kind.value = 'phrase'; fields.is_pinned.checked = true;
  const original = values(form), label = save.textContent, waiting = submit(form);
  for (const [name, field] of Object.entries(fields)) check(field.disabled, 'pending save prevents editing ' + name);
  check(cancel.disabled && save.disabled, 'save and cancel are unavailable while the explicit save is pending');
  check(save.textContent.includes('Đang lưu') && form.getAttribute('aria-busy') === 'true', 'learner receives a visible and accessible pending state');
  for (const [name, field] of Object.entries(fields)) name === 'is_pinned' ? toggle(field) : input(field, 'Late change that must not be accepted');
  check(JSON.stringify(values(form)) === JSON.stringify(original), 'pending editor cannot accept changes absent from the submitted snapshot');
  cancel.onclick(); await submit(form);
  check(env.form() === form && env.posts().length === 1, 'pending cancel/double submit neither discards draft nor posts twice');
  check(env.posts()[0].options.canRetry(), 'existing retry guard accepts the same connected owned form');
  env.pending().reject(Error('Fictional offline failure')); await waiting;
  check(env.form() === form && JSON.stringify(values(form)) === JSON.stringify(original), 'failure retains the exact learner contents');
  check(Object.values(fields).every(field => !field.disabled) && !cancel.disabled && !save.disabled, 'failure restores editing, cancel and retry');
  check(save.textContent === label && form.getAttribute('aria-busy') === 'false', 'failure restores the save label and idle state');
  check(form.querySelector('#note-error').textContent === 'Fictional offline failure' && !form.querySelector('#note-error').hidden, 'failure is shown inline');
  input(fields.own_sentence, '  I can revise my fictional sentence after a failed save.  '); toggle(fields.is_pinned);
  const successful = submit(form); await submit(form); cancel.onclick();
  check(env.posts().length === 2 && env.form() === form, 'retry still allows only one explicit request');
  const data = env.posts()[1].options.data;
  check(data.title === original.title.trim() && data.body === original.body.trim() && data.own_sentence === fields.own_sentence.value.trim() && data.kind === 'phrase' && data.is_pinned === 0, 'retry sends exactly the corrected, validated snapshot');
  env.pending().resolve(); await successful;
  check(!env.form() && !form.isConnected && env.toasts.some(toast => toast[0].includes('Đã lưu')), 'successful explicit save closes the editor and confirms completion');
  check(env.document.activeElement === env.view.querySelector('#note-new'), 'successful save retains existing focus return');
  check(!env.posts()[1].options.canRetry(), 'detached editor cannot retry after success');
  env.view.querySelector('#note-new').onclick();
  const fresh = env.form(); check(Object.values(fresh.elements).every(field => !field.disabled), 'a new draft is editable after success');
  fresh.querySelector('#note-cancel').onclick();
  check(!env.form() && env.posts().length === 2, 'ordinary cancel discards only the current unsaved draft without another write');
  console.log(`PASS: ${checks} actual-module assertions for validation, pending-save input prevention, failure retention/unlock, corrected retry, snapshot success, cancellation and duplicate submission.`);
})().catch(error => { console.error(error); process.exitCode = 1; });
