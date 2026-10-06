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
  return { render };
});
