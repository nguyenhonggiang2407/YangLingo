from __future__ import annotations
from pathlib import Path
import csv, json

ROOT=Path(__file__).resolve().parents[1]
SEED=ROOT/'database/seeds/021_toeic_800_handbooks.sql'
OUT=ROOT/'assets/flashbooks'
OUT.mkdir(parents=True, exist_ok=True)
FIELDS=['category','term','definition','ipa','part_of_speech','example_en','example_vi','card_type','topic','subtopic','toeic_part','difficulty','pattern','collocations','word_family','explanation','audio_text','tags','source']

def write_csv(name, rows):
    p=OUT/name
    with p.open('w',encoding='utf-8-sig',newline='') as f:
        w=csv.DictWriter(f,fieldnames=FIELDS)
        w.writeheader(); w.writerows(rows)
    print(name, len(rows))


def parse_tuple(line:str):
    s=line.strip()
    if s.endswith(','): s=s[:-1]
    if s.endswith(';'): s=s[:-1]
    if not (s.startswith('(') and s.endswith(')')): return None
    s=s[1:-1]; vals=[]; i=0; n=len(s)
    while i<n:
        while i<n and s[i].isspace(): i+=1
        if i<n and s[i]=="'":
            i+=1; out=[]
            while i<n:
                if s[i]=="'":
                    if i+1<n and s[i+1]=="'": out.append("'"); i+=2; continue
                    i+=1; break
                out.append(s[i]); i+=1
            vals.append(''.join(out))
        else:
            j=i
            while j<n and s[j]!=',': j+=1
            vals.append(s[i:j].strip()); i=j
        while i<n and s[i].isspace(): i+=1
        if i<n and s[i]==',': i+=1
    return vals

# ---------------- Verb Master ----------------
TOPIC_VI={
    'Business & Management':'Kinh doanh & Quản lý',
    'HR & Communication':'Nhân sự & Giao tiếp',
    'Finance & Purchasing':'Tài chính & Mua sắm',
    'Operations & Logistics':'Vận hành & Hậu cần',
    'Irregular Verbs':'Động từ bất quy tắc',
}
verb_rows=[]; seen=set()
for line in SEED.read_text(encoding='utf-8').splitlines():
    if "'VERB_MASTER'" not in line or not line.strip().startswith('('): continue
    v=parse_tuple(line)
    if not v or len(v)<12: continue
    external,item_type,term,meaning,definition,ex_en,ex_vi,topic,level,meta_raw,content_hash,active=v[:12]
    try: meta=json.loads(meta_raw)
    except Exception: meta={}
    key=term.casefold().strip()
    if key in seen: continue
    seen.add(key)
    sub=TOPIC_VI.get(topic,topic or 'Động từ TOEIC 800+')
    v1=meta.get('v1') or term; v2=meta.get('v2') or ''; v3=meta.get('v3') or ''; ed=meta.get('ed_pronunciation') or ''
    forms=[]
    if v1: forms.append(f'V1: {v1}')
    if v2: forms.append(f'V2: {v2}')
    if v3: forms.append(f'V3: {v3}')
    if ed: forms.append(f'-ed: {ed}')
    explanation=' · '.join(forms) if forms else definition
    verb_rows.append({
        'category':sub,'term':term,'definition':meaning or definition,'ipa':'','part_of_speech':'verb',
        'example_en':ex_en,'example_vi':ex_vi,'card_type':'VOCABULARY','topic':'TOEIC Verb Master 800+','subtopic':sub,
        'toeic_part':'','difficulty':'2','pattern':explanation,'collocations':meta.get('collocations',''),'word_family':'',
        'explanation':explanation,'audio_text':meta.get('audio_text') or ex_en or term,
        'tags':'toeic,800-plus,verb-master,pdf-flashbook','source':'TOEIC 800+ Verb Master PDF'
    })

# Add explicit -ed pronunciation examples that are learning content in the PDF but are not in the 293-item seed.
ed_groups={
    '/t/':['work','help','stop','look','check','ask','fix','laugh','miss','discuss','finish','watch','reach','like'],
    '/d/':['play','stay','arrive','live','move','improve','call','clean','open','order','deliver','change','prepare','require','love'],
    '/ɪd/':['want','start','wait','visit','expect','need','decide','provide','include','attend','recommend','request'],
}
past_map={
 'work':'worked','help':'helped','stop':'stopped','look':'looked','check':'checked','ask':'asked','fix':'fixed','laugh':'laughed','miss':'missed','discuss':'discussed','finish':'finished','watch':'watched','reach':'reached','like':'liked',
 'play':'played','stay':'stayed','arrive':'arrived','live':'lived','move':'moved','improve':'improved','call':'called','clean':'cleaned','open':'opened','order':'ordered','deliver':'delivered','change':'changed','prepare':'prepared','require':'required','love':'loved',
 'want':'wanted','start':'started','wait':'waited','visit':'visited','expect':'expected','need':'needed','decide':'decided','provide':'provided','include':'included','attend':'attended','recommend':'recommended','request':'requested'
}
for ed,terms in ed_groups.items():
    for term in terms:
        if term.casefold() in seen: continue
        seen.add(term.casefold())
        past=past_map[term]
        verb_rows.append({
            'category':f'Phát âm -ed {ed}','term':term,'definition':f'V2/V3: {past} · -ed đọc {ed}','ipa':'','part_of_speech':'verb',
            'example_en':'','example_vi':'','card_type':'VOCABULARY','topic':'TOEIC Verb Master 800+','subtopic':f'Phát âm -ed {ed}',
            'toeic_part':'','difficulty':'1','pattern':f'{term} → {past} → {ed}','collocations':'','word_family':'',
            'explanation':f'Nhóm phát âm -ed {ed} theo bảng trong PDF.','audio_text':past,
            'tags':'toeic,800-plus,ed-pronunciation,pdf-flashbook','source':'TOEIC 800+ Verb Master PDF'
        })
# Explicit confusing verb pair entries missing from the seed.
for term,definition,pattern,example in [
    ('raise','làm tăng; nâng lên','raise - raised - raised · ngoại động từ, cần tân ngữ','The company raised prices.'),
    ('found','thành lập','found - founded - founded',''),
]:
    if term.casefold() not in seen:
        seen.add(term.casefold())
        verb_rows.append({'category':'Cặp động từ dễ nhầm','term':term,'definition':definition,'ipa':'','part_of_speech':'verb','example_en':example,'example_vi':'','card_type':'VOCABULARY','topic':'TOEIC Verb Master 800+','subtopic':'Cặp động từ dễ nhầm','toeic_part':'','difficulty':'2','pattern':pattern,'collocations':'','word_family':'','explanation':pattern,'audio_text':example or term,'tags':'toeic,800-plus,confusing-verbs,pdf-flashbook','source':'TOEIC 800+ Verb Master PDF'})
# Special adjective -ed pronunciation items.
for term in ['learned','aged','beloved','naked','wicked','crooked']:
    if term.casefold() in seen: continue
    seen.add(term.casefold())
    verb_rows.append({'category':'Tính từ -ed phát âm đặc biệt','term':term,'definition':'Khi dùng như tính từ, -ed có thể đọc /ɪd/.','ipa':'','part_of_speech':'adjective','example_en':'','example_vi':'','card_type':'VOCABULARY','topic':'TOEIC Verb Master 800+','subtopic':'Tính từ -ed phát âm đặc biệt','toeic_part':'','difficulty':'2','pattern':f'{term}: -ed có thể đọc /ɪd/ khi là tính từ','collocations':'','word_family':'','explanation':'Theo mục 1.5 của PDF Verb Master.','audio_text':term,'tags':'toeic,800-plus,ed-pronunciation,pdf-flashbook','source':'TOEIC 800+ Verb Master PDF'})
write_csv('toeic-verb-master-800-flashcards.csv',verb_rows)

# ---------------- Listening vocabulary & chunks ----------------
listening=[]
def L(cat,part,term,meaning,card='LISTENING_CHUNK'):
    listening.append({'category':cat,'term':term,'definition':meaning,'ipa':'','part_of_speech':'word / phrase','example_en':'','example_vi':'','card_type':card,'topic':'TOEIC Listening 800+','subtopic':cat,'toeic_part':str(part),'difficulty':'1' if part<=2 else '2','pattern':'','collocations':'','word_family':'','explanation':'','audio_text':term,'tags':f'toeic,800-plus,listening,part{part},pdf-flashbook','source':'TOEIC Listening 100 câu 800+ PDF'})
for term,meaning in [
('typing','gõ phím'),('pointing at','chỉ vào'),('leaning against','tựa vào'),('pouring','rót'),('sweeping','quét'),('mopping','lau sàn'),('examining','kiểm tra'),('stacking','xếp chồng'),('hanging','treo'),('loading','chất hàng'),('unloading','dỡ hàng'),('crossing','băng qua'),('facing','đối mặt'),('wearing','mặc/đeo'),('carrying','mang/xách'),('operating','vận hành'),('assembling','lắp ráp'),('paving','lát đường')]: L('Part 1 · Hành động người',1,term,meaning)
for term,meaning in [('parked','đang đậu'),('stacked','xếp chồng'),('scattered','rải rác'),('displayed','trưng bày'),('lined up','xếp hàng'),('hung','treo'),('folded','gấp lại'),('piled up','chất đống'),('occupied','có người ngồi')]: L('Part 1 · Trạng thái đồ vật',1,term,meaning)
for term,meaning in [('next to','bên cạnh'),('in front of','phía trước'),('behind','phía sau'),('along','dọc theo'),('across from','đối diện'),('beneath','bên dưới'),('on top of','trên đỉnh'),('at the corner','ở góc')]: L('Part 1 · Vị trí',1,term,meaning)
for term,meaning in [('Let me check.','Để tôi kiểm tra.'),("I'm not sure.",'Tôi không chắc.'),("That hasn't been decided yet.",'Chưa được quyết định.'),('As far as I know.','Theo tôi biết.'),('You should ask [tên].','Bạn nên hỏi [tên].'),('Either one is fine.','Cái nào cũng được.'),('It depends on...','Tùy thuộc vào...'),('I thought you knew.','Tôi tưởng bạn biết rồi.')]: L('Part 2 · Phản hồi gián tiếp',2,term,meaning)
for term,meaning in [('in charge of','phụ trách'),('take effect','có hiệu lực'),('out of stock','hết hàng'),('on schedule','đúng tiến độ'),('behind schedule','trễ tiến độ'),('ahead of schedule','sớm hơn dự kiến'),('push back / postpone','hoãn lại'),('move up','đẩy sớm lên'),('called off / canceled','hủy bỏ')]: L('Part 2 · Cụm thường nghe',2,term,meaning)
for term,meaning in [('be in charge of','phụ trách'),('work overtime','làm thêm giờ'),('take a day off','nghỉ 1 ngày'),('fill in for someone','thay thế ai'),('hand in / turn in','nộp'),('follow up on','theo dõi tiếp'),('get back to someone','phản hồi lại'),('run into a problem','gặp vấn đề'),('wrap up','kết thúc'),('figure out','tìm ra')]: L('Part 3 · Công việc',3,term,meaning)
for term,meaning in [('move up','đẩy sớm'),('push back','lùi lại'),('call off','hủy'),('pencil in','ghi tạm vào lịch'),('squeeze in','chen thêm vào'),('right away','ngay lập tức'),('no later than','không muộn hơn')]: L('Part 3 · Lịch trình',3,term,meaning)
for term,meaning in [('This is [tên] calling from...','Tôi là [tên] gọi từ...'),("I'm calling to let you know...",'Tôi gọi để thông báo...'),("I'm calling regarding...",'Tôi gọi liên quan đến...'),('Please call me back at...','Vui lòng gọi lại số...'),('at your earliest convenience','khi nào thuận tiện nhất')]: L('Part 4 · Tin nhắn thoại',4,term,meaning)
for term,meaning in [('Attention, all employees/passengers','Thông báo đến toàn thể...'),('Please be advised that...','Xin lưu ý rằng...'),('effective immediately','có hiệu lực ngay lập tức'),('until further notice','cho đến khi có thông báo mới'),('We apologize for any inconvenience.','Xin lỗi vì sự bất tiện.')]: L('Part 4 · Thông báo',4,term,meaning)
for term,meaning in [('limited-time offer','ưu đãi có hạn'),('for more information','để biết thêm thông tin'),('sign up / register','đăng ký'),('free of charge','miễn phí'),("don't miss out",'đừng bỏ lỡ'),('visit our website at...','truy cập website tại...')]: L('Part 4 · Quảng cáo',4,term,meaning)
# Keep source category distinctions; only remove exact duplicates within the same category.
uniq=[];seen2=set()
for r in listening:
    k=(r['category'].casefold(),r['term'].casefold())
    if k in seen2: continue
    seen2.add(k);uniq.append(r)
write_csv('toeic-listening-vocab-800-flashcards.csv',uniq)

# ---------------- Grammar patterns / fixed phrases / confusing words ----------------
grammar=[]
def G(cat,term,definition,example='',card='GRAMMAR',pattern='',difficulty='2'):
    grammar.append({'category':cat,'term':term,'definition':definition,'ipa':'','part_of_speech':'grammar / phrase','example_en':example,'example_vi':'','card_type':card,'topic':'TOEIC Grammar 800+','subtopic':cat,'toeic_part':'5','difficulty':difficulty,'pattern':pattern or term,'collocations':'','word_family':'','explanation':definition,'audio_text':example or term,'tags':'toeic,800-plus,grammar,pdf-flashbook','source':'TOEIC Grammar 800+ PDF'})
# Word-form suffix cards preserve all examples without inventing lexical meanings.
for term,definition,examples in [
('-tion / -sion','Đuôi danh từ.','information; decision; permission; contribution'),('-ment','Đuôi danh từ.','management; requirement; improvement; achievement'),('-ness','Đuôi danh từ.','awareness; effectiveness; willingness; business'),('-ity / -ty','Đuôi danh từ.','ability; productivity; quality; responsibility'),('-ance / -ence','Đuôi danh từ.','performance; experience; attendance; preference'),('-er / -or','Đuôi danh từ chỉ người/vai trò.','manager; supervisor; employer; competitor'),('-ee','Đuôi danh từ; trong ví dụ nguồn thường chỉ người bị tác động.','employee; trainee; attendee'),('-ist','Đuôi danh từ.','specialist; analyst; receptionist'),('-al (noun)','Có thể là đuôi danh từ.','approval; arrival; removal; proposal'),('-ure','Đuôi danh từ.','procedure; expenditure; failure; departure'),('-th','Đuôi danh từ.','growth; strength; width; length'),
('-ize / -ise','Đuôi động từ.','organize; authorize; specialize; maximize'),('-ify','Đuôi động từ.','notify; identify; simplify; qualify'),('-ate','Đuôi động từ.','participate; negotiate; evaluate; demonstrate'),('-en','Đuôi động từ.','strengthen; broaden; shorten; widen'),
('-ive','Đuôi tính từ.','effective; productive; competitive; impressive'),('-ful','Đuôi tính từ.','successful; helpful; meaningful; careful'),('-less','Đuôi tính từ.','regardless; careless; wireless; countless'),('-ous','Đuôi tính từ.','various; numerous; previous; enormous'),('-al (adjective)','Đuôi tính từ.','additional; professional; optional; financial'),('-able / -ible','Đuôi tính từ.','available; reliable; flexible; accessible'),('-ent / -ant','Đuôi tính từ.','different; significant; relevant; important'),('-ic','Đuôi tính từ.','specific; strategic; automatic; domestic'),('-ed adjective','Tính từ -ed thường mô tả cảm xúc/trạng thái của người bị tác động.','experienced; detailed; satisfied; qualified'),('-ing adjective','Tính từ -ing thường mô tả tính chất gây tác động.','outstanding; leading; growing; existing'),('-ly','Đuôi trạng từ phổ biến.','recently; significantly; approximately; immediately; successfully; carefully; thoroughly; consistently; considerably; frequently; currently; previously')]:
    G('Loại từ & Word Forms',term,definition,examples,'GRAMMAR',term,'1')
G('Loại từ & Word Forms','-ed vs -ing','-ed = cảm xúc/trạng thái của người bị tác động; -ing = tính chất của vật/sự việc gây tác động.','I am bored. / The movie is boring.','GRAMMAR','-ed vs -ing','1')
G('Loại từ & Word Forms','Tính từ kết thúc -ly','Một số từ kết thúc -ly vẫn là tính từ, không phải trạng từ.','friendly; timely; costly; orderly; lively; likely; lovely; lonely','GRAMMAR','adjective ending -ly','2')
G('Chủ–vị','Danh từ không đếm được','information, equipment, furniture, luggage, advice, merchandise, machinery dùng động từ số ít trong các ví dụ nguồn.','The equipment is expensive.','GRAMMAR','uncountable noun + singular verb','2')
# Prepositional fixed phrases
for term,meaning in [
('in advance','trước'),('in charge of','phụ trách'),('in accordance with','theo'),('in addition to','ngoài ra'),('in case of','trong trường hợp'),('in compliance with','tuân thủ'),('in response to','để phản hồi'),('in terms of','về mặt'),('in regard to','liên quan đến'),('in favor of','ủng hộ'),('on behalf of','thay mặt cho'),('on account of','do, bởi vì'),('on time','đúng giờ'),('on schedule','đúng tiến độ'),('at no additional cost','không tính thêm phí'),('with regard to','liên quan đến'),('regardless of','bất kể'),('as of','kể từ'),('due to','do, vì'),('owing to','do, vì'),('except for','ngoại trừ'),('instead of','thay vì'),('according to','theo'),('as a result of','kết quả của')]: G('Cụm giới từ',term,meaning,'','COLLOCATION',term,'2')
for term,meaning in [
('apply for','nộp đơn xin'),('comply with','tuân thủ'),('contribute to','đóng góp'),('deal with','giải quyết'),('depend on','phụ thuộc'),('participate in','tham gia'),('refer to','đề cập đến'),('result in','dẫn đến'),('respond to','phản hồi'),('specialize in','chuyên về'),('account for','chiếm / giải thích'),('consist of','gồm có'),('benefit from','hưởng lợi'),('approve of','tán thành'),('agree with','đồng ý với người'),('agree on','thống nhất về vấn đề'),('agree to','đồng ý với đề xuất'),('look forward to','mong đợi; theo sau bởi N/V-ing')]: G('Động từ + giới từ',term,meaning,'','COLLOCATION',term,'2')
for term,meaning in [
('responsible for','chịu trách nhiệm'),('capable of','có khả năng'),('eligible for','đủ điều kiện'),('familiar with','quen thuộc'),('interested in','quan tâm'),('satisfied with','hài lòng'),('committed to','cam kết'),('subject to','phải chịu / tùy thuộc'),('based on','dựa trên'),('concerned about','lo ngại về'),('available for / to','có sẵn cho'),('suitable for','phù hợp cho'),('aware of','nhận thức về'),('consistent with','nhất quán với'),('similar to','tương tự'),('different from','khác với')]: G('Tính từ + giới từ',term,meaning,'','COLLOCATION',term,'2')
# Connectors, grouped by the exact role/meaning given in the source.
for term,meaning in [('and','và'),('but','nhưng'),('or','hoặc'),('so','nên'),('yet','nhưng mà'),('nor','cũng không')]: G('Liên từ đẳng lập',term,meaning,'','GRAMMAR',f'{term} + mệnh đề ngang hàng','1')
for term,meaning in [('because','vì'),('since','vì'),('as','vì'),('although','mặc dù'),('though','mặc dù'),('even though','mặc dù'),('if','nếu'),('unless','trừ khi'),('provided that','miễn là'),('when','khi'),('while','trong khi'),('before','trước khi'),('after','sau khi'),('until','cho đến khi'),('once','một khi / khi'),('as soon as','ngay khi'),('so that','để mà'),('where','nơi mà'),('wherever','bất cứ nơi nào')]: G('Liên từ phụ thuộc',term,meaning,'','GRAMMAR',f'{term} + S + V','2')
for term,meaning in [('Moreover','Hơn nữa'),('Furthermore','Hơn nữa'),('In addition','Hơn nữa / ngoài ra'),('Additionally','Hơn nữa'),('However','Tuy nhiên'),('Nevertheless','Tuy nhiên'),('Nonetheless','Tuy nhiên'),('Therefore','Do đó'),('Consequently','Do đó'),('As a result','Do đó / kết quả là'),('Thus','Do đó'),('For example','Ví dụ'),('For instance','Ví dụ'),('In other words','Nói cách khác'),('That is','Nói cách khác'),('Instead','Thay vào đó'),('Otherwise','Thay vào đó / nếu không'),('Alternatively','Thay vào đó / phương án khác'),('Similarly','Tương tự'),('Likewise','Tương tự'),('Meanwhile','Trong khi đó'),('In the meantime','Trong khi đó')]: G('Trạng từ nối',term,meaning,'','GRAMMAR','Câu 1. Connector, câu 2.','2')
for term,meaning,pattern in [('Despite','mặc dù','despite + N/V-ing'),('In spite of','mặc dù','in spite of + N/V-ing'),('Because of','bởi vì','because of + N/V-ing'),('Due to','bởi vì','due to + N'),('Owing to','bởi vì','owing to + N'),('During','trong suốt','during + N')]: G('Giới từ nối',term,meaning,'','GRAMMAR',pattern,'2')
G('Bẫy liên từ','although vs despite','although + S + V ↔ despite + N/V-ing','','GRAMMAR','although + S+V / despite + N/V-ing','3')
G('Bẫy liên từ','because vs because of','because + S + V ↔ because of + N/V-ing','','GRAMMAR','because + S+V / because of + N/V-ing','3')
G('Bẫy liên từ','while vs during','while + S + V ↔ during + N','','GRAMMAR','while + S+V / during + N','3')
# Gerund / infinitive triggers.
for term in ['enjoy','avoid','consider','suggest','recommend','postpone','delay','mind','finish','practice','admit','deny','risk','involve','keep','appreciate','imagine','quit','discuss','mention']:
    G('Gerund · V-ing',f'{term} + V-ing','Động từ này đi với V-ing theo danh sách trong PDF.','','GRAMMAR',f'{term} + V-ing','2')
for term in ['want','need','plan','decide','agree','offer','promise','expect','hope','refuse','choose','manage','afford','arrange','attempt','fail','intend','learn','prepare','seem','tend','wish','would like']:
    G('Infinitive · to V',f'{term} + to V','Động từ/cụm này đi với to V theo danh sách trong PDF.','','GRAMMAR',f'{term} + to V','2')
for term in ['begin','start','continue','like','love','hate','prefer','intend']:
    G('V-ing hoặc to V',f'{term} + V-ing / to V','Có thể đi với cả V-ing và to V theo nhóm “cả hai” trong PDF.','','GRAMMAR',f'{term} + V-ing / to V','2')
for term,definition in [('remember + V-ing / to V','V-ing = nhớ đã làm; to V = nhớ phải làm.'),('stop + V-ing / to V','V-ing = dừng làm việc đó; to V = dừng lại để làm việc khác.'),('forget + V-ing / to V','V-ing = quên đã làm; to V = quên phải làm.')]: G('Gerund / Infinitive · đổi nghĩa',term,definition,'','GRAMMAR',term,'3')
# Subjunctive triggers.
for term in ['suggest','recommend','propose','request','require','demand','insist','urge','ask','advise','mandate']:
    G('Câu giả định',f'{term} that + S + V(base)','Động từ kích hoạt cấu trúc that + S + V nguyên thể.','','GRAMMAR',f'{term} that + S + V(base)','3')
for term in ['important','essential','necessary','vital','crucial','imperative','recommended','required','mandatory']:
    G('Câu giả định',f'It is {term} that + S + V(base)','Tính từ kích hoạt cấu trúc giả định với V nguyên thể.','','GRAMMAR',f'It is {term} that + S + V(base)','3')
# Confusing-word group cards preserve the source contrasts.
for term,definition,example in [
('already vs yet','already = đã (câu khẳng định); yet = chưa/đã (câu hỏi/phủ định).','The report has already been submitted. / Has the report been submitted yet?'),
('still vs yet','still = vẫn còn; yet = chưa.','The issue is still unresolved.'),
('ago vs before','ago = trước đây, thường với quá khứ đơn; before = trước, trong ví dụ nguồn dùng với quá khứ hoàn thành.','I met her two years ago. / I had met her before the meeting.'),
('many vs much','many + danh từ đếm được số nhiều; much + danh từ không đếm được.','many employees / much information'),
('a lot of / plenty of','Dùng được với cả danh từ đếm được và không đếm được.','a lot of time / a lot of people'),
('few vs a few','few = ít, sắc thái tiêu cực; a few = một vài, tích cực hơn; đi với danh từ đếm được.','Few people attended. / A few people attended.'),
('little vs a little','little = ít, tiêu cực; a little = một chút, tích cực hơn; đi với danh từ không đếm được.','There is little time left. / There is a little time left.'),
('each vs every','each nhấn mạnh từng cái; every nhấn mạnh toàn bộ.','Each employee received a bonus. / Every employee must attend.'),
('most vs almost','most = hầu hết; almost = gần như; không nói “almost employees”.','Most employees agreed. / Almost all employees agreed.'),
('economic vs economical','economic = thuộc về kinh tế; economical = tiết kiệm.','economic growth / an economical car'),
('industrial vs industrious','industrial = thuộc công nghiệp; industrious = chăm chỉ.','industrial zone / industrious worker'),
('considerate vs considerable','considerate = chu đáo; considerable = đáng kể.','a considerate colleague / considerable progress'),
('respective / respectful / respectable','respective = tương ứng; respectful = tôn trọng; respectable = đáng kính.','respective departments / respectful to colleagues / respectable company'),
('late / later / latter / latest','late = muộn/quá cố; later = sau đó; latter = cái sau trong hai cái; latest = mới nhất.','the late Mr. Smith / See you later / the latter option / the latest update'),
('so vs so that','so = nên, chỉ kết quả; so that = để mà, chỉ mục đích.','It rained, so the game was canceled. / He left early so that he could catch the train.'),
('therefore vs because','therefore = trạng từ nối “do đó”; because = liên từ “vì”.','The costs increased; therefore, we revised the budget. / We revised the budget because the costs increased.')
]: G('Từ dễ nhầm',term,definition,example,'GRAMMAR',term,'3')
write_csv('toeic-grammar-800-flashcards.csv',grammar)
