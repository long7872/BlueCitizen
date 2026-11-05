// Build-time only: translate the reference JSX layout into native Flutter specs.
// No reference HTML, Tailwind, or browser is used by the delivered Flutter app.
async function measureDesigns() {
  await document.fonts.ready;
  await Promise.all([...document.images].map(i=>i.complete?Promise.resolve():new Promise(r=>{i.onload=r;i.onerror=r;})));
  const frames=[];
  const number=v=>Number.parseFloat(v)||0;
  for(const frame of document.querySelectorAll('.design-frame')){
    const base=frame.getBoundingClientRect();
    const rect=e=>{const r=e.getBoundingClientRect();return [r.x-base.x,r.y-base.y,r.width,r.height].map(n=>Math.round(n*1000)/1000);};
    const elements=[];
    const inputs=[];
    let order=0;
    const visible=e=>{const s=getComputedStyle(e);return s.display!=='none'&&s.visibility!=='hidden'&&number(s.opacity)!==0;};
    for(const el of frame.querySelectorAll('*')){
      if(!visible(el)||el.closest('[hidden],.hidden'))continue;
      if(el.closest('[data-name="Status Bar"],[data-name="Home Bar"]'))continue;
      const style=getComputedStyle(el), r=rect(el);
      if(r[2]<0.1||r[3]<0.1)continue;
      const ancestry=[];let p=el;while(p&&p!==frame){if(p.dataset.nodeId)ancestry.push(p.dataset.nodeId);p=p.parentElement;}
      const inNav=!!el.closest('[data-name="BottomAppBar"],[data-name="Bottom App Bar"]');
      const shared={id:el.dataset.nodeId??el.closest('[data-node-id]')?.dataset.nodeId??'',name:el.dataset.name??el.closest('[data-name]')?.dataset.name??'',r,ancestry,nav:inNav,opacity:number(style.opacity),order:order++};
      if(el.tagName==='IMG'){
        elements.push({...shared,type:'image',asset:el.getAttribute('src').replace(/^\//,''),fit:style.objectFit,radius:number(style.borderTopLeftRadius)});
      }else{
        const border=[style.borderTopWidth,style.borderRightWidth,style.borderBottomWidth,style.borderLeftWidth].map(number);
        if(style.backgroundColor!=='rgba(0, 0, 0, 0)'||border.some(Boolean)||style.boxShadow!=='none'||style.backgroundImage!=='none'){
          elements.push({...shared,type:'box',color:style.backgroundColor,gradient:style.backgroundImage,border,borderColor:[style.borderTopColor,style.borderRightColor,style.borderBottomColor,style.borderLeftColor],radius:[style.borderTopLeftRadius,style.borderTopRightRadius,style.borderBottomRightRadius,style.borderBottomLeftRadius].map(number),shadow:style.boxShadow});
        }
        for(const node of el.childNodes){
          if(node.nodeType!==Node.TEXT_NODE||!node.textContent.trim())continue;
          const range=document.createRange();range.selectNodeContents(node);const b=range.getBoundingClientRect();
          elements.push({...shared,type:'text',text:node.textContent.replace(/\s+/g,' '),r:[b.x-base.x,b.y-base.y,b.width,b.height].map(n=>Math.round(n*1000)/1000),font:style.fontFamily,size:number(style.fontSize),weight:number(style.fontWeight),color:style.color,lineHeight:style.lineHeight==='normal'?null:number(style.lineHeight),letterSpacing:number(style.letterSpacing),align:style.textAlign,decoration:style.textDecorationLine});
        }
      }
      if(el.dataset.name&&/search|input|textarea/i.test(el.dataset.name))inputs.push({id:el.dataset.nodeId,name:el.dataset.name,r});
    }
    frames.push({id:frame.dataset.screen,name:frame.dataset.name,width:base.width,height:base.height,elements,inputs});
  }
  const result=await fetch('/__save_layout',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(frames)});
  const status=document.createElement('p');status.id='export-status';status.textContent=`Exported ${frames.length} Flutter screen specifications: ${result.status}`;document.body.prepend(status);
}
measureDesigns().catch(e=>{document.body.prepend(Object.assign(document.createElement('p'),{textContent:'Export error: '+e.message}));});
