(()=>{
  'use strict';
  const nav=document.querySelector('.nav');
  const menu=document.querySelector('#menu-btn');
  const sidebar=document.querySelector('#sidebar');
  const syncNavigation=()=>{
    const route=(location.hash.slice(1)||'dashboard').split('/')[0];
    nav?.querySelectorAll('a[data-route]').forEach(link=>{
      if(link.dataset.route===route){link.setAttribute('aria-current','page');const group=link.closest('details');if(group)group.open=true;}
      else link.removeAttribute('aria-current');
    });
  };
  syncNavigation();
  window.addEventListener('hashchange',syncNavigation);
  if(sidebar&&menu)new MutationObserver(()=>menu.setAttribute('aria-expanded',String(sidebar.classList.contains('open')))).observe(sidebar,{attributes:true,attributeFilter:['class']});
  const syncTheme=()=>{document.querySelector('meta[name="theme-color"]')?.setAttribute('content',document.documentElement.dataset.theme==='dark'?'#14151e':'#f7f8fc');};
  syncTheme();
  new MutationObserver(syncTheme).observe(document.documentElement,{attributes:true,attributeFilter:['data-theme']});
  const userButton=document.querySelector('#user-btn'),dropdown=document.querySelector('#user-dropdown');
  if(userButton&&dropdown){
    userButton.setAttribute('aria-haspopup','true');
    userButton.setAttribute('aria-controls','user-dropdown');
    const syncMenu=()=>userButton.setAttribute('aria-expanded',String(!dropdown.classList.contains('hidden')));
    syncMenu();new MutationObserver(syncMenu).observe(dropdown,{attributes:true,attributeFilter:['class']});
    document.addEventListener('click',e=>{if(!e.target.closest('.user-menu'))dropdown.classList.add('hidden');});
  }
  document.addEventListener('keydown',e=>{
    if(e.key==='Escape'){
      sidebar?.classList.remove('open');document.querySelector('#scrim')?.classList.remove('show');dropdown?.classList.add('hidden');
    }
    if((e.ctrlKey||e.metaKey)&&e.key.toLowerCase()==='k'){
      e.preventDefault();location.hash='sets';
      const focusSearch=()=>{const search=document.querySelector('#set-search');if(search){search.focus();return true;}return false;};
      if(!focusSearch()){
        const observer=new MutationObserver(()=>{if(focusSearch())observer.disconnect();});
        observer.observe(document.querySelector('#view'),{childList:true,subtree:true});
        setTimeout(()=>observer.disconnect(),5000);
      }
    }
  });
})();
