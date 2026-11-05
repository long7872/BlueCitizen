import fs from 'node:fs';
import path from 'node:path';
import {parse} from '@babel/parser';

const root=path.resolve(import.meta.dirname,'../..');
const inventory=JSON.parse(fs.readFileSync(`${root}/design_source/screen_inventory.json`));
const out=`${root}/design_source/preview`;
fs.mkdirSync(out,{recursive:true});
const escape=s=>String(s).replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;');
const assets=new Map();
const results=[];
for(const screen of inventory){
  const file=`${root}/design_source/${screen.id.replace(':','_')}.txt`;
  if(!fs.existsSync(file))continue;
  const raw=fs.readFileSync(file,'utf8');
  let code=raw.split('SUPER CRITICAL:')[0].replace(/^```[^\n]*\n/,'').replace(/```\s*$/,'').trim();
  const start=code.search(/(?:const |import |export default )/);
  if(start>0)code=code.slice(start);
  try{
    const ast=parse(code,{sourceType:'module',plugins:['jsx','typescript']});
    const vars={};let tree;
    const value=n=>{
      if(!n)return '';
      if(n.type==='StringLiteral'||n.type==='NumericLiteral'||n.type==='BooleanLiteral')return n.value;
      if(n.type==='Identifier')return vars[n.name]??'';
      if(n.type==='TemplateLiteral')return n.quasis.map((q,i)=>q.value.cooked+(n.expressions[i]?value(n.expressions[i]):'')).join('');
      if(n.type==='JSXExpressionContainer')return value(n.expression);
      return '';
    };
    for(const n of ast.program.body){
      if(n.type==='VariableDeclaration')for(const d of n.declarations)vars[d.id.name]=value(d.init);
      if(n.type==='ExportDefaultDeclaration'){
        tree=n.declaration.body?.body?.find(x=>x.type==='ReturnStatement')?.argument;
        if(n.declaration.type==='ArrowFunctionExpression')tree=n.declaration.body;
      }
    }
    for(const [key,url] of Object.entries(vars)){
      if(typeof url==='string'&&/\/api\/mcp\/asset\/.+\.(svg|png|jpg|jpeg|webp)$/.test(url)){
        const filename=screen.id.replace(':','_')+'_'+url.split('/').at(-1);
        if(!assets.has(url))assets.set(url,{url,file:`assets/images/${feature(screen)}/${filename}`});
        vars[key]='/'+assets.get(url).file;
      }
    }
    const render=n=>{
      if(!n)return '';
      if(n.type==='JSXText')return escape(n.value.replace(/\s+/g,' '));
      if(n.type==='JSXExpressionContainer')return escape(value(n.expression));
      if(n.type==='JSXFragment')return n.children.map(render).join('');
      if(n.type!=='JSXElement')return '';
      let tag=n.openingElement.name.name;
      if(tag==='a')tag='div';
      const attrs=n.openingElement.attributes.filter(a=>a.type==='JSXAttribute').map(a=>{
        const k=a.name.name==='className'?'class':a.name.name;
        const v=value(a.value);
        return `${k}="${escape(v)}"`;
      }).join(' ');
      const children=n.children.map(render).join('');
      return ['img','input','br','hr'].includes(tag)?`<${tag} ${attrs}>`:`<${tag} ${attrs}>${children}</${tag}>`;
    };
    if(!tree)throw Error('No JSX return');
    const html=render(tree);
    const frame=`<section class="design-frame" data-screen="${screen.id}" data-name="${escape(screen.name)}" style="width:${screen.width}px;height:${screen.height}px">${html}</section>`;
    results.push({...screen,feature:feature(screen),html:frame});
  }catch(e){console.error(screen.id,screen.name,e.message);}
}
function feature(s){
 const section=s.section.toLowerCase();
 if(section.includes('community /')||section.endsWith('/ community'))return 'community';
 if(section.includes('profile &amp;'))return 'profile';
 if(section.includes('knowledge'))return 'knowledge';
 if(section.includes('event flow'))return 'events';
 if(section.includes('/ donate'))return 'donate';
 if(section.includes('report flow'))return section.includes('notification')?'notifications':'report';
 if(section.includes('map &amp; admin'))return section.includes('map flow')?'map':'admin';
 return 'dashboard';
}
fs.writeFileSync(`${out}/assets.json`,JSON.stringify([...assets.values()],null,2));
fs.writeFileSync(`${out}/manifest.json`,JSON.stringify(results.map(({html,...s})=>s),null,2));
const head=`<!doctype html><html><head><meta charset="utf-8"><link href="/design_source/preview/style.css" rel="stylesheet"><style>@font-face{font-family:'Afacad Flux';src:url('/assets/fonts/AfacadFlux/AfacadFlux-VariableFont_slnt,wght.ttf')}@font-face{font-family:'Patrick Hand';src:url('/assets/fonts/PatrickHand/PatrickHand-Regular.ttf')}@font-face{font-family:'Inter';src:url('/assets/fonts/Inter/Inter-Variable.ttf');font-weight:100 900}body{margin:0;background:#e5edf0;font-family:'Afacad Flux',sans-serif}.design-frame{position:relative;flex:none;background:white;isolation:isolate;overflow:hidden}.design-frame>div{width:100%;height:100%}p{margin:0}img{display:block}[class*=Patrick_Hand]{font-family:"Patrick Hand"!important}[class*=Inter]{font-family:Inter!important}[class*=Afacad_Flux]{font-family:"Afacad Flux"!important}#frames{display:flex;flex-wrap:wrap;align-items:flex-start;gap:32px}</style></head><body>`;
fs.writeFileSync(`${out}/index.html`,head+'<main id="frames">'+results.map(s=>s.html).join('\n')+'</main><script src="/tools/figma/measure.js"></script></body></html>');
for(const s of results)fs.writeFileSync(`${out}/${s.id.replace(':','_')}.html`,head+s.html+'</body></html>');
fs.writeFileSync(`${out}/input.css`,'@import "../../tools/figma/node_modules/tailwindcss/index.css";\n@source "../../*.txt";\n@source "./*.html";\n');
console.log(JSON.stringify({screens:results.length,assets:assets.size}));
