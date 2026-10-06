(function (root, factory) {
  'use strict';
  if (typeof module === 'object' && module.exports) module.exports = factory();
  else root.YLPronunciation = factory();
})(typeof window === 'object' ? window : globalThis, function () {
  'use strict';
  const escape = value => String(value).replace(/[&<>'"]/g, c => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', "'": '&#39;', '"': '&quot;'
  }[c]));
  // Display the stored notation verbatim: older entries may use another dialect.
  // Dialect labels and slash delimiters belong to the source, never infer them.
  function render(value) {
    const text = String(value ?? '').trim();
    return text ? '<span class="yl-ipa"><span class="yl-ipa-label">IPA</span>' +
      '<span class="yl-ipa-value">' + escape(text) + '</span></span>' : '';
  }
  // Older cards sometimes embed IPA in their meaning instead of the IPA field.
  // Conceal only recognized slash-delimited notation in unanswered prompts;
  // keep ordinary Vietnamese alternatives such as tàu/xe/máy bay intact.
  function hideFromPrompt(value) {
    return String(value ?? '').replace(/\/([^/\r\n]+)\//g, (whole, body) => {
      const text = body.trim();
      const phonetic = /[\u0250-\u02ffθð]/u.test(text) || /^(?:[ptkbdgfvszhmnlrwjiueao]|red)$/.test(text);
      return phonetic ? '(xem cách đọc khi lật thẻ)' : whole;
    });
  }
  return { render, hideFromPrompt };
});
