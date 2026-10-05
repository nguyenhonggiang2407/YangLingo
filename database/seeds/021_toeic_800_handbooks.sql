-- TOEIC 800+ Handbooks: content seed generated from three user-provided PDFs.
-- Additive/idempotent. Existing user data, SRS and attempts are untouched.
INSERT INTO learning_handbooks(code,title,subtitle,description,source_pdf_path,source_note,sort_order,is_active) VALUES('grammar-800','TOEIC Grammar 800+','Ngữ pháp nền tảng → Part 5–6','16 chủ đề ngữ pháp, bảng tần suất, lộ trình 11+ tuần và mẹo xử lý Part 5. Nội dung được chuyển từ PDF người dùng cung cấp thành bài đọc có tiến độ.','assets/handbooks/toeic-grammar-800-plus.pdf','User-provided PDF integrated into YangLingo',10,1) ON DUPLICATE KEY UPDATE title=VALUES(title),subtitle=VALUES(subtitle),description=VALUES(description),source_pdf_path=VALUES(source_pdf_path),source_note=VALUES(source_note),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbooks(code,title,subtitle,description,source_pdf_path,source_note,sort_order,is_active) VALUES('listening-800','TOEIC Listening 100 câu 800+','Part 1–4 · Dictation · Shadowing · Connected Speech','100 mục luyện nghe từ Part 1 đến Part 4, kèm transcript/đáp án tự kiểm tra, chiến lược, lộ trình 6 tháng và lịch 30 phút/ngày.','assets/handbooks/toeic-listening-100-cau-800-plus.pdf','User-provided PDF integrated into YangLingo',20,1) ON DUPLICATE KEY UPDATE title=VALUES(title),subtitle=VALUES(subtitle),description=VALUES(description),source_pdf_path=VALUES(source_pdf_path),source_note=VALUES(source_note),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbooks(code,title,subtitle,description,source_pdf_path,source_note,sort_order,is_active) VALUES('verb-800','TOEIC 800+ Verb Master','-ed · V1–V2–V3 · Verbs theo chủ đề · Collocations','Quy tắc -ed, 107 động từ bất quy tắc, 187 động từ TOEIC theo chủ đề, collocations và checklist Active Recall/SRS.','assets/handbooks/toeic-verb-master-800-plus.pdf','User-provided PDF integrated into YangLingo',30,1) ON DUPLICATE KEY UPDATE title=VALUES(title),subtitle=VALUES(subtitle),description=VALUES(description),source_pdf_path=VALUES(source_pdf_path),source_note=VALUES(source_note),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-01','Loại Từ (Parts Of Speech)','1. LOẠI TỪ (PARTS OF SPEECH)
★ Chiếm 30-40% câu hỏi Part 5 — quan trọng nhất!
Ý tưởng cốt lõi: Mỗi vị trí trong câu cần ĐÚNG loại từ.
  TOEIC cho 4 đáp án cùng gốc nhưng khác đuôi → bạn chọn đúng loại.
VD đề thi:
The company made a ______ to expand overseas.
  (A) decide (B) decision (C) decisive (D) decisively
    → Sau "a" cần DANH TỪ → (B) decision ✓

1.1 DANH TỪ (NOUN) — chỉ người, vật, sự việc

Vị trí danh từ:
 • Sau mạo từ: a/an/the + ___        → a decision, the improvement
 • Sau tính từ: adj + ___        → important meeting, annual report
 • Sau sở hữu: my/his/our + ___ → our agreement, his performance
 • Sau giới từ: of/in/for + ___ → lack of experience, in attendance
 • Làm chủ ngữ: ___ is/are...     → Attendance is mandatory.
 • Sau this/that/these/those         → this opportunity

Đuôi danh từ phổ biến:
-tion/-sion : information, decision, permission, contribution
-ment        : management, requirement, improvement, achievement
-ness      : awareness, effectiveness, willingness, business
-ity/-ty   : ability, productivity, quality, responsibility
-ance/-ence : performance, experience, attendance, preference
-er/-or    : manager, supervisor, employer, competitor

-ee       : employee, trainee, attendee (người bị tác động)
-ist     : specialist, analyst, receptionist
-al      : approval, arrival, removal, proposal
-ure      : procedure, expenditure, failure, departure
-th       : growth, strength, width, length

1.2 ĐỘNG TỪ (VERB) — chỉ hành động, trạng thái

Vị trí động từ:
 • Sau chủ ngữ: The manager ___ the report. → reviewed
 • Sau trợ động từ: will/can/should/must + ___ → must submit
 • Sau to: to + V nguyên thể → to improve

Đuôi động từ:
-ize/-ise : organize, authorize, specialize, maximize
-ify    : notify, identify, simplify, qualify
-ate     : participate, negotiate, evaluate, demonstrate
-en      : strengthen, broaden, shorten, widen

1.3 TÍNH TỪ (ADJECTIVE) — mô tả danh từ

Vị trí tính từ:
 • Trước danh từ: ___ + N           → annual report, significant growth
 • Sau be/seem/become/remain:           → The results are impressive.
 • Sau keep/make/find + O:           → keep customers satisfied

Đuôi tính từ:
-ive    : effective, productive, competitive, impressive
-ful    : successful, helpful, meaningful, careful
-less    : regardless, careless, wireless, countless
-ous     : various, numerous, previous, enormous
-al     : additional, professional, optional, financial
-able/-ible: available, reliable, flexible, accessible
-ent/-ant : different, significant, relevant, important
-ic     : specific, strategic, automatic, domestic
-ed      : experienced, detailed, satisfied, qualified
-ing     : outstanding, leading, growing, existing
★ Phân biệt -ed vs -ing (RẤT HAY RA ĐỀ):
-ed = cảm xúc của NGƯỜI (bị tác động)
-ing = tính chất của VẬT (gây tác động)
VD: I am bored. (Tôi chán.) ← người cảm thấy
The movie is boring. (Phim chán.) ← phim gây cảm giác
She was surprised. (Cô ấy ngạc nhiên.)
The news was surprising. (Tin gây ngạc nhiên.)

Các cặp hay thi:
interested / interesting (thú vị)

satisfied / satisfying (hài lòng)
disappointed / disappointing (thất vọng)
confused / confusing (bối rối)
excited / exciting (hào hứng)
exhausted / exhausting (kiệt sức)
convinced / convincing (thuyết phục)

1.4 TRẠNG TỪ (ADVERB) — bổ nghĩa cho động từ, tính từ, cả câu

Vị trí trạng từ:
• Trước tính từ: ___ + adj      → highly effective, extremely important
• Trước trạng từ khác:           → very quickly, quite recently
• Bổ nghĩa động từ:            → increased significantly
• Đầu câu (bổ nghĩa cả câu): → Unfortunately, the event was canceled.
Đuôi trạng từ: hầu hết thêm -ly vào tính từ
-ly : recently, significantly, approximately, immediately,
successfully, carefully, thoroughly, consistently,
considerably, frequently, currently, previously
★ Ngoại lệ KHÔNG có -ly nhưng vẫn là trạng từ:
very, quite, rather, almost, already, still, just, even, often
★ Tính từ kết thúc bằng -ly (KHÔNG phải trạng từ — BẪY):
friendly, timely, costly, orderly, lively, likely, lovely, lonely
VD: a friendly staff ← tính từ, KHÔNG phải trạng từ

TÓM TẮT NHANH — CÁCH CHỌN LOẠI TỪ:
 a/an/the/my/his/our + (adj) + [___] → DANH TỪ
 S + [___] + O                 → ĐỘNG TỪ
 [___] + danh từ                → TÍNH TỪ
 [___] + tính từ / động từ          → TRẠNG TỪ
 be/seem/become + [___]               → TÍNH TỪ
VD đề thi:
 1. The manager gave a ______ presentation.
 (A) convince (B) convincing (C) convinced (D) convincingly
   → a + ___ + presentation (N) → cần ADJ → (B) convincing ✓
(convincing = gây ấn tượng; convinced = bị thuyết phục)
 2. The project was completed ______.
 (A) success (B) successful (C) successfully (D) succeed
   → bổ nghĩa cho "completed" (V) → cần ADV → (C) successfully ✓
 3. Customer ______ is our top priority.
 (A) satisfy (B) satisfied (C) satisfying (D) satisfaction
   → Làm chủ ngữ → cần NOUN → (D) satisfaction ✓','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 10,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-02','Thì (Tenses)','2. THÌ (TENSES)
★ Chiếm 10-15% câu hỏi Part 5/6
Mẹo: TOEIC không hỏi lý thuyết, chỉ cho bạn chọn dạng đúng.

Nhìn DẤU HIỆU THỜI GIAN trong câu để chọn thì.

2.1 HIỆN TẠI ĐƠN (Simple Present)
Cấu trúc: S + V(s/es)
Dùng khi: thói quen, sự thật, lịch trình cố định
Dấu hiệu: always, usually, often, sometimes, every day/week/year,
regularly, frequently, occasionally
VD: The store opens at 9 A.M. every day.
(Cửa hàng mở cửa lúc 9 giờ mỗi ngày.)
Employees usually submit reports on Friday.
(Nhân viên thường nộp báo cáo vào thứ Sáu.)

2.2 HIỆN TẠI TIẾP DIỄN (Present Continuous)
Cấu trúc: S + am/is/are + V-ing
Dùng khi: đang xảy ra, tạm thời, kế hoạch tương lai gần
Dấu hiệu: now, at the moment, currently, right now, this week
VD: We are currently updating our website.
(Chúng tôi đang cập nhật website.)
The company is expanding its operations in Asia.
(Công ty đang mở rộng hoạt động ở châu Á.)

2.3 HIỆN TẠI HOÀN THÀNH (Present Perfect) ★ RẤT HAY THI
Cấu trúc: S + have/has + V3 (past participle)
Dùng khi: hành động bắt đầu trong quá khứ, kéo dài hoặc ảnh hưởng đến hiện tại
Dấu hiệu: since, for, already, yet, just, recently, lately,
so far, up to now, ever, never, over the past [time]
VD: She has worked here since 2020.
(Cô ấy đã làm ở đây từ 2020.)
We have already submitted the proposal.
(Chúng tôi đã nộp bản đề xuất rồi.)
Sales have increased over the past year.
(Doanh số đã tăng trong năm qua.)
★ since + mốc thời gian: since Monday, since 2020, since last month
★ for + khoảng thời gian: for three years, for a long time

2.4 HIỆN TẠI HOÀN THÀNH TIẾP DIỄN (Present Perfect Continuous)
Cấu trúc: S + have/has + been + V-ing
Dùng khi: hành động bắt đầu trong quá khứ, VẪN ĐANG tiếp diễn, nhấn mạnh quá trình
Dấu hiệu: for, since, all day, all morning
VD: They have been negotiating the contract for two weeks.
(Họ đã đàm phán hợp đồng suốt 2 tuần nay.)

2.5 QUÁ KHỨ ĐƠN (Simple Past)
Cấu trúc: S + V2 (past tense) / V-ed
Dùng khi: hành động đã hoàn thành trong quá khứ
Dấu hiệu: yesterday, last week/month/year, ago, in 2020,

at that time, previously, formerly
VD: The company launched a new product last month.
(Công ty ra mắt sản phẩm mới tháng trước.)
She resigned two weeks ago.
(Cô ấy từ chức 2 tuần trước.)

2.6 QUÁ KHỨ TIẾP DIỄN (Past Continuous)
Cấu trúc: S + was/were + V-ing
Dùng khi: hành động đang xảy ra tại một thời điểm trong quá khứ,
hoặc đang xảy ra thì bị một hành động khác cắt ngang
Dấu hiệu: while, when, at that time, at 3 P.M. yesterday
VD: While I was reviewing the document, the phone rang.
(Trong khi tôi đang xem tài liệu, điện thoại reo.)

2.7 QUÁ KHỨ HOÀN THÀNH (Past Perfect)
Cấu trúc: S + had + V3
Dùng khi: hành động xảy ra TRƯỚC một hành động khác trong quá khứ
Dấu hiệu: before, after, by the time, already, until, once
VD: By the time the manager arrived, the meeting had already started.
(Lúc quản lý đến, cuộc họp đã bắt đầu rồi.)
She had completed the report before the deadline.
(Cô ấy đã hoàn thành báo cáo trước hạn chót.)

2.8 TƯƠNG LAI ĐƠN (Simple Future)
Cấu trúc: S + will + V nguyên thể
Dùng khi: dự đoán, quyết định tức thì, hứa hẹn, sự kiện tương lai
Dấu hiệu: tomorrow, next week/month/year, soon, in the future
VD: The new policy will take effect next month.
(Chính sách mới sẽ có hiệu lực tháng tới.)

2.9 TƯƠNG LAI GẦN (Be going to)
Cấu trúc: S + am/is/are + going to + V
Dùng khi: kế hoạch đã quyết định, dự đoán có bằng chứng
VD: We are going to hire ten more employees.
(Chúng tôi sẽ tuyển thêm 10 nhân viên.)

2.10 TƯƠNG LAI TIẾP DIỄN (Future Continuous)
Cấu trúc: S + will be + V-ing
Dùng khi: hành động sẽ đang xảy ra tại một thời điểm tương lai
VD: This time next week, I will be attending the conference.
(Giờ này tuần sau, tôi sẽ đang dự hội nghị.)

2.11 TƯƠNG LAI HOÀN THÀNH (Future Perfect) ★ HAY THI
Cấu trúc: S + will have + V3
Dùng khi: hành động sẽ hoàn thành TRƯỚC một thời điểm tương lai
Dấu hiệu: by + thời gian tương lai, by the time, by the end of

VD: By the end of this quarter, we will have completed the project.
(Đến cuối quý này, chúng tôi sẽ hoàn thành dự án.)
By next Friday, she will have worked here for ten years.
(Đến thứ Sáu tới, cô ấy sẽ làm ở đây được 10 năm.)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 20,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-03','Câu Bị Động (Passive Voice)','3. CÂU BỊ ĐỘNG (PASSIVE VOICE)
★ Rất hay xuất hiện trong TOEIC vì ngữ cảnh công việc
Cấu trúc: S + be + V3 (past participle)
Dùng khi: không cần/không biết ai làm, nhấn mạnh đối tượng bị tác động.
Bảng chia thì ở bị động:
 Hiện tại đơn:     is/am/are + V3     → Reports are submitted weekly.
 Hiện tại tiếp diễn: is/am/are being + V3 → The road is being repaired.
 Hiện tại hoàn thành: has/have been + V3 → The order has been shipped.
 Quá khứ đơn:        was/were + V3        → The event was canceled.
 Quá khứ tiếp diễn: was/were being + V3 → The system was being updated.
 Quá khứ hoàn thành: had been + V3             → The issue had been resolved.
 Tương lai đơn:      will be + V3     → You will be notified.
 Tương lai hoàn thành: will have been + V3 → It will have been completed.
 Sau modal:        can/should be + V3 → Tickets can be purchased online.
★ Mẹo TOEIC: Nếu chủ ngữ là VẬT/NGƯỜI bị tác động → chọn bị động
VD: The meeting ______ to next Monday.
 (A) postponed (B) was postponed (C) postponing (D) has postponing
   → meeting bị hoãn → bị động → (B) was postponed ✓','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 30,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-04','Sự Hòa Hợp Chủ - Vị (Subject-Verb Agreement)','4. SỰ HÒA HỢP CHỦ - VỊ (SUBJECT-VERB AGREEMENT)
Nguyên tắc: Chủ ngữ số ít → V số ít (has/is/V-s)
 Chủ ngữ số nhiều → V số nhiều (have/are/V)

Dễ bị nhầm khi câu dài, giới từ chen giữa:
The list of candidates HAS been reviewed. ✓
(list = số ít, of candidates chỉ là bổ ngữ)
KHÔNG PHẢI: The list of candidates HAVE been reviewed. ✗

Các trường hợp đặc biệt:

LUÔN SỐ ÍT:
Each / Every + N số ít + V số ít
   → Each employee is required to attend.
Everyone / Everybody / Someone / Nobody + V số ít
   → Everyone has been informed.
The number of + N + V số ít
   → The number of complaints has decreased.
V-ing làm chủ ngữ:
   → Attending the workshop is mandatory.

Danh từ không đếm được (information, equipment, furniture,
luggage, advice, merchandise, machinery):
   → The equipment is expensive. (KHÔNG: are expensive)

LUÔN SỐ NHIỀU:
A number of + N + V số nhiều
   → A number of employees have signed up.
Both / Several / Many / Few + V số nhiều
   → Both options are acceptable.

TÙY THUỘC:
 Either A or B → V theo B (gần nhất)
   → Either the manager or the staff members are responsible.
 Neither A nor B → V theo B
   → Neither the employees nor the director was available.
VD đề thi:
The results of the survey ______ that customers prefer online shopping.
 (A) indicates (B) indicate (C) indicating (D) to indicate
   → results = số nhiều → (B) indicate ✓','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 40,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-05','Đại Từ (Pronouns)','5. ĐẠI TỪ (PRONOUNS)
Bảng đại từ:
 Chủ ngữ                Tân ngữ               Sở hữu (adj)           Sở hữu (pron)          Phản thân
 I                      me                    my                     mine                   myself
 you                    you                   your                   yours                  yourself
 he                     him                   his                    his                    himself
 she                    her                   her                    hers                   herself
 it                     it                    its                    —                      itself
 we                     us                    our                    ours                   ourselves
 they                   them                  their                  theirs                 themselves

Cách dùng:
 Chủ ngữ: ___ + V        → She approved the budget.
 Tân ngữ: V + ___        → The manager contacted her.
 Sở hữu adj: ___ + N      → Please bring your ID.
 Sở hữu pron: thay N      → The report is mine. (= my report)
 Phản thân: tự mình        → He completed the task himself.
★ HAY THI — those who / those + V-ing / those + V3:
Those who register early will receive a discount.
(Những ai đăng ký sớm sẽ được giảm giá.)
Those interested should contact HR.
(Những ai quan tâm hãy liên hệ HR.)
★ HAY THI — it vs its vs it''s:
 it''s = it is (nó là)   → It''s important to arrive on time.
 its = của nó (sở hữu)     → The company increased its revenue.
KHÔNG BAO GIỜ: its'' ← không tồn tại!

★ HAY THI — other / another / the other / others:
another + N số ít = thêm một cái nữa
   → We need another week. (Thêm 1 tuần nữa.)
other + N số nhiều = những cái khác (chưa xác định)
   → Other employees will be notified. (Nhân viên khác sẽ được thông báo.)
the other = cái còn lại (đã xác định)
   → One office is downtown; the other is in the suburbs.
others = những người/cái khác (đại từ)
   → Some agreed; others disagreed.','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 50,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-06','Mạo Từ (Articles: A, An, The)','6. MẠO TỪ (ARTICLES: a, an, the)
a/an = một (chưa xác định, lần đầu nhắc đến)
a + phụ âm: a report, a university (/juː/ = phụ âm)
an + nguyên âm: an employee, an hour (/aʊ/ = nguyên âm)
the = cái đó (xác định, đã biết, duy nhất)
the conference room (phòng họp mà hai người đều biết)
the CEO of the company (chỉ có 1)
the results of the survey (kết quả cụ thể)

Không dùng mạo từ:
Danh từ chung, không xác định, số nhiều: Employees must wear badges.
Danh từ không đếm được nói chung: Information is available online.
Trước tên riêng: Mr. Tanaka, Tokyo, Flect Co.
VD đề thi:
______ attached document contains the project timeline.
 (A) A (B) An (C) The (D) —
   → tài liệu đính kèm cụ thể → (C) The ✓','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 60,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-07','Giới Từ (Prepositions)','7. GIỚI TỪ (PREPOSITIONS)
★ Rất hay thi, cần học thuộc các cụm cố định

Giới từ thời gian:
at + giờ cụ thể:        at 3 P.M., at noon, at midnight
on + ngày/thứ:          on Monday, on July 5th, on weekends
in + tháng/năm/mùa:         in March, in 2025, in the morning
by + hạn chót:          by Friday (trước thứ Sáu)
within + khoảng thời gian: within 24 hours (trong vòng 24 giờ)
during + sự kiện:        during the meeting (trong suốt cuộc họp)
throughout + cả quá trình: throughout the year (suốt cả năm)
until/till + đến khi:    until 5 P.M. (đến 5 giờ chiều)
prior to + trước khi:     prior to the event (trước sự kiện)
following + sau khi:       following the presentation (sau buổi thuyết trình)

Giới từ địa điểm:
at + địa chỉ cụ thể:     at the office, at 123 Oak Street

in + không gian lớn/bên trong: in Tokyo, in the building, in Room 3
on + bề mặt/tầng:             on the table, on the second floor

Cụm giới từ hay thi (HỌC THUỘC):
 in advance (trước)                                      in charge of (phụ trách)
 in accordance with (theo)                               in addition to (ngoài ra)
 in case of (trong trường hợp)                           in compliance with (tuân thủ)
 in response to (để phản hồi)                            in terms of (về mặt)
 in regard to (liên quan đến)                            in favor of (ủng hộ)
 on behalf of (thay mặt cho)                             on account of (do, bởi vì)
 on time (đúng giờ)                                      on schedule (đúng tiến độ)

at no additional cost (không tính thêm phí)
with regard to (liên quan đến)
 regardless of (bất kể)                                  as of (kể từ: as of January 1)
 due to (do, vì)                                         owing to (do, vì)
 except for (ngoại trừ)                                  instead of (thay vì)
 according to (theo)                                     as a result of (kết quả của)

Động từ + giới từ (hay thi):
 apply for (nộp đơn xin)                                 comply with (tuân thủ)
 contribute to (đóng góp)                                deal with (giải quyết)
 depend on (phụ thuộc)                                   participate in (tham gia)
 refer to (đề cập đến)                                   result in (dẫn đến)
 respond to (phản hồi)                                   specialize in (chuyên về)
 account for (chiếm/giải thích)                          consist of (gồm có)
 benefit from (hưởng lợi)                                approve of (tán thành)
 agree with/on/to                                        look forward to (mong đợi)

agree with + người (đồng ý với ai)
agree on + vấn đề (thống nhất về)
agree to + đề xuất (đồng ý với đề xuất)

Tính từ + giới từ (hay thi):
responsible for (chịu trách nhiệm)
capable of (có khả năng)
eligible for (đủ điều kiện)
familiar with (quen thuộc)
interested in (quan tâm)
satisfied with (hài lòng)
committed to (cam kết)
subject to (phải chịu/tùy thuộc)
based on (dựa trên)
concerned about (lo ngại về)
available for/to (có sẵn cho)
suitable for (phù hợp cho)
aware of (nhận thức về)
consistent with (nhất quán với)
similar to (tương tự)
different from (khác với)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 70,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-08','Liên Từ & Từ Nối (Conjunctions & Connectors)','8. LIÊN TỪ & TỪ NỐI (CONJUNCTIONS & CONNECTORS)
★ Rất hay thi Part 5/6 — phân biệt loại từ nối

8.1 LIÊN TỪ ĐẲNG LẬP (nối 2 vế ngang hàng)
                                                                                             nor (cũng
 and (và)            but (nhưng)       or (hoặc)         so (nên)           yet (nhưng mà)
                                                                                             không)

VD: The deadline is Friday, so please submit your work early.

8.2 LIÊN TỪ PHỤ THUỘC (nối mệnh đề phụ với mệnh đề chính)
Cấu trúc: ____ + S + V, S + V.
Nguyên nhân:       because / since / as (vì)
Nhượng bộ:        although / though / even though (mặc dù)
Điều kiện:      if / unless (nếu / trừ khi) / provided that (miễn là)
Thời gian:      when / while / before / after / until / once / as soon as
Mục đích:        so that (để mà)
Nơi chốn:       where / wherever
VD: Although the project was behind schedule, the team managed to finish on time.
(Mặc dù dự án trễ tiến độ, đội vẫn hoàn thành đúng hạn.)

8.3 TRẠNG TỪ NỐI (nối 2 câu độc lập)
Cấu trúc: Câu 1. ______, câu 2. HOẶC Câu 1; ______, câu 2.
Bổ sung:       Moreover / Furthermore / In addition / Additionally (Hơn nữa)
Tương phản: However / Nevertheless / Nonetheless (Tuy nhiên)
Kết quả:       Therefore / Consequently / As a result / Thus (Do đó)
Ví dụ:        For example / For instance (Ví dụ)
Nói cách khác: In other words / That is (Nói cách khác)
Thay vào đó: Instead / Otherwise / Alternatively (Thay vào đó)
Tương tự:       Similarly / Likewise (Tương tự)
Ngoài ra:      Meanwhile / In the meantime (Trong khi đó)
VD: The budget was cut. Therefore, some projects were postponed.
(Ngân sách bị cắt. Do đó, một số dự án bị hoãn.)

8.4 GIỚI TỪ NỐI (đi với cụm danh từ hoặc V-ing, KHÔNG đi với mệnh đề)
Cấu trúc: ____ + N / V-ing
Mặc dù:       Despite / In spite of + N/V-ing (mặc dù)
Bởi vì:      Because of / Due to / Owing to + N (bởi vì)
Trong suốt: During + N (trong suốt)
VD: Despite the rain, the event was held outdoors.
(Mặc dù trời mưa, sự kiện vẫn tổ chức ngoài trời.)
★★★ PHÂN BIỆT QUAN TRỌNG NHẤT (HAY THI):
 although + S + V          ←→ despite + N/V-ing
 because + S + V           ←→ because of + N/V-ing
 while + S + V           ←→ during + N
VD:

Although it rained, we went out. ← mệnh đề (S + V)
Despite the rain, we went out. ← cụm danh từ (N)
Because the costs increased, we cut the budget. ← mệnh đề
Because of the increased costs, we cut the budget. ← cụm danh từ
VD đề thi:
______ the heavy traffic, Ms. Kim arrived on time.
 (A) Although (B) Despite (C) Because (D) However
   → "the heavy traffic" = cụm danh từ → cần giới từ → (B) Despite ✓
 (A) sai vì although cần mệnh đề (S + V)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 80,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-09','Mệnh Đề Quan Hệ (Relative Clauses)','9. MỆNH ĐỀ QUAN HỆ (RELATIVE CLAUSES)
Đại từ quan hệ:
 who    → thay cho NGƯỜI (chủ ngữ)
 whom → thay cho NGƯỜI (tân ngữ)
 which → thay cho VẬT
 that → thay cho NGƯỜI hoặc VẬT
 whose → thay cho SỞ HỮU (của ai/của cái gì)
 where → thay cho NƠI CHỐN
 when → thay cho THỜI GIAN
VD:
The employee who submitted the report will be rewarded.
(Nhân viên mà nộp báo cáo sẽ được thưởng.)
The software which was installed last week is not working.
(Phần mềm mà được cài tuần trước không hoạt động.)
The company whose products are popular expanded overseas.
(Công ty mà sản phẩm nổi tiếng đã mở rộng ra nước ngoài.)
The hotel where the conference will be held is downtown.
(Khách sạn nơi hội nghị sẽ diễn ra ở trung tâm.)
★ HAY THI — Rút gọn mệnh đề quan hệ:
V-ing (chủ động):
The man standing at the door = The man who is standing at the door
V3/V-ed (bị động):
The report submitted yesterday = The report which was submitted yesterday
VD đề thi:
Applicants ______ meet the requirements will be contacted.
 (A) who (B) which (C) whose (D) whom
   → Applicants = người + làm chủ ngữ → (A) who ✓','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 90,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-10','So Sánh (Comparatives & Superlatives)','10. SO SÁNH (COMPARATIVES & SUPERLATIVES)
So sánh hơn (Comparative): so sánh 2 đối tượng
Adj/Adv ngắn (1 âm tiết): adj-ER + than
   → This office is larger than the old one.
Adj/Adv dài (2+ âm tiết): MORE + adj + than
   → This method is more efficient than the previous one.

So sánh nhất (Superlative): so sánh 3+ đối tượng
Adj/Adv ngắn: THE + adj-EST
   → This is the largest office in the building.
Adj/Adv dài: THE MOST + adj
   → This is the most efficient method available.

Bất quy tắc:
 good/well → better → the best
 bad/badly → worse → the worst
 many/much → more → the most
 little → less → the least
 far → farther/further → the farthest/furthest

So sánh bằng:
as + adj/adv + as
   → This model is as reliable as the previous one.
(Model này đáng tin cậy bằng model trước.)
not as + adj/adv + as = kém hơn
   → This printer is not as fast as that one.
★ HAY THI — so sánh kép (càng... càng...):
The more you practice, the better you get.
(Càng luyện tập nhiều, bạn càng giỏi hơn.)
VD đề thi:
The new system is significantly ______ than the old one.
 (A) fast (B) faster (C) fastest (D) fastly
   → "than" = so sánh hơn → (B) faster ✓','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 100,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-11','Câu Điều Kiện (Conditionals)','11. CÂU ĐIỀU KIỆN (CONDITIONALS)
Loại 0 — Sự thật hiển nhiên:
If + S + V(s), S + V(s).
   → If you heat water to 100°C, it boils.
Loại 1 — Có thể xảy ra (tương lai): ★ HAY THI NHẤT
If + S + V (hiện tại), S + will/can/should + V.
   → If sales increase, we will hire more staff.
(Nếu doanh số tăng, chúng tôi sẽ tuyển thêm.)
   → If you have any questions, please contact us.
(Nếu bạn có thắc mắc, vui lòng liên hệ.)
Loại 2 — Không có thật ở hiện tại (giả định):
If + S + V(quá khứ), S + would/could + V.
   → If I had more time, I would attend the seminar.
(Nếu tôi có nhiều thời gian hơn, tôi sẽ dự hội thảo.)
Loại 3 — Không có thật trong quá khứ (tiếc nuối):
If + S + had + V3, S + would have + V3.
   → If we had started earlier, we would have met the deadline.
(Nếu chúng tôi bắt đầu sớm hơn, chúng tôi đã kịp hạn.)

★ Unless = If ... not (trừ khi):
Unless you register by Friday, you will not be admitted.
= If you do not register by Friday, you will not be admitted.
(Trừ khi bạn đăng ký trước thứ Sáu, bạn sẽ không được nhận.)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 110,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-12','Động Từ Khuyết Thiếu (Modal Verbs)','12. ĐỘNG TỪ KHUYẾT THIẾU (MODAL VERBS)
Cấu trúc: S + modal + V nguyên thể (KHÔNG chia, KHÔNG thêm s/to)
 can      = có thể (khả năng)        → She can speak three languages.
 could     = có thể (quá khứ/lịch sự) → Could you send me the file?
 may       = có thể (cho phép/xác suất)→ You may leave early today.
 might     = có thể (xác suất thấp) → It might rain tomorrow.
 should    = nên                  → You should review the contract.
 must      = phải (bắt buộc)         → Visitors must wear badges.
 will     = sẽ                 → The package will arrive tomorrow.
 would     = sẽ (điều kiện/lịch sự) → Would you mind helping me?
 shall    = sẽ (trang trọng)        → Shall we proceed?
 need      = cần                 → You need not worry.
 ought to = nên (= should)            → We ought to review the data.
★ HAY THI — Phân biệt:
must = chắc chắn phải (100%)
   → All employees must attend the meeting.
should = nên (khuyên nhủ)
   → Employees should arrive 10 minutes early.
may/might = có thể (cho phép/khả năng)
   → Guests may use the parking lot.
★ HAY THI — must vs have to:
must = bắt buộc (nội quy, luật)
have to = phải (hoàn cảnh bắt buộc)
don''t have to = không cần phải (khác "must not" = cấm!)
   → You must not park here. (Cấm đỗ xe ở đây.)
   → You don''t have to attend. (Không cần phải dự.)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 120,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-13','Gerund Vs Infinitive (V-Ing Vs To V)','13. GERUND vs INFINITIVE (V-ing vs to V)
GERUND (V-ing) — Động từ đi với V-ing:
enjoy, avoid, consider, suggest, recommend, postpone, delay,
mind, finish, practice, admit, deny, risk, involve, keep,
appreciate, imagine, quit, discuss, mention
VD: She enjoys working from home.
We considered hiring a consultant.
I appreciate your helping us.
INFINITIVE (to V) — Động từ đi với to V:
want, need, plan, decide, agree, offer, promise, expect,
hope, refuse, choose, manage, afford, arrange, attempt,

fail, intend, learn, prepare, seem, tend, wish, would like
VD: They decided to expand overseas.
She agreed to postpone the meeting.
We plan to launch a new product.
CẢ HAI (nghĩa giống nhau):
begin, start, continue, like, love, hate, prefer, intend
VD: It started raining. = It started to rain.
CẢ HAI (nghĩa KHÁC nhau) — BẪY:
remember + V-ing = nhớ đã làm (quá khứ)
remember + to V = nhớ phải làm (tương lai)
   → I remember meeting him. (Tôi nhớ đã gặp anh ấy.)
   → Remember to submit the report. (Nhớ nộp báo cáo nhé.)
stop + V-ing = dừng làm việc đó
stop + to V = dừng lại để làm việc khác
   → She stopped talking. (Cô ấy ngừng nói.)
   → She stopped to talk. (Cô ấy dừng lại để nói chuyện.)
forget + V-ing = quên đã làm
forget + to V = quên phải làm
★ Sau giới từ → LUÔN dùng V-ing:
interested in learning, capable of handling, look forward to hearing,
instead of waiting, in addition to managing, prior to attending
VD: We look forward to hearing from you. ← "to" ở đây là GIỚI TỪ, không phải to V!','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 130,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-14','Câu Giả Định (Subjunctive)','14. CÂU GIẢ ĐỊNH (SUBJUNCTIVE)
★ Hay thi ở trình độ cao
Cấu trúc: S + động từ đề nghị/yêu cầu + that + S + V nguyên thể
Các động từ kích hoạt:
suggest, recommend, propose, request, require, demand,
insist, urge, ask, advise, mandate
VD:
The manager suggested that she attend the training.
(Quản lý đề nghị cô ấy tham dự đào tạo.)
   → attend, KHÔNG PHẢI attends (dù chủ ngữ she)
It is important that all employees be on time.
   → be, KHÔNG PHẢI are
The policy requires that each employee submit a report monthly.
   → submit, KHÔNG PHẢI submits
★ Tính từ kích hoạt (It is ___ that + S + V nguyên thể):
important, essential, necessary, vital, crucial, imperative,
recommended, required, mandatory','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 140,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-15','Cấu Trúc Song Song (Parallel Structure)','15. CẤU TRÚC SONG SONG (PARALLEL STRUCTURE)
Nguyên tắc: Các thành phần nối bằng and/or/but phải CÙNG dạng.

SAI: The job requires writing reports, to analyze data, and communication.
 (V-ing + to V + N → lộn xộn)
ĐÚNG: The job requires writing reports, analyzing data, and communicating.
 (V-ing + V-ing + V-ing → song song)
ĐÚNG: The job requires the ability to write reports, analyze data, and communicate.
 (to V + V + V → song song sau to)
VD đề thi:
The seminar will cover how to manage time, set priorities, and ______ effectively.
 (A) communicate (B) communication (C) communicating (D) communicated
   → manage, set, ___ → cần V nguyên thể → (A) communicate ✓
★ Cũng áp dụng cho both...and, either...or, neither...nor,
not only...but also, whether...or:
The company not only reduced costs but also improved quality.
(Công ty không chỉ giảm chi phí mà còn cải thiện chất lượng.)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 150,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-16','Từ Gây Nhầm Lẫn (Confusing Words)','16. TỪ GÂY NHẦM LẪN (CONFUSING WORDS)
★ Các cặp từ TOEIC rất thích hỏi

Trạng từ thời gian:
already (đã — câu khẳng định) vs yet (chưa/đã — câu hỏi/phủ định)
   → The report has already been submitted.
   → Has the report been submitted yet?
still (vẫn còn) vs yet (chưa)
   → The issue is still unresolved. (Vấn đề vẫn chưa giải quyết.)
ago (trước đây — quá khứ đơn) vs before (trước — quá khứ hoàn thành)
   → I met her two years ago.
   → I had met her before the meeting.

Lượng từ:
many + đếm được (N số nhiều): many employees
much + không đếm được: much information
a lot of / plenty of + cả hai: a lot of time, a lot of people
few (ít — tiêu cực) vs a few (một vài — tích cực) + đếm được
   → Few people attended. (Ít người dự — đáng buồn.)
   → A few people attended. (Một vài người dự — vẫn ổn.)
little (ít — tiêu cực) vs a little (một chút — tích cực) + không đếm được
   → There is little time left. (Còn ít thời gian.)
   → There is a little time left. (Còn một chút thời gian.)
each (mỗi — nhấn mạnh từng cái) vs every (mỗi — nhấn mạnh toàn bộ)
   → Each employee received a bonus.
   → Every employee must attend.
most (hầu hết) vs almost (gần như)
   → Most employees agreed. (Hầu hết nhân viên đồng ý.)
   → Almost all employees agreed. (Gần như tất cả đồng ý.)

★ KHÔNG NÓI: Almost employees ← SAI!

Tính từ gây nhầm:
economic (thuộc về kinh tế) vs economical (tiết kiệm)
   → economic growth (tăng trưởng kinh tế)
   → an economical car (xe tiết kiệm nhiên liệu)
industrial (thuộc công nghiệp) vs industrious (chăm chỉ)
   → industrial zone vs industrious worker
considerate (chu đáo) vs considerable (đáng kể)
   → a considerate colleague vs considerable progress
respective (tương ứng) vs respectful (tôn trọng) vs respectable (đáng kính)
   → Return to your respective departments.
   → Be respectful to your colleagues.
   → a respectable company
late (muộn/cố) vs later (sau đó) vs latter (cái sau — trong 2 cái) vs latest (mới nhất)
   → the late Mr. Smith (ông Smith quá cố)
   → See you later. (Gặp lại sau.)
   → The latter option is better. (Lựa chọn thứ hai tốt hơn.)
   → the latest update (bản cập nhật mới nhất)

Từ nối gây nhầm:
so (nên — kết quả) vs so that (để mà — mục đích)
   → It rained, so the game was canceled. (kết quả)
   → He left early so that he could catch the train. (mục đích)
therefore (do đó — trạng từ, cần dấu ; hoặc .) vs because (vì — liên từ)
   → The costs increased; therefore, we revised the budget. (2 câu)
   → We revised the budget because the costs increased. (1 câu)','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 160,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'grammar-roadmap','Tần suất, lộ trình 11+ tuần & mẹo Part 5','BẢNG TÓM TẮT — TẦN SUẤT RA ĐỀ THEO CHỦ ĐỀ
 Chủ đề ngữ pháp                     Tần suất Part 5                   Tần suất Part 6
 Loại từ (Parts of Speech)           ★★★★★ (30-40%)                    ★★★★
 Thì (Tenses)                        ★★★★ (10-15%)                     ★★★★★
 Giới từ (Prepositions)              ★★★★ (10-15%)                     ★★★
 Liên từ & Từ nối                    ★★★★ (10-15%)                     ★★★★★
 Đại từ (Pronouns)                   ★★★ (5-8%)                        ★★★
 Câu bị động                         ★★★ (5-8%)                        ★★★
 Sự hòa hợp chủ-vị                   ★★ (3-5%)                         ★★
 So sánh                             ★★ (3-5%)                         ★★
 Mạo từ                              ★★ (2-4%)                         ★
 Gerund/Infinitive                   ★★ (2-4%)                         ★★
 Câu giả định                        ★ (1-2%)                          ★
 Câu điều kiện                       ★ (1-2%)                          ★★
 Cấu trúc song song                  ★ (1-2%)                          ★

LỘ TRÌNH HỌC NGỮ PHÁP CHO NGƯỜI MẤT GỐC
TUẦN 1-2: NỀN TẢNG
   → Loại từ (Mục 1) — học kỹ, nắm chắc, đây là cốt lõi

   → Thì hiện tại đơn, quá khứ đơn, tương lai đơn (Mục 2)

TUẦN 3-4: NÂNG CẤP
   → Thì hiện tại hoàn thành, quá khứ hoàn thành (Mục 2)
   → Câu bị động (Mục 3)
   → Đại từ (Mục 5)

TUẦN 5-6: MỞ RỘNG
   → Giới từ — học thuộc các cụm cố định (Mục 7)
   → Liên từ & Từ nối (Mục 8) — đặc biệt although vs despite
   → Sự hòa hợp chủ-vị (Mục 4)

TUẦN 7-8: HOÀN THIỆN
   → Mệnh đề quan hệ (Mục 9)
   → So sánh (Mục 10)
   → Câu điều kiện (Mục 11)
   → Modal verbs (Mục 12)

TUẦN 9-10: NÂNG CAO
   → Gerund vs Infinitive (Mục 13)
   → Câu giả định (Mục 14)
   → Cấu trúc song song (Mục 15)
   → Từ gây nhầm lẫn (Mục 16)

TUẦN 11+: LUYỆN ĐỀ
   → Làm đề Part 5 + Part 6 hàng ngày (10-15 câu/ngày)
   → Ghi lại lỗi sai, phân loại theo chủ đề ngữ pháp
   → Ôn lại chủ đề nào sai nhiều

MẸO LÀM BÀI PART 5 (30 câu — 10 phút)
 1. Nhìn 4 đáp án TRƯỚC:
• Cùng gốc khác đuôi → câu hỏi LOẠI TỪ → xác định vị trí cần điền
• 4 từ khác nhau hoàn toàn → câu hỏi TỪ VỰNG → đọc cả câu
• 4 dạng chia khác nhau → câu hỏi CHIA ĐỘNG TỪ → tìm dấu hiệu thì
 2. Không cần đọc CẢ CÂU cho mọi câu hỏi:
• Câu loại từ: chỉ cần nhìn xung quanh chỗ trống
• Câu từ vựng: phải đọc cả câu để hiểu nghĩa
• Câu ngữ pháp: đọc đủ để xác định cấu trúc
 3. Mỗi câu tối đa 20 giây — không nên quá 30 giây
 Không chắc → đánh dấu, quay lại sau
Chúc bạn học tốt và đạt 800+ TOEIC!
Kiên trì mỗi ngày, từ mất gốc vẫn lên được 800!','{"source":"user-provided PDF","handbook_code":"grammar-800"}', 170,1 FROM learning_handbooks WHERE code='grammar-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-guide','Cách dùng tài liệu','CÁCH DÙNG TÀI LIỆU
    Mỗi câu nên luyện theo 4 bước: nghe không nhìn transcript → chọn/đoán → mở transcript và phân tích
    → nghe lại + shadowing.','{"source":"user-provided PDF","handbook_code":"listening-800"}', 10,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-overview','Tổng quan TOEIC Listening','TỔNG QUAN ĐỀ NGHE TOEIC (100 câu — 45 phút)
Part 1: Mô tả tranh (Photographs) — 6 câu
  → Nghe 4 câu mô tả, chọn câu đúng với bức tranh
Part 2: Hỏi – Đáp (Question-Response) — 25 câu
  → Nghe 1 câu hỏi + 3 đáp án, chọn đáp án phù hợp
Part 3: Hội thoại (Conversations) — 39 câu
  → Nghe đoạn hội thoại 2-3 người, trả lời 3 câu hỏi/đoạn
Part 4: Bài nói ngắn (Talks) — 30 câu
  → Nghe bài nói 1 người (thông báo, tin nhắn...), trả lời 3 câu hỏi/đoạn','{"source":"user-provided PDF","handbook_code":"listening-800"}', 20,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-part1','Part 1 — Photographs','PART 1 — MÔ TẢ TRANH (6 câu)
Dạng đề: Xem tranh → Nghe 4 câu (A, B, C, D) → Chọn câu mô tả đúng nhất.
Bẫy thường gặp: Từ phát âm giống nhau (copying/coping), hành động sai, chủ ngữ sai.
10 câu mẫu thường gặp trong Part 1:
    1. A woman is typing on a keyboard.
      → Một người phụ nữ đang gõ bàn phím.
    2. Some boxes are being loaded onto a truck.
      → Một số thùng hàng đang được chất lên xe tải.
    3. The man is reaching for a book on the shelf.
      → Người đàn ông đang với lấy một cuốn sách trên kệ.
    4. Chairs have been arranged around a table.
      → Ghế đã được xếp xung quanh bàn.
    5. A vehicle is parked next to the building.
      → Một chiếc xe đang đậu bên cạnh tòa nhà.
    6. She is holding a cup of coffee.
      → Cô ấy đang cầm một tách cà phê.
    7. People are walking along the sidewalk.
      → Mọi người đang đi bộ dọc vỉa hè.
    8. Documents are spread out on the desk.
      → Tài liệu được trải ra trên bàn.
    9. The shelves are stocked with merchandise.
      → Các kệ hàng được chất đầy hàng hóa.
    10. A man is standing at a podium giving a presentation.
      → Một người đàn ông đang đứng trên bục phát biểu.

★ Từ vựng hay gặp Part 1:
Hành động người:
    typing (gõ phím) • pointing at (chỉ vào) • leaning against (tựa vào)
    pouring (rót) • sweeping (quét) • mopping (lau sàn)
    examining (kiểm tra) • stacking (xếp chồng) • hanging (treo)
    loading (chất hàng) • unloading (dỡ hàng) • crossing (băng qua)
    facing (đối mặt) • wearing (mặc/đeo) • carrying (mang/xách)
    operating (vận hành) • assembling (lắp ráp) • paving (lát đường)
Trạng thái đồ vật:
    parked (đang đậu) • stacked (xếp chồng) • scattered (rải rác)
    displayed (trưng bày) • lined up (xếp hàng) • hung (treo)
    folded (gấp lại) • piled up (chất đống) • occupied (có người ngồi)
Vị trí:
    next to (bên cạnh) • in front of (phía trước) • behind (phía sau)
    along (dọc theo) • across from (đối diện) • beneath (bên dưới)
    on top of (trên đỉnh) • at the corner (ở góc)

★ Mẹo Part 1:
     Phân biệt "being + V3" (đang được làm — có người làm) vs "been + V3" (đã được làm — trạng thái)
VD: "Tables are being set" (đang dọn) vs "Tables have been set" (đã dọn xong)
  Cẩn thận từ phát âm gần: work/walk, coast/cost, copying/coping, shipping/shopping','{"source":"user-provided PDF","handbook_code":"listening-800"}', 30,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-part2','Part 2 — Question–Response','PART 2 — HỎI ĐÁP (25 câu)
Dạng đề: Nghe 1 câu hỏi → Nghe 3 đáp án (A, B, C) → Chọn đáp án tự nhiên nhất.
Lưu ý: KHÔNG có đề in trên giấy, phải nghe 100%.
Bẫy: Đáp án đúng thường KHÔNG trả lời trực tiếp mà trả lời gián tiếp.
30 câu mẫu thường gặp trong Part 2:

Câu hỏi WH (Who, What, When, Where, Why, How)
11. Where is the meeting room?
  → Phòng họp ở đâu?
  ✓ It''s on the third floor. (Ở tầng 3.)
12. When does the store close?
  → Cửa hàng đóng cửa lúc mấy giờ?
  ✓ At nine o''clock. (Lúc 9 giờ.)
13. Who is in charge of the project?
  → Ai phụ trách dự án?
  ✓ Ms. Tanaka is leading it. (Bà Tanaka đang dẫn dắt.)
14. What time is the conference call?
  → Cuộc họp qua điện thoại lúc mấy giờ?
  ✓ It''s been moved to two thirty. (Nó đã được chuyển sang 2:30.)
15. Why was the shipment delayed?
  → Tại sao lô hàng bị trễ?
  ✓ There was a problem at customs. (Có vấn đề ở hải quan.)
16. How long will the renovation take?
  → Việc sửa chữa sẽ mất bao lâu?
  ✓ About three weeks. (Khoảng ba tuần.)
17. Where should I put these files?
  → Tôi nên để mấy tập hồ sơ này ở đâu?
  ✓ On the shelf next to the printer. (Trên kệ cạnh máy in.)
18. Who approved the budget?
  → Ai đã duyệt ngân sách?
  ✓ The finance director did. (Giám đốc tài chính.)
19. What did the client say about the proposal?
  → Khách hàng nói gì về bản đề xuất?
  ✓ They want some revisions. (Họ muốn sửa đổi một số chỗ.)
20. How do I get to the warehouse?
  → Làm sao tôi đến được nhà kho?
  ✓ Take the elevator to the basement. (Đi thang máy xuống tầng hầm.)

Câu hỏi Yes/No
21. Has the report been submitted yet?
  → Báo cáo đã được nộp chưa?
  ✓ I''ll finish it by noon. (Tôi sẽ hoàn thành trước trưa.)

 Đáp án gián tiếp — không nói Yes/No

22. Is Mr. Kim available this afternoon?
  → Ông Kim có rảnh chiều nay không?
  ✓ Let me check his calendar. (Để tôi xem lịch của ông ấy.)

23. Did you receive the email I sent?
  → Bạn đã nhận được email tôi gửi chưa?
  ✓ No, could you resend it? (Chưa, bạn gửi lại được không?)
24. Are we still meeting at three?
  → Chúng ta vẫn họp lúc 3 giờ chứ?
  ✓ As far as I know. (Theo tôi biết thì vẫn vậy.)
25. Will the new policy take effect next month?
  → Chính sách mới sẽ có hiệu lực tháng sau chứ?
  ✓ That hasn''t been decided yet. (Điều đó vẫn chưa được quyết định.)

Câu hỏi lựa chọn (A or B?)
26. Should we order lunch or go out to eat?
  → Chúng ta nên đặt cơm hay ra ngoài ăn?
  ✓ Let''s try the new restaurant nearby. (Thử nhà hàng mới gần đây đi.)
27. Would you prefer the morning shift or the evening shift?
  → Bạn thích ca sáng hay ca tối?
  ✓ Either one is fine with me. (Cái nào cũng được.)
28. Is the training on Monday or Tuesday?
  → Buổi đào tạo vào thứ Hai hay thứ Ba?
  ✓ It''s actually been postponed. (Thực ra nó đã bị hoãn.)

Câu hỏi đuôi / Câu đề nghị / Câu phát biểu
29. You''ve been to the Tokyo office before, haven''t you?
  → Bạn đã từng đến văn phòng Tokyo rồi, phải không?
  ✓ Yes, twice last year. (Có, hai lần năm ngoái.)
30. Could you help me set up the projector?
  → Bạn có thể giúp tôi lắp máy chiếu không?
  ✓ Sure, just give me a minute. (Được, cho tôi một phút.)
31. Let''s reschedule the meeting to Friday.
  → Chuyển cuộc họp sang thứ Sáu đi.
  ✓ That works for me. (Với tôi thì được.)
32. I heard the parking lot will be closed next week.
  → Tôi nghe nói bãi đỗ xe sẽ đóng tuần sau.
  ✓ Where are we supposed to park then? (Vậy chúng ta đỗ ở đâu?)
33. This printer seems to be out of paper.
  → Máy in này hình như hết giấy rồi.
  ✓ There''s more in the supply room. (Còn thêm trong phòng vật tư.)
34. Would you mind reviewing this document for me?
  → Bạn có phiền xem lại tài liệu này cho tôi không?
  ✓ I''d be happy to. (Tôi sẵn lòng.)
35. The deadline has been extended, hasn''t it?
  → Hạn chót đã được gia hạn, phải không?
  ✓ Yes, we have until the end of the month now. (Đúng, giờ chúng ta có đến cuối tháng.)
36. How about we take a break before the next session?
  → Hay là chúng ta nghỉ giải lao trước buổi tiếp theo?
  ✓ Good idea. I could use some coffee. (Ý hay. Tôi cũng muốn uống cà phê.)
37. Don''t forget to lock up when you leave.
  → Đừng quên khóa cửa khi rời đi nhé.
  ✓ I always do. (Tôi luôn làm vậy mà.)
38. I can''t seem to connect to the Wi-Fi.
  → Tôi không kết nối được Wi-Fi.

      ✓ The password was changed this morning. (Mật khẩu đã đổi sáng nay.)
    39. Why don''t we invite the marketing team to the meeting?
      → Sao chúng ta không mời đội marketing vào cuộc họp?
      ✓ I''ll send them an email right away. (Tôi sẽ gửi email cho họ ngay.)
    40. The new hire starts next Monday, right?
      → Nhân viên mới bắt đầu thứ Hai tuần sau, đúng không?
      ✓ Actually, it''s been pushed back to Wednesday. (Thực ra đã lùi lại đến thứ Tư.)

★ Từ vựng & Cụm từ hay gặp Part 2:
Đáp án gián tiếp phổ biến (rất quan trọng!):
Let me check. (Để tôi kiểm tra.)
I''m not sure. (Tôi không chắc.)
That hasn''t been decided yet. (Chưa được quyết định.)
As far as I know. (Theo tôi biết.)
You should ask [tên]. (Bạn nên hỏi [tên].)
Either one is fine. (Cái nào cũng được.)
It depends on... (Tùy thuộc vào...)
I thought you knew. (Tôi tưởng bạn biết rồi.)
Cụm từ thường nghe:
in charge of (phụ trách)
take effect (có hiệu lực)
out of stock (hết hàng)
on schedule (đúng tiến độ)
behind schedule (trễ tiến độ)
ahead of schedule (sớm hơn dự kiến)
push back / postpone (hoãn lại)
move up (đẩy sớm lên)
called off / canceled (hủy bỏ)
★ Mẹo Part 2:
     Nghe kỹ 2 từ đầu tiên — chúng quyết định loại câu hỏi (Where → địa điểm, When → thời gian)
     Đáp án đúng THƯỜNG KHÔNG lặp lại từ trong câu hỏi — nếu nghe thấy từ giống, khả năng cao là bẫy
     Đáp án gián tiếp chiếm ~40% đề — đừng tìm Yes/No, hãy tìm phản hồi tự nhiên','{"source":"user-provided PDF","handbook_code":"listening-800"}', 40,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-part3','Part 3 — Conversations','PART 3 — HỘI THOẠI (39 câu = 13 đoạn × 3 câu hỏi)
Dạng đề: Nghe đoạn hội thoại 2-3 người → Trả lời 3 câu hỏi (có in trên đề).
Chiến lược: ĐỌC CÂU HỎI TRƯỚC khi nghe — biết cần tìm gì.
36 câu mẫu (12 đoạn hội thoại ngắn × 3 câu hỏi):

Đoạn 1: Đặt phòng họp
41. W: Do we have a conference room booked for the client meeting tomorrow?
 M: I checked, and Room B is available from 10 to 12.
 W: That should work. Can you also order some refreshments?
 W: Chúng ta đã đặt phòng họp cho cuộc gặp khách hàng ngày mai chưa?
 M: Tôi đã kiểm tra, Phòng B trống từ 10 đến 12 giờ.
 W: Vậy là được. Bạn đặt thêm đồ ăn nhẹ được không?
Q41. What are the speakers discussing?
  → Họ đang bàn về việc gì? → Chuẩn bị cho cuộc họp khách hàng.
Q42. What time is Room B available?
  → Phòng B trống lúc mấy giờ? → Từ 10 đến 12 giờ.
Q43. What does the woman ask the man to do?
  → Người phụ nữ nhờ người đàn ông làm gì? → Đặt đồ ăn nhẹ.

Đoạn 2: Vấn đề giao hàng
44. M: I just got a call from the shipping company. Our delivery will be two days late.
 W: That''s going to cause problems. We promised the client it''d arrive by Friday.
 M: I know. I''ll contact them to see if there''s a faster option.
 M: Tôi vừa nhận cuộc gọi từ công ty vận chuyển. Hàng sẽ trễ 2 ngày.
 W: Vậy sẽ gây ra vấn đề. Chúng ta đã hứa khách hàng là đến trước thứ Sáu.
 M: Tôi biết. Tôi sẽ liên hệ họ xem có lựa chọn nhanh hơn không.
Q44. What is the problem?
  → Vấn đề là gì? → Giao hàng bị trễ 2 ngày.
Q45. When was the delivery originally promised?
  → Ban đầu hẹn giao khi nào? → Trước thứ Sáu.
Q46. What will the man do next?
  → Người đàn ông sẽ làm gì tiếp? → Liên hệ công ty vận chuyển.

Đoạn 3: Nhân viên mới
47. M: Have you met the new marketing manager?
 W: Not yet. I heard she transferred from the Singapore office.
 M: Yes. She''ll be introduced at the staff meeting this afternoon.
 M: Bạn đã gặp quản lý marketing mới chưa?
 W: Chưa. Tôi nghe nói cô ấy chuyển từ văn phòng Singapore.
 M: Đúng vậy. Cô ấy sẽ được giới thiệu tại cuộc họp nhân viên chiều nay.
Q47. What are they talking about?
  → Họ đang nói về gì? → Quản lý marketing mới.
Q48. Where did the new manager come from?
  → Quản lý mới đến từ đâu? → Văn phòng Singapore.
Q49. When will she be introduced?
  → Cô ấy sẽ được giới thiệu khi nào? → Tại cuộc họp chiều nay.

Đoạn 4: Sự cố kỹ thuật
50. W: The printer on the second floor isn''t working again.
 M: Did you submit a maintenance request?

 W: Yes, but they said a technician won''t be available until tomorrow.
 W: Máy in tầng 2 lại hỏng rồi.
 M: Bạn đã gửi yêu cầu bảo trì chưa?
 W: Rồi, nhưng họ nói kỹ thuật viên không rảnh đến ngày mai.
Q50. What is the problem?
  → Vấn đề là gì? → Máy in tầng 2 hỏng.
Q51. What did the woman already do?
  → Người phụ nữ đã làm gì? → Gửi yêu cầu bảo trì.
Q52. When will the technician come?
  → Kỹ thuật viên sẽ đến khi nào? → Ngày mai.

Đoạn 5: Đào tạo
53. M: Are you attending the software training session next week?
 W: I''d like to, but it conflicts with my sales presentation.
 M: They''re offering a second session on Thursday. You could sign up for that one.
 M: Bạn có tham gia buổi đào tạo phần mềm tuần sau không?
 W: Tôi muốn, nhưng trùng với buổi thuyết trình bán hàng của tôi.
 M: Họ có mở thêm buổi thứ hai vào thứ Năm. Bạn đăng ký buổi đó được.
Q53. Why can''t the woman attend the training?
  → Tại sao cô ấy không dự được? → Trùng lịch thuyết trình bán hàng.
Q54. What does the man suggest?
  → Người đàn ông gợi ý gì? → Đăng ký buổi thứ Năm.
Q55. What is the training about?
  → Buổi đào tạo về gì? → Phần mềm.

Đoạn 6: Thay đổi chính sách
56. W: Did you see the memo about the new expense policy?
 M: Yes. All travel expenses over $200 now need director approval.
 W: That''s going to slow things down. I''ll bring it up at the next team meeting.
 W: Bạn có thấy thông báo về chính sách chi phí mới không?
 M: Rồi. Mọi chi phí đi công tác trên 200 đô giờ cần giám đốc duyệt.
 W: Vậy sẽ chậm trễ lắm. Tôi sẽ đề cập tại cuộc họp nhóm tới.
Q56. What changed in the expense policy?
  → Chính sách chi phí thay đổi gì? → Chi phí trên $200 cần giám đốc duyệt.
Q57. What is the woman''s concern?
  → Cô ấy lo ngại gì? → Quy trình sẽ bị chậm lại.
Q58. What will the woman do?
  → Cô ấy sẽ làm gì? → Nêu vấn đề tại cuộc họp nhóm.

Đoạn 7: Thuê địa điểm tổ chức sự kiện
59. M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?
 W: The Grand Hotel has a nice banquet hall that can hold up to 200 people.
 M: That sounds perfect. I''ll call them today to check availability.
 M: Tôi đang tìm địa điểm cho bữa tiệc công ty hàng năm. Bạn có gợi ý gì không?
 W: Khách sạn Grand có phòng tiệc đẹp chứa được tới 200 người.
 M: Nghe tuyệt đấy. Tôi sẽ gọi họ hôm nay để hỏi lịch trống.
Q59. What is the man planning?
  → Anh ấy đang lên kế hoạch gì? → Bữa tiệc công ty hàng năm.
Q60. How many people can the banquet hall hold?
  → Phòng tiệc chứa được bao nhiêu người? → 200 người.

Q61. What will the man do next?
  → Anh ấy sẽ làm gì tiếp? → Gọi điện kiểm tra lịch trống.

Đoạn 8: Phỏng vấn xin việc
62. W: How did your job interview go this morning?
 M: Pretty well, I think. They said they''ll let me know by the end of the week.
 W: That''s fast. They must have been impressed.
 W: Buổi phỏng vấn sáng nay thế nào?
 M: Khá tốt. Họ nói sẽ thông báo trước cuối tuần.
 W: Nhanh thế. Chắc họ ấn tượng lắm.
Q62. What did the man do this morning?
  → Anh ấy làm gì sáng nay? → Đi phỏng vấn.
Q63. When will he hear back?
  → Khi nào anh ấy nhận phản hồi? → Trước cuối tuần.
Q64. What does the woman imply?
  → Cô ấy ám chỉ gì? → Công ty có vẻ ấn tượng với anh ấy.

Đoạn 9: Chuyển văn phòng
65. M: Our department is moving to the fifth floor next month.
 W: Really? I hadn''t heard. Will we have more space?
 M: Yes, and we''ll be closer to the IT team, which should make collaboration easier.
 M: Phòng chúng ta sẽ chuyển lên tầng 5 tháng sau.
 W: Thật à? Tôi chưa nghe. Sẽ có rộng hơn không?
 M: Có, và chúng ta sẽ gần đội IT hơn, giúp hợp tác dễ hơn.
Q65. What will happen next month?
  → Tháng sau có chuyện gì? → Phòng ban chuyển lên tầng 5.
Q66. What is one advantage of the new location?
  → Lợi ích của địa điểm mới? → Gần đội IT hơn, dễ hợp tác.
Q67. How does the woman react to the news?
  → Cô ấy phản ứng thế nào? → Ngạc nhiên vì chưa biết.

Đoạn 10: Phản hồi khách hàng
68. W: We''ve been getting a lot of complaints about our new app update.
 M: What''s the main issue?
 W: Users say it crashes frequently. I think we need to release a patch this week.
 W: Chúng ta nhận nhiều phàn nàn về bản cập nhật ứng dụng mới.
 M: Vấn đề chính là gì?
 W: Người dùng nói nó hay bị văng. Tôi nghĩ cần phát hành bản vá tuần này.
Q68. What are customers complaining about?
  → Khách hàng phàn nàn về gì? → Bản cập nhật ứng dụng mới.
Q69. What is the main problem?
  → Vấn đề chính là gì? → Ứng dụng hay bị văng (crash).
Q70. What does the woman suggest?
  → Cô ấy đề xuất gì? → Phát hành bản vá tuần này.

Đoạn 11: Đặt hàng văn phòng phẩm
71. M: We''re running low on printer paper and toner cartridges.
 W: I placed an order yesterday, but the supplier said delivery might take a week.
 M: A week? Maybe we should try a different supplier.
 M: Giấy in và mực in sắp hết rồi.
 W: Tôi đã đặt hàng hôm qua, nhưng nhà cung cấp nói giao hàng có thể mất một tuần.

     M: Một tuần? Có lẽ chúng ta nên thử nhà cung cấp khác.
Q71. What is running low?
  → Cái gì sắp hết? → Giấy in và mực in.
Q72. When did the woman place the order?
  → Cô ấy đặt hàng khi nào? → Hôm qua.
Q73. What does the man suggest?
  → Anh ấy gợi ý gì? → Thử nhà cung cấp khác.

Đoạn 12: Hội thoại 3 người
    74. M1: The client wants to move the project deadline up by two weeks.
     W: That''s really tight. We''d have to bring in additional staff.
     M2: Or we could outsource part of the design work. That might be faster.
     M1: Khách hàng muốn đẩy sớm hạn dự án 2 tuần.
     W: Gấp quá. Chúng ta phải đưa thêm nhân sự vào.
     M2: Hoặc chúng ta có thể thuê ngoài phần thiết kế. Có thể nhanh hơn.
Q74. What does the client want?
  → Khách hàng muốn gì? → Đẩy sớm hạn 2 tuần.
Q75. What does the woman suggest?
  → Cô ấy đề xuất gì? → Thêm nhân sự.
Q76. What is the second man''s alternative?
  → Phương án của người đàn ông thứ hai? → Thuê ngoài phần thiết kế.

★ Từ vựng & Cụm từ hay gặp Part 3:
Công việc:
    be in charge of (phụ trách) • work overtime (làm thêm giờ)
    take a day off (nghỉ 1 ngày) • fill in for someone (thay thế ai)
    hand in / turn in (nộp) • follow up on (theo dõi tiếp)
    get back to someone (phản hồi lại) • run into a problem (gặp vấn đề)
    wrap up (kết thúc) • figure out (tìm ra)
Lịch trình:
    move up (đẩy sớm) • push back (lùi lại) • call off (hủy)
    pencil in (ghi tạm vào lịch) • squeeze in (chen thêm vào)
    right away (ngay lập tức) • no later than (không muộn hơn)

★ Mẹo Part 3:
     ĐỌC CÂU HỎI + ĐÁP ÁN TRƯỚC khi nghe — đây là bí quyết quan trọng nhất
     Câu hỏi thường theo thứ tự nội dung — Q1 ở đầu đoạn, Q3 ở cuối đoạn
     "What does the man imply?" — đáp án không nói thẳng, phải suy luận','{"source":"user-provided PDF","handbook_code":"listening-800"}', 50,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-part4','Part 4 — Talks','PART 4 — BÀI NÓI NGẮN (30 câu = 10 đoạn × 3 câu hỏi)
Dạng đề: Nghe 1 người nói (thông báo, quảng cáo, tin nhắn thoại, hướng dẫn...) → 3 câu hỏi.
Các dạng bài phổ biến: telephone message, announcement, advertisement,
news report, introduction, tour guide, recorded message.
24 câu mẫu (8 bài nói ngắn × 3 câu hỏi):

Bài 1: Tin nhắn thoại (Telephone message)
 77. Hi, this is Laura from Greenfield Supplies. I''m calling to let you know
that the office furniture you ordered has arrived at our warehouse.
You can pick it up anytime between 9 A.M. and 6 P.M., or we can
arrange delivery for an additional fee. Please call us back at
555-0172 to let us know your preference.
Xin chào, tôi là Laura từ Greenfield Supplies. Tôi gọi để thông báo
nội thất văn phòng bạn đặt đã đến kho chúng tôi. Bạn có thể đến
lấy bất cứ lúc nào từ 9 giờ sáng đến 6 giờ chiều, hoặc chúng tôi
có thể sắp xếp giao hàng với phí thêm. Vui lòng gọi lại 555-0172
để cho chúng tôi biết bạn chọn cách nào.
Q77. Why is the speaker calling?
  → Tại sao người nói gọi điện? → Thông báo hàng đã đến kho.
Q78. What are the pickup hours?
  → Giờ nhận hàng? → 9 giờ sáng đến 6 giờ chiều.
Q79. What should the listener do?
  → Người nghe nên làm gì? → Gọi lại để cho biết lựa chọn.

Bài 2: Thông báo nội bộ (Company announcement)
 80. Attention, all employees. Starting next Monday, the company parking
lot on Oak Street will be closed for resurfacing. This work is
expected to take approximately two weeks. During this time, please
use the public parking garage on Elm Street. The company will
reimburse parking fees — just submit your receipts to HR.
Thông báo đến toàn thể nhân viên. Bắt đầu từ thứ Hai tới, bãi đỗ xe
công ty trên phố Oak sẽ đóng cửa để tái tráng nhựa. Công việc dự
kiến mất khoảng hai tuần. Trong thời gian này, vui lòng sử dụng
bãi đỗ xe công cộng trên phố Elm. Công ty sẽ hoàn trả phí đỗ xe
— chỉ cần nộp biên lai cho phòng nhân sự.
Q80. What will happen next Monday?
  → Thứ Hai tới có gì? → Bãi đỗ xe đóng cửa.
Q81. How long will the work take?
  → Công việc kéo dài bao lâu? → Khoảng hai tuần.
Q82. How can employees get reimbursed?
  → Nhân viên được hoàn phí bằng cách nào? → Nộp biên lai cho HR.

Bài 3: Quảng cáo (Advertisement)
 83. Are you looking for a way to improve your team''s productivity?
TaskMaster Pro is the project management tool used by over 10,000
companies worldwide. With features like real-time collaboration,
automated reporting, and mobile access, your team can work smarter,
not harder. Sign up for a free 30-day trial at taskmaster.com.
Bạn đang tìm cách nâng cao năng suất cho đội ngũ? TaskMaster Pro
là công cụ quản lý dự án được hơn 10.000 công ty trên toàn thế

giới sử dụng. Với tính năng cộng tác thời gian thực, báo cáo tự
động và truy cập di động, đội của bạn có thể làm việc thông minh
hơn. Đăng ký dùng thử miễn phí 30 ngày tại taskmaster.com.
Q83. What is being advertised?
  → Quảng cáo về gì? → Công cụ quản lý dự án.
Q84. How many companies use the product?
  → Bao nhiêu công ty sử dụng? → Hơn 10.000.
Q85. What is offered to new users?
  → Ưu đãi cho người dùng mới? → Dùng thử miễn phí 30 ngày.

Bài 4: Hướng dẫn tour (Tour guide)
 86. Welcome to the Riverside Museum of Art. Today''s tour will begin in
the East Wing, where we''ll see the new contemporary art exhibition.
Then we''ll move to the sculpture garden on the second floor. Please
note that photography is not permitted in the East Wing, but you''re
welcome to take photos in all other areas. The tour will last
approximately 90 minutes.
Chào mừng đến Bảo tàng Nghệ thuật Riverside. Tour hôm nay sẽ bắt
đầu ở Cánh Đông, nơi trưng bày triển lãm nghệ thuật đương đại mới.
Sau đó chúng ta sẽ đến vườn điêu khắc ở tầng 2. Xin lưu ý không
được chụp ảnh ở Cánh Đông, nhưng bạn có thể chụp ở tất cả khu vực
khác. Tour kéo dài khoảng 90 phút.
Q86. Where will the tour start?
  → Tour bắt đầu ở đâu? → Cánh Đông (East Wing).
Q87. What is NOT allowed in the East Wing?
  → Không được làm gì ở Cánh Đông? → Chụp ảnh.
Q88. How long is the tour?
  → Tour kéo dài bao lâu? → Khoảng 90 phút.

Bài 5: Tin tức (News report)
 89. In local business news, Hartfield Industries announced today that
it will open a new manufacturing plant in Riverside County. The
facility is expected to create over 500 jobs in the area. Construction
will begin in March, with operations scheduled to start by the end
of the year.
Tin kinh doanh địa phương, Hartfield Industries hôm nay thông báo
sẽ mở nhà máy sản xuất mới tại quận Riverside. Cơ sở này dự kiến
tạo ra hơn 500 việc làm trong khu vực. Xây dựng sẽ bắt đầu vào
tháng 3, dự kiến hoạt động vào cuối năm.
Q89. What did Hartfield Industries announce?
  → Hartfield thông báo gì? → Mở nhà máy mới.
Q90. How many jobs will be created?
  → Sẽ tạo ra bao nhiêu việc làm? → Hơn 500.
Q91. When will construction begin?
  → Xây dựng bắt đầu khi nào? → Tháng 3.

Bài 6: Tin nhắn thoại (Voicemail)
 92. Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car
is ready for pickup. We replaced the brake pads and also noticed
that your front tires are quite worn, so we''d recommend replacing
those soon. Your total comes to $285. We''re open until 7 P.M. today.

Xin chào ông Nakamura. Tôi là Diane từ City Auto Repair. Xe của ông
đã sửa xong. Chúng tôi đã thay má phanh và cũng nhận thấy lốp
trước khá mòn, nên khuyến nghị ông thay sớm. Tổng cộng là $285.
Chúng tôi mở cửa đến 7 giờ tối hôm nay.
Q92. Why is the speaker calling?
  → Tại sao gọi điện? → Thông báo xe đã sửa xong.
Q93. What additional recommendation is made?
  → Khuyến nghị thêm gì? → Thay lốp trước.
Q94. How much is the total?
  → Tổng cộng bao nhiêu? → $285.

Bài 7: Giới thiệu diễn giả (Introduction)
 95. It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah
Mitchell. Dr. Mitchell is the author of three best-selling books on
leadership and has over 20 years of experience in organizational
management. She currently serves as the dean of the Business School
at Western University. Please join me in welcoming Dr. Mitchell.
Tôi hân hạnh giới thiệu diễn giả chính hôm nay, Tiến sĩ Sarah
Mitchell. Tiến sĩ Mitchell là tác giả của 3 cuốn sách bán chạy về
lãnh đạo và có hơn 20 năm kinh nghiệm trong quản trị tổ chức.
Hiện bà là Trưởng khoa Kinh doanh tại Đại học Western. Xin chào
đón Tiến sĩ Mitchell.
Q95. Who is Dr. Mitchell?
  → Tiến sĩ Mitchell là ai? → Tác giả, diễn giả chính.
Q96. How many books has she written?
  → Bà ấy viết bao nhiêu sách? → 3 cuốn.
Q97. What is her current position?
  → Chức vụ hiện tại? → Trưởng khoa Kinh doanh, ĐH Western.

Bài 8: Thông báo tự động (Recorded message)
98. Thank you for calling Sunrise Airlines. Due to the severe weather
conditions, all flights departing from Terminal 2 have been delayed
by approximately two hours. Passengers are advised to check our
website or mobile app for the latest updates. We apologize for
any inconvenience.
Cảm ơn bạn đã gọi đến Sunrise Airlines. Do điều kiện thời tiết
khắc nghiệt, tất cả chuyến bay khởi hành từ Nhà ga 2 đã bị hoãn
khoảng 2 tiếng. Hành khách nên kiểm tra website hoặc ứng dụng
để biết thông tin mới nhất. Chúng tôi xin lỗi vì sự bất tiện.
Q98. Why are flights delayed?
  → Tại sao chuyến bay bị hoãn? → Thời tiết xấu.
Q99. How long is the delay?
  → Hoãn bao lâu? → Khoảng 2 tiếng.
Q100. What are passengers advised to do?
  → Hành khách được khuyên làm gì? → Kiểm tra website hoặc app.

★ Từ vựng & Cụm từ hay gặp Part 4:
Tin nhắn thoại:
This is [tên] calling from... (Tôi là [tên] gọi từ...)
I''m calling to let you know... (Tôi gọi để thông báo...)
I''m calling regarding... (Tôi gọi liên quan đến...)
Please call me back at... (Vui lòng gọi lại số...)

at your earliest convenience (khi nào thuận tiện nhất)
Thông báo:
Attention, all employees/passengers (Thông báo đến toàn thể...)
Please be advised that... (Xin lưu ý rằng...)
effective immediately (có hiệu lực ngay lập tức)
until further notice (cho đến khi có thông báo mới)
We apologize for any inconvenience. (Xin lỗi vì sự bất tiện.)
Quảng cáo:
limited-time offer (ưu đãi có hạn)
for more information (để biết thêm thông tin)
sign up / register (đăng ký)
free of charge (miễn phí)
don''t miss out (đừng bỏ lỡ)
visit our website at... (truy cập website tại...)
★ Mẹo Part 4:
   Giống Part 3: ĐỌC CÂU HỎI TRƯỚC
   Xác định DẠNG BÀI ngay 2 giây đầu (thông báo? quảng cáo? tin nhắn?)
   Câu hỏi "What is the purpose of the message?" — luôn nằm ở đầu bài
   Câu hỏi "What should listeners do?" — luôn nằm ở cuối bài','{"source":"user-provided PDF","handbook_code":"listening-800"}', 60,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-roadmap','Lộ trình 6 tháng cho người mất gốc','LỜI KHUYÊN CHO NGƯỜI MẤT GỐC TIẾNG ANH
GIAI ĐOẠN 1: XÂY LẠI NỀN TẢNG (Tháng 1-2)
Mục tiêu: Nghe hiểu được câu đơn giản, nhận diện được từ cơ bản.
 1. Bắt đầu từ Part 1 và Part 2 — đây là phần ngắn, dễ nhất
 Mỗi ngày nghe 10-15 câu Part 1 + Part 2
 Nghe → đọc transcript → nghe lại → bắt chước đọc theo (shadowing)
 2. Học 10 từ vựng mới mỗi ngày — ĐỪNG học quá nhiều
 Ưu tiên từ trong danh sách ở file này
 Học kèm CÂU VÍ DỤ, không học từ đơn lẻ
 Dùng app flashcard (Anki, Quizlet) để ôn lặp lại
 3. Nghe mỗi ngày ít nhất 15-30 phút
 Gợi ý: TOEIC Listening practice trên YouTube
 Nghe podcast tiếng Anh dễ: 6 Minute English (BBC), VOA Learning English

GIAI ĐOẠN 2: TĂNG TỐC (Tháng 3-4)
Mục tiêu: Nghe hiểu được hội thoại, bắt đầu làm đề thật.
 4. Chuyển sang Part 3 và Part 4
 Tập kỹ năng ĐỌC CÂU HỎI TRƯỚC khi nghe — đây là kỹ năng sống còn
 Nghe 1 đoạn → trả lời → kiểm tra đáp án → nghe lại → đọc transcript
 5. Phương pháp Dictation (chép chính tả)
 Nghe 1 câu → viết lại → kiểm tra với transcript
 Rất hiệu quả để cải thiện khả năng nhận diện từ
 6. Phương pháp Shadowing (đọc theo)
 Nghe audio → đọc theo CÙNG LÚC với người nói
 Giúp cải thiện phát âm + quen với tốc độ nói tự nhiên

GIAI ĐOẠN 3: LUYỆN ĐỀ THẬT (Tháng 5-6)
Mục tiêu: Quen với format đề, quản lý thời gian.
 7. Làm đề thật mỗi tuần 1-2 bộ
 Sách gợi ý: ETS TOEIC Official (bộ đề chính thức)
 Hacker''s TOEIC Listening
 Economy TOEIC
 8. Phân tích lỗi sai
 Sau mỗi đề, GHI LẠI câu sai vào sổ
 Phân loại: sai vì không nghe được từ? sai vì hiểu nhầm? sai vì không kịp đọc câu hỏi?
 Tập trung khắc phục điểm yếu','{"source":"user-provided PDF","handbook_code":"listening-800"}', 70,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-golden','Nguyên tắc vàng: dictation, shadowing, linking & accents','NGUYÊN TẮC VÀNG:
★ Mỗi ngày 30 phút tốt hơn cuối tuần 5 tiếng
   → Nghe hàng ngày giúp tai quen dần, đừng nhồi nhét.

★ Nghe HIỂU trước, nghe NHANH sau
   → Giai đoạn đầu nghe chậm (0.75x) cũng được, rồi tăng dần.

★ Đừng dịch sang tiếng Việt trong đầu
   → Cố gắng hiểu trực tiếp bằng tiếng Anh.
   → Ban đầu sẽ khó, nhưng kiên trì sẽ quen.

★ Tập trung vào NGHE, không phải nhìn transcript
  → Nghe ít nhất 2-3 lần trước khi mở transcript.

★ Âm nối (Linking) là thử thách lớn nhất
  → "pick it up" nghe như "pi-ki-tup"
  → "let me know" nghe như "le-mi-now"
  → "called off" nghe như "call-doff"
  → Luyện nghe âm nối sẽ giúp hiểu người bản xứ nhanh hơn rất nhiều.

★ Các dạng phát âm đặc biệt cần quen:
  → Giọng Mỹ: "water" = /ˈwɑːdər/, "schedule" = /ˈskedʒuːl/
  → Giọng Anh: "schedule" = /ˈʃedjuːl/, "advertisement" = /ədˈvɜːtɪsmənt/
  → Giọng Úc: "today" = /təˈdaɪ/, "day" = /daɪ/
  → TOEIC sử dụng cả 4 giọng: Mỹ, Anh, Úc, Canada','{"source":"user-provided PDF","handbook_code":"listening-800"}', 80,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-targets','Mục tiêu luyện tập hướng tới 800+','BẢNG TÓM TẮT: SỐ CÂU CẦN ĐẠT ĐỂ ĐƯỢC 800+
                   Part                         Tổng câu                        Cần đúng (tối thiểu)

Part 1 (Ảnh)                                         6                                  5-6

Part 2 (Hỏi đáp)                                     25                                20-22

Part 3 (Hội thoại)                                   39                                30-33

Part 4 (Bài nói)                                     30                                24-26

TỔNG                                                100                          ~80-87 câu đúng

LƯU Ý VỀ ĐIỂM
Số câu đúng ở trên là mục tiêu luyện tập trong tài liệu. TOEIC dùng thang điểm quy đổi; số câu đúng
không chuyển sang điểm theo một công thức cố định.','{"source":"user-provided PDF","handbook_code":"listening-800"}', 90,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-schedule','Lịch học 6 tháng — 30 phút/ngày','LỊCH HỌC GỢI Ý (6 tháng - 30 phút/ngày)
Ngày                                                  Nội dung luyện

Thứ Hai                                               Part 2 (15 câu) + ôn từ vựng

Thứ Ba                                                Part 3 (1 đoạn hội thoại) + dictation

Thứ Tư                                                Part 4 (1 bài nói) + shadowing

Thứ Năm                                               Part 1 + Part 2 hỗn hợp + ôn từ vựng

Thứ Sáu                                               Part 3 (1 đoạn) + Part 4 (1 bài) + ghi chú lỗi sai

Thứ Bảy                                               Làm mini test (30-50 câu) hoặc đề thật

Chủ Nhật                                              Nghỉ hoặc nghe podcast/video tiếng Anh thoải mái','{"source":"user-provided PDF","handbook_code":"listening-800"}', 100,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'listening-maintain','Nguyên tắc duy trì','NGUYÊN TẮC DUY TRÌ
30 phút mỗi ngày hiệu quả hơn học dồn. Ưu tiên nghe trước transcript, sau đó mới kiểm tra và
shadowing.

                  KIÊN TRÌ MỖI NGÀY - NGHE ÍT NHƯNG NGHE SÂU

           Mục tiêu: nghe được câu → nhận diện cụm → hiểu ý → phản xạ với tốc độ TOEIC.','{"source":"user-provided PDF","handbook_code":"listening-800"}', 110,1 FROM learning_handbooks WHERE code='listening-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-ed','1. Phát âm -ed: /t/, /d/, /ɪd/','1. QUY TẮC PHÁT ÂM ĐUÔI -ED
Điểm quan trọng nhất: không nhìn chữ cái cuối; hãy xác định ÂM cuối của động từ nguyên mẫu.

          Cách đọc                    Khi âm cuối là                            Ví dụ                        Ghi nhớ

                                                                      wanted, needed, started,
/ɪd/                               Âm cuối /t/ hoặc /d/                                             Có thêm 1 âm tiết
                                                                        decided, attended

                                Âm vô thanh /p, k, f, s, ʃ, tʃ,       worked, helped, laughed,
/t/                                                                                                 Không thêm âm tiết
                                           θ/                         missed, washed, watched

                               Âm hữu thanh + nguyên âm                played, called, cleaned,
/d/                                                                                                 Không thêm âm tiết
                                        (trừ /d/)                      lived, moved, changed

 Công thức nhớ nhanh: T/D -> /ɪd/ | Âm vô thanh -> /t/ | Còn lại -> /d/.

1.1 Nhóm /t/
 Âm vô thanh thường gặp: /p/, /k/, /f/, /s/, /ʃ/, /tʃ/, /θ/.

                  V1                                       Quá khứ                                       Đọc -ed

work                                                        worked                                         /t/

help                                                         helped                                        /t/

stop                                                        stopped                                        /t/

look                                                         looked                                        /t/

check                                                       checked                                        /t/

ask                                                          asked                                         /t/

fix                                                           fixed                                        /t/

laugh                                                       laughed                                        /t/

miss                                                         missed                                        /t/

discuss                                                    discussed                                       /t/

finish                                                      finished                                       /t/

watch                                                       watched                                        /t/

reach                                                       reached                                        /t/

1.2 Nhóm /d/
 Âm cuối hữu thanh và tất cả nguyên âm thường làm -ed đọc /d/.

                V1                                Quá khứ                      Đọc -ed

play                                               played                        /d/

stay                                               stayed                        /d/

arrive                                             arrived                       /d/

live                                                lived                        /d/

move                                               moved                         /d/

improve                                          improved                        /d/

call                                               called                        /d/

clean                                             cleaned                        /d/

open                                              opened                         /d/

order                                             ordered                        /d/

deliver                                           delivered                      /d/

change                                            changed                        /d/

prepare                                           prepared                       /d/

require                                           required                       /d/

1.3 Nhóm /ɪd/
 Nếu V1 kết thúc bằng âm /t/ hoặc /d/, -ed tạo thêm một âm tiết /ɪd/.

                V1                                Quá khứ                      Đọc -ed

want                                              wanted                         /ɪd/

start                                              started                       /ɪd/

wait                                               waited                        /ɪd/

visit                                              visited                       /ɪd/

expect                                            expected                       /ɪd/

need                                              needed                         /ɪd/

decide                                            decided                        /ɪd/

provide                                           provided                       /ɪd/

include                                           included                       /ɪd/

attend                                            attended                       /ɪd/

                 V1                                  Quá khứ                                Đọc -ed

recommend                                          recommended                                /ɪd/

request                                              requested                                /ɪd/

1.4 Nhìn âm, không nhìn chữ
 like -> liked: chữ cuối là e nhưng âm cuối thực tế là /k/ -> -ed đọc /t/.
 love -> loved: âm cuối /v/ là hữu thanh -> -ed đọc /d/.

 Mẹo cảm nhận hữu thanh/vô thanh: Đặt tay lên cổ họng khi phát âm âm cuối. Cổ họng rung -> hữu
 thanh; không rung -> vô thanh.

1.5 Một số tính từ -ed có cách đọc đặc biệt
Khi các từ sau được dùng như tính từ, cách đọc có thể là /ɪd/: learned, aged, beloved, naked, wicked,
crooked.','{"source":"user-provided PDF","handbook_code":"verb-800"}', 10,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-ed-listening','2. Bẫy nghe -ed trong TOEIC Listening','2. BẪY NGHE -ED TRONG TOEIC LISTENING
                 Từ                                   Đọc -ed                           Điểm cần nghe

                                                                             Âm /t/ rất ngắn, dễ “mất” trước từ tiếp
worked                                                   /t/
                                                                                              theo.

                                                                             Cụm phụ âm cuối có thể khiến người
asked                                                    /t/
                                                                                  học bỏ sót dấu quá khứ.

                                                                             Trong “checked the schedule”, âm cuối
checked                                                  /t/
                                                                                        nối rất nhanh.

finished                                                 /t/                      Không đọc thành “finish-id”.

changed                                                  /d/                 Âm /d/ bám vào âm cuối của changed.

moved                                                    /d/                 Không có một âm tiết “ed” tách riêng.

                                                                             Đuôi /d/ ngắn; TOEIC hay dùng ở ngữ
scheduled                                                /d/
                                                                                        cảnh cuộc hẹn.

wanted                                                  /ɪd/                            Có thêm âm tiết.

needed                                                  /ɪd/                            Có thêm âm tiết.

                                                                                  Rất hay gặp trong ngữ cảnh
attended                                                /ɪd/
                                                                                      seminar/conference.

requested                                               /ɪd/                      Hay gặp ở customer service.

provided                                                /ɪd/                      Hay gặp trong câu bị động.

 Ví dụ nghe: Have you checked the schedule? | The meeting has been moved to Friday. | The order
 was shipped yesterday.','{"source":"user-provided PDF","handbook_code":"verb-800"}', 20,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-irregular','3. Động từ bất quy tắc quan trọng','3. ĐỘNG TỪ BẤT QUY TẮC QUAN TRỌNG CHO TOEIC
Động từ bất quy tắc không tạo V2/V3 bằng cách chỉ thêm -ed. Với TOEIC, cần nhận ra chúng trong Part 5-6 và
đọc/nghe được trong Part 1-4 và Part 7.

            V1 (Base)               V2 (Past)             V3 (Past participle)                  Nghĩa

arise                                arose                      arisen             phát sinh

bear                                  bore                       borne             chịu đựng; mang

beat                                  beat                      beaten             đánh bại

become                              became                     become              trở thành

begin                                began                      begun              bắt đầu

bend                                  bent                       bent              uốn cong

bid                                    bid                        bid              đấu thầu

bind                                 bound                      bound              ràng buộc

break                                broke                      broken             phá vỡ

bring                               brought                    brought             mang đến

broadcast                           broadcast                  broadcast           phát sóng

build                                 built                      built             xây dựng

buy                                  bought                     bought             mua

catch                                caught                     caught             bắt

choose                               chose                      chosen             chọn

come                                  came                       come              đến

cost                                  cost                       cost              tốn

cut                                    cut                        cut              cắt

deal                                  dealt                      dealt             giải quyết

do                                     did                       done              làm

draw                                  drew                      drawn              vẽ; rút

drink                                drank                       drunk             uống

drive                                drove                      driven             lái xe

eat                                    ate                       eaten             ăn

           V1 (Base)   V2 (Past)       V3 (Past participle)                    Nghĩa

fall                      fell                fallen            rơi; giảm

feed                     fed                   fed              cung cấp

feel                     felt                  felt             cảm thấy

fight                   fought               fought             chiến đấu

find                    found                 found             tìm thấy

fly                      flew                 flown             bay

forbid                 forbade              forbidden           cấm

forecast               forecast             forecast            dự báo

forget                  forgot              forgotten           quên

forgive                forgave              forgiven            tha thứ

freeze                   froze               frozen             đóng băng

get                      got               gotten/got           nhận; đạt

give                     gave                 given             cho

go                       went                 gone              đi

grow                     grew                grown              phát triển

have                     had                   had              có

hear                    heard                 heard             nghe

hide                     hid                 hidden             giấu

hit                       hit                  hit              đạt; đánh

hold                     held                 held              tổ chức; giữ

hurt                     hurt                 hurt              tổn thương

keep                     kept                 kept              giữ

know                    knew                 known              biết

lay                      laid                  laid             đặt; bày ra

lead                      led                  led              dẫn dắt

leave                    left                  left             rời đi

lend                     lent                  lent             cho vay

let                       let                  let              cho phép

lie                       lay                  lain             nằm

lose                     lost                  lost             mất; thua

           V1 (Base)   V2 (Past)        V3 (Past participle)                    Nghĩa

make                     made                  made              làm; tạo

mean                     meant                meant              có nghĩa

meet                      met                   met              gặp

mistake                 mistook              mistaken            nhầm lẫn

overcome               overcame              overcome            vượt qua

overlook               overlooked           overlooked           bỏ sót (QUY TẮC!)

overtake                overtook            overtaken            vượt qua

pay                       paid                 paid              trả tiền

put                       put                   put              đặt

quit                      quit                  quit             nghỉ việc

read                   read /rɛd/            read /rɛd/          đọc

ride                     rode                 ridden             đi (xe)

rise                      rose                 risen             tăng lên

run                       ran                   run              chạy; điều hành

say                       said                 said              nói

see                       saw                  seen              nhìn thấy

seek                    sought                sought             tìm kiếm

sell                      sold                 sold              bán

send                      sent                 sent              gửi

set                       set                   set              thiết lập

shake                    shook                shaken             lắc; rung

show                    showed                shown              cho xem

shrink                  shrank                shrunk             co lại; giảm

shut                      shut                 shut              đóng

sit                       sat                   sat              ngồi

speak                    spoke                spoken             nói

spend                    spent                 spent             chi tiêu; dành

split                     split                split             chia tách

spread                  spread                spread             lan rộng

stand                    stood                 stood             đứng

            V1 (Base)               V2 (Past)              V3 (Past participle)                 Nghĩa

steal                                 stole                      stolen             trộm

stick                                stuck                        stuck             dính; bám

strike                               struck                      struck             đình công; đánh

swear                                swore                       sworn              thề

sweep                                swept                        swept             quét

swim                                 swam                         swum              bơi

take                                  took                        taken             lấy

teach                                taught                      taught             dạy

tear                                  tore                        torn              xé

tell                                  told                         told             nói; kể

think                               thought                     thought             nghĩ

throw                                threw                       thrown             ném

undergo                            underwent                   undergone            trải qua

understand                         understood                  understood           hiểu

undertake                          undertook                   undertaken           đảm nhận

undo                                 undid                       undone             hoàn tác

uphold                               upheld                      upheld             duy trì

wear                                  wore                        worn              mặc

win                                   won                         won               thắng

withdraw                            withdrew                   withdrawn            rút lui

withhold                            withheld                    withheld            giữ lại

withstand                          withstood                    withstood           chịu đựng

write                                wrote                       written            viết','{"source":"user-provided PDF","handbook_code":"verb-800"}', 30,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-confusing','4. Động từ/cặp từ đặc biệt cần nhớ','4. CÁC ĐỘNG TỪ/CẶP TỪ ĐẶC BIỆT CẦN NHỚ
read - read - read Chữ viết giống nhau. Hiện tại thường /riːd/; V2/V3 đọc /red/.

lead - led - led Rất hay gặp trong business English: lead a team, lead a project, lead the company.

 pay - paid - paid Các cụm nên nhớ: pay a bill, pay a fee, pay an invoice, paid leave, paid vacation.

 bring/buy/catch/teach/think bring-brought-brought; buy-bought-bought; catch-caught-caught; teach-
 taught-taught; think-thought-thought.

4.1 rise vs raise
          Từ                       Dạng                         Loại                    Cách dùng                    Ví dụ

                                                                                                           Prices rose last
                                                                                Tự tăng/lên; không cần
rise                     rise - rose - risen           Nội động từ                                         month. / Sales have
                                                                                tân ngữ
                                                                                                           risen.

                                                                                Ai đó làm cái gì tăng;     The company raised
raise                    raise - raised - raised       Ngoại động từ
                                                                                cần tân ngữ                prices.

4.2 lie vs lay
               Từ                              Dạng                             Nghĩa                            Ví dụ

lie                                       lie - lay - lain                      nằm                 He lay on the sofa.

                                                                                                    She laid the documents on
lay                                       lay - laid - laid             đặt/bày cái gì xuống
                                                                                                    the desk.

4.3 find vs found
                    Từ                                          Dạng                                      Nghĩa

find                                                     find - found - found                            tìm thấy

found                                                found - founded - founded                           thành lập

 Ghi chú biên tập: overlook là động từ quy tắc: overlook - overlooked - overlooked. Từ look cũng là động
 từ quy tắc (look - looked - looked).','{"source":"user-provided PDF","handbook_code":"verb-800"}', 40,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-essential','5. Động từ thiết yếu cho TOEIC 800+','5. ĐỘNG TỪ THIẾT YẾU CHO TOEIC 800+
Danh sách dưới đây được sắp theo ngữ cảnh TOEIC. Mỗi dòng gồm: động từ, nghĩa, cách đọc -ed (nếu là
động từ quy tắc) và một câu ví dụ.

5.1 Kinh doanh & Quản lý
           Verb                                Nghĩa                             -ed                          Ví dụ TOEIC

acquire                                 mua lại, thu mua                         /d/                The firm acquired a competitor.

              Verb          Nghĩa                  -ed                 Ví dụ TOEIC

administer                  quản lý                /d/      She administers the department.

advertise                 quảng cáo                /d/      We advertised the position.

allocate                    phân bổ                /ɪd/     Funds were allocated to R&D.

announce                   thông báo               /t/      The CEO announced a merger.

appoint                    bổ nhiệm                /ɪd/     He was appointed as director.

approve                   chấp thuận               /d/      The board approved the budget.

assess                     đánh giá                /t/      We assessed the risks.

assign                  giao (nhiệm vụ)            /d/      Tasks were assigned to staff.

authorize                  ủy quyền                /d/      Only managers can authorize.

boost                      thúc đẩy                /ɪd/     Sales were boosted by the ad.

                                                            Teams collaborated on the
collaborate                 hợp tác                /ɪd/
                                                            project.

commit                      cam kết                /ɪd/     We committed to the deadline.

compensate                bồi thường               /ɪd/     Employees were compensated.

compete                   cạnh tranh               /ɪd/     Firms compete for market share.

comply                     tuân thủ                /d/      You must comply with the policy.

conduct                    tiến hành               /ɪd/     A survey was conducted.

confirm                    xác nhận                /d/      Please confirm your attendance.

consult                     tư vấn                 /ɪd/     We consulted an expert.

contribute                 đóng góp                /ɪd/     She contributed ideas.

coordinate                 phối hợp                /ɪd/     He coordinated the event.

delegate                  giao quyền               /ɪd/     Managers should delegate tasks.

demonstrate          chứng minh; trình diễn        /ɪd/     She demonstrated the product.

designate                   chỉ định               /ɪd/     A meeting room was designated.

determine                  xác định                /d/      We determined the cause.

develop                    phát triển              /t/      They developed a new system.

disclose                     tiết lộ               /d/      Details were not disclosed.

distribute                 phân phối               /ɪd/     Products are distributed globally.

dominate                   thống trị               /ɪd/     The brand dominates the market.

eliminate                   loại bỏ                /ɪd/     Waste was eliminated.

emphasize                 nhấn mạnh                /d/      He emphasized teamwork.

              Verb      Nghĩa             -ed                  Ví dụ TOEIC

enforce                thực thi            /t/      Rules are strictly enforced.

                                                    We enhanced the user
enhance               nâng cao             /t/
                                                    experience.

ensure                 đảm bảo             /d/      Please ensure quality.

establish             thành lập            /t/      The firm was established in 1990.

estimate               ước tính           /ɪd/      Costs were estimated at $5M.

                                                    Performance is evaluated
evaluate               đánh giá           /ɪd/
                                                    annually.

exceed                vượt quá            /ɪd/      Sales exceeded expectations.

execute               thực hiện           /ɪd/      The plan was executed well.

expand                 mở rộng            /ɪd/      We expanded into Asia.

facilitate           tạo điều kiện        /ɪd/      Technology facilitates work.

forecast               dự báo             irreg     Revenue was forecast to rise.

generate                tạo ra            /ɪd/      The campaign generated leads.

guarantee              bảo đảm             /d/      Satisfaction is guaranteed.

implement             triển khai          /ɪd/      The policy was implemented.

indicate                chỉ ra            /ɪd/      Data indicates growth.

initiate             khởi xướng           /ɪd/      She initiated the project.

inspect                kiểm tra           /ɪd/      The facility was inspected.

invest                  đầu tư            /ɪd/      They invested in technology.

launch                  ra mắt             /t/      A new product was launched.

                                                    Equipment is maintained
maintain                duy trì            /d/
                                                    monthly.

manufacture            sản xuất            /d/      Parts are manufactured locally.

maximize              tối đa hóa           /d/      We maximized efficiency.

merge                 sáp nhập             /d/      The two firms merged.

minimize             tối thiểu hóa         /d/      We minimized downtime.

monitor                theo dõi            /d/      Progress is monitored weekly.

negotiate             đàm phán            /ɪd/      Terms were negotiated.

notify                thông báo            /d/      Clients were notified.

obtain                 đạt được            /d/      A permit was obtained.

operate               vận hành            /ɪd/      The plant operates 24/7.

              Verb          Nghĩa                -ed                   Ví dụ TOEIC

organize                   tổ chức                /d/      She organized the conference.

outline                   phác thảo               /d/      He outlined the strategy.

outsource                 thuê ngoài              /t/      IT was outsourced.

oversee                    giám sát              irreg     She oversees operations.

participate               tham gia               /ɪd/      All staff participated.

persuade                 thuyết phục             /ɪd/      He persuaded the client.

postpone                   hoãn lại               /d/      The meeting was postponed.

proceed                   tiến hành              /ɪd/      Please proceed to gate 5.

process                     xử lý                 /t/      Orders are processed daily.

promote              thăng chức; quảng bá        /ɪd/      She was promoted to VP.

propose                    đề xuất                /d/      He proposed a new plan.

purchase                    mua                   /t/      Equipment was purchased.

recruit                  tuyển dụng              /ɪd/      We recruited 20 engineers.

reduce                      giảm                  /t/      Costs were reduced by 15%.

regulate                  điều chỉnh             /ɪd/      The industry is regulated.

reimburse                  hoàn trả               /t/      Expenses will be reimbursed.

release                   phát hành               /t/      A report was released.

relocate                  di chuyển              /ɪd/      The office relocated.

renew                      gia hạn                /d/      The contract was renewed.

replace                    thay thế               /t/      Old parts were replaced.

represent                  đại diện              /ɪd/      She represented the firm.

require                    yêu cầu                /d/      Approval is required.

resign                     từ chức                /d/      The director resigned.

resolve                   giải quyết              /d/      The issue was resolved.

restore                   khôi phục               /d/      Service was restored.

restrict                   hạn chế               /ɪd/      Access is restricted.

retain                      giữ lại               /d/      We retained top talent.

retrieve                  truy xuất               /d/      Files were retrieved.

revise                     sửa đổi                /d/      The manual was revised.

schedule                   sắp lịch               /d/      A meeting was scheduled.

secure                    bảo đảm                 /d/      Funding was secured.

              Verb              Nghĩa                -ed                 Ví dụ TOEIC

ship                          vận chuyển             /t/      Orders shipped yesterday.

sponsor                         tài trợ              /d/      The event was sponsored.

streamline                     tinh gọn              /d/      Operations were streamlined.

submit                           nộp                 /ɪd/     Applications must be submitted.

subscribe                      đăng ký               /d/      Readers subscribed online.

supervise                      giám sát              /d/      He supervises 30 employees.

supply                         cung cấp              /d/      Materials are supplied weekly.

surpass                        vượt qua              /t/      Revenue surpassed $1B.

suspend                        đình chỉ              /ɪd/     Operations were suspended.

sustain                         duy trì              /d/      Growth was sustained.

terminate                      chấm dứt              /ɪd/     The contract was terminated.

transfer                        chuyển               /d/      She transferred to HQ.

                                                              Technology transformed the
transform                      biến đổi              /d/
                                                              field.

update                         cập nhật              /ɪd/     The system was updated.

upgrade                        nâng cấp              /ɪd/     Software was upgraded.

utilize                        sử dụng               /d/      Resources were utilized fully.

validate                       xác nhận              /ɪd/     Data was validated.

verify                         xác minh              /d/      Information was verified.

5.2 Nhân sự & Giao tiếp
              Verb              Nghĩa                -ed                 Ví dụ TOEIC

accommodate                 đáp ứng; bố trí          /ɪd/     We accommodated all requests.

acknowledge               xác nhận; thừa nhận        /d/      We acknowledged the receipt.

address                    giải quyết; đề cập        /t/      Concerns were addressed.

advise                          khuyên               /d/      Employees are advised to…

anticipate                     dự đoán               /ɪd/     We anticipated high demand.

apologize                       xin lỗi              /d/      We apologized for the delay.

apply                      nộp đơn; áp dụng          /d/      She applied for the position.

appreciate                   đánh giá cao            /ɪd/     Your help is appreciated.

assist                          hỗ trợ               /ɪd/     Staff assisted the customers.

             Verb         Nghĩa                -ed                 Ví dụ TOEIC

attend                   tham dự               /ɪd/     Please attend the seminar.

clarify                   làm rõ               /d/      Could you clarify the policy?

                                                        She was commended for her
commend                 khen ngợi              /ɪd/
                                                        work.

communicate              giao tiếp             /ɪd/     Changes were communicated.

consider                 xem xét               /d/      All options were considered.

correspond          liên lạc; tương ứng        /ɪd/     They corresponded via email.

decline               từ chối; giảm            /d/      She declined the invitation.

dismiss               sa thải; bác bỏ          /t/      The complaint was dismissed.

encounter                gặp phải              /d/      We encountered difficulties.

encourage             khuyến khích             /d/      Staff are encouraged to apply.

engage                tham gia; thuê           /d/      We engaged a consultant.

enroll                   ghi danh              /d/      Employees enrolled in training.

forward                chuyển tiếp             /ɪd/     The email was forwarded.

inquire                 hỏi thăm               /d/      She inquired about the service.

instruct               hướng dẫn               /ɪd/     Staff were instructed to…

interview               phỏng vấn              /d/      Candidates were interviewed.

mention                   đề cập               /d/      As mentioned earlier…

permit                  cho phép               /ɪd/     Parking is not permitted.

praise                  khen ngợi              /d/      The team was praised.

prefer                  thích hơn              /d/      Customers preferred online.

recommend                đề xuất               /ɪd/     I recommend this vendor.

refer               giới thiệu; đề cập         /d/      She was referred by a friend.

register                 đăng ký               /d/      Please register by Friday.

remind                  nhắc nhở               /ɪd/     We reminded all participants.

request                  yêu cầu               /ɪd/     A refund was requested.

respond                  phản hồi              /ɪd/     She responded promptly.

specify                   chỉ rõ               /d/      Requirements were specified.

suggest                    gợi ý               /ɪd/     He suggested a new approach.

volunteer              tình nguyện             /d/      She volunteered for the task.

5.3 Tài chính & Mua sắm
            Verb               Nghĩa               -ed                 Ví dụ TOEIC

afford                    có đủ khả năng           /ɪd/     We can''t afford the upgrade.

calculate                    tính toán             /ɪd/     Totals were calculated.

charge                        tính phí             /d/      No fee will be charged.

deposit                   nạp tiền; đặt cọc        /ɪd/     A deposit was required.

discount                      giảm giá             /ɪd/     Items were discounted 20%.

exchange                       đổi trả             /d/      Goods may be exchanged.

finance                        tài trợ             /t/      The project was financed.

impose                         áp đặt              /d/      New tariffs were imposed.

invoice                     lập hóa đơn            /t/      Clients will be invoiced.

owe                              nợ                /d/      The balance owed is $500.

quote                         báo giá              /ɪd/     A price was quoted.

refund                       hoàn tiền             /ɪd/     The payment was refunded.

reserve                      đặt trước             /d/      A room was reserved.

waive                        miễn (phí)            /d/      The fee was waived.

5.4 Vận hành & Hậu cần
            Verb               Nghĩa               -ed                 Ví dụ TOEIC

assemble                      lắp ráp              /d/      Parts were assembled on site.

attach                       đính kèm              /t/      Please see the attached file.

deliver                      giao hàng             /d/      Goods were delivered on time.

demolish                      phá dỡ               /t/      The old building was demolished.

detect                       phát hiện             /ɪd/     A defect was detected.

discard                        loại bỏ             /ɪd/     Damaged items were discarded.

dispatch                       gửi đi              /t/      Orders were dispatched today.

display                      trưng bày             /d/      Products are displayed.

dispose                        vứt bỏ              /d/      Waste must be disposed of.

equip                         trang bị             /t/      Rooms are equipped with WiFi.

install                   cài đặt; lắp đặt         /d/      Software was installed.

load                         chất hàng             /ɪd/     Trucks were loaded.

              Verb                Nghĩa                          -ed                            Ví dụ TOEIC

locate                         xác định vị trí                   /ɪd/                The office is located downtown.

modify                           chỉnh sửa                       /d/                 The design was modified.

occupy                          chiếm giữ                        /d/                 The building is fully occupied.

preserve                          bảo tồn                        /d/                 Historical sites are preserved.

prohibit                            cấm                          /ɪd/                Smoking is prohibited.

reconstruct                    tái xây dựng                      /ɪd/                The bridge was reconstructed.

refurbish                        tân trang                        /t/                The hotel was refurbished.

renovate                         sửa sang                        /ɪd/                The lobby was renovated.

repair                           sửa chữa                        /d/                 The machine was repaired.

resume                          tiếp tục lại                     /d/                 Service will resume tomorrow.

remodel                           cải tạo                        /d/                 The store was remodeled.

stock                             dự trữ                          /t/                Shelves are fully stocked.

store                             lưu trữ                        /d/                 Data is stored securely.

wrap                                gói                           /t/                Gifts were wrapped.','{"source":"user-provided PDF","handbook_code":"verb-800"}', 50,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-collocations','6. Học theo collocations — không học từ rời','6. HỌC THEO COLLOCATIONS - KHÔNG HỌC TỪ RỜI
                     Động từ                                            Collocations nên thuộc

                                                  apply for a position; apply for a job; apply for a loan; apply for
apply
                                                                           membership

                                                      submit an application; submit a report; submit a proposal;
submit
                                                                          submit a request

                                                       attend a meeting; attend a conference; attend a seminar;
attend
                                                                          attend a workshop

                                                        arrange a meeting; arrange transportation; arrange an
arrange
                                                               appointment; arrange accommodation

                                                      provide information; provide assistance; provide services;
provide
                                                                          provide training

pay                                                     pay a bill; pay a fee; pay an invoice; pay by credit card

                                                      schedule a meeting; schedule an appointment; schedule an
schedule
                                                                              interview

comply                                                  comply with regulations; comply with company policy

contribute                                                   contribute to a project; contribute to growth

                        Động từ                                                 Collocations nên thuộc

                                                                  refer to the document; refer a customer to another
refer
                                                                                     department

6.1 Nhóm tình huống TOEIC
                         Chủ đề                                                   Động từ trọng tâm

Meeting                                                        arrange, attend, discuss, postpone, cancel, schedule, hold

Employment                                                      hire, employ, recruit, train, promote, supervise, resign

Sales                                                                 buy, sell, order, purchase, pay, ship, deliver

Office                                                             submit, prepare, print, copy, send, receive, attach

Customer service                                                  contact, inform, assist, respond, request, complain

Finance                                                              pay, spend, cost, increase, reduce, rise, raise

Travel                                                             arrive, depart, leave, board, reserve, book, cancel

Production                                                       produce, manufacture, install, repair, replace, inspect

Projects                                                           begin, complete, manage, lead, develop, improve

Documents                                                            sign, fill out, submit, attach, review, approve','{"source":"user-provided PDF","handbook_code":"verb-800"}', 60,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO learning_handbook_sections(handbook_id,section_key,title,body_text,metadata_json,sort_order,is_active) SELECT id,'verb-strategy','7. Chiến lược học hướng tới TOEIC 800+','7. CHIẾN LƯỢC HỌC ĐỂ HƯỚNG TỚI TOEIC 800+
 Nhớ nghĩa + V2/V3 + cách phát âm -ed. Không học riêng nghĩa tiếng Việt.
 Với động từ bất quy tắc, ôn cả 3 dạng và đặt chúng vào câu thì quá khứ, hiện tại hoàn thành và bị động.
 Học collocation: submit an application, comply with regulations, attend a conference...
 Phân biệt nội động từ/ngoại động từ: rise vs raise; lie vs lay.
 Nhớ giới từ đi kèm: comply with, contribute to, refer to, apply for.
 Luyện nghe các câu có Past Simple, Present Perfect và Passive vì đây là nơi -ed/V3 xuất hiện liên tục.
 Ôn theo Active Recall: che V2/V3 và tự nói ra; che nghĩa và tự nhớ; nghe câu rồi xác định động từ.
 Ưu tiên SRS: từ sai hoặc nghe không ra phải quay lại sớm hơn từ đã chắc.

7.1 Mẫu học một động từ
           V1                      V2                     V3                         -ed                  Collocations

                                                                                                     submit a report;
submit                 submitted              submitted                  /ɪd/                        submit an application;
                                                                                                     submit a proposal

                                                                                                     send an email; send a
send                   sent                   sent                       irregular                   document; send a
                                                                                                     confirmation

           V1                      V2                      V3            -ed                  Collocations

                                                                                         schedule a meeting;
                                                                                         schedule an
schedule               scheduled               scheduled         /d/
                                                                                         appointment; schedule
                                                                                         an interview

                                                                                         attend a meeting;
attend                 attended                attended          /ɪd/                    attend a conference;
                                                                                         attend a seminar

7.2 Checklist trước khi coi một động từ là “đã thuộc”
 ☐ Tôi biết nghĩa chính trong ngữ cảnh công việc/TOEIC.
 ☐ Tôi nói được V2 và V3 mà không cần nhìn đáp án.
 ☐ Nếu là động từ quy tắc, tôi biết -ed đọc /t/, /d/ hay /ɪd/.
 ☐ Tôi biết ít nhất 2 collocations tự nhiên.
 ☐ Tôi có thể nhận ra từ khi nghe ở tốc độ hội thoại.
 ☐ Tôi có thể dùng từ trong một câu Past Simple, Present Perfect hoặc Passive.

 Mục tiêu thực tế: Học chắc khoảng 100+ động từ cốt lõi trước, sau đó mở rộng toàn bộ danh sách theo
 chủ đề. Chất lượng ghi nhớ và khả năng nghe/nhận diện quan trọng hơn học số lượng thật nhanh.

                              END - TOEIC 800+ VERB MASTER HANDBOOK','{"source":"user-provided PDF","handbook_code":"verb-800"}', 70,1 FROM learning_handbooks WHERE code='verb-800' ON DUPLICATE KEY UPDATE title=VALUES(title),body_text=VALUES(body_text),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,1,'LISTENING_SENTENCE','Part 1','A woman is typing on a keyboard.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Một người phụ nữ đang gõ bàn phím.','Một người phụ nữ đang gõ bàn phím.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"A woman is typing on a keyboard."}', 1,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,2,'LISTENING_SENTENCE','Part 1','Some boxes are being loaded onto a truck.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Một số thùng hàng đang được chất lên xe tải.','Một số thùng hàng đang được chất lên xe tải.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"Some boxes are being loaded onto a truck."}', 2,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,3,'LISTENING_SENTENCE','Part 1','The man is reaching for a book on the shelf.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Người đàn ông đang với lấy một cuốn sách trên kệ.','Người đàn ông đang với lấy một cuốn sách trên kệ.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"The man is reaching for a book on the shelf."}', 3,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,4,'LISTENING_SENTENCE','Part 1','Chairs have been arranged around a table.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Ghế đã được xếp xung quanh bàn.','Ghế đã được xếp xung quanh bàn.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"Chairs have been arranged around a table."}', 4,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,5,'LISTENING_SENTENCE','Part 1','A vehicle is parked next to the building.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Một chiếc xe đang đậu bên cạnh tòa nhà.','Một chiếc xe đang đậu bên cạnh tòa nhà.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"A vehicle is parked next to the building."}', 5,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,6,'LISTENING_SENTENCE','Part 1','She is holding a cup of coffee.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Cô ấy đang cầm một tách cà phê.','Cô ấy đang cầm một tách cà phê.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"She is holding a cup of coffee."}', 6,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,7,'LISTENING_SENTENCE','Part 1','People are walking along the sidewalk.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Mọi người đang đi bộ dọc vỉa hè.','Mọi người đang đi bộ dọc vỉa hè.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"People are walking along the sidewalk."}', 7,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,8,'LISTENING_SENTENCE','Part 1','Documents are spread out on the desk.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Tài liệu được trải ra trên bàn.','Tài liệu được trải ra trên bàn.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"Documents are spread out on the desk."}', 8,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,9,'LISTENING_SENTENCE','Part 1','The shelves are stocked with merchandise.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Các kệ hàng được chất đầy hàng hóa.','Các kệ hàng được chất đầy hàng hóa.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"The shelves are stocked with merchandise."}', 9,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,10,'LISTENING_SENTENCE','Part 1','A man is standing at a podium giving a presentation.','Nghe câu mô tả và tự xác định nội dung trước khi mở đáp án.','Một người đàn ông đang đứng trên bục phát biểu.','Một người đàn ông đang đứng trên bục phát biểu.','Blind listening → mở transcript → shadowing.','{"toeic_part":1,"transcript":"A man is standing at a podium giving a presentation."}', 10,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,11,'QUESTION_RESPONSE','Part 2','Where is the meeting room?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','It''s on the third floor.','Phòng họp ở đâu?','Ở tầng 3.','{"toeic_part":2,"transcript":"Where is the meeting room?","response_vi":"Ở tầng 3."}', 11,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,12,'QUESTION_RESPONSE','Part 2','When does the store close?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','At nine o''clock.','Cửa hàng đóng cửa lúc mấy giờ?','Lúc 9 giờ.','{"toeic_part":2,"transcript":"When does the store close?","response_vi":"Lúc 9 giờ."}', 12,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,13,'QUESTION_RESPONSE','Part 2','Who is in charge of the project?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Ms. Tanaka is leading it.','Ai phụ trách dự án?','Bà Tanaka đang dẫn dắt.','{"toeic_part":2,"transcript":"Who is in charge of the project?","response_vi":"Bà Tanaka đang dẫn dắt."}', 13,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,14,'QUESTION_RESPONSE','Part 2','What time is the conference call?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','It''s been moved to two thirty.','Cuộc họp qua điện thoại lúc mấy giờ?','Nó đã được chuyển sang 2:30.','{"toeic_part":2,"transcript":"What time is the conference call?","response_vi":"Nó đã được chuyển sang 2:30."}', 14,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,15,'QUESTION_RESPONSE','Part 2','Why was the shipment delayed?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','There was a problem at customs.','Tại sao lô hàng bị trễ?','Có vấn đề ở hải quan.','{"toeic_part":2,"transcript":"Why was the shipment delayed?","response_vi":"Có vấn đề ở hải quan."}', 15,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,16,'QUESTION_RESPONSE','Part 2','How long will the renovation take?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','About three weeks.','Việc sửa chữa sẽ mất bao lâu?','Khoảng ba tuần.','{"toeic_part":2,"transcript":"How long will the renovation take?","response_vi":"Khoảng ba tuần."}', 16,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,17,'QUESTION_RESPONSE','Part 2','Where should I put these files?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','On the shelf next to the printer.','Tôi nên để mấy tập hồ sơ này ở đâu?','Trên kệ cạnh máy in.','{"toeic_part":2,"transcript":"Where should I put these files?","response_vi":"Trên kệ cạnh máy in."}', 17,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,18,'QUESTION_RESPONSE','Part 2','Who approved the budget?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','The finance director did.','Ai đã duyệt ngân sách?','Giám đốc tài chính.','{"toeic_part":2,"transcript":"Who approved the budget?","response_vi":"Giám đốc tài chính."}', 18,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,19,'QUESTION_RESPONSE','Part 2','What did the client say about the proposal?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','They want some revisions.','Khách hàng nói gì về bản đề xuất?','Họ muốn sửa đổi một số chỗ.','{"toeic_part":2,"transcript":"What did the client say about the proposal?","response_vi":"Họ muốn sửa đổi một số chỗ."}', 19,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,20,'QUESTION_RESPONSE','Part 2','How do I get to the warehouse?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Take the elevator to the basement.','Làm sao tôi đến được nhà kho?','Đi thang máy xuống tầng hầm.','{"toeic_part":2,"transcript":"How do I get to the warehouse?","response_vi":"Đi thang máy xuống tầng hầm."}', 20,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,21,'QUESTION_RESPONSE','Part 2','Has the report been submitted yet?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','I''ll finish it by noon.','Báo cáo đã được nộp chưa?','Tôi sẽ hoàn thành trước trưa.','{"toeic_part":2,"transcript":"Has the report been submitted yet?","response_vi":"Tôi sẽ hoàn thành trước trưa."}', 21,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,22,'QUESTION_RESPONSE','Part 2','Is Mr. Kim available this afternoon?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Let me check his calendar.','Ông Kim có rảnh chiều nay không?','Để tôi xem lịch của ông ấy.','{"toeic_part":2,"transcript":"Is Mr. Kim available this afternoon?","response_vi":"Để tôi xem lịch của ông ấy."}', 22,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,23,'QUESTION_RESPONSE','Part 2','Did you receive the email I sent?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','No, could you resend it?','Bạn đã nhận được email tôi gửi chưa?','Chưa, bạn gửi lại được không?','{"toeic_part":2,"transcript":"Did you receive the email I sent?","response_vi":"Chưa, bạn gửi lại được không?"}', 23,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,24,'QUESTION_RESPONSE','Part 2','Are we still meeting at three?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','As far as I know.','Chúng ta vẫn họp lúc 3 giờ chứ?','Theo tôi biết thì vẫn vậy.','{"toeic_part":2,"transcript":"Are we still meeting at three?","response_vi":"Theo tôi biết thì vẫn vậy."}', 24,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,25,'QUESTION_RESPONSE','Part 2','Will the new policy take effect next month?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','That hasn''t been decided yet.','Chính sách mới sẽ có hiệu lực tháng sau chứ?','Điều đó vẫn chưa được quyết định.','{"toeic_part":2,"transcript":"Will the new policy take effect next month?","response_vi":"Điều đó vẫn chưa được quyết định."}', 25,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,26,'QUESTION_RESPONSE','Part 2','Should we order lunch or go out to eat?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Let''s try the new restaurant nearby.','Chúng ta nên đặt cơm hay ra ngoài ăn?','Thử nhà hàng mới gần đây đi.','{"toeic_part":2,"transcript":"Should we order lunch or go out to eat?","response_vi":"Thử nhà hàng mới gần đây đi."}', 26,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,27,'QUESTION_RESPONSE','Part 2','Would you prefer the morning shift or the evening shift?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Either one is fine with me.','Bạn thích ca sáng hay ca tối?','Cái nào cũng được.','{"toeic_part":2,"transcript":"Would you prefer the morning shift or the evening shift?","response_vi":"Cái nào cũng được."}', 27,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,28,'QUESTION_RESPONSE','Part 2','Is the training on Monday or Tuesday?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','It''s actually been postponed.','Buổi đào tạo vào thứ Hai hay thứ Ba?','Thực ra nó đã bị hoãn.','{"toeic_part":2,"transcript":"Is the training on Monday or Tuesday?","response_vi":"Thực ra nó đã bị hoãn."}', 28,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,29,'QUESTION_RESPONSE','Part 2','You''ve been to the Tokyo office before, haven''t you?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Yes, twice last year.','Bạn đã từng đến văn phòng Tokyo rồi, phải không?','Có, hai lần năm ngoái.','{"toeic_part":2,"transcript":"You''ve been to the Tokyo office before, haven''t you?","response_vi":"Có, hai lần năm ngoái."}', 29,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,30,'QUESTION_RESPONSE','Part 2','Could you help me set up the projector?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Sure, just give me a minute.','Bạn có thể giúp tôi lắp máy chiếu không?','Được, cho tôi một phút.','{"toeic_part":2,"transcript":"Could you help me set up the projector?","response_vi":"Được, cho tôi một phút."}', 30,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,31,'QUESTION_RESPONSE','Part 2','Let''s reschedule the meeting to Friday.','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','That works for me.','Chuyển cuộc họp sang thứ Sáu đi.','Với tôi thì được.','{"toeic_part":2,"transcript":"Let''s reschedule the meeting to Friday.","response_vi":"Với tôi thì được."}', 31,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,32,'QUESTION_RESPONSE','Part 2','I heard the parking lot will be closed next week.','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Where are we supposed to park then?','Tôi nghe nói bãi đỗ xe sẽ đóng tuần sau.','Vậy chúng ta đỗ ở đâu?','{"toeic_part":2,"transcript":"I heard the parking lot will be closed next week.","response_vi":"Vậy chúng ta đỗ ở đâu?"}', 32,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,33,'QUESTION_RESPONSE','Part 2','This printer seems to be out of paper.','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','There''s more in the supply room.','Máy in này hình như hết giấy rồi.','Còn thêm trong phòng vật tư.','{"toeic_part":2,"transcript":"This printer seems to be out of paper.","response_vi":"Còn thêm trong phòng vật tư."}', 33,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,34,'QUESTION_RESPONSE','Part 2','Would you mind reviewing this document for me?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','I''d be happy to.','Bạn có phiền xem lại tài liệu này cho tôi không?','Tôi sẵn lòng.','{"toeic_part":2,"transcript":"Would you mind reviewing this document for me?","response_vi":"Tôi sẵn lòng."}', 34,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,35,'QUESTION_RESPONSE','Part 2','The deadline has been extended, hasn''t it?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Yes, we have until the end of the month now.','Hạn chót đã được gia hạn, phải không?','Đúng, giờ chúng ta có đến cuối tháng.','{"toeic_part":2,"transcript":"The deadline has been extended, hasn''t it?","response_vi":"Đúng, giờ chúng ta có đến cuối tháng."}', 35,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,36,'QUESTION_RESPONSE','Part 2','How about we take a break before the next session?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Good idea. I could use some coffee.','Hay là chúng ta nghỉ giải lao trước buổi tiếp theo?','Ý hay. Tôi cũng muốn uống cà phê.','{"toeic_part":2,"transcript":"How about we take a break before the next session?","response_vi":"Ý hay. Tôi cũng muốn uống cà phê."}', 36,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,37,'QUESTION_RESPONSE','Part 2','Don''t forget to lock up when you leave.','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','I always do.','Đừng quên khóa cửa khi rời đi nhé.','Tôi luôn làm vậy mà.','{"toeic_part":2,"transcript":"Don''t forget to lock up when you leave.","response_vi":"Tôi luôn làm vậy mà."}', 37,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,38,'QUESTION_RESPONSE','Part 2','I can''t seem to connect to the Wi-Fi.','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','The password was changed this morning.','Tôi không kết nối được Wi-Fi.','Mật khẩu đã đổi sáng nay.','{"toeic_part":2,"transcript":"I can''t seem to connect to the Wi-Fi.","response_vi":"Mật khẩu đã đổi sáng nay."}', 38,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,39,'QUESTION_RESPONSE','Part 2','Why don''t we invite the marketing team to the meeting?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','I''ll send them an email right away.','Sao chúng ta không mời đội marketing vào cuộc họp?','Tôi sẽ gửi email cho họ ngay.','{"toeic_part":2,"transcript":"Why don''t we invite the marketing team to the meeting?","response_vi":"Tôi sẽ gửi email cho họ ngay."}', 39,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,40,'QUESTION_RESPONSE','Part 2','The new hire starts next Monday, right?','Nghe câu hỏi và tự nghĩ phản hồi tự nhiên.','Actually, it''s been pushed back to Wednesday.','Nhân viên mới bắt đầu thứ Hai tuần sau, đúng không?','Thực ra đã lùi lại đến thứ Tư.','{"toeic_part":2,"transcript":"The new hire starts next Monday, right?","response_vi":"Thực ra đã lùi lại đến thứ Tư."}', 40,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,41,'COMPREHENSION','Part 3 · Đoạn 1: Đặt phòng họp','W: Do we have a conference room booked for the client meeting tomorrow?
M: I checked, and Room B is available from 10 to 12.
W: That should work. Can you also order some refreshments?','What are the speakers discussing?','Chuẩn bị cho cuộc họp khách hàng.','Họ đang bàn về việc gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":1,"group_title":"Đặt phòng họp","transcript":"W: Do we have a conference room booked for the client meeting tomorrow?\\nM: I checked, and Room B is available from 10 to 12.\\nW: That should work. Can you also order some refreshments?"}', 41,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,42,'COMPREHENSION','Part 3 · Đoạn 1: Đặt phòng họp','W: Do we have a conference room booked for the client meeting tomorrow?
M: I checked, and Room B is available from 10 to 12.
W: That should work. Can you also order some refreshments?','What time is Room B available?','Từ 10 đến 12 giờ.','Phòng B trống lúc mấy giờ?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":1,"group_title":"Đặt phòng họp","transcript":"W: Do we have a conference room booked for the client meeting tomorrow?\\nM: I checked, and Room B is available from 10 to 12.\\nW: That should work. Can you also order some refreshments?"}', 42,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,43,'COMPREHENSION','Part 3 · Đoạn 1: Đặt phòng họp','W: Do we have a conference room booked for the client meeting tomorrow?
M: I checked, and Room B is available from 10 to 12.
W: That should work. Can you also order some refreshments?','What does the woman ask the man to do?','Đặt đồ ăn nhẹ.','Người phụ nữ nhờ người đàn ông làm gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":1,"group_title":"Đặt phòng họp","transcript":"W: Do we have a conference room booked for the client meeting tomorrow?\\nM: I checked, and Room B is available from 10 to 12.\\nW: That should work. Can you also order some refreshments?"}', 43,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,44,'COMPREHENSION','Part 3 · Đoạn 2: Vấn đề giao hàng','M: I just got a call from the shipping company. Our delivery will be two days late.
W: That''s going to cause problems. We promised the client it''d arrive by Friday.
M: I know. I''ll contact them to see if there''s a faster option.','What is the problem?','Giao hàng bị trễ 2 ngày.','Vấn đề là gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":2,"group_title":"Vấn đề giao hàng","transcript":"M: I just got a call from the shipping company. Our delivery will be two days late.\\nW: That''s going to cause problems. We promised the client it''d arrive by Friday.\\nM: I know. I''ll contact them to see if there''s a faster option."}', 44,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,45,'COMPREHENSION','Part 3 · Đoạn 2: Vấn đề giao hàng','M: I just got a call from the shipping company. Our delivery will be two days late.
W: That''s going to cause problems. We promised the client it''d arrive by Friday.
M: I know. I''ll contact them to see if there''s a faster option.','When was the delivery originally promised?','Trước thứ Sáu.','Ban đầu hẹn giao khi nào?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":2,"group_title":"Vấn đề giao hàng","transcript":"M: I just got a call from the shipping company. Our delivery will be two days late.\\nW: That''s going to cause problems. We promised the client it''d arrive by Friday.\\nM: I know. I''ll contact them to see if there''s a faster option."}', 45,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,46,'COMPREHENSION','Part 3 · Đoạn 2: Vấn đề giao hàng','M: I just got a call from the shipping company. Our delivery will be two days late.
W: That''s going to cause problems. We promised the client it''d arrive by Friday.
M: I know. I''ll contact them to see if there''s a faster option.','What will the man do next?','Liên hệ công ty vận chuyển.','Người đàn ông sẽ làm gì tiếp?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":2,"group_title":"Vấn đề giao hàng","transcript":"M: I just got a call from the shipping company. Our delivery will be two days late.\\nW: That''s going to cause problems. We promised the client it''d arrive by Friday.\\nM: I know. I''ll contact them to see if there''s a faster option."}', 46,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,47,'COMPREHENSION','Part 3 · Đoạn 3: Nhân viên mới','M: Have you met the new marketing manager?
W: Not yet. I heard she transferred from the Singapore office.
M: Yes. She''ll be introduced at the staff meeting this afternoon.','What are they talking about?','Quản lý marketing mới.','Họ đang nói về gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":3,"group_title":"Nhân viên mới","transcript":"M: Have you met the new marketing manager?\\nW: Not yet. I heard she transferred from the Singapore office.\\nM: Yes. She''ll be introduced at the staff meeting this afternoon."}', 47,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,48,'COMPREHENSION','Part 3 · Đoạn 3: Nhân viên mới','M: Have you met the new marketing manager?
W: Not yet. I heard she transferred from the Singapore office.
M: Yes. She''ll be introduced at the staff meeting this afternoon.','Where did the new manager come from?','Văn phòng Singapore.','Quản lý mới đến từ đâu?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":3,"group_title":"Nhân viên mới","transcript":"M: Have you met the new marketing manager?\\nW: Not yet. I heard she transferred from the Singapore office.\\nM: Yes. She''ll be introduced at the staff meeting this afternoon."}', 48,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,49,'COMPREHENSION','Part 3 · Đoạn 3: Nhân viên mới','M: Have you met the new marketing manager?
W: Not yet. I heard she transferred from the Singapore office.
M: Yes. She''ll be introduced at the staff meeting this afternoon.','When will she be introduced?','Tại cuộc họp chiều nay.','Cô ấy sẽ được giới thiệu khi nào?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":3,"group_title":"Nhân viên mới","transcript":"M: Have you met the new marketing manager?\\nW: Not yet. I heard she transferred from the Singapore office.\\nM: Yes. She''ll be introduced at the staff meeting this afternoon."}', 49,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,50,'COMPREHENSION','Part 3 · Đoạn 4: Sự cố kỹ thuật','W: The printer on the second floor isn''t working again.
M: Did you submit a maintenance request?
W: Yes, but they said a technician won''t be available until tomorrow.','What is the problem?','Máy in tầng 2 hỏng.','Vấn đề là gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":4,"group_title":"Sự cố kỹ thuật","transcript":"W: The printer on the second floor isn''t working again.\\nM: Did you submit a maintenance request?\\nW: Yes, but they said a technician won''t be available until tomorrow."}', 50,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,51,'COMPREHENSION','Part 3 · Đoạn 4: Sự cố kỹ thuật','W: The printer on the second floor isn''t working again.
M: Did you submit a maintenance request?
W: Yes, but they said a technician won''t be available until tomorrow.','What did the woman already do?','Gửi yêu cầu bảo trì.','Người phụ nữ đã làm gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":4,"group_title":"Sự cố kỹ thuật","transcript":"W: The printer on the second floor isn''t working again.\\nM: Did you submit a maintenance request?\\nW: Yes, but they said a technician won''t be available until tomorrow."}', 51,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,52,'COMPREHENSION','Part 3 · Đoạn 4: Sự cố kỹ thuật','W: The printer on the second floor isn''t working again.
M: Did you submit a maintenance request?
W: Yes, but they said a technician won''t be available until tomorrow.','When will the technician come?','Ngày mai.','Kỹ thuật viên sẽ đến khi nào?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":4,"group_title":"Sự cố kỹ thuật","transcript":"W: The printer on the second floor isn''t working again.\\nM: Did you submit a maintenance request?\\nW: Yes, but they said a technician won''t be available until tomorrow."}', 52,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,53,'COMPREHENSION','Part 3 · Đoạn 5: Đào tạo','M: Are you attending the software training session next week?
W: I''d like to, but it conflicts with my sales presentation.
M: They''re offering a second session on Thursday. You could sign up for that one.','Why can''t the woman attend the training?','Trùng lịch thuyết trình bán hàng.','Tại sao cô ấy không dự được?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":5,"group_title":"Đào tạo","transcript":"M: Are you attending the software training session next week?\\nW: I''d like to, but it conflicts with my sales presentation.\\nM: They''re offering a second session on Thursday. You could sign up for that one."}', 53,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,54,'COMPREHENSION','Part 3 · Đoạn 5: Đào tạo','M: Are you attending the software training session next week?
W: I''d like to, but it conflicts with my sales presentation.
M: They''re offering a second session on Thursday. You could sign up for that one.','What does the man suggest?','Đăng ký buổi thứ Năm.','Người đàn ông gợi ý gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":5,"group_title":"Đào tạo","transcript":"M: Are you attending the software training session next week?\\nW: I''d like to, but it conflicts with my sales presentation.\\nM: They''re offering a second session on Thursday. You could sign up for that one."}', 54,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,55,'COMPREHENSION','Part 3 · Đoạn 5: Đào tạo','M: Are you attending the software training session next week?
W: I''d like to, but it conflicts with my sales presentation.
M: They''re offering a second session on Thursday. You could sign up for that one.','What is the training about?','Phần mềm.','Buổi đào tạo về gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":5,"group_title":"Đào tạo","transcript":"M: Are you attending the software training session next week?\\nW: I''d like to, but it conflicts with my sales presentation.\\nM: They''re offering a second session on Thursday. You could sign up for that one."}', 55,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,56,'COMPREHENSION','Part 3 · Đoạn 6: Thay đổi chính sách','W: Did you see the memo about the new expense policy?
M: Yes. All travel expenses over $200 now need director approval.
W: That''s going to slow things down. I''ll bring it up at the next team meeting.','What changed in the expense policy?','Chi phí trên $200 cần giám đốc duyệt.','Chính sách chi phí thay đổi gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":6,"group_title":"Thay đổi chính sách","transcript":"W: Did you see the memo about the new expense policy?\\nM: Yes. All travel expenses over $200 now need director approval.\\nW: That''s going to slow things down. I''ll bring it up at the next team meeting."}', 56,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,57,'COMPREHENSION','Part 3 · Đoạn 6: Thay đổi chính sách','W: Did you see the memo about the new expense policy?
M: Yes. All travel expenses over $200 now need director approval.
W: That''s going to slow things down. I''ll bring it up at the next team meeting.','What is the woman''s concern?','Quy trình sẽ bị chậm lại.','Cô ấy lo ngại gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":6,"group_title":"Thay đổi chính sách","transcript":"W: Did you see the memo about the new expense policy?\\nM: Yes. All travel expenses over $200 now need director approval.\\nW: That''s going to slow things down. I''ll bring it up at the next team meeting."}', 57,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,58,'COMPREHENSION','Part 3 · Đoạn 6: Thay đổi chính sách','W: Did you see the memo about the new expense policy?
M: Yes. All travel expenses over $200 now need director approval.
W: That''s going to slow things down. I''ll bring it up at the next team meeting.','What will the woman do?','Nêu vấn đề tại cuộc họp nhóm.','Cô ấy sẽ làm gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":6,"group_title":"Thay đổi chính sách","transcript":"W: Did you see the memo about the new expense policy?\\nM: Yes. All travel expenses over $200 now need director approval.\\nW: That''s going to slow things down. I''ll bring it up at the next team meeting."}', 58,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,59,'COMPREHENSION','Part 3 · Đoạn 7: Thuê địa điểm tổ chức sự kiện','M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?
W: The Grand Hotel has a nice banquet hall that can hold up to 200 people.
M: That sounds perfect. I''ll call them today to check availability.','What is the man planning?','Bữa tiệc công ty hàng năm.','Anh ấy đang lên kế hoạch gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":7,"group_title":"Thuê địa điểm tổ chức sự kiện","transcript":"M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?\\nW: The Grand Hotel has a nice banquet hall that can hold up to 200 people.\\nM: That sounds perfect. I''ll call them today to check availability."}', 59,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,60,'COMPREHENSION','Part 3 · Đoạn 7: Thuê địa điểm tổ chức sự kiện','M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?
W: The Grand Hotel has a nice banquet hall that can hold up to 200 people.
M: That sounds perfect. I''ll call them today to check availability.','How many people can the banquet hall hold?','200 người.','Phòng tiệc chứa được bao nhiêu người?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":7,"group_title":"Thuê địa điểm tổ chức sự kiện","transcript":"M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?\\nW: The Grand Hotel has a nice banquet hall that can hold up to 200 people.\\nM: That sounds perfect. I''ll call them today to check availability."}', 60,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,61,'COMPREHENSION','Part 3 · Đoạn 7: Thuê địa điểm tổ chức sự kiện','M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?
W: The Grand Hotel has a nice banquet hall that can hold up to 200 people.
M: That sounds perfect. I''ll call them today to check availability.','What will the man do next?','Gọi điện kiểm tra lịch trống.','Anh ấy sẽ làm gì tiếp?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":7,"group_title":"Thuê địa điểm tổ chức sự kiện","transcript":"M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?\\nW: The Grand Hotel has a nice banquet hall that can hold up to 200 people.\\nM: That sounds perfect. I''ll call them today to check availability."}', 61,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,62,'COMPREHENSION','Part 3 · Đoạn 8: Phỏng vấn xin việc','W: How did your job interview go this morning?
M: Pretty well, I think. They said they''ll let me know by the end of the week.
W: That''s fast. They must have been impressed.','What did the man do this morning?','Đi phỏng vấn.','Anh ấy làm gì sáng nay?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":8,"group_title":"Phỏng vấn xin việc","transcript":"W: How did your job interview go this morning?\\nM: Pretty well, I think. They said they''ll let me know by the end of the week.\\nW: That''s fast. They must have been impressed."}', 62,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,63,'COMPREHENSION','Part 3 · Đoạn 8: Phỏng vấn xin việc','W: How did your job interview go this morning?
M: Pretty well, I think. They said they''ll let me know by the end of the week.
W: That''s fast. They must have been impressed.','When will he hear back?','Trước cuối tuần.','Khi nào anh ấy nhận phản hồi?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":8,"group_title":"Phỏng vấn xin việc","transcript":"W: How did your job interview go this morning?\\nM: Pretty well, I think. They said they''ll let me know by the end of the week.\\nW: That''s fast. They must have been impressed."}', 63,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,64,'COMPREHENSION','Part 3 · Đoạn 8: Phỏng vấn xin việc','W: How did your job interview go this morning?
M: Pretty well, I think. They said they''ll let me know by the end of the week.
W: That''s fast. They must have been impressed.','What does the woman imply?','Công ty có vẻ ấn tượng với anh ấy.','Cô ấy ám chỉ gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":8,"group_title":"Phỏng vấn xin việc","transcript":"W: How did your job interview go this morning?\\nM: Pretty well, I think. They said they''ll let me know by the end of the week.\\nW: That''s fast. They must have been impressed."}', 64,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,65,'COMPREHENSION','Part 3 · Đoạn 9: Chuyển văn phòng','M: Our department is moving to the fifth floor next month.
W: Really? I hadn''t heard. Will we have more space?
M: Yes, and we''ll be closer to the IT team, which should make collaboration easier.','What will happen next month?','Phòng ban chuyển lên tầng 5.','Tháng sau có chuyện gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":9,"group_title":"Chuyển văn phòng","transcript":"M: Our department is moving to the fifth floor next month.\\nW: Really? I hadn''t heard. Will we have more space?\\nM: Yes, and we''ll be closer to the IT team, which should make collaboration easier."}', 65,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,66,'COMPREHENSION','Part 3 · Đoạn 9: Chuyển văn phòng','M: Our department is moving to the fifth floor next month.
W: Really? I hadn''t heard. Will we have more space?
M: Yes, and we''ll be closer to the IT team, which should make collaboration easier.','What is one advantage of the new location?','Gần đội IT hơn, dễ hợp tác.','Lợi ích của địa điểm mới?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":9,"group_title":"Chuyển văn phòng","transcript":"M: Our department is moving to the fifth floor next month.\\nW: Really? I hadn''t heard. Will we have more space?\\nM: Yes, and we''ll be closer to the IT team, which should make collaboration easier."}', 66,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,67,'COMPREHENSION','Part 3 · Đoạn 9: Chuyển văn phòng','M: Our department is moving to the fifth floor next month.
W: Really? I hadn''t heard. Will we have more space?
M: Yes, and we''ll be closer to the IT team, which should make collaboration easier.','How does the woman react to the news?','Ngạc nhiên vì chưa biết.','Cô ấy phản ứng thế nào?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":9,"group_title":"Chuyển văn phòng","transcript":"M: Our department is moving to the fifth floor next month.\\nW: Really? I hadn''t heard. Will we have more space?\\nM: Yes, and we''ll be closer to the IT team, which should make collaboration easier."}', 67,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,68,'COMPREHENSION','Part 3 · Đoạn 10: Phản hồi khách hàng','W: We''ve been getting a lot of complaints about our new app update.
M: What''s the main issue?
W: Users say it crashes frequently. I think we need to release a patch this week.','What are customers complaining about?','Bản cập nhật ứng dụng mới.','Khách hàng phàn nàn về gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":10,"group_title":"Phản hồi khách hàng","transcript":"W: We''ve been getting a lot of complaints about our new app update.\\nM: What''s the main issue?\\nW: Users say it crashes frequently. I think we need to release a patch this week."}', 68,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,69,'COMPREHENSION','Part 3 · Đoạn 10: Phản hồi khách hàng','W: We''ve been getting a lot of complaints about our new app update.
M: What''s the main issue?
W: Users say it crashes frequently. I think we need to release a patch this week.','What is the main problem?','Ứng dụng hay bị văng (crash).','Vấn đề chính là gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":10,"group_title":"Phản hồi khách hàng","transcript":"W: We''ve been getting a lot of complaints about our new app update.\\nM: What''s the main issue?\\nW: Users say it crashes frequently. I think we need to release a patch this week."}', 69,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,70,'COMPREHENSION','Part 3 · Đoạn 10: Phản hồi khách hàng','W: We''ve been getting a lot of complaints about our new app update.
M: What''s the main issue?
W: Users say it crashes frequently. I think we need to release a patch this week.','What does the woman suggest?','Phát hành bản vá tuần này.','Cô ấy đề xuất gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":10,"group_title":"Phản hồi khách hàng","transcript":"W: We''ve been getting a lot of complaints about our new app update.\\nM: What''s the main issue?\\nW: Users say it crashes frequently. I think we need to release a patch this week."}', 70,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,71,'COMPREHENSION','Part 3 · Đoạn 11: Đặt hàng văn phòng phẩm','M: We''re running low on printer paper and toner cartridges.
W: I placed an order yesterday, but the supplier said delivery might take a week.
M: A week? Maybe we should try a different supplier.','What is running low?','Giấy in và mực in.','Cái gì sắp hết?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":11,"group_title":"Đặt hàng văn phòng phẩm","transcript":"M: We''re running low on printer paper and toner cartridges.\\nW: I placed an order yesterday, but the supplier said delivery might take a week.\\nM: A week? Maybe we should try a different supplier."}', 71,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,72,'COMPREHENSION','Part 3 · Đoạn 11: Đặt hàng văn phòng phẩm','M: We''re running low on printer paper and toner cartridges.
W: I placed an order yesterday, but the supplier said delivery might take a week.
M: A week? Maybe we should try a different supplier.','When did the woman place the order?','Hôm qua.','Cô ấy đặt hàng khi nào?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":11,"group_title":"Đặt hàng văn phòng phẩm","transcript":"M: We''re running low on printer paper and toner cartridges.\\nW: I placed an order yesterday, but the supplier said delivery might take a week.\\nM: A week? Maybe we should try a different supplier."}', 72,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,73,'COMPREHENSION','Part 3 · Đoạn 11: Đặt hàng văn phòng phẩm','M: We''re running low on printer paper and toner cartridges.
W: I placed an order yesterday, but the supplier said delivery might take a week.
M: A week? Maybe we should try a different supplier.','What does the man suggest?','Thử nhà cung cấp khác.','Anh ấy gợi ý gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":11,"group_title":"Đặt hàng văn phòng phẩm","transcript":"M: We''re running low on printer paper and toner cartridges.\\nW: I placed an order yesterday, but the supplier said delivery might take a week.\\nM: A week? Maybe we should try a different supplier."}', 73,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,74,'COMPREHENSION','Part 3 · Đoạn 12: Hội thoại 3 người','M1: The client wants to move the project deadline up by two weeks.
W: That''s really tight. We''d have to bring in additional staff.
M2: Or we could outsource part of the design work. That might be faster.','What does the client want?','Đẩy sớm hạn 2 tuần.','Khách hàng muốn gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":12,"group_title":"Hội thoại 3 người","transcript":"M1: The client wants to move the project deadline up by two weeks.\\nW: That''s really tight. We''d have to bring in additional staff.\\nM2: Or we could outsource part of the design work. That might be faster."}', 74,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,75,'COMPREHENSION','Part 3 · Đoạn 12: Hội thoại 3 người','M1: The client wants to move the project deadline up by two weeks.
W: That''s really tight. We''d have to bring in additional staff.
M2: Or we could outsource part of the design work. That might be faster.','What does the woman suggest?','Thêm nhân sự.','Cô ấy đề xuất gì?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":12,"group_title":"Hội thoại 3 người","transcript":"M1: The client wants to move the project deadline up by two weeks.\\nW: That''s really tight. We''d have to bring in additional staff.\\nM2: Or we could outsource part of the design work. That might be faster."}', 75,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,76,'COMPREHENSION','Part 3 · Đoạn 12: Hội thoại 3 người','M1: The client wants to move the project deadline up by two weeks.
W: That''s really tight. We''d have to bring in additional staff.
M2: Or we could outsource part of the design work. That might be faster.','What is the second man''s alternative?','Thuê ngoài phần thiết kế.','Phương án của người đàn ông thứ hai?','Đọc câu hỏi trước → nghe hội thoại → tự trả lời → mở đáp án.','{"toeic_part":3,"group_no":12,"group_title":"Hội thoại 3 người","transcript":"M1: The client wants to move the project deadline up by two weeks.\\nW: That''s really tight. We''d have to bring in additional staff.\\nM2: Or we could outsource part of the design work. That might be faster."}', 76,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,77,'COMPREHENSION','Part 4 · Bài 1: Tin nhắn thoại (Telephone message)','Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference.','Why is the speaker calling?','Thông báo hàng đã đến kho.','Tại sao người nói gọi điện?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":1,"group_title":"Tin nhắn thoại (Telephone message)","transcript":"Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference."}', 77,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,78,'COMPREHENSION','Part 4 · Bài 1: Tin nhắn thoại (Telephone message)','Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference.','What are the pickup hours?','9 giờ sáng đến 6 giờ chiều.','Giờ nhận hàng?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":1,"group_title":"Tin nhắn thoại (Telephone message)","transcript":"Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference."}', 78,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,79,'COMPREHENSION','Part 4 · Bài 1: Tin nhắn thoại (Telephone message)','Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference.','What should the listener do?','Gọi lại để cho biết lựa chọn.','Người nghe nên làm gì?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":1,"group_title":"Tin nhắn thoại (Telephone message)","transcript":"Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference."}', 79,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,80,'COMPREHENSION','Part 4 · Bài 2: Thông báo nội bộ (Company announcement)','Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR.','What will happen next Monday?','Bãi đỗ xe đóng cửa.','Thứ Hai tới có gì?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":2,"group_title":"Thông báo nội bộ (Company announcement)","transcript":"Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR."}', 80,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,81,'COMPREHENSION','Part 4 · Bài 2: Thông báo nội bộ (Company announcement)','Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR.','How long will the work take?','Khoảng hai tuần.','Công việc kéo dài bao lâu?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":2,"group_title":"Thông báo nội bộ (Company announcement)","transcript":"Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR."}', 81,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,82,'COMPREHENSION','Part 4 · Bài 2: Thông báo nội bộ (Company announcement)','Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR.','How can employees get reimbursed?','Nộp biên lai cho HR.','Nhân viên được hoàn phí bằng cách nào?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":2,"group_title":"Thông báo nội bộ (Company announcement)","transcript":"Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR."}', 82,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,83,'COMPREHENSION','Part 4 · Bài 3: Quảng cáo (Advertisement)','Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com.','What is being advertised?','Công cụ quản lý dự án.','Quảng cáo về gì?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":3,"group_title":"Quảng cáo (Advertisement)","transcript":"Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com."}', 83,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,84,'COMPREHENSION','Part 4 · Bài 3: Quảng cáo (Advertisement)','Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com.','How many companies use the product?','Hơn 10.000.','Bao nhiêu công ty sử dụng?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":3,"group_title":"Quảng cáo (Advertisement)","transcript":"Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com."}', 84,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,85,'COMPREHENSION','Part 4 · Bài 3: Quảng cáo (Advertisement)','Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com.','What is offered to new users?','Dùng thử miễn phí 30 ngày.','Ưu đãi cho người dùng mới?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":3,"group_title":"Quảng cáo (Advertisement)","transcript":"Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com."}', 85,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,86,'COMPREHENSION','Part 4 · Bài 4: Hướng dẫn tour (Tour guide)','Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes.','Where will the tour start?','Cánh Đông (East Wing).','Tour bắt đầu ở đâu?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":4,"group_title":"Hướng dẫn tour (Tour guide)","transcript":"Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes."}', 86,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,87,'COMPREHENSION','Part 4 · Bài 4: Hướng dẫn tour (Tour guide)','Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes.','What is NOT allowed in the East Wing?','Chụp ảnh.','Không được làm gì ở Cánh Đông?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":4,"group_title":"Hướng dẫn tour (Tour guide)","transcript":"Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes."}', 87,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,88,'COMPREHENSION','Part 4 · Bài 4: Hướng dẫn tour (Tour guide)','Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes.','How long is the tour?','Khoảng 90 phút.','Tour kéo dài bao lâu?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":4,"group_title":"Hướng dẫn tour (Tour guide)","transcript":"Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes."}', 88,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,89,'COMPREHENSION','Part 4 · Bài 5: Tin tức (News report)','In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year.','What did Hartfield Industries announce?','Mở nhà máy mới.','Hartfield thông báo gì?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":5,"group_title":"Tin tức (News report)","transcript":"In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year."}', 89,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,90,'COMPREHENSION','Part 4 · Bài 5: Tin tức (News report)','In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year.','How many jobs will be created?','Hơn 500.','Sẽ tạo ra bao nhiêu việc làm?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":5,"group_title":"Tin tức (News report)","transcript":"In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year."}', 90,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,91,'COMPREHENSION','Part 4 · Bài 5: Tin tức (News report)','In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year.','When will construction begin?','Tháng 3.','Xây dựng bắt đầu khi nào?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":5,"group_title":"Tin tức (News report)","transcript":"In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year."}', 91,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,92,'COMPREHENSION','Part 4 · Bài 6: Tin nhắn thoại (Voicemail)','Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today.','Why is the speaker calling?','Thông báo xe đã sửa xong.','Tại sao gọi điện?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":6,"group_title":"Tin nhắn thoại (Voicemail)","transcript":"Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today."}', 92,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,93,'COMPREHENSION','Part 4 · Bài 6: Tin nhắn thoại (Voicemail)','Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today.','What additional recommendation is made?','Thay lốp trước.','Khuyến nghị thêm gì?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":6,"group_title":"Tin nhắn thoại (Voicemail)","transcript":"Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today."}', 93,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,94,'COMPREHENSION','Part 4 · Bài 6: Tin nhắn thoại (Voicemail)','Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today.','How much is the total?','$285.','Tổng cộng bao nhiêu?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":6,"group_title":"Tin nhắn thoại (Voicemail)","transcript":"Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today."}', 94,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,95,'COMPREHENSION','Part 4 · Bài 7: Giới thiệu diễn giả (Introduction)','It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell.','Who is Dr. Mitchell?','Tác giả, diễn giả chính.','Tiến sĩ Mitchell là ai?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":7,"group_title":"Giới thiệu diễn giả (Introduction)","transcript":"It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell."}', 95,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,96,'COMPREHENSION','Part 4 · Bài 7: Giới thiệu diễn giả (Introduction)','It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell.','How many books has she written?','3 cuốn.','Bà ấy viết bao nhiêu sách?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":7,"group_title":"Giới thiệu diễn giả (Introduction)","transcript":"It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell."}', 96,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,97,'COMPREHENSION','Part 4 · Bài 7: Giới thiệu diễn giả (Introduction)','It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell.','What is her current position?','Trưởng khoa Kinh doanh, ĐH Western.','Chức vụ hiện tại?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":7,"group_title":"Giới thiệu diễn giả (Introduction)","transcript":"It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell."}', 97,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,98,'COMPREHENSION','Part 4 · Bài 8: Thông báo tự động (Recorded message)','Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience.','Why are flights delayed?','Thời tiết xấu.','Tại sao chuyến bay bị hoãn?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":8,"group_title":"Thông báo tự động (Recorded message)","transcript":"Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience."}', 98,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,99,'COMPREHENSION','Part 4 · Bài 8: Thông báo tự động (Recorded message)','Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience.','How long is the delay?','Khoảng 2 tiếng.','Hoãn bao lâu?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":8,"group_title":"Thông báo tự động (Recorded message)","transcript":"Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience."}', 99,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT INTO handbook_practice_items(section_id,item_no,item_type,group_key,audio_text,prompt,answer,translation,explanation,metadata_json,sort_order,is_active) SELECT s.id,100,'COMPREHENSION','Part 4 · Bài 8: Thông báo tự động (Recorded message)','Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience.','What are passengers advised to do?','Kiểm tra website hoặc app.','Hành khách được khuyên làm gì?','Xác định dạng bài → nghe bài nói → tự trả lời → mở đáp án.','{"toeic_part":4,"group_no":8,"group_title":"Thông báo tự động (Recorded message)","transcript":"Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience."}', 100,1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4' ON DUPLICATE KEY UPDATE item_type=VALUES(item_type),group_key=VALUES(group_key),audio_text=VALUES(audio_text),prompt=VALUES(prompt),answer=VALUES(answer),translation=VALUES(translation),explanation=VALUES(explanation),metadata_json=VALUES(metadata_json),sort_order=VALUES(sort_order),is_active=1;
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-grammar-01','GRAMMAR_LESSON','Parts of Speech / Word Forms','Loại từ: xác định vị trí cần danh từ, động từ, tính từ hay trạng từ trước khi chọn đáp án.','Loại từ: xác định vị trí cần danh từ, động từ, tính từ hay trạng từ trước khi chọn đáp án.','The manager gave a convincing presentation.','','Parts of Speech / Word Forms','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-01","grammar_category":"PARTS_OF_SPEECH","tags":"toeic,800-plus,grammar,parts_of_speech","audio_text":"The manager gave a convincing presentation.","source":"TOEIC Grammar 800+ user handbook"}','4f631062826a2b8e576a19919e30efdd4ef728f1',1),
('hbk-grammar-02','GRAMMAR_LESSON','Tenses','Thì: ưu tiên dấu hiệu thời gian và quan hệ trước–sau để chọn dạng động từ.','Thì: ưu tiên dấu hiệu thời gian và quan hệ trước–sau để chọn dạng động từ.','We have already submitted the proposal.','','Tenses','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-02","grammar_category":"TENSES","tags":"toeic,800-plus,grammar,tenses","audio_text":"We have already submitted the proposal.","source":"TOEIC Grammar 800+ user handbook"}','a67b90179ba445dae52a3fdf1fb4870d2101ca24',1),
('hbk-grammar-03','GRAMMAR_LESSON','Passive Voice','Bị động: S + be + V3; rất thường gặp khi chủ ngữ là đối tượng nhận hành động.','Bị động: S + be + V3; rất thường gặp khi chủ ngữ là đối tượng nhận hành động.','The order has been shipped.','','Passive Voice','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-03","grammar_category":"PASSIVE_VOICE","tags":"toeic,800-plus,grammar,passive_voice","audio_text":"The order has been shipped.","source":"TOEIC Grammar 800+ user handbook"}','caec5900ef5ff014f38b20346b58275be534927c',1),
('hbk-grammar-04','GRAMMAR_LESSON','Subject–Verb Agreement','Chủ–vị: xác định chủ ngữ thật, bỏ qua cụm giới từ chen giữa và chú ý each/every, a number of, neither...nor.','Chủ–vị: xác định chủ ngữ thật, bỏ qua cụm giới từ chen giữa và chú ý each/every, a number of, neither...nor.','The list of candidates has been reviewed.','','Subject–Verb Agreement','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-04","grammar_category":"SUBJECT_VERB_AGREEMENT","tags":"toeic,800-plus,grammar,subject_verb_agreement","audio_text":"The list of candidates has been reviewed.","source":"TOEIC Grammar 800+ user handbook"}','5fa59b7d6fd9bbfb4398e23be7c0bad6fc47d4bd',1),
('hbk-grammar-05','GRAMMAR_LESSON','Pronouns','Đại từ: chọn đúng chủ ngữ, tân ngữ, tính từ sở hữu, đại từ sở hữu hoặc phản thân theo vị trí.','Đại từ: chọn đúng chủ ngữ, tân ngữ, tính từ sở hữu, đại từ sở hữu hoặc phản thân theo vị trí.','The company increased its revenue.','','Pronouns','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-05","grammar_category":"PRONOUNS","tags":"toeic,800-plus,grammar,pronouns","audio_text":"The company increased its revenue.","source":"TOEIC Grammar 800+ user handbook"}','fd5f9000c0b5b6067cd0fac8a97b6d8e0421c8fd',1),
('hbk-grammar-06','GRAMMAR_LESSON','Articles','Mạo từ: a/an cho danh từ đếm được số ít chưa xác định; the cho đối tượng đã xác định; một số danh từ dùng không mạo từ.','Mạo từ: a/an cho danh từ đếm được số ít chưa xác định; the cho đối tượng đã xác định; một số danh từ dùng không mạo từ.','We received an application from a candidate.','','Articles','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-06","grammar_category":"ARTICLES","tags":"toeic,800-plus,grammar,articles","audio_text":"We received an application from a candidate.","source":"TOEIC Grammar 800+ user handbook"}','ddef8d8800318220bae8768917b185587d994027',1),
('hbk-grammar-07','GRAMMAR_LESSON','Prepositions','Giới từ: học theo cụm cố định và ngữ cảnh thời gian, địa điểm, động từ/tính từ đi kèm.','Giới từ: học theo cụm cố định và ngữ cảnh thời gian, địa điểm, động từ/tính từ đi kèm.','Please submit the application by Friday.','','Prepositions','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-07","grammar_category":"PREPOSITIONS","tags":"toeic,800-plus,grammar,prepositions","audio_text":"Please submit the application by Friday.","source":"TOEIC Grammar 800+ user handbook"}','c2c61205ee190ef222ccdc3c9fb3dbb0c0961053',1),
('hbk-grammar-08','GRAMMAR_LESSON','Conjunctions & Connectors','Liên từ/từ nối: phân biệt liên từ nối mệnh đề, trạng từ nối và giới từ nối trước cụm danh từ/V-ing.','Liên từ/từ nối: phân biệt liên từ nối mệnh đề, trạng từ nối và giới từ nối trước cụm danh từ/V-ing.','Although sales fell, profits increased.','','Conjunctions & Connectors','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-08","grammar_category":"CONJUNCTIONS","tags":"toeic,800-plus,grammar,conjunctions","audio_text":"Although sales fell, profits increased.","source":"TOEIC Grammar 800+ user handbook"}','f4b848560d926a2d308cade572a3377b1727e6e8',1),
('hbk-grammar-09','GRAMMAR_LESSON','Relative Clauses','Mệnh đề quan hệ: who/whom/whose cho người, which/that cho vật; where/when cho nơi chốn/thời gian.','Mệnh đề quan hệ: who/whom/whose cho người, which/that cho vật; where/when cho nơi chốn/thời gian.','The employee who won the award works in Sales.','','Relative Clauses','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-09","grammar_category":"RELATIVE_CLAUSES","tags":"toeic,800-plus,grammar,relative_clauses","audio_text":"The employee who won the award works in Sales.","source":"TOEIC Grammar 800+ user handbook"}','22ae12a87e60677fa0e73eccdea2a20292d08955',1),
('hbk-grammar-10','GRAMMAR_LESSON','Comparatives & Superlatives','So sánh: comparative + than, superlative + in/of và các cấu trúc the more..., the more....','So sánh: comparative + than, superlative + in/of và các cấu trúc the more..., the more....','This model is more efficient than the previous one.','','Comparatives & Superlatives','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-10","grammar_category":"COMPARATIVES","tags":"toeic,800-plus,grammar,comparatives","audio_text":"This model is more efficient than the previous one.","source":"TOEIC Grammar 800+ user handbook"}','821295a7710a55bace114edf0dbb80e1a58afd8f',1),
('hbk-grammar-11','GRAMMAR_LESSON','Conditionals','Câu điều kiện: nhận dạng loại 0/1/2/3 theo thời gian và mức độ thực tế.','Câu điều kiện: nhận dạng loại 0/1/2/3 theo thời gian và mức độ thực tế.','If the order arrives today, we will ship it tomorrow.','','Conditionals','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-11","grammar_category":"CONDITIONALS","tags":"toeic,800-plus,grammar,conditionals","audio_text":"If the order arrives today, we will ship it tomorrow.","source":"TOEIC Grammar 800+ user handbook"}','2c5b9b52eada9a9d09f4c12c38800053ad750d8d',1),
('hbk-grammar-12','GRAMMAR_LESSON','Modal Verbs','Modal verbs: modal + V nguyên thể; chú ý sắc thái khả năng, nghĩa vụ, lời khuyên và suy đoán.','Modal verbs: modal + V nguyên thể; chú ý sắc thái khả năng, nghĩa vụ, lời khuyên và suy đoán.','Employees must wear identification badges.','','Modal Verbs','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-12","grammar_category":"MODAL_VERBS","tags":"toeic,800-plus,grammar,modal_verbs","audio_text":"Employees must wear identification badges.","source":"TOEIC Grammar 800+ user handbook"}','43405dd3f644148eb2ffc5c6fa9d62f7758d2dbd',1),
('hbk-grammar-13','GRAMMAR_LESSON','Gerund vs Infinitive','Gerund/Infinitive: học theo động từ/cấu trúc cố định; giới từ + V-ing, nhiều động từ theo sau bởi to V.','Gerund/Infinitive: học theo động từ/cấu trúc cố định; giới từ + V-ing, nhiều động từ theo sau bởi to V.','We look forward to hearing from you.','','Gerund vs Infinitive','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-13","grammar_category":"GERUNDS_INFINITIVES","tags":"toeic,800-plus,grammar,gerunds_infinitives","audio_text":"We look forward to hearing from you.","source":"TOEIC Grammar 800+ user handbook"}','878e1e19e6b2cfe5f1191f02cc2cb5aaf21f7167',1),
('hbk-grammar-14','GRAMMAR_LESSON','Subjunctive','Câu giả định: sau suggest/recommend/request/require + that + S + V nguyên thể.','Câu giả định: sau suggest/recommend/request/require + that + S + V nguyên thể.','The manager requested that the report be submitted by noon.','','Subjunctive','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-14","grammar_category":"SUBJUNCTIVE","tags":"toeic,800-plus,grammar,subjunctive","audio_text":"The manager requested that the report be submitted by noon.","source":"TOEIC Grammar 800+ user handbook"}','308747cda020dd8340cfc2587062657f4893b488',1),
('hbk-grammar-15','GRAMMAR_LESSON','Parallel Structure','Song song: các thành phần nối bằng and/or/but hoặc cặp liên từ phải cùng dạng ngữ pháp.','Song song: các thành phần nối bằng and/or/but hoặc cặp liên từ phải cùng dạng ngữ pháp.','The role requires planning, organizing, and reporting.','','Parallel Structure','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-15","grammar_category":"PARALLEL_STRUCTURE","tags":"toeic,800-plus,grammar,parallel_structure","audio_text":"The role requires planning, organizing, and reporting.","source":"TOEIC Grammar 800+ user handbook"}','cf33af6eadf4c0f557afcf4d62eedcbb3c91d374',1),
('hbk-grammar-16','GRAMMAR_LESSON','Confusing Words','Từ dễ nhầm: phân biệt already/yet, many/much, few/a few, most/almost, economic/economical và các connector gần nghĩa.','Từ dễ nhầm: phân biệt already/yet, many/much, few/a few, most/almost, economic/economical và các connector gần nghĩa.','The report has already been submitted.','','Confusing Words','B1-B2','{"handbook_code":"grammar-800","handbook_section":"grammar-16","grammar_category":"CONFUSING_WORDS","tags":"toeic,800-plus,grammar,confusing_words","audio_text":"The report has already been submitted.","source":"TOEIC Grammar 800+ user handbook"}','d26def2ccc9d6ae0b11f9c2cf7d96968ccac242a',1),
('hbk-verb-accommodate','VERB_MASTER','accommodate','đáp ứng; bố trí','V1: accommodate · -ed: /ɪd/','We accommodated all requests.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"accommodate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We accommodated all requests.","source":"TOEIC 800+ Verb Master user handbook"}','6a2d87dd627bd292aa88826d98a64d543cc339f7',1),
('hbk-verb-acknowledge','VERB_MASTER','acknowledge','xác nhận; thừa nhận','V1: acknowledge · -ed: /d/','We acknowledged the receipt.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"acknowledge","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We acknowledged the receipt.","source":"TOEIC 800+ Verb Master user handbook"}','b5816a634145219bafd8c173172cc6366001f6fb',1),
('hbk-verb-acquire','VERB_MASTER','acquire','mua lại, thu mua','V1: acquire · -ed: /d/','The firm acquired a competitor.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"acquire","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The firm acquired a competitor.","source":"TOEIC 800+ Verb Master user handbook"}','7c85be3bf5066ae88fff61d3b458295b30a83d5a',1),
('hbk-verb-address','VERB_MASTER','address','giải quyết; đề cập','V1: address · -ed: /t/','Concerns were addressed.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"address","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Concerns were addressed.","source":"TOEIC 800+ Verb Master user handbook"}','7a4d15edc9ba4ebfb0919b0e95e83899e49cadf0',1),
('hbk-verb-administer','VERB_MASTER','administer','quản lý','V1: administer · -ed: /d/','She administers the department.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"administer","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She administers the department.","source":"TOEIC 800+ Verb Master user handbook"}','f8f99bef3c14cf595a970bf33dfccc3e286cf73f',1),
('hbk-verb-advertise','VERB_MASTER','advertise','quảng cáo','V1: advertise · -ed: /d/','We advertised the position.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"advertise","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We advertised the position.","source":"TOEIC 800+ Verb Master user handbook"}','d3d33c8de3f1b503ab00c7e29fe82660cfa98ab7',1),
('hbk-verb-advise','VERB_MASTER','advise','khuyên','V1: advise · -ed: /d/','Employees are advised to…','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"advise","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Employees are advised to…","source":"TOEIC 800+ Verb Master user handbook"}','1c3a6cc245c5b4e9ae76f0659c3ad0d7cf64dc30',1),
('hbk-verb-afford','VERB_MASTER','afford','có đủ khả năng','V1: afford · -ed: /ɪd/','We can''t afford the upgrade.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"afford","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We can''t afford the upgrade.","source":"TOEIC 800+ Verb Master user handbook"}','c99aa87ec8693068a71c4978904d41766cffdad6',1),
('hbk-verb-allocate','VERB_MASTER','allocate','phân bổ','V1: allocate · -ed: /ɪd/','Funds were allocated to R&D.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"allocate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Funds were allocated to R&D.","source":"TOEIC 800+ Verb Master user handbook"}','3680316ed90cdb064727c4a11be51a762c8d2072',1),
('hbk-verb-announce','VERB_MASTER','announce','thông báo','V1: announce · -ed: /t/','The CEO announced a merger.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"announce","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The CEO announced a merger.","source":"TOEIC 800+ Verb Master user handbook"}','541b539ac70685ddb79e85722e9d375fc3c9e63e',1),
('hbk-verb-anticipate','VERB_MASTER','anticipate','dự đoán','V1: anticipate · -ed: /ɪd/','We anticipated high demand.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"anticipate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We anticipated high demand.","source":"TOEIC 800+ Verb Master user handbook"}','c595a39a6f7debd55ae8866cdbd97a4fc9e06b5f',1),
('hbk-verb-apologize','VERB_MASTER','apologize','xin lỗi','V1: apologize · -ed: /d/','We apologized for the delay.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"apologize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We apologized for the delay.","source":"TOEIC 800+ Verb Master user handbook"}','056f39a1d39a453c2f651ba9f02a7c4182292fe2',1),
('hbk-verb-apply','VERB_MASTER','apply','nộp đơn; áp dụng','V1: apply · -ed: /d/','She applied for the position.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"apply","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"apply for a position; apply for a job; apply for a loan; apply for membership","tags":"toeic,800-plus,verb,verb-master","audio_text":"She applied for the position.","source":"TOEIC 800+ Verb Master user handbook"}','de721a0dca8250e938722a20e9e23a93261f8527',1),
('hbk-verb-appoint','VERB_MASTER','appoint','bổ nhiệm','V1: appoint · -ed: /ɪd/','He was appointed as director.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"appoint","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He was appointed as director.","source":"TOEIC 800+ Verb Master user handbook"}','c38e47cf8c55966a8fe5b13006e90a1f3e5d74ef',1),
('hbk-verb-appreciate','VERB_MASTER','appreciate','đánh giá cao','V1: appreciate · -ed: /ɪd/','Your help is appreciated.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"appreciate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Your help is appreciated.","source":"TOEIC 800+ Verb Master user handbook"}','f72506e7b8dd0c52b6c8835896594c894c621154',1),
('hbk-verb-approve','VERB_MASTER','approve','chấp thuận','V1: approve · -ed: /d/','The board approved the budget.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"approve","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The board approved the budget.","source":"TOEIC 800+ Verb Master user handbook"}','4e8df9b2a7d68905e0ee43f14cf50aeb23accf21',1),
('hbk-verb-arise','VERB_MASTER','arise','phát sinh','V1: arise · V2: arose · V3: arisen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"arise","v2":"arose","v3":"arisen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"arise","source":"TOEIC 800+ Verb Master user handbook"}','95a7ab59f67a2dbf9cc581aee028f3b347ab3ca8',1),
('hbk-verb-assemble','VERB_MASTER','assemble','lắp ráp','V1: assemble · -ed: /d/','Parts were assembled on site.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"assemble","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Parts were assembled on site.","source":"TOEIC 800+ Verb Master user handbook"}','b1a563d48bf9ea6fcf6ca5fd39e55a8d6ff6ed0d',1),
('hbk-verb-assess','VERB_MASTER','assess','đánh giá','V1: assess · -ed: /t/','We assessed the risks.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"assess","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We assessed the risks.","source":"TOEIC 800+ Verb Master user handbook"}','8efa088a9436eed3da025b7987bb06c738ae42de',1),
('hbk-verb-assign','VERB_MASTER','assign','giao (nhiệm vụ)','V1: assign · -ed: /d/','Tasks were assigned to staff.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"assign","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Tasks were assigned to staff.","source":"TOEIC 800+ Verb Master user handbook"}','963ae76437a650b9cc09f0497e7ffb93a1e7a9c1',1),
('hbk-verb-assist','VERB_MASTER','assist','hỗ trợ','V1: assist · -ed: /ɪd/','Staff assisted the customers.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"assist","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Staff assisted the customers.","source":"TOEIC 800+ Verb Master user handbook"}','eb4df17af81fa85795d05dc83d61ed50758ee544',1),
('hbk-verb-attach','VERB_MASTER','attach','đính kèm','V1: attach · -ed: /t/','Please see the attached file.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"attach","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Please see the attached file.","source":"TOEIC 800+ Verb Master user handbook"}','097fbb60c875e6df16f50b5c1d8f8054e3923849',1),
('hbk-verb-attend','VERB_MASTER','attend','tham dự','V1: attend · -ed: /ɪd/','Please attend the seminar.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"attend","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"attend a meeting; attend a conference; attend a seminar; attend a workshop","tags":"toeic,800-plus,verb,verb-master","audio_text":"Please attend the seminar.","source":"TOEIC 800+ Verb Master user handbook"}','95de08a1f42b332131b5b12627084249e06af771',1),
('hbk-verb-authorize','VERB_MASTER','authorize','ủy quyền','V1: authorize · -ed: /d/','Only managers can authorize.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"authorize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Only managers can authorize.","source":"TOEIC 800+ Verb Master user handbook"}','156225890a85719de694a271c29dcdc459f15e0a',1),
('hbk-verb-bear','VERB_MASTER','bear','chịu đựng; mang','V1: bear · V2: bore · V3: borne · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"bear","v2":"bore","v3":"borne","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"bear","source":"TOEIC 800+ Verb Master user handbook"}','1f5383e3b5ee84cdf5c577d42909fde23990a97f',1),
('hbk-verb-beat','VERB_MASTER','beat','đánh bại','V1: beat · V2: beat · V3: beaten · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"beat","v2":"beat","v3":"beaten","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"beat","source":"TOEIC 800+ Verb Master user handbook"}','918fca768545965e739b13539230227b706be73a',1),
('hbk-verb-become','VERB_MASTER','become','trở thành','V1: become · V2: became · V3: become · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"become","v2":"became","v3":"become","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"become","source":"TOEIC 800+ Verb Master user handbook"}','bf2fadbb26a0863b3f9ce21d40579c774168d4b3',1),
('hbk-verb-begin','VERB_MASTER','begin','bắt đầu','V1: begin · V2: began · V3: begun · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"begin","v2":"began","v3":"begun","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"begin","source":"TOEIC 800+ Verb Master user handbook"}','a303833dcec22fdbe991f5a0cff6d43a59456ad4',1),
('hbk-verb-bend','VERB_MASTER','bend','uốn cong','V1: bend · V2: bent · V3: bent · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"bend","v2":"bent","v3":"bent","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"bend","source":"TOEIC 800+ Verb Master user handbook"}','d5aeba8b9f4c0866934493063a0e64d9fdd06009',1),
('hbk-verb-bid','VERB_MASTER','bid','đấu thầu','V1: bid · V2: bid · V3: bid · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"bid","v2":"bid","v3":"bid","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"bid","source":"TOEIC 800+ Verb Master user handbook"}','7bfeab964752a611b4ea7ba88fc3f73f1df936ee',1),
('hbk-verb-bind','VERB_MASTER','bind','ràng buộc','V1: bind · V2: bound · V3: bound · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"bind","v2":"bound","v3":"bound","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"bind","source":"TOEIC 800+ Verb Master user handbook"}','208b697a533e226d5ff264e65810226e535ba423',1),
('hbk-verb-boost','VERB_MASTER','boost','thúc đẩy','V1: boost · -ed: /ɪd/','Sales were boosted by the ad.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"boost","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Sales were boosted by the ad.","source":"TOEIC 800+ Verb Master user handbook"}','b22b1c9e3660f638e7f604f26da8a2df999fd00d',1),
('hbk-verb-break','VERB_MASTER','break','phá vỡ','V1: break · V2: broke · V3: broken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"break","v2":"broke","v3":"broken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"break","source":"TOEIC 800+ Verb Master user handbook"}','ded59d67da613edbac819b28bb98e5bf9dc5f336',1),
('hbk-verb-bring','VERB_MASTER','bring','mang đến','V1: bring · V2: brought · V3: brought · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"bring","v2":"brought","v3":"brought","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"bring","source":"TOEIC 800+ Verb Master user handbook"}','b9f9dde351aa064d99fcfdc44ee66eac9a891a98',1),
('hbk-verb-broadcast','VERB_MASTER','broadcast','phát sóng','V1: broadcast · V2: broadcast · V3: broadcast · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"broadcast","v2":"broadcast","v3":"broadcast","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"broadcast","source":"TOEIC 800+ Verb Master user handbook"}','808259be17c04d72658c84de5e0dc2b2efe7b6bc',1),
('hbk-verb-build','VERB_MASTER','build','xây dựng','V1: build · V2: built · V3: built · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"build","v2":"built","v3":"built","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"build","source":"TOEIC 800+ Verb Master user handbook"}','145da4fd0dcdaebe8248c0c3160e4196132a6e9d',1),
('hbk-verb-buy','VERB_MASTER','buy','mua','V1: buy · V2: bought · V3: bought · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"buy","v2":"bought","v3":"bought","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"buy","source":"TOEIC 800+ Verb Master user handbook"}','29797b4d7a894bbebd418d30abd160d0ad63f46a',1),
('hbk-verb-calculate','VERB_MASTER','calculate','tính toán','V1: calculate · -ed: /ɪd/','Totals were calculated.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"calculate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Totals were calculated.","source":"TOEIC 800+ Verb Master user handbook"}','9c4076a0b477976f7bc0e70e28c2e46255eb9ff7',1),
('hbk-verb-catch','VERB_MASTER','catch','bắt','V1: catch · V2: caught · V3: caught · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"catch","v2":"caught","v3":"caught","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"catch","source":"TOEIC 800+ Verb Master user handbook"}','3bbe22689bffb2b752b67ebe09a42520466d46fd',1),
('hbk-verb-charge','VERB_MASTER','charge','tính phí','V1: charge · -ed: /d/','No fee will be charged.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"charge","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"No fee will be charged.","source":"TOEIC 800+ Verb Master user handbook"}','ffef705afc3f406111d919a877363d931f5e88c8',1),
('hbk-verb-choose','VERB_MASTER','choose','chọn','V1: choose · V2: chose · V3: chosen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"choose","v2":"chose","v3":"chosen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"choose","source":"TOEIC 800+ Verb Master user handbook"}','707e5d38d9a1b3fa53e834d656e5c02a3f9e4ac0',1),
('hbk-verb-clarify','VERB_MASTER','clarify','làm rõ','V1: clarify · -ed: /d/','Could you clarify the policy?','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"clarify","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Could you clarify the policy?","source":"TOEIC 800+ Verb Master user handbook"}','843f062a4866f31baaab3465c342cd2dc43fcced',1),
('hbk-verb-collaborate','VERB_MASTER','collaborate','hợp tác','V1: collaborate · -ed: /ɪd/','Teams collaborated on the project.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"collaborate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Teams collaborated on the project.","source":"TOEIC 800+ Verb Master user handbook"}','a4521f10d2c2263d726bc03befd17b2251888f1c',1),
('hbk-verb-come','VERB_MASTER','come','đến','V1: come · V2: came · V3: come · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"come","v2":"came","v3":"come","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"come","source":"TOEIC 800+ Verb Master user handbook"}','03ff5cdadb6dd9b6fee4063a9606620c2e45e841',1);
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-verb-commend','VERB_MASTER','commend','khen ngợi','V1: commend · -ed: /ɪd/','She was commended for her work.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"commend","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She was commended for her work.","source":"TOEIC 800+ Verb Master user handbook"}','64296b892f919bd889d78aadbf6378f1d1fb64d0',1),
('hbk-verb-commit','VERB_MASTER','commit','cam kết','V1: commit · -ed: /ɪd/','We committed to the deadline.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"commit","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We committed to the deadline.","source":"TOEIC 800+ Verb Master user handbook"}','7f8052d3ae61ba9e6d61d12b3f53e8f5a296c050',1),
('hbk-verb-communicate','VERB_MASTER','communicate','giao tiếp','V1: communicate · -ed: /ɪd/','Changes were communicated.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"communicate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Changes were communicated.","source":"TOEIC 800+ Verb Master user handbook"}','a54d16058bae58ae9fb92c1671abc01760f1c4f9',1),
('hbk-verb-compensate','VERB_MASTER','compensate','bồi thường','V1: compensate · -ed: /ɪd/','Employees were compensated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"compensate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Employees were compensated.","source":"TOEIC 800+ Verb Master user handbook"}','2e1374c8c4abc8a874921b8a774607b27dd41c16',1),
('hbk-verb-compete','VERB_MASTER','compete','cạnh tranh','V1: compete · -ed: /ɪd/','Firms compete for market share.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"compete","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Firms compete for market share.","source":"TOEIC 800+ Verb Master user handbook"}','f2c09ede0c756d0aac5e7e1613d0fdf79be4ef6a',1),
('hbk-verb-comply','VERB_MASTER','comply','tuân thủ','V1: comply · -ed: /d/','You must comply with the policy.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"comply","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"comply with regulations; comply with company policy","tags":"toeic,800-plus,verb,verb-master","audio_text":"You must comply with the policy.","source":"TOEIC 800+ Verb Master user handbook"}','3fb8b98a3bac69f8dd5fa2caea8ff8cb778181f8',1),
('hbk-verb-conduct','VERB_MASTER','conduct','tiến hành','V1: conduct · -ed: /ɪd/','A survey was conducted.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"conduct","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A survey was conducted.","source":"TOEIC 800+ Verb Master user handbook"}','4ecd9548b3273b455b8bcc1f2744f2db282a029e',1),
('hbk-verb-confirm','VERB_MASTER','confirm','xác nhận','V1: confirm · -ed: /d/','Please confirm your attendance.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"confirm","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Please confirm your attendance.","source":"TOEIC 800+ Verb Master user handbook"}','a8a382af3a0acf7bd8f846cc71d9e4d79a82c67c',1),
('hbk-verb-consider','VERB_MASTER','consider','xem xét','V1: consider · -ed: /d/','All options were considered.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"consider","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"All options were considered.","source":"TOEIC 800+ Verb Master user handbook"}','7fc1311d78e1e9dbbabc011d3bf4c88986d7e9bd',1),
('hbk-verb-consult','VERB_MASTER','consult','tư vấn','V1: consult · -ed: /ɪd/','We consulted an expert.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"consult","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We consulted an expert.","source":"TOEIC 800+ Verb Master user handbook"}','27cac63e2ec3fdbda720fea73f947a4442099aac',1),
('hbk-verb-contribute','VERB_MASTER','contribute','đóng góp','V1: contribute · -ed: /ɪd/','She contributed ideas.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"contribute","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"contribute to a project; contribute to growth","tags":"toeic,800-plus,verb,verb-master","audio_text":"She contributed ideas.","source":"TOEIC 800+ Verb Master user handbook"}','9f1940fbaceb28050acc35fcee73223a5649dd0e',1),
('hbk-verb-coordinate','VERB_MASTER','coordinate','phối hợp','V1: coordinate · -ed: /ɪd/','He coordinated the event.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"coordinate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He coordinated the event.","source":"TOEIC 800+ Verb Master user handbook"}','81998472791f024c455454c9c759cefc982b9f75',1),
('hbk-verb-correspond','VERB_MASTER','correspond','liên lạc; tương ứng','V1: correspond · -ed: /ɪd/','They corresponded via email.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"correspond","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"They corresponded via email.","source":"TOEIC 800+ Verb Master user handbook"}','39683764ebd372d1d0986485400850596cf296c2',1),
('hbk-verb-cost','VERB_MASTER','cost','tốn','V1: cost · V2: cost · V3: cost · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"cost","v2":"cost","v3":"cost","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"cost","source":"TOEIC 800+ Verb Master user handbook"}','664af830d6dfa07927ea4652412501d97a4edbe5',1),
('hbk-verb-cut','VERB_MASTER','cut','cắt','V1: cut · V2: cut · V3: cut · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"cut","v2":"cut","v3":"cut","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"cut","source":"TOEIC 800+ Verb Master user handbook"}','03b1312a0b78e471cf5992da60556be74ca4c666',1),
('hbk-verb-deal','VERB_MASTER','deal','giải quyết','V1: deal · V2: dealt · V3: dealt · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"deal","v2":"dealt","v3":"dealt","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"deal","source":"TOEIC 800+ Verb Master user handbook"}','e488177112c142ec8359c932dae6fbb89682a9e5',1),
('hbk-verb-decline','VERB_MASTER','decline','từ chối; giảm','V1: decline · -ed: /d/','She declined the invitation.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"decline","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She declined the invitation.","source":"TOEIC 800+ Verb Master user handbook"}','2b29c24de176d1301a88292916904f6d6b4e8a4d',1),
('hbk-verb-delegate','VERB_MASTER','delegate','giao quyền','V1: delegate · -ed: /ɪd/','Managers should delegate tasks.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"delegate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Managers should delegate tasks.","source":"TOEIC 800+ Verb Master user handbook"}','33caed4d33bb28df5639ad63175fb72982be922b',1),
('hbk-verb-deliver','VERB_MASTER','deliver','giao hàng','V1: deliver · -ed: /d/','Goods were delivered on time.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"deliver","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Goods were delivered on time.","source":"TOEIC 800+ Verb Master user handbook"}','308e44a792ee9ed7481e97007a6143d14a7eac50',1),
('hbk-verb-demolish','VERB_MASTER','demolish','phá dỡ','V1: demolish · -ed: /t/','The old building was demolished.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"demolish","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The old building was demolished.","source":"TOEIC 800+ Verb Master user handbook"}','1c3469ffb54d3de9f0c2e0845483386c881d8734',1),
('hbk-verb-demonstrate','VERB_MASTER','demonstrate','chứng minh; trình diễn','V1: demonstrate · -ed: /ɪd/','She demonstrated the product.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"demonstrate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She demonstrated the product.","source":"TOEIC 800+ Verb Master user handbook"}','2fa06d5fa7ddbb3ff5a5eb949c6a3796803eeb7c',1),
('hbk-verb-deposit','VERB_MASTER','deposit','nạp tiền; đặt cọc','V1: deposit · -ed: /ɪd/','A deposit was required.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"deposit","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A deposit was required.","source":"TOEIC 800+ Verb Master user handbook"}','b8edf042a78289519c3864fff3c2e11ac7ae0a2d',1),
('hbk-verb-designate','VERB_MASTER','designate','chỉ định','V1: designate · -ed: /ɪd/','A meeting room was designated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"designate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A meeting room was designated.","source":"TOEIC 800+ Verb Master user handbook"}','de0958b342ba8b0e6508fab081b2270d0b123e2f',1),
('hbk-verb-detect','VERB_MASTER','detect','phát hiện','V1: detect · -ed: /ɪd/','A defect was detected.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"detect","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A defect was detected.","source":"TOEIC 800+ Verb Master user handbook"}','a5d3fd4472103d6d132f3da2c6aa39c582c078b9',1),
('hbk-verb-determine','VERB_MASTER','determine','xác định','V1: determine · -ed: /d/','We determined the cause.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"determine","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We determined the cause.","source":"TOEIC 800+ Verb Master user handbook"}','5e682a6197109bd5ab0be607164292107f32a90c',1),
('hbk-verb-develop','VERB_MASTER','develop','phát triển','V1: develop · -ed: /t/','They developed a new system.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"develop","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"They developed a new system.","source":"TOEIC 800+ Verb Master user handbook"}','f6f4fdfcede62650acbcb9513f291dee94ca4663',1),
('hbk-verb-discard','VERB_MASTER','discard','loại bỏ','V1: discard · -ed: /ɪd/','Damaged items were discarded.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"discard","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Damaged items were discarded.","source":"TOEIC 800+ Verb Master user handbook"}','5e411143904384dddc2a673b360fe764bc641eaf',1),
('hbk-verb-disclose','VERB_MASTER','disclose','tiết lộ','V1: disclose · -ed: /d/','Details were not disclosed.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"disclose","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Details were not disclosed.","source":"TOEIC 800+ Verb Master user handbook"}','27c4f7bca00f977e3f42db7e4414d890d023986d',1),
('hbk-verb-discount','VERB_MASTER','discount','giảm giá','V1: discount · -ed: /ɪd/','Items were discounted 20%.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"discount","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Items were discounted 20%.","source":"TOEIC 800+ Verb Master user handbook"}','9e29a0fc2bbd71720dbc91fe23a641ccc2844dfe',1),
('hbk-verb-dismiss','VERB_MASTER','dismiss','sa thải; bác bỏ','V1: dismiss · -ed: /t/','The complaint was dismissed.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"dismiss","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The complaint was dismissed.","source":"TOEIC 800+ Verb Master user handbook"}','dc652b81d21f6692165f9dc49c9b36fda5aeed4b',1),
('hbk-verb-dispatch','VERB_MASTER','dispatch','gửi đi','V1: dispatch · -ed: /t/','Orders were dispatched today.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"dispatch","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Orders were dispatched today.","source":"TOEIC 800+ Verb Master user handbook"}','d4b674b8071db481f90cc7a9c8ab44a80e457669',1),
('hbk-verb-display','VERB_MASTER','display','trưng bày','V1: display · -ed: /d/','Products are displayed.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"display","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Products are displayed.","source":"TOEIC 800+ Verb Master user handbook"}','5a0844ff9f4608ea6310ff5e75308e82cd7ebeb5',1),
('hbk-verb-dispose','VERB_MASTER','dispose','vứt bỏ','V1: dispose · -ed: /d/','Waste must be disposed of.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"dispose","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Waste must be disposed of.","source":"TOEIC 800+ Verb Master user handbook"}','2f7d8d4e62cb8af59956ea0854ad099b9848e3e9',1),
('hbk-verb-distribute','VERB_MASTER','distribute','phân phối','V1: distribute · -ed: /ɪd/','Products are distributed globally.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"distribute","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Products are distributed globally.","source":"TOEIC 800+ Verb Master user handbook"}','e531de8f576b78dae5b56d4f88446ebdf8ebb3f3',1),
('hbk-verb-do','VERB_MASTER','do','làm','V1: do · V2: did · V3: done · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"do","v2":"did","v3":"done","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"do","source":"TOEIC 800+ Verb Master user handbook"}','8164311d29dd3f47611cc40920af6cd24da4b539',1),
('hbk-verb-dominate','VERB_MASTER','dominate','thống trị','V1: dominate · -ed: /ɪd/','The brand dominates the market.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"dominate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The brand dominates the market.","source":"TOEIC 800+ Verb Master user handbook"}','67496c6c50283a0c49a333cdedc3692e17109cbc',1),
('hbk-verb-draw','VERB_MASTER','draw','vẽ; rút','V1: draw · V2: drew · V3: drawn · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"draw","v2":"drew","v3":"drawn","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"draw","source":"TOEIC 800+ Verb Master user handbook"}','d9dbafc95e72a1fe1d1222444ec85e2803f4f12c',1),
('hbk-verb-drink','VERB_MASTER','drink','uống','V1: drink · V2: drank · V3: drunk · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"drink","v2":"drank","v3":"drunk","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"drink","source":"TOEIC 800+ Verb Master user handbook"}','452584e28d7cda16c9dc01a7bce02650d6a47662',1),
('hbk-verb-drive','VERB_MASTER','drive','lái xe','V1: drive · V2: drove · V3: driven · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"drive","v2":"drove","v3":"driven","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"drive","source":"TOEIC 800+ Verb Master user handbook"}','a28e3c99dbd6f90a6444167692d415f6cc6f3d18',1),
('hbk-verb-eat','VERB_MASTER','eat','ăn','V1: eat · V2: ate · V3: eaten · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"eat","v2":"ate","v3":"eaten","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"eat","source":"TOEIC 800+ Verb Master user handbook"}','1fcb78b9bd7389ba6ca68623bc9afbef3083b67a',1),
('hbk-verb-eliminate','VERB_MASTER','eliminate','loại bỏ','V1: eliminate · -ed: /ɪd/','Waste was eliminated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"eliminate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Waste was eliminated.","source":"TOEIC 800+ Verb Master user handbook"}','cb4035022bfb0de496506102ba36d06ba12414b4',1),
('hbk-verb-emphasize','VERB_MASTER','emphasize','nhấn mạnh','V1: emphasize · -ed: /d/','He emphasized teamwork.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"emphasize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He emphasized teamwork.","source":"TOEIC 800+ Verb Master user handbook"}','70c79d51c4a4a21c32abe287f08fb1a25c8c22df',1),
('hbk-verb-encounter','VERB_MASTER','encounter','gặp phải','V1: encounter · -ed: /d/','We encountered difficulties.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"encounter","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We encountered difficulties.","source":"TOEIC 800+ Verb Master user handbook"}','9577cd76b9b9850c56ee3b0ebcccc728c91af926',1),
('hbk-verb-encourage','VERB_MASTER','encourage','khuyến khích','V1: encourage · -ed: /d/','Staff are encouraged to apply.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"encourage","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Staff are encouraged to apply.","source":"TOEIC 800+ Verb Master user handbook"}','f07182165b30c9473f880b228b290fbc52107582',1),
('hbk-verb-enforce','VERB_MASTER','enforce','thực thi','V1: enforce · -ed: /t/','Rules are strictly enforced.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"enforce","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Rules are strictly enforced.","source":"TOEIC 800+ Verb Master user handbook"}','47434a5286e162b09ce3f5baf046701d20294bea',1),
('hbk-verb-engage','VERB_MASTER','engage','tham gia; thuê','V1: engage · -ed: /d/','We engaged a consultant.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"engage","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We engaged a consultant.","source":"TOEIC 800+ Verb Master user handbook"}','f12a07d4a1cb458caaababd602ca4579bd3801a4',1),
('hbk-verb-enhance','VERB_MASTER','enhance','nâng cao','V1: enhance · -ed: /t/','We enhanced the user experience.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"enhance","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We enhanced the user experience.","source":"TOEIC 800+ Verb Master user handbook"}','769497890b6db58249311e3f050017032e2959fb',1),
('hbk-verb-enroll','VERB_MASTER','enroll','ghi danh','V1: enroll · -ed: /d/','Employees enrolled in training.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"enroll","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Employees enrolled in training.","source":"TOEIC 800+ Verb Master user handbook"}','bdebac90d1bd83dbf9851e2ed4f8e3aae9bce3d2',1),
('hbk-verb-ensure','VERB_MASTER','ensure','đảm bảo','V1: ensure · -ed: /d/','Please ensure quality.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"ensure","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Please ensure quality.","source":"TOEIC 800+ Verb Master user handbook"}','0517fceb7f88be75f3b24eb9bc6c9c4f71ab8cf8',1),
('hbk-verb-equip','VERB_MASTER','equip','trang bị','V1: equip · -ed: /t/','Rooms are equipped with WiFi.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"equip","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Rooms are equipped with WiFi.","source":"TOEIC 800+ Verb Master user handbook"}','4755f3030f73fba1379d461e2657f77291e1e8f2',1),
('hbk-verb-establish','VERB_MASTER','establish','thành lập','V1: establish · -ed: /t/','The firm was established in 1990.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"establish","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The firm was established in 1990.","source":"TOEIC 800+ Verb Master user handbook"}','92ea45ef5a8fdca5c2bc341d2c191dfe7c4915d4',1),
('hbk-verb-estimate','VERB_MASTER','estimate','ước tính','V1: estimate · -ed: /ɪd/','Costs were estimated at $5M.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"estimate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Costs were estimated at $5M.","source":"TOEIC 800+ Verb Master user handbook"}','f8ddda47e5e2522b59bb64aa1c4c876666a06974',1),
('hbk-verb-evaluate','VERB_MASTER','evaluate','đánh giá','V1: evaluate · -ed: /ɪd/','Performance is evaluated annually.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"evaluate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Performance is evaluated annually.","source":"TOEIC 800+ Verb Master user handbook"}','caae1267e89f3d3e06a3f1b2fba6286ce99c7735',1),
('hbk-verb-exceed','VERB_MASTER','exceed','vượt quá','V1: exceed · -ed: /ɪd/','Sales exceeded expectations.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"exceed","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Sales exceeded expectations.","source":"TOEIC 800+ Verb Master user handbook"}','ad1dccac148ca97e4da897f1fa59678d5920d9a7',1),
('hbk-verb-exchange','VERB_MASTER','exchange','đổi trả','V1: exchange · -ed: /d/','Goods may be exchanged.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"exchange","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Goods may be exchanged.","source":"TOEIC 800+ Verb Master user handbook"}','3125f2bcbfa67da6b5134e41728bb5de75cc72de',1),
('hbk-verb-execute','VERB_MASTER','execute','thực hiện','V1: execute · -ed: /ɪd/','The plan was executed well.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"execute","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The plan was executed well.","source":"TOEIC 800+ Verb Master user handbook"}','18346b3c58b6d4b0947c248949df33da28000553',1),
('hbk-verb-expand','VERB_MASTER','expand','mở rộng','V1: expand · -ed: /ɪd/','We expanded into Asia.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"expand","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We expanded into Asia.","source":"TOEIC 800+ Verb Master user handbook"}','68a2823e1effced469d4623679dffbf9951238a0',1),
('hbk-verb-facilitate','VERB_MASTER','facilitate','tạo điều kiện','V1: facilitate · -ed: /ɪd/','Technology facilitates work.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"facilitate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Technology facilitates work.","source":"TOEIC 800+ Verb Master user handbook"}','fd19888b6b34908119e5076d201073fee1d116f2',1),
('hbk-verb-fall','VERB_MASTER','fall','rơi; giảm','V1: fall · V2: fell · V3: fallen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"fall","v2":"fell","v3":"fallen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"fall","source":"TOEIC 800+ Verb Master user handbook"}','9542cf6bad9fb9f65ef252a0036708d407d9295f',1),
('hbk-verb-feed','VERB_MASTER','feed','cung cấp','V1: feed · V2: fed · V3: fed · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"feed","v2":"fed","v3":"fed","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"feed","source":"TOEIC 800+ Verb Master user handbook"}','e067e2e67158945f23fba607a47c464a79758f4e',1);
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-verb-feel','VERB_MASTER','feel','cảm thấy','V1: feel · V2: felt · V3: felt · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"feel","v2":"felt","v3":"felt","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"feel","source":"TOEIC 800+ Verb Master user handbook"}','d46b6159e0300fb15ebc105b6bab87b98973988e',1),
('hbk-verb-fight','VERB_MASTER','fight','chiến đấu','V1: fight · V2: fought · V3: fought · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"fight","v2":"fought","v3":"fought","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"fight","source":"TOEIC 800+ Verb Master user handbook"}','8f32e39078dbab27530c1f6dbaeefa45e8d80eba',1),
('hbk-verb-finance','VERB_MASTER','finance','tài trợ','V1: finance · -ed: /t/','The project was financed.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"finance","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The project was financed.","source":"TOEIC 800+ Verb Master user handbook"}','22d5fe12e7bcb91ba79f33e1e16dd6d2ae6d03d6',1),
('hbk-verb-find','VERB_MASTER','find','tìm thấy','V1: find · V2: found · V3: found · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"find","v2":"found","v3":"found","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"find","source":"TOEIC 800+ Verb Master user handbook"}','14239f7c1e8e49619e7dd5beb3569759da7553b1',1),
('hbk-verb-fly','VERB_MASTER','fly','bay','V1: fly · V2: flew · V3: flown · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"fly","v2":"flew","v3":"flown","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"fly","source":"TOEIC 800+ Verb Master user handbook"}','80a806b39f41721fa48119eee1bc6edbc88fc249',1),
('hbk-verb-forbid','VERB_MASTER','forbid','cấm','V1: forbid · V2: forbade · V3: forbidden · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"forbid","v2":"forbade","v3":"forbidden","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"forbid","source":"TOEIC 800+ Verb Master user handbook"}','f945e3c672387fba800cc93ce9f77baa7244727f',1),
('hbk-verb-forecast','VERB_MASTER','forecast','dự báo','V1: forecast · V2: forecast · V3: forecast · -ed: irregular','Revenue was forecast to rise.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"forecast","v2":"forecast","v3":"forecast","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Revenue was forecast to rise.","source":"TOEIC 800+ Verb Master user handbook"}','744966b94aa33ffd01b629fda3f7c817c0551896',1),
('hbk-verb-forget','VERB_MASTER','forget','quên','V1: forget · V2: forgot · V3: forgotten · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"forget","v2":"forgot","v3":"forgotten","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"forget","source":"TOEIC 800+ Verb Master user handbook"}','15974e829d778090f132e404de61e20b880683f2',1),
('hbk-verb-forgive','VERB_MASTER','forgive','tha thứ','V1: forgive · V2: forgave · V3: forgiven · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"forgive","v2":"forgave","v3":"forgiven","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"forgive","source":"TOEIC 800+ Verb Master user handbook"}','e5b58b723629a383c947a01ad573ae67d8ba4200',1),
('hbk-verb-forward','VERB_MASTER','forward','chuyển tiếp','V1: forward · -ed: /ɪd/','The email was forwarded.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"forward","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The email was forwarded.","source":"TOEIC 800+ Verb Master user handbook"}','891b8005436e7f989a9f6dc88aa8630be3fa7274',1),
('hbk-verb-freeze','VERB_MASTER','freeze','đóng băng','V1: freeze · V2: froze · V3: frozen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"freeze","v2":"froze","v3":"frozen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"freeze","source":"TOEIC 800+ Verb Master user handbook"}','7d522a85be470e23cce558467cfb31ecf2a15473',1),
('hbk-verb-generate','VERB_MASTER','generate','tạo ra','V1: generate · -ed: /ɪd/','The campaign generated leads.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"generate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The campaign generated leads.","source":"TOEIC 800+ Verb Master user handbook"}','372b1ea644d206c18d2beec86d3f3b4600432691',1),
('hbk-verb-get','VERB_MASTER','get','nhận; đạt','V1: get · V2: got · V3: gotten/got · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"get","v2":"got","v3":"gotten/got","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"get","source":"TOEIC 800+ Verb Master user handbook"}','517798365f2caf5064b9e3f356e80adf3b05b6d8',1),
('hbk-verb-give','VERB_MASTER','give','cho','V1: give · V2: gave · V3: given · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"give","v2":"gave","v3":"given","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"give","source":"TOEIC 800+ Verb Master user handbook"}','062e002655da8c5666b7e0cc1a779d0e25fa235a',1),
('hbk-verb-go','VERB_MASTER','go','đi','V1: go · V2: went · V3: gone · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"go","v2":"went","v3":"gone","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"go","source":"TOEIC 800+ Verb Master user handbook"}','40fd238341f7066107ce6f3f82b206fbd1dc8be8',1),
('hbk-verb-grow','VERB_MASTER','grow','phát triển','V1: grow · V2: grew · V3: grown · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"grow","v2":"grew","v3":"grown","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"grow","source":"TOEIC 800+ Verb Master user handbook"}','ec46a1c130c83bfa68089845f78410f01c1ca174',1),
('hbk-verb-guarantee','VERB_MASTER','guarantee','bảo đảm','V1: guarantee · -ed: /d/','Satisfaction is guaranteed.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"guarantee","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Satisfaction is guaranteed.","source":"TOEIC 800+ Verb Master user handbook"}','a4f32fb1cd379465f2b96dd3a54f89d78ddd1df1',1),
('hbk-verb-have','VERB_MASTER','have','có','V1: have · V2: had · V3: had · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"have","v2":"had","v3":"had","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"have","source":"TOEIC 800+ Verb Master user handbook"}','b8f71e9b978f362a66884fce00f1fac7bd722ca7',1),
('hbk-verb-hear','VERB_MASTER','hear','nghe','V1: hear · V2: heard · V3: heard · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"hear","v2":"heard","v3":"heard","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"hear","source":"TOEIC 800+ Verb Master user handbook"}','714e6eec81fec26dfc6944104618400ba67c9e00',1),
('hbk-verb-hide','VERB_MASTER','hide','giấu','V1: hide · V2: hid · V3: hidden · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"hide","v2":"hid","v3":"hidden","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"hide","source":"TOEIC 800+ Verb Master user handbook"}','9df1e090eb917dae4b6af02c7de3f26252ce0e1f',1),
('hbk-verb-hit','VERB_MASTER','hit','đạt; đánh','V1: hit · V2: hit · V3: hit · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"hit","v2":"hit","v3":"hit","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"hit","source":"TOEIC 800+ Verb Master user handbook"}','7acd556499eeede1526796fae762e2ea855ca933',1),
('hbk-verb-hold','VERB_MASTER','hold','tổ chức; giữ','V1: hold · V2: held · V3: held · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"hold","v2":"held","v3":"held","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"hold","source":"TOEIC 800+ Verb Master user handbook"}','a601930481357c99614c6da9f674fa8fdf4a274e',1),
('hbk-verb-hurt','VERB_MASTER','hurt','tổn thương','V1: hurt · V2: hurt · V3: hurt · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"hurt","v2":"hurt","v3":"hurt","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"hurt","source":"TOEIC 800+ Verb Master user handbook"}','6a41f6fcf2bf860fd57563effba9329dc55e7c7f',1),
('hbk-verb-implement','VERB_MASTER','implement','triển khai','V1: implement · -ed: /ɪd/','The policy was implemented.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"implement","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The policy was implemented.","source":"TOEIC 800+ Verb Master user handbook"}','a0163738ed9ef959a26ca159232385cbbf9235c4',1),
('hbk-verb-impose','VERB_MASTER','impose','áp đặt','V1: impose · -ed: /d/','New tariffs were imposed.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"impose","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"New tariffs were imposed.","source":"TOEIC 800+ Verb Master user handbook"}','986b1aeb784de3fcdad56508d63c923a40f98394',1),
('hbk-verb-indicate','VERB_MASTER','indicate','chỉ ra','V1: indicate · -ed: /ɪd/','Data indicates growth.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"indicate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Data indicates growth.","source":"TOEIC 800+ Verb Master user handbook"}','3f2cfb04f46bced36e505eb5a25b659c00b6b45e',1),
('hbk-verb-initiate','VERB_MASTER','initiate','khởi xướng','V1: initiate · -ed: /ɪd/','She initiated the project.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"initiate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She initiated the project.","source":"TOEIC 800+ Verb Master user handbook"}','4f603a13b9f7c27dc00d5197578afbafca653cdb',1),
('hbk-verb-inquire','VERB_MASTER','inquire','hỏi thăm','V1: inquire · -ed: /d/','She inquired about the service.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"inquire","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She inquired about the service.","source":"TOEIC 800+ Verb Master user handbook"}','4400492d7ab3aefa8f9e0d46ccbcdf3b25bb51a6',1),
('hbk-verb-inspect','VERB_MASTER','inspect','kiểm tra','V1: inspect · -ed: /ɪd/','The facility was inspected.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"inspect","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The facility was inspected.","source":"TOEIC 800+ Verb Master user handbook"}','d1a2ac77593ac1b207c1ebb07b39772aa0ec30b1',1),
('hbk-verb-install','VERB_MASTER','install','cài đặt; lắp đặt','V1: install · -ed: /d/','Software was installed.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"install","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Software was installed.","source":"TOEIC 800+ Verb Master user handbook"}','240b07eda8acc0086fe0ef58bca8c1887d07f6a6',1),
('hbk-verb-instruct','VERB_MASTER','instruct','hướng dẫn','V1: instruct · -ed: /ɪd/','Staff were instructed to…','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"instruct","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Staff were instructed to…","source":"TOEIC 800+ Verb Master user handbook"}','f2b0499d6588d9473adc9229730b48770be18c76',1),
('hbk-verb-interview','VERB_MASTER','interview','phỏng vấn','V1: interview · -ed: /d/','Candidates were interviewed.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"interview","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Candidates were interviewed.","source":"TOEIC 800+ Verb Master user handbook"}','d6e49ee4ea4a50f646b744b33e43fd3b661f3872',1),
('hbk-verb-invest','VERB_MASTER','invest','đầu tư','V1: invest · -ed: /ɪd/','They invested in technology.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"invest","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"They invested in technology.","source":"TOEIC 800+ Verb Master user handbook"}','acaebefab3560fabe01e46007cef89650a89af67',1),
('hbk-verb-invoice','VERB_MASTER','invoice','lập hóa đơn','V1: invoice · -ed: /t/','Clients will be invoiced.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"invoice","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Clients will be invoiced.","source":"TOEIC 800+ Verb Master user handbook"}','6ce2a855257273870846dad55810b6f53e99f2ba',1),
('hbk-verb-keep','VERB_MASTER','keep','giữ','V1: keep · V2: kept · V3: kept · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"keep","v2":"kept","v3":"kept","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"keep","source":"TOEIC 800+ Verb Master user handbook"}','d4244c664a974415d4e6c883d94a0cc5993a54dc',1),
('hbk-verb-know','VERB_MASTER','know','biết','V1: know · V2: knew · V3: known · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"know","v2":"knew","v3":"known","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"know","source":"TOEIC 800+ Verb Master user handbook"}','ca9979ab929268907d1cff2f7659b72e4eec4ed6',1),
('hbk-verb-launch','VERB_MASTER','launch','ra mắt','V1: launch · -ed: /t/','A new product was launched.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"launch","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A new product was launched.","source":"TOEIC 800+ Verb Master user handbook"}','b1729763cd29cf59c0705fecfb8a5a4319770c59',1),
('hbk-verb-lay','VERB_MASTER','lay','đặt; bày ra','V1: lay · V2: laid · V3: laid · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"lay","v2":"laid","v3":"laid","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"lay","source":"TOEIC 800+ Verb Master user handbook"}','f864827e6cc7209b2e9503219c32d201c860149c',1),
('hbk-verb-lead','VERB_MASTER','lead','dẫn dắt','V1: lead · V2: led · V3: led · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"lead","v2":"led","v3":"led","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"lead","source":"TOEIC 800+ Verb Master user handbook"}','8d97119ae5475773e5ee66e6bb1ad12a1bc3fc63',1),
('hbk-verb-leave','VERB_MASTER','leave','rời đi','V1: leave · V2: left · V3: left · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"leave","v2":"left","v3":"left","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"leave","source":"TOEIC 800+ Verb Master user handbook"}','468a36c9a894173d27453a2bf06a035e28ba7dfb',1),
('hbk-verb-lend','VERB_MASTER','lend','cho vay','V1: lend · V2: lent · V3: lent · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"lend","v2":"lent","v3":"lent","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"lend","source":"TOEIC 800+ Verb Master user handbook"}','55e783264d6d57daba5fc025b7f3cb6c87dd1417',1),
('hbk-verb-let','VERB_MASTER','let','cho phép','V1: let · V2: let · V3: let · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"let","v2":"let","v3":"let","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"let","source":"TOEIC 800+ Verb Master user handbook"}','4b7bae6dc9685b88493c28d57fe33214576f54ad',1),
('hbk-verb-lie','VERB_MASTER','lie','nằm','V1: lie · V2: lay · V3: lain · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"lie","v2":"lay","v3":"lain","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"lie","source":"TOEIC 800+ Verb Master user handbook"}','2c3b9c254ef3bd7f8f1c82177cb426bbc4b4a139',1),
('hbk-verb-load','VERB_MASTER','load','chất hàng','V1: load · -ed: /ɪd/','Trucks were loaded.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"load","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Trucks were loaded.","source":"TOEIC 800+ Verb Master user handbook"}','f9808e1fd0e3552c82b085b1ebfde3d199216ab3',1),
('hbk-verb-locate','VERB_MASTER','locate','xác định vị trí','V1: locate · -ed: /ɪd/','The office is located downtown.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"locate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The office is located downtown.","source":"TOEIC 800+ Verb Master user handbook"}','011ca13b1a528507e3de43dfa04a6aabc8d7b2ab',1),
('hbk-verb-lose','VERB_MASTER','lose','mất; thua','V1: lose · V2: lost · V3: lost · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"lose","v2":"lost","v3":"lost","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"lose","source":"TOEIC 800+ Verb Master user handbook"}','5f0fd9c789e5bb96f82ae22cf355d191162a9a80',1),
('hbk-verb-maintain','VERB_MASTER','maintain','duy trì','V1: maintain · -ed: /d/','Equipment is maintained monthly.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"maintain","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Equipment is maintained monthly.","source":"TOEIC 800+ Verb Master user handbook"}','7d827e9f59e8a8ca3ddebc5a59a7624f971fb23d',1),
('hbk-verb-make','VERB_MASTER','make','làm; tạo','V1: make · V2: made · V3: made · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"make","v2":"made","v3":"made","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"make","source":"TOEIC 800+ Verb Master user handbook"}','5a4c05a025354628c861b595870d67a7ffc0864e',1),
('hbk-verb-manufacture','VERB_MASTER','manufacture','sản xuất','V1: manufacture · -ed: /d/','Parts are manufactured locally.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"manufacture","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Parts are manufactured locally.","source":"TOEIC 800+ Verb Master user handbook"}','ded135ea689702ef5de42e6c2626b57d1054fc73',1),
('hbk-verb-maximize','VERB_MASTER','maximize','tối đa hóa','V1: maximize · -ed: /d/','We maximized efficiency.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"maximize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We maximized efficiency.","source":"TOEIC 800+ Verb Master user handbook"}','cf37733fd1728dea422d91c8eb77aa1dfc0de02d',1),
('hbk-verb-mean','VERB_MASTER','mean','có nghĩa','V1: mean · V2: meant · V3: meant · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"mean","v2":"meant","v3":"meant","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"mean","source":"TOEIC 800+ Verb Master user handbook"}','89e6410e5a50d6ce3de58a3eb0658c9ce96d76a3',1),
('hbk-verb-meet','VERB_MASTER','meet','gặp','V1: meet · V2: met · V3: met · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"meet","v2":"met","v3":"met","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"meet","source":"TOEIC 800+ Verb Master user handbook"}','a5bb894b31dd1ff228dd975a514b6d07690f89b6',1),
('hbk-verb-mention','VERB_MASTER','mention','đề cập','V1: mention · -ed: /d/','As mentioned earlier…','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"mention","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"As mentioned earlier…","source":"TOEIC 800+ Verb Master user handbook"}','1d13d5e7d1824bc0b34f76449aff48076f1be9f3',1),
('hbk-verb-merge','VERB_MASTER','merge','sáp nhập','V1: merge · -ed: /d/','The two firms merged.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"merge","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The two firms merged.","source":"TOEIC 800+ Verb Master user handbook"}','af3398e6832e0402f413e260f927668a47994514',1),
('hbk-verb-minimize','VERB_MASTER','minimize','tối thiểu hóa','V1: minimize · -ed: /d/','We minimized downtime.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"minimize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We minimized downtime.","source":"TOEIC 800+ Verb Master user handbook"}','28ac9fa6cc168d85628b1b03cee41d544d986b86',1),
('hbk-verb-mistake','VERB_MASTER','mistake','nhầm lẫn','V1: mistake · V2: mistook · V3: mistaken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"mistake","v2":"mistook","v3":"mistaken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"mistake","source":"TOEIC 800+ Verb Master user handbook"}','1f24e70c8e2ef9e484139e87c9e8375b90fa5a1a',1),
('hbk-verb-modify','VERB_MASTER','modify','chỉnh sửa','V1: modify · -ed: /d/','The design was modified.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"modify","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The design was modified.","source":"TOEIC 800+ Verb Master user handbook"}','e0d7b5d0b66e9a57326a05a99e99e8563f9babaf',1),
('hbk-verb-monitor','VERB_MASTER','monitor','theo dõi','V1: monitor · -ed: /d/','Progress is monitored weekly.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"monitor","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Progress is monitored weekly.","source":"TOEIC 800+ Verb Master user handbook"}','2ef9b1ecf42877b33994432b591f069412754c21',1),
('hbk-verb-negotiate','VERB_MASTER','negotiate','đàm phán','V1: negotiate · -ed: /ɪd/','Terms were negotiated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"negotiate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Terms were negotiated.","source":"TOEIC 800+ Verb Master user handbook"}','184f7094166a07c863cab76677c1479bf593fb56',1),
('hbk-verb-notify','VERB_MASTER','notify','thông báo','V1: notify · -ed: /d/','Clients were notified.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"notify","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Clients were notified.","source":"TOEIC 800+ Verb Master user handbook"}','773d0dd49e3519cd64505abf1a1b8e9853d6c48e',1);
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-verb-obtain','VERB_MASTER','obtain','đạt được','V1: obtain · -ed: /d/','A permit was obtained.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"obtain","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A permit was obtained.","source":"TOEIC 800+ Verb Master user handbook"}','e49f00ea6fe4d34c793c88ed9503cc3d394ea034',1),
('hbk-verb-occupy','VERB_MASTER','occupy','chiếm giữ','V1: occupy · -ed: /d/','The building is fully occupied.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"occupy","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The building is fully occupied.","source":"TOEIC 800+ Verb Master user handbook"}','e1bcaf039fffd4fce07d1d94c97ae7663a64aa5f',1),
('hbk-verb-operate','VERB_MASTER','operate','vận hành','V1: operate · -ed: /ɪd/','The plant operates 24/7.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"operate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The plant operates 24/7.","source":"TOEIC 800+ Verb Master user handbook"}','41784d3d9f9b2e0794f24a712aa98fe520e906ec',1),
('hbk-verb-organize','VERB_MASTER','organize','tổ chức','V1: organize · -ed: /d/','She organized the conference.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"organize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She organized the conference.","source":"TOEIC 800+ Verb Master user handbook"}','6f7ad5da2aa761de8a1330d6806ab7114f1f9422',1),
('hbk-verb-outline','VERB_MASTER','outline','phác thảo','V1: outline · -ed: /d/','He outlined the strategy.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"outline","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He outlined the strategy.","source":"TOEIC 800+ Verb Master user handbook"}','2748f805e4c6cb187f4c60eb91d8d0b9156b62ad',1),
('hbk-verb-outsource','VERB_MASTER','outsource','thuê ngoài','V1: outsource · -ed: /t/','IT was outsourced.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"outsource","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"IT was outsourced.","source":"TOEIC 800+ Verb Master user handbook"}','de15c06f57188ac865fab0ee62e2fd0151626516',1),
('hbk-verb-overcome','VERB_MASTER','overcome','vượt qua','V1: overcome · V2: overcame · V3: overcome · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"overcome","v2":"overcame","v3":"overcome","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"overcome","source":"TOEIC 800+ Verb Master user handbook"}','45e30ff975619705b8bc669b8713ec4fdfc925f8',1),
('hbk-verb-overlook','VERB_MASTER','overlook','bỏ sót (QUY TẮC!)','V1: overlook · V2: overlooked · V3: overlooked · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"overlook","v2":"overlooked","v3":"overlooked","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"overlook","source":"TOEIC 800+ Verb Master user handbook"}','80849a8a4091301b2f424a2fd1af0337e2b819b1',1),
('hbk-verb-oversee','VERB_MASTER','oversee','giám sát','V1: oversee · -ed: irreg','She oversees operations.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"oversee","v2":"","v3":"","ed_pronunciation":"irreg","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She oversees operations.","source":"TOEIC 800+ Verb Master user handbook"}','b863fb0a3f0089da9f67e9f70a6db4d4f9021cd9',1),
('hbk-verb-overtake','VERB_MASTER','overtake','vượt qua','V1: overtake · V2: overtook · V3: overtaken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"overtake","v2":"overtook","v3":"overtaken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"overtake","source":"TOEIC 800+ Verb Master user handbook"}','397a46368bd37ae315c0b2db76d8d0bbec44bf40',1),
('hbk-verb-owe','VERB_MASTER','owe','nợ','V1: owe · -ed: /d/','The balance owed is $500.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"owe","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The balance owed is $500.","source":"TOEIC 800+ Verb Master user handbook"}','b8d3c8ae30e1f98fdc8ac23b5a1a152207b15a7c',1),
('hbk-verb-participate','VERB_MASTER','participate','tham gia','V1: participate · -ed: /ɪd/','All staff participated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"participate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"All staff participated.","source":"TOEIC 800+ Verb Master user handbook"}','f0f4b9f9b5b420d5822a13741502ffd0683b0dca',1),
('hbk-verb-pay','VERB_MASTER','pay','trả tiền','V1: pay · V2: paid · V3: paid · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"pay","v2":"paid","v3":"paid","ed_pronunciation":"irregular","collocations":"pay a bill; pay a fee; pay an invoice; pay by credit card","tags":"toeic,800-plus,verb,verb-master","audio_text":"pay","source":"TOEIC 800+ Verb Master user handbook"}','65f3808d625bd65fa440c35b6cb47a47c74aaf9f',1),
('hbk-verb-permit','VERB_MASTER','permit','cho phép','V1: permit · -ed: /ɪd/','Parking is not permitted.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"permit","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Parking is not permitted.","source":"TOEIC 800+ Verb Master user handbook"}','886c60a6e77d28945131857499c579e5107412c9',1),
('hbk-verb-persuade','VERB_MASTER','persuade','thuyết phục','V1: persuade · -ed: /ɪd/','He persuaded the client.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"persuade","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He persuaded the client.","source":"TOEIC 800+ Verb Master user handbook"}','056f770cb5f5a3701df0b156bfb7cadddfba6e4c',1),
('hbk-verb-postpone','VERB_MASTER','postpone','hoãn lại','V1: postpone · -ed: /d/','The meeting was postponed.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"postpone","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The meeting was postponed.","source":"TOEIC 800+ Verb Master user handbook"}','4dc248c8d71df1b04236da46e4cd6f04bf5f6b6d',1),
('hbk-verb-praise','VERB_MASTER','praise','khen ngợi','V1: praise · -ed: /d/','The team was praised.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"praise","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The team was praised.","source":"TOEIC 800+ Verb Master user handbook"}','4fcc2907ad128c7c69503c1fc619a3b546ee2186',1),
('hbk-verb-prefer','VERB_MASTER','prefer','thích hơn','V1: prefer · -ed: /d/','Customers preferred online.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"prefer","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Customers preferred online.","source":"TOEIC 800+ Verb Master user handbook"}','e2ab2f8335f58213ed91f7c1c2a383e3548dd117',1),
('hbk-verb-preserve','VERB_MASTER','preserve','bảo tồn','V1: preserve · -ed: /d/','Historical sites are preserved.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"preserve","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Historical sites are preserved.","source":"TOEIC 800+ Verb Master user handbook"}','fd01389f429bb43f39292b5dfa56613e6a98b63f',1),
('hbk-verb-proceed','VERB_MASTER','proceed','tiến hành','V1: proceed · -ed: /ɪd/','Please proceed to gate 5.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"proceed","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Please proceed to gate 5.","source":"TOEIC 800+ Verb Master user handbook"}','98afe3d2e1879e74827281cf74c71fce44108acc',1),
('hbk-verb-process','VERB_MASTER','process','xử lý','V1: process · -ed: /t/','Orders are processed daily.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"process","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Orders are processed daily.","source":"TOEIC 800+ Verb Master user handbook"}','ee5e873ad49505a532bb9547c0b9d1be8d7e34d0',1),
('hbk-verb-prohibit','VERB_MASTER','prohibit','cấm','V1: prohibit · -ed: /ɪd/','Smoking is prohibited.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"prohibit","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Smoking is prohibited.","source":"TOEIC 800+ Verb Master user handbook"}','559b5399d9aaff5c4aa88e8ae970784a3e7a814a',1),
('hbk-verb-promote','VERB_MASTER','promote','thăng chức; quảng bá','V1: promote · -ed: /ɪd/','She was promoted to VP.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"promote","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She was promoted to VP.","source":"TOEIC 800+ Verb Master user handbook"}','1723486b6a384ac7933ada9771f8beb177703652',1),
('hbk-verb-propose','VERB_MASTER','propose','đề xuất','V1: propose · -ed: /d/','He proposed a new plan.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"propose","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He proposed a new plan.","source":"TOEIC 800+ Verb Master user handbook"}','39c2baf4a60854b8b076913b4620cf4d9768436e',1),
('hbk-verb-purchase','VERB_MASTER','purchase','mua','V1: purchase · -ed: /t/','Equipment was purchased.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"purchase","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Equipment was purchased.","source":"TOEIC 800+ Verb Master user handbook"}','8d7a5596d5e614f53cfa7e5075bbc94bd3165055',1),
('hbk-verb-put','VERB_MASTER','put','đặt','V1: put · V2: put · V3: put · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"put","v2":"put","v3":"put","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"put","source":"TOEIC 800+ Verb Master user handbook"}','af7c024c48f4c1eb576f6fa2420286f393a80f41',1),
('hbk-verb-quit','VERB_MASTER','quit','nghỉ việc','V1: quit · V2: quit · V3: quit · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"quit","v2":"quit","v3":"quit","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"quit","source":"TOEIC 800+ Verb Master user handbook"}','50c708b1b27ddd012ead6f44701e4985d585ab76',1),
('hbk-verb-quote','VERB_MASTER','quote','báo giá','V1: quote · -ed: /ɪd/','A price was quoted.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"quote","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A price was quoted.","source":"TOEIC 800+ Verb Master user handbook"}','0d9873e2e347249bbc46ff21da340331b9181855',1),
('hbk-verb-read','VERB_MASTER','read','đọc','V1: read · V2: read /rɛd/ · V3: read /rɛd/ · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"read","v2":"read /rɛd/","v3":"read /rɛd/","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"read","source":"TOEIC 800+ Verb Master user handbook"}','eb83570ab4d6c296a2f35a11ddf3b82e6a557772',1),
('hbk-verb-recommend','VERB_MASTER','recommend','đề xuất','V1: recommend · -ed: /ɪd/','I recommend this vendor.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"recommend","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"I recommend this vendor.","source":"TOEIC 800+ Verb Master user handbook"}','4895766ea302937beb4721584d6d4ce33155ac60',1),
('hbk-verb-reconstruct','VERB_MASTER','reconstruct','tái xây dựng','V1: reconstruct · -ed: /ɪd/','The bridge was reconstructed.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"reconstruct","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The bridge was reconstructed.","source":"TOEIC 800+ Verb Master user handbook"}','a3c4b52917850ebff10372c66aa6bf32ddaef1ee',1),
('hbk-verb-recruit','VERB_MASTER','recruit','tuyển dụng','V1: recruit · -ed: /ɪd/','We recruited 20 engineers.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"recruit","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We recruited 20 engineers.","source":"TOEIC 800+ Verb Master user handbook"}','8ca2101c17de95bda891f883f46bb3c930559013',1),
('hbk-verb-reduce','VERB_MASTER','reduce','giảm','V1: reduce · -ed: /t/','Costs were reduced by 15%.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"reduce","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Costs were reduced by 15%.","source":"TOEIC 800+ Verb Master user handbook"}','0f4ebd7d34c2eed102e84d4cbe829ea8647c6989',1),
('hbk-verb-refer','VERB_MASTER','refer','giới thiệu; đề cập','V1: refer · -ed: /d/','She was referred by a friend.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"refer","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"refer to the document; refer a customer to another department","tags":"toeic,800-plus,verb,verb-master","audio_text":"She was referred by a friend.","source":"TOEIC 800+ Verb Master user handbook"}','59ec6fec7d58ba27eeed8445bfc5843cf7fdd5f7',1),
('hbk-verb-refund','VERB_MASTER','refund','hoàn tiền','V1: refund · -ed: /ɪd/','The payment was refunded.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"refund","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The payment was refunded.","source":"TOEIC 800+ Verb Master user handbook"}','4fd473cd8967f57cf63025323dfcfded16839508',1),
('hbk-verb-refurbish','VERB_MASTER','refurbish','tân trang','V1: refurbish · -ed: /t/','The hotel was refurbished.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"refurbish","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The hotel was refurbished.","source":"TOEIC 800+ Verb Master user handbook"}','bcbe3ea78f98fa89e278ee1cc8a8d73a091120fe',1),
('hbk-verb-register','VERB_MASTER','register','đăng ký','V1: register · -ed: /d/','Please register by Friday.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"register","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Please register by Friday.","source":"TOEIC 800+ Verb Master user handbook"}','19c9d675fc2220243b7e23d63e4433d4e07f14cd',1),
('hbk-verb-regulate','VERB_MASTER','regulate','điều chỉnh','V1: regulate · -ed: /ɪd/','The industry is regulated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"regulate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The industry is regulated.","source":"TOEIC 800+ Verb Master user handbook"}','6864e1e6b506269117fab86f8a6a25479e7020df',1),
('hbk-verb-reimburse','VERB_MASTER','reimburse','hoàn trả','V1: reimburse · -ed: /t/','Expenses will be reimbursed.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"reimburse","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Expenses will be reimbursed.","source":"TOEIC 800+ Verb Master user handbook"}','11e3a1b13bc4c10816fd26f614c316040d162595',1),
('hbk-verb-release','VERB_MASTER','release','phát hành','V1: release · -ed: /t/','A report was released.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"release","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A report was released.","source":"TOEIC 800+ Verb Master user handbook"}','9297f60f794f23e59c8e30469f3aeb94ff1094f7',1),
('hbk-verb-relocate','VERB_MASTER','relocate','di chuyển','V1: relocate · -ed: /ɪd/','The office relocated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"relocate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The office relocated.","source":"TOEIC 800+ Verb Master user handbook"}','7c06aa63d79ffb8f71f019f0e0db526e3f210189',1),
('hbk-verb-remind','VERB_MASTER','remind','nhắc nhở','V1: remind · -ed: /ɪd/','We reminded all participants.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"remind","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We reminded all participants.","source":"TOEIC 800+ Verb Master user handbook"}','805e1a3c8b8c475daed2d67af46aae6de2394996',1),
('hbk-verb-remodel','VERB_MASTER','remodel','cải tạo','V1: remodel · -ed: /d/','The store was remodeled.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"remodel","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The store was remodeled.","source":"TOEIC 800+ Verb Master user handbook"}','4366b1d8467c1d44e2d98467a150f43b17d8b0eb',1),
('hbk-verb-renew','VERB_MASTER','renew','gia hạn','V1: renew · -ed: /d/','The contract was renewed.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"renew","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The contract was renewed.","source":"TOEIC 800+ Verb Master user handbook"}','979261a29d2f1104ff84593ea129aff22394e300',1),
('hbk-verb-renovate','VERB_MASTER','renovate','sửa sang','V1: renovate · -ed: /ɪd/','The lobby was renovated.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"renovate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The lobby was renovated.","source":"TOEIC 800+ Verb Master user handbook"}','0373100e429c1661f388b34e8f25e1f89157e6c3',1),
('hbk-verb-repair','VERB_MASTER','repair','sửa chữa','V1: repair · -ed: /d/','The machine was repaired.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"repair","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The machine was repaired.","source":"TOEIC 800+ Verb Master user handbook"}','93fd0a4ab5db88082b88671aa90708dc3bce2dcc',1),
('hbk-verb-replace','VERB_MASTER','replace','thay thế','V1: replace · -ed: /t/','Old parts were replaced.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"replace","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Old parts were replaced.","source":"TOEIC 800+ Verb Master user handbook"}','abc2cb881ccd5766f263358b1647af311e700e71',1),
('hbk-verb-represent','VERB_MASTER','represent','đại diện','V1: represent · -ed: /ɪd/','She represented the firm.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"represent","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She represented the firm.","source":"TOEIC 800+ Verb Master user handbook"}','f2235f915bf70aa158264e8205a470d1ae7ece9a',1),
('hbk-verb-request','VERB_MASTER','request','yêu cầu','V1: request · -ed: /ɪd/','A refund was requested.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"request","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A refund was requested.","source":"TOEIC 800+ Verb Master user handbook"}','f9d7fb0b99cc42d157d27a1d557cb58dc1a1388c',1),
('hbk-verb-require','VERB_MASTER','require','yêu cầu','V1: require · -ed: /d/','Approval is required.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"require","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Approval is required.","source":"TOEIC 800+ Verb Master user handbook"}','2c753657a2cc80b32f9cf009f65b3056ea151e5e',1),
('hbk-verb-reserve','VERB_MASTER','reserve','đặt trước','V1: reserve · -ed: /d/','A room was reserved.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"reserve","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"A room was reserved.","source":"TOEIC 800+ Verb Master user handbook"}','bc984f7cd37071f6b158c9af01e582ecc355a4f4',1),
('hbk-verb-resign','VERB_MASTER','resign','từ chức','V1: resign · -ed: /d/','The director resigned.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"resign","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The director resigned.","source":"TOEIC 800+ Verb Master user handbook"}','47e9421df77a4aad0698d9bae452e0f987a62479',1),
('hbk-verb-resolve','VERB_MASTER','resolve','giải quyết','V1: resolve · -ed: /d/','The issue was resolved.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"resolve","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The issue was resolved.","source":"TOEIC 800+ Verb Master user handbook"}','7b1f0f701c911d345e7cadf6239d89bc8fe7f111',1),
('hbk-verb-respond','VERB_MASTER','respond','phản hồi','V1: respond · -ed: /ɪd/','She responded promptly.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"respond","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She responded promptly.","source":"TOEIC 800+ Verb Master user handbook"}','50a0ab8560946356a5390d325ef75848065b681b',1),
('hbk-verb-restore','VERB_MASTER','restore','khôi phục','V1: restore · -ed: /d/','Service was restored.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"restore","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Service was restored.","source":"TOEIC 800+ Verb Master user handbook"}','6db3e717c31e375310b617699f5b0a4bd0e86ec4',1),
('hbk-verb-restrict','VERB_MASTER','restrict','hạn chế','V1: restrict · -ed: /ɪd/','Access is restricted.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"restrict","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Access is restricted.","source":"TOEIC 800+ Verb Master user handbook"}','e778b5c4c6bfd3e830eb3dc25d324fc9b6881d47',1),
('hbk-verb-resume','VERB_MASTER','resume','tiếp tục lại','V1: resume · -ed: /d/','Service will resume tomorrow.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"resume","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Service will resume tomorrow.","source":"TOEIC 800+ Verb Master user handbook"}','da6f57975d6f4fcebf9c97b31ef8199efcfb5dfc',1),
('hbk-verb-retain','VERB_MASTER','retain','giữ lại','V1: retain · -ed: /d/','We retained top talent.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"retain","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"We retained top talent.","source":"TOEIC 800+ Verb Master user handbook"}','592180892a4edf4ff109399587f840b922b2a697',1),
('hbk-verb-retrieve','VERB_MASTER','retrieve','truy xuất','V1: retrieve · -ed: /d/','Files were retrieved.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"retrieve","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Files were retrieved.","source":"TOEIC 800+ Verb Master user handbook"}','c55278bfb6599eacd0d303032abb6123da07e27f',1),
('hbk-verb-revise','VERB_MASTER','revise','sửa đổi','V1: revise · -ed: /d/','The manual was revised.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"revise","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The manual was revised.","source":"TOEIC 800+ Verb Master user handbook"}','6cb0453175e6e4ee9b0657b5aa0a0931a0c9d073',1);
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-verb-ride','VERB_MASTER','ride','đi (xe)','V1: ride · V2: rode · V3: ridden · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"ride","v2":"rode","v3":"ridden","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"ride","source":"TOEIC 800+ Verb Master user handbook"}','f304c282af3f49a958b38a9868435e6a16df770c',1),
('hbk-verb-rise','VERB_MASTER','rise','tăng lên','V1: rise · V2: rose · V3: risen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"rise","v2":"rose","v3":"risen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"rise","source":"TOEIC 800+ Verb Master user handbook"}','a08127e3e1817a153a1618c128ed7219f313858d',1),
('hbk-verb-run','VERB_MASTER','run','chạy; điều hành','V1: run · V2: ran · V3: run · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"run","v2":"ran","v3":"run","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"run","source":"TOEIC 800+ Verb Master user handbook"}','337ca98bfaf7e40e59319c6e9a30427f05699711',1),
('hbk-verb-say','VERB_MASTER','say','nói','V1: say · V2: said · V3: said · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"say","v2":"said","v3":"said","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"say","source":"TOEIC 800+ Verb Master user handbook"}','2b85d40005c8298a5981c89b7db83689fc44681e',1),
('hbk-verb-schedule','VERB_MASTER','schedule','sắp lịch','V1: schedule · -ed: /d/','A meeting was scheduled.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"schedule","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"schedule a meeting; schedule an appointment; schedule an interview","tags":"toeic,800-plus,verb,verb-master","audio_text":"A meeting was scheduled.","source":"TOEIC 800+ Verb Master user handbook"}','98337d96d5764df246e6026ef932f9b17109bbb1',1),
('hbk-verb-secure','VERB_MASTER','secure','bảo đảm','V1: secure · -ed: /d/','Funding was secured.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"secure","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Funding was secured.","source":"TOEIC 800+ Verb Master user handbook"}','09def7338fc376cd1a67e738dbf4017c68b04c87',1),
('hbk-verb-see','VERB_MASTER','see','nhìn thấy','V1: see · V2: saw · V3: seen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"see","v2":"saw","v3":"seen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"see","source":"TOEIC 800+ Verb Master user handbook"}','e03692c8adb500d3e0da2fee19409252e1bfe9ea',1),
('hbk-verb-seek','VERB_MASTER','seek','tìm kiếm','V1: seek · V2: sought · V3: sought · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"seek","v2":"sought","v3":"sought","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"seek","source":"TOEIC 800+ Verb Master user handbook"}','41916f89d0b6c51a726665d35cd141f17b11bf4a',1),
('hbk-verb-sell','VERB_MASTER','sell','bán','V1: sell · V2: sold · V3: sold · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"sell","v2":"sold","v3":"sold","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"sell","source":"TOEIC 800+ Verb Master user handbook"}','96cb647daf2417b7798fa9bb6c887593f18744fd',1),
('hbk-verb-send','VERB_MASTER','send','gửi','V1: send · V2: sent · V3: sent · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"send","v2":"sent","v3":"sent","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"send","source":"TOEIC 800+ Verb Master user handbook"}','cf9023a670dd50e11a9a9815a97b532b3e738434',1),
('hbk-verb-set','VERB_MASTER','set','thiết lập','V1: set · V2: set · V3: set · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"set","v2":"set","v3":"set","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"set","source":"TOEIC 800+ Verb Master user handbook"}','53abbc95254c6d87a501584d830cd5b23ebccecc',1),
('hbk-verb-shake','VERB_MASTER','shake','lắc; rung','V1: shake · V2: shook · V3: shaken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"shake","v2":"shook","v3":"shaken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"shake","source":"TOEIC 800+ Verb Master user handbook"}','32b61122b12b23f26c86287fe733fc2ca52ff884',1),
('hbk-verb-ship','VERB_MASTER','ship','vận chuyển','V1: ship · -ed: /t/','Orders shipped yesterday.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"ship","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Orders shipped yesterday.","source":"TOEIC 800+ Verb Master user handbook"}','cd7bc5c60e856254df4c77c70c34d5377f7e76b3',1),
('hbk-verb-show','VERB_MASTER','show','cho xem','V1: show · V2: showed · V3: shown · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"show","v2":"showed","v3":"shown","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"show","source":"TOEIC 800+ Verb Master user handbook"}','23e088fc8d26889c3f9fabf23d8ce4229dccc6b6',1),
('hbk-verb-shrink','VERB_MASTER','shrink','co lại; giảm','V1: shrink · V2: shrank · V3: shrunk · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"shrink","v2":"shrank","v3":"shrunk","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"shrink","source":"TOEIC 800+ Verb Master user handbook"}','f351a74dd406c46efddb679b61c6812d868f481c',1),
('hbk-verb-shut','VERB_MASTER','shut','đóng','V1: shut · V2: shut · V3: shut · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"shut","v2":"shut","v3":"shut","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"shut","source":"TOEIC 800+ Verb Master user handbook"}','3d1fba146c5414604311c88b622f05a5aa48bb44',1),
('hbk-verb-sit','VERB_MASTER','sit','ngồi','V1: sit · V2: sat · V3: sat · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"sit","v2":"sat","v3":"sat","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"sit","source":"TOEIC 800+ Verb Master user handbook"}','553edc81e07114123e3a18ebe2787530b643e415',1),
('hbk-verb-speak','VERB_MASTER','speak','nói','V1: speak · V2: spoke · V3: spoken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"speak","v2":"spoke","v3":"spoken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"speak","source":"TOEIC 800+ Verb Master user handbook"}','2ff98364b23fec300a677768c54dd0f08fd319df',1),
('hbk-verb-specify','VERB_MASTER','specify','chỉ rõ','V1: specify · -ed: /d/','Requirements were specified.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"specify","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Requirements were specified.","source":"TOEIC 800+ Verb Master user handbook"}','95daeaaaa56215d6210ec89b3d6f0e17299fabd1',1),
('hbk-verb-spend','VERB_MASTER','spend','chi tiêu; dành','V1: spend · V2: spent · V3: spent · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"spend","v2":"spent","v3":"spent","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"spend","source":"TOEIC 800+ Verb Master user handbook"}','2236da0602ab2a73d93a880fcd105e1e91f450e3',1),
('hbk-verb-split','VERB_MASTER','split','chia tách','V1: split · V2: split · V3: split · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"split","v2":"split","v3":"split","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"split","source":"TOEIC 800+ Verb Master user handbook"}','98e795cf231fd4256fd3fa86035a487423375e41',1),
('hbk-verb-sponsor','VERB_MASTER','sponsor','tài trợ','V1: sponsor · -ed: /d/','The event was sponsored.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"sponsor","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The event was sponsored.","source":"TOEIC 800+ Verb Master user handbook"}','04eb13606448ac05f8e306b995b7baec1cce2efa',1),
('hbk-verb-spread','VERB_MASTER','spread','lan rộng','V1: spread · V2: spread · V3: spread · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"spread","v2":"spread","v3":"spread","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"spread","source":"TOEIC 800+ Verb Master user handbook"}','544fcb8b09c353ac27d0b07485cfd5dd7c836edb',1),
('hbk-verb-stand','VERB_MASTER','stand','đứng','V1: stand · V2: stood · V3: stood · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"stand","v2":"stood","v3":"stood","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"stand","source":"TOEIC 800+ Verb Master user handbook"}','cb5982c968a531febe0a8117d00330e912828265',1),
('hbk-verb-steal','VERB_MASTER','steal','trộm','V1: steal · V2: stole · V3: stolen · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"steal","v2":"stole","v3":"stolen","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"steal","source":"TOEIC 800+ Verb Master user handbook"}','f554687f9f76bcd722e4eb3446031d34fd2ace23',1),
('hbk-verb-stick','VERB_MASTER','stick','dính; bám','V1: stick · V2: stuck · V3: stuck · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"stick","v2":"stuck","v3":"stuck","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"stick","source":"TOEIC 800+ Verb Master user handbook"}','080402348f3364668124f2b514d87bfbc1fbbf5a',1),
('hbk-verb-stock','VERB_MASTER','stock','dự trữ','V1: stock · -ed: /t/','Shelves are fully stocked.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"stock","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Shelves are fully stocked.","source":"TOEIC 800+ Verb Master user handbook"}','6e6d6b670d01e32ef42e815fce2a01092baad247',1),
('hbk-verb-store','VERB_MASTER','store','lưu trữ','V1: store · -ed: /d/','Data is stored securely.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"store","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Data is stored securely.","source":"TOEIC 800+ Verb Master user handbook"}','f5217361d92699a9f76dc57688a3ee39e134489e',1),
('hbk-verb-streamline','VERB_MASTER','streamline','tinh gọn','V1: streamline · -ed: /d/','Operations were streamlined.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"streamline","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Operations were streamlined.","source":"TOEIC 800+ Verb Master user handbook"}','b2cc3287c4401d7962d3e7e522c8fe692c2f7ca3',1),
('hbk-verb-strike','VERB_MASTER','strike','đình công; đánh','V1: strike · V2: struck · V3: struck · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"strike","v2":"struck","v3":"struck","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"strike","source":"TOEIC 800+ Verb Master user handbook"}','8fcb8136847cb09130bc4335084f7ae62ac16132',1),
('hbk-verb-submit','VERB_MASTER','submit','nộp','V1: submit · -ed: /ɪd/','Applications must be submitted.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"submit","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"submit an application; submit a report; submit a proposal; submit a request","tags":"toeic,800-plus,verb,verb-master","audio_text":"Applications must be submitted.","source":"TOEIC 800+ Verb Master user handbook"}','9f3f8ffc41722643f490e2946b2d89b8b839c958',1),
('hbk-verb-subscribe','VERB_MASTER','subscribe','đăng ký','V1: subscribe · -ed: /d/','Readers subscribed online.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"subscribe","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Readers subscribed online.","source":"TOEIC 800+ Verb Master user handbook"}','4f7075857b8df2f5ca7e2b186faed5fc107d438f',1),
('hbk-verb-suggest','VERB_MASTER','suggest','gợi ý','V1: suggest · -ed: /ɪd/','He suggested a new approach.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"suggest","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He suggested a new approach.","source":"TOEIC 800+ Verb Master user handbook"}','bae7d0ee9aef398eab656303b661802d36a90684',1),
('hbk-verb-supervise','VERB_MASTER','supervise','giám sát','V1: supervise · -ed: /d/','He supervises 30 employees.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"supervise","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"He supervises 30 employees.","source":"TOEIC 800+ Verb Master user handbook"}','b982532b10531f0ffec2d1ddc5df2dcfbd5b8a73',1),
('hbk-verb-supply','VERB_MASTER','supply','cung cấp','V1: supply · -ed: /d/','Materials are supplied weekly.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"supply","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Materials are supplied weekly.","source":"TOEIC 800+ Verb Master user handbook"}','7f09939773079c606a0c09fb8498a736584e6401',1),
('hbk-verb-surpass','VERB_MASTER','surpass','vượt qua','V1: surpass · -ed: /t/','Revenue surpassed $1B.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"surpass","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Revenue surpassed $1B.","source":"TOEIC 800+ Verb Master user handbook"}','eca36db978eed7a59f922bcf8c58a7c8c3aad987',1),
('hbk-verb-suspend','VERB_MASTER','suspend','đình chỉ','V1: suspend · -ed: /ɪd/','Operations were suspended.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"suspend","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Operations were suspended.","source":"TOEIC 800+ Verb Master user handbook"}','5ae0425ebd96f57ab8ee4893782b00cd28f60805',1),
('hbk-verb-sustain','VERB_MASTER','sustain','duy trì','V1: sustain · -ed: /d/','Growth was sustained.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"sustain","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Growth was sustained.","source":"TOEIC 800+ Verb Master user handbook"}','90cc0ff2469f9971c3e3c4c6877a65aa17a2cab7',1),
('hbk-verb-swear','VERB_MASTER','swear','thề','V1: swear · V2: swore · V3: sworn · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"swear","v2":"swore","v3":"sworn","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"swear","source":"TOEIC 800+ Verb Master user handbook"}','1779bcb22b8123ac50e91f877d177442ffbf31e7',1),
('hbk-verb-sweep','VERB_MASTER','sweep','quét','V1: sweep · V2: swept · V3: swept · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"sweep","v2":"swept","v3":"swept","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"sweep","source":"TOEIC 800+ Verb Master user handbook"}','79f2c556e9d3e744d85c4f21197a241cc10f6058',1),
('hbk-verb-swim','VERB_MASTER','swim','bơi','V1: swim · V2: swam · V3: swum · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"swim","v2":"swam","v3":"swum","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"swim","source":"TOEIC 800+ Verb Master user handbook"}','a4f106687f72a9a2351c71ac3cf2fcd373701231',1),
('hbk-verb-take','VERB_MASTER','take','lấy','V1: take · V2: took · V3: taken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"take","v2":"took","v3":"taken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"take","source":"TOEIC 800+ Verb Master user handbook"}','6c9a3033a33d65806948856f865642895e4e0bb6',1),
('hbk-verb-teach','VERB_MASTER','teach','dạy','V1: teach · V2: taught · V3: taught · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"teach","v2":"taught","v3":"taught","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"teach","source":"TOEIC 800+ Verb Master user handbook"}','9c6b23c8949a3d3c0a7b6e7bb7bd8b6203ecb1b5',1),
('hbk-verb-tear','VERB_MASTER','tear','xé','V1: tear · V2: tore · V3: torn · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"tear","v2":"tore","v3":"torn","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"tear","source":"TOEIC 800+ Verb Master user handbook"}','6a42bba92e499fdc555103927dab86e152ed5c0e',1),
('hbk-verb-tell','VERB_MASTER','tell','nói; kể','V1: tell · V2: told · V3: told · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"tell","v2":"told","v3":"told","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"tell","source":"TOEIC 800+ Verb Master user handbook"}','0275acbba188ca4b7d576e31366e19ff7e21a18e',1),
('hbk-verb-terminate','VERB_MASTER','terminate','chấm dứt','V1: terminate · -ed: /ɪd/','The contract was terminated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"terminate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The contract was terminated.","source":"TOEIC 800+ Verb Master user handbook"}','a3992fa2cbda02ae144e332d13622acb6eda2508',1),
('hbk-verb-think','VERB_MASTER','think','nghĩ','V1: think · V2: thought · V3: thought · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"think","v2":"thought","v3":"thought","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"think","source":"TOEIC 800+ Verb Master user handbook"}','04613fafb5e1d253e51aa20215c318339ec21ea6',1),
('hbk-verb-throw','VERB_MASTER','throw','ném','V1: throw · V2: threw · V3: thrown · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"throw","v2":"threw","v3":"thrown","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"throw","source":"TOEIC 800+ Verb Master user handbook"}','8111002d83d66e4e02dec01ea2a6d0e05e242b03',1),
('hbk-verb-transfer','VERB_MASTER','transfer','chuyển','V1: transfer · -ed: /d/','She transferred to HQ.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"transfer","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She transferred to HQ.","source":"TOEIC 800+ Verb Master user handbook"}','5514038c60a4642a725c50eae659bbc45a37232a',1),
('hbk-verb-transform','VERB_MASTER','transform','biến đổi','V1: transform · -ed: /d/','Technology transformed the field.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"transform","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Technology transformed the field.","source":"TOEIC 800+ Verb Master user handbook"}','5ece53a738ef6fbd5be2b359697f4801b3a428f1',1),
('hbk-verb-undergo','VERB_MASTER','undergo','trải qua','V1: undergo · V2: underwent · V3: undergone · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"undergo","v2":"underwent","v3":"undergone","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"undergo","source":"TOEIC 800+ Verb Master user handbook"}','8765da8faa86c5850e5d972c232f23c67584eb22',1),
('hbk-verb-understand','VERB_MASTER','understand','hiểu','V1: understand · V2: understood · V3: understood · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"understand","v2":"understood","v3":"understood","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"understand","source":"TOEIC 800+ Verb Master user handbook"}','aa0ea4b565f3a1e2b9e3f6d65ee0194516d88f1a',1),
('hbk-verb-undertake','VERB_MASTER','undertake','đảm nhận','V1: undertake · V2: undertook · V3: undertaken · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"undertake","v2":"undertook","v3":"undertaken","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"undertake","source":"TOEIC 800+ Verb Master user handbook"}','d6e0a04be8fea256a15e2e322a6dd5c8a695f6ba',1),
('hbk-verb-undo','VERB_MASTER','undo','hoàn tác','V1: undo · V2: undid · V3: undone · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"undo","v2":"undid","v3":"undone","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"undo","source":"TOEIC 800+ Verb Master user handbook"}','3d7c432a526feefbfd40b5861e1304b40be2ad7b',1),
('hbk-verb-update','VERB_MASTER','update','cập nhật','V1: update · -ed: /ɪd/','The system was updated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"update","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The system was updated.","source":"TOEIC 800+ Verb Master user handbook"}','346dfb028ea871948f5113c0f06a7c32cc4865ca',1),
('hbk-verb-upgrade','VERB_MASTER','upgrade','nâng cấp','V1: upgrade · -ed: /ɪd/','Software was upgraded.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"upgrade","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Software was upgraded.","source":"TOEIC 800+ Verb Master user handbook"}','73de774fd2948a3e4b4021ff383192ac2fe49a4d',1),
('hbk-verb-uphold','VERB_MASTER','uphold','duy trì','V1: uphold · V2: upheld · V3: upheld · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"uphold","v2":"upheld","v3":"upheld","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"uphold","source":"TOEIC 800+ Verb Master user handbook"}','a2ec1a09e6ec070d72c73b1d90f014f904281dfb',1),
('hbk-verb-utilize','VERB_MASTER','utilize','sử dụng','V1: utilize · -ed: /d/','Resources were utilized fully.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"utilize","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Resources were utilized fully.","source":"TOEIC 800+ Verb Master user handbook"}','4937b5b5e1c7428484a5d74951ac328cbed46134',1),
('hbk-verb-validate','VERB_MASTER','validate','xác nhận','V1: validate · -ed: /ɪd/','Data was validated.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"validate","v2":"","v3":"","ed_pronunciation":"/ɪd/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Data was validated.","source":"TOEIC 800+ Verb Master user handbook"}','b01a0d11e2e36e270e881cde01c185f831feb039',1),
('hbk-verb-verify','VERB_MASTER','verify','xác minh','V1: verify · -ed: /d/','Information was verified.','','Business & Management','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"verify","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Information was verified.","source":"TOEIC 800+ Verb Master user handbook"}','d10cce5c0c6521ebdb9dbb908f1e775415ff6d9a',1);
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-verb-volunteer','VERB_MASTER','volunteer','tình nguyện','V1: volunteer · -ed: /d/','She volunteered for the task.','','HR & Communication','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"volunteer","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"She volunteered for the task.","source":"TOEIC 800+ Verb Master user handbook"}','eb6150823c97ee95af45b250e98113a51e3fe492',1),
('hbk-verb-waive','VERB_MASTER','waive','miễn (phí)','V1: waive · -ed: /d/','The fee was waived.','','Finance & Purchasing','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"waive","v2":"","v3":"","ed_pronunciation":"/d/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"The fee was waived.","source":"TOEIC 800+ Verb Master user handbook"}','11ea9cd585c3ec5de4adfd8062d90cb184d85346',1),
('hbk-verb-wear','VERB_MASTER','wear','mặc','V1: wear · V2: wore · V3: worn · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"wear","v2":"wore","v3":"worn","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"wear","source":"TOEIC 800+ Verb Master user handbook"}','464d0dc3e204938f78c177971e26ea4ddffff149',1),
('hbk-verb-win','VERB_MASTER','win','thắng','V1: win · V2: won · V3: won · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"win","v2":"won","v3":"won","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"win","source":"TOEIC 800+ Verb Master user handbook"}','533ea8efb261e65d26c35c9afbad08f5309ffc87',1),
('hbk-verb-withdraw','VERB_MASTER','withdraw','rút lui','V1: withdraw · V2: withdrew · V3: withdrawn · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"withdraw","v2":"withdrew","v3":"withdrawn","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"withdraw","source":"TOEIC 800+ Verb Master user handbook"}','abd2631ca8525486a5e21ca39f44b8ac58ebb223',1),
('hbk-verb-withhold','VERB_MASTER','withhold','giữ lại','V1: withhold · V2: withheld · V3: withheld · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"withhold","v2":"withheld","v3":"withheld","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"withhold","source":"TOEIC 800+ Verb Master user handbook"}','ccf4af667fbab8bb034b17423781fe82faa6388c',1),
('hbk-verb-withstand','VERB_MASTER','withstand','chịu đựng','V1: withstand · V2: withstood · V3: withstood · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"withstand","v2":"withstood","v3":"withstood","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"withstand","source":"TOEIC 800+ Verb Master user handbook"}','f710efd13b9c523d0876da6a578fb0b551d3319c',1),
('hbk-verb-wrap','VERB_MASTER','wrap','gói','V1: wrap · -ed: /t/','Gifts were wrapped.','','Operations & Logistics','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-essential","v1":"wrap","v2":"","v3":"","ed_pronunciation":"/t/","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"Gifts were wrapped.","source":"TOEIC 800+ Verb Master user handbook"}','be45ea800beec6f66893e11cdc3a45ee7589e1f8',1),
('hbk-verb-write','VERB_MASTER','write','viết','V1: write · V2: wrote · V3: written · -ed: irregular','','','Irregular Verbs','B1-B2','{"handbook_code":"verb-800","handbook_section":"verb-irregular","v1":"write","v2":"wrote","v3":"written","ed_pronunciation":"irregular","collocations":"","tags":"toeic,800-plus,verb,verb-master","audio_text":"write","source":"TOEIC 800+ Verb Master user handbook"}','d908ed0ea060f3a243056f11b6bf91950abacb26',1),
('hbk-listening-p1-001','LISTENING_RECOGNITION','A woman is typing on a keyboard.','Một người phụ nữ đang gõ bàn phím.','Part 1 sentence recognition','A woman is typing on a keyboard.','Một người phụ nữ đang gõ bàn phím.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"A woman is typing on a keyboard.","transcript":"A woman is typing on a keyboard.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','8f221fa0b1a50413be692f91bc6831b8fe10b3cd',1),
('hbk-listening-p1-002','LISTENING_RECOGNITION','Some boxes are being loaded onto a truck.','Một số thùng hàng đang được chất lên xe tải.','Part 1 sentence recognition','Some boxes are being loaded onto a truck.','Một số thùng hàng đang được chất lên xe tải.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"Some boxes are being loaded onto a truck.","transcript":"Some boxes are being loaded onto a truck.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','7a950613f51e9da6de2bd2bb72e34e1e189c7d67',1),
('hbk-listening-p1-003','LISTENING_RECOGNITION','The man is reaching for a book on the shelf.','Người đàn ông đang với lấy một cuốn sách trên kệ.','Part 1 sentence recognition','The man is reaching for a book on the shelf.','Người đàn ông đang với lấy một cuốn sách trên kệ.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"The man is reaching for a book on the shelf.","transcript":"The man is reaching for a book on the shelf.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','94a3d84bbdc387039297159cd77b2e5cfb5d05c4',1),
('hbk-listening-p1-004','LISTENING_RECOGNITION','Chairs have been arranged around a table.','Ghế đã được xếp xung quanh bàn.','Part 1 sentence recognition','Chairs have been arranged around a table.','Ghế đã được xếp xung quanh bàn.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"Chairs have been arranged around a table.","transcript":"Chairs have been arranged around a table.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','58e4fd1ea5f8a305f8cef34b31fd10f8717bf30b',1),
('hbk-listening-p1-005','LISTENING_RECOGNITION','A vehicle is parked next to the building.','Một chiếc xe đang đậu bên cạnh tòa nhà.','Part 1 sentence recognition','A vehicle is parked next to the building.','Một chiếc xe đang đậu bên cạnh tòa nhà.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"A vehicle is parked next to the building.","transcript":"A vehicle is parked next to the building.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','cbc3ab5f623b2beb048386ec65ffb60bc4301be2',1),
('hbk-listening-p1-006','LISTENING_RECOGNITION','She is holding a cup of coffee.','Cô ấy đang cầm một tách cà phê.','Part 1 sentence recognition','She is holding a cup of coffee.','Cô ấy đang cầm một tách cà phê.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"She is holding a cup of coffee.","transcript":"She is holding a cup of coffee.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','69e7e131aac1cdc2e3b2ea029223ae7a020d16bc',1),
('hbk-listening-p1-007','LISTENING_RECOGNITION','People are walking along the sidewalk.','Mọi người đang đi bộ dọc vỉa hè.','Part 1 sentence recognition','People are walking along the sidewalk.','Mọi người đang đi bộ dọc vỉa hè.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"People are walking along the sidewalk.","transcript":"People are walking along the sidewalk.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','13a4d0a94af206edff9d5e08ac07a72348c5331b',1),
('hbk-listening-p1-008','LISTENING_RECOGNITION','Documents are spread out on the desk.','Tài liệu được trải ra trên bàn.','Part 1 sentence recognition','Documents are spread out on the desk.','Tài liệu được trải ra trên bàn.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"Documents are spread out on the desk.","transcript":"Documents are spread out on the desk.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','6a62999cbe8bb39e9623bf07858bfc4d07a184be',1),
('hbk-listening-p1-009','LISTENING_RECOGNITION','The shelves are stocked with merchandise.','Các kệ hàng được chất đầy hàng hóa.','Part 1 sentence recognition','The shelves are stocked with merchandise.','Các kệ hàng được chất đầy hàng hóa.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"The shelves are stocked with merchandise.","transcript":"The shelves are stocked with merchandise.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','1d82eda2b237df7ba818bf9968ebb60b568db45a',1),
('hbk-listening-p1-010','LISTENING_RECOGNITION','A man is standing at a podium giving a presentation.','Một người đàn ông đang đứng trên bục phát biểu.','Part 1 sentence recognition','A man is standing at a podium giving a presentation.','Một người đàn ông đang đứng trên bục phát biểu.','TOEIC Part 1','B1','{"handbook_code":"listening-800","handbook_section":"listening-part1","toeic_part":1,"audio_text":"A man is standing at a podium giving a presentation.","transcript":"A man is standing at a podium giving a presentation.","tags":"toeic,800-plus,listening,part1","source":"TOEIC Listening 100 câu user handbook"}','ae0963b8dbf7642cf66d02c9cae3664832962b65',1),
('hbk-listening-p2-011','LISTENING_RECOGNITION','Where is the meeting room?','Phòng họp ở đâu?','Natural response: It''s on the third floor.','It''s on the third floor.','Ở tầng 3.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Where is the meeting room?","response":"It''s on the third floor.","response_vi":"Ở tầng 3.","transcript":"Where is the meeting room?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','e31042901cccd3f7561b04748d2f6c245e5ad224',1),
('hbk-listening-p2-012','LISTENING_RECOGNITION','When does the store close?','Cửa hàng đóng cửa lúc mấy giờ?','Natural response: At nine o''clock.','At nine o''clock.','Lúc 9 giờ.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"When does the store close?","response":"At nine o''clock.","response_vi":"Lúc 9 giờ.","transcript":"When does the store close?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','322cb5668be6ccc610b8a70d571a5fa94c2084c2',1),
('hbk-listening-p2-013','LISTENING_RECOGNITION','Who is in charge of the project?','Ai phụ trách dự án?','Natural response: Ms. Tanaka is leading it.','Ms. Tanaka is leading it.','Bà Tanaka đang dẫn dắt.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Who is in charge of the project?","response":"Ms. Tanaka is leading it.","response_vi":"Bà Tanaka đang dẫn dắt.","transcript":"Who is in charge of the project?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','09370e7a37d11bdb305ca47ea1c61a497d4bb4be',1),
('hbk-listening-p2-014','LISTENING_RECOGNITION','What time is the conference call?','Cuộc họp qua điện thoại lúc mấy giờ?','Natural response: It''s been moved to two thirty.','It''s been moved to two thirty.','Nó đã được chuyển sang 2:30.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"What time is the conference call?","response":"It''s been moved to two thirty.","response_vi":"Nó đã được chuyển sang 2:30.","transcript":"What time is the conference call?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','7c20cbd58c77ade3b31bdb27a80841999e6a4fe4',1),
('hbk-listening-p2-015','LISTENING_RECOGNITION','Why was the shipment delayed?','Tại sao lô hàng bị trễ?','Natural response: There was a problem at customs.','There was a problem at customs.','Có vấn đề ở hải quan.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Why was the shipment delayed?","response":"There was a problem at customs.","response_vi":"Có vấn đề ở hải quan.","transcript":"Why was the shipment delayed?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','ea146bfe66dee7a8fe360e59fca044394a7e143d',1),
('hbk-listening-p2-016','LISTENING_RECOGNITION','How long will the renovation take?','Việc sửa chữa sẽ mất bao lâu?','Natural response: About three weeks.','About three weeks.','Khoảng ba tuần.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"How long will the renovation take?","response":"About three weeks.","response_vi":"Khoảng ba tuần.","transcript":"How long will the renovation take?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','1262274b26d87d8ad252633d952391b40e2a66b3',1),
('hbk-listening-p2-017','LISTENING_RECOGNITION','Where should I put these files?','Tôi nên để mấy tập hồ sơ này ở đâu?','Natural response: On the shelf next to the printer.','On the shelf next to the printer.','Trên kệ cạnh máy in.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Where should I put these files?","response":"On the shelf next to the printer.","response_vi":"Trên kệ cạnh máy in.","transcript":"Where should I put these files?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','3dd30abe59d5260b254d560abc516049c08428af',1),
('hbk-listening-p2-018','LISTENING_RECOGNITION','Who approved the budget?','Ai đã duyệt ngân sách?','Natural response: The finance director did.','The finance director did.','Giám đốc tài chính.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Who approved the budget?","response":"The finance director did.","response_vi":"Giám đốc tài chính.","transcript":"Who approved the budget?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','df392a727d87edc23e70fb92e7265dbe1c5c5879',1),
('hbk-listening-p2-019','LISTENING_RECOGNITION','What did the client say about the proposal?','Khách hàng nói gì về bản đề xuất?','Natural response: They want some revisions.','They want some revisions.','Họ muốn sửa đổi một số chỗ.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"What did the client say about the proposal?","response":"They want some revisions.","response_vi":"Họ muốn sửa đổi một số chỗ.","transcript":"What did the client say about the proposal?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','ce5910c2150c861fb577c2f3d86641110ecb7545',1),
('hbk-listening-p2-020','LISTENING_RECOGNITION','How do I get to the warehouse?','Làm sao tôi đến được nhà kho?','Natural response: Take the elevator to the basement.','Take the elevator to the basement.','Đi thang máy xuống tầng hầm.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"How do I get to the warehouse?","response":"Take the elevator to the basement.","response_vi":"Đi thang máy xuống tầng hầm.","transcript":"How do I get to the warehouse?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','2a77c99d9172f457d2a98fc6855d6e9aa0f72de1',1),
('hbk-listening-p2-021','LISTENING_RECOGNITION','Has the report been submitted yet?','Báo cáo đã được nộp chưa?','Natural response: I''ll finish it by noon.','I''ll finish it by noon.','Tôi sẽ hoàn thành trước trưa.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Has the report been submitted yet?","response":"I''ll finish it by noon.","response_vi":"Tôi sẽ hoàn thành trước trưa.","transcript":"Has the report been submitted yet?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','cb18952939e69dda72fb1ed519246490bd3ecf40',1),
('hbk-listening-p2-022','LISTENING_RECOGNITION','Is Mr. Kim available this afternoon?','Ông Kim có rảnh chiều nay không?','Natural response: Let me check his calendar.','Let me check his calendar.','Để tôi xem lịch của ông ấy.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Is Mr. Kim available this afternoon?","response":"Let me check his calendar.","response_vi":"Để tôi xem lịch của ông ấy.","transcript":"Is Mr. Kim available this afternoon?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','8a792684adba992d37ad0a2dbb5a99b6c1db82a7',1),
('hbk-listening-p2-023','LISTENING_RECOGNITION','Did you receive the email I sent?','Bạn đã nhận được email tôi gửi chưa?','Natural response: No, could you resend it?','No, could you resend it?','Chưa, bạn gửi lại được không?','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Did you receive the email I sent?","response":"No, could you resend it?","response_vi":"Chưa, bạn gửi lại được không?","transcript":"Did you receive the email I sent?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','489b224bdb4d1f40c312fa1ac627befc65a08e9c',1),
('hbk-listening-p2-024','LISTENING_RECOGNITION','Are we still meeting at three?','Chúng ta vẫn họp lúc 3 giờ chứ?','Natural response: As far as I know.','As far as I know.','Theo tôi biết thì vẫn vậy.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Are we still meeting at three?","response":"As far as I know.","response_vi":"Theo tôi biết thì vẫn vậy.","transcript":"Are we still meeting at three?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','226dcc495e0f12a25ce7c4ece814442adff3f0b2',1),
('hbk-listening-p2-025','LISTENING_RECOGNITION','Will the new policy take effect next month?','Chính sách mới sẽ có hiệu lực tháng sau chứ?','Natural response: That hasn''t been decided yet.','That hasn''t been decided yet.','Điều đó vẫn chưa được quyết định.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Will the new policy take effect next month?","response":"That hasn''t been decided yet.","response_vi":"Điều đó vẫn chưa được quyết định.","transcript":"Will the new policy take effect next month?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','8dce70c563ffbc85a338cd00f1d15f428fb09176',1),
('hbk-listening-p2-026','LISTENING_RECOGNITION','Should we order lunch or go out to eat?','Chúng ta nên đặt cơm hay ra ngoài ăn?','Natural response: Let''s try the new restaurant nearby.','Let''s try the new restaurant nearby.','Thử nhà hàng mới gần đây đi.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Should we order lunch or go out to eat?","response":"Let''s try the new restaurant nearby.","response_vi":"Thử nhà hàng mới gần đây đi.","transcript":"Should we order lunch or go out to eat?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','9905a0b80b69fdf67f18fdc066bc10a3fa497543',1),
('hbk-listening-p2-027','LISTENING_RECOGNITION','Would you prefer the morning shift or the evening shift?','Bạn thích ca sáng hay ca tối?','Natural response: Either one is fine with me.','Either one is fine with me.','Cái nào cũng được.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Would you prefer the morning shift or the evening shift?","response":"Either one is fine with me.","response_vi":"Cái nào cũng được.","transcript":"Would you prefer the morning shift or the evening shift?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','c62d506789811d8cd63e9a12ecacf056dec54816',1),
('hbk-listening-p2-028','LISTENING_RECOGNITION','Is the training on Monday or Tuesday?','Buổi đào tạo vào thứ Hai hay thứ Ba?','Natural response: It''s actually been postponed.','It''s actually been postponed.','Thực ra nó đã bị hoãn.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Is the training on Monday or Tuesday?","response":"It''s actually been postponed.","response_vi":"Thực ra nó đã bị hoãn.","transcript":"Is the training on Monday or Tuesday?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','4a6d31e43d8d827630e3b98a26a77f257763d83f',1),
('hbk-listening-p2-029','LISTENING_RECOGNITION','You''ve been to the Tokyo office before, haven''t you?','Bạn đã từng đến văn phòng Tokyo rồi, phải không?','Natural response: Yes, twice last year.','Yes, twice last year.','Có, hai lần năm ngoái.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"You''ve been to the Tokyo office before, haven''t you?","response":"Yes, twice last year.","response_vi":"Có, hai lần năm ngoái.","transcript":"You''ve been to the Tokyo office before, haven''t you?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','9160207a528cb084e0371f763c71fbdb5039bf32',1),
('hbk-listening-p2-030','LISTENING_RECOGNITION','Could you help me set up the projector?','Bạn có thể giúp tôi lắp máy chiếu không?','Natural response: Sure, just give me a minute.','Sure, just give me a minute.','Được, cho tôi một phút.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Could you help me set up the projector?","response":"Sure, just give me a minute.","response_vi":"Được, cho tôi một phút.","transcript":"Could you help me set up the projector?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','ed703fd124e37b31705a3c2691f39e0d89fde91e',1),
('hbk-listening-p2-031','LISTENING_RECOGNITION','Let''s reschedule the meeting to Friday.','Chuyển cuộc họp sang thứ Sáu đi.','Natural response: That works for me.','That works for me.','Với tôi thì được.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Let''s reschedule the meeting to Friday.","response":"That works for me.","response_vi":"Với tôi thì được.","transcript":"Let''s reschedule the meeting to Friday.","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','55a53b2af185afdecb7312adcdbdafebaca68fa2',1),
('hbk-listening-p2-032','LISTENING_RECOGNITION','I heard the parking lot will be closed next week.','Tôi nghe nói bãi đỗ xe sẽ đóng tuần sau.','Natural response: Where are we supposed to park then?','Where are we supposed to park then?','Vậy chúng ta đỗ ở đâu?','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"I heard the parking lot will be closed next week.","response":"Where are we supposed to park then?","response_vi":"Vậy chúng ta đỗ ở đâu?","transcript":"I heard the parking lot will be closed next week.","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','7dbdb0d97f1450b5e11153c9d9b129f2ff1779ec',1),
('hbk-listening-p2-033','LISTENING_RECOGNITION','This printer seems to be out of paper.','Máy in này hình như hết giấy rồi.','Natural response: There''s more in the supply room.','There''s more in the supply room.','Còn thêm trong phòng vật tư.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"This printer seems to be out of paper.","response":"There''s more in the supply room.","response_vi":"Còn thêm trong phòng vật tư.","transcript":"This printer seems to be out of paper.","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','457b86eed5b40a51ca3b7a270da932679d327b9c',1),
('hbk-listening-p2-034','LISTENING_RECOGNITION','Would you mind reviewing this document for me?','Bạn có phiền xem lại tài liệu này cho tôi không?','Natural response: I''d be happy to.','I''d be happy to.','Tôi sẵn lòng.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Would you mind reviewing this document for me?","response":"I''d be happy to.","response_vi":"Tôi sẵn lòng.","transcript":"Would you mind reviewing this document for me?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','e82f44f57aa2fca21b84ee85cae663e2c19a7cec',1),
('hbk-listening-p2-035','LISTENING_RECOGNITION','The deadline has been extended, hasn''t it?','Hạn chót đã được gia hạn, phải không?','Natural response: Yes, we have until the end of the month now.','Yes, we have until the end of the month now.','Đúng, giờ chúng ta có đến cuối tháng.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"The deadline has been extended, hasn''t it?","response":"Yes, we have until the end of the month now.","response_vi":"Đúng, giờ chúng ta có đến cuối tháng.","transcript":"The deadline has been extended, hasn''t it?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','212f8675862179204c30cfc6626f8b632a08ba50',1),
('hbk-listening-p2-036','LISTENING_RECOGNITION','How about we take a break before the next session?','Hay là chúng ta nghỉ giải lao trước buổi tiếp theo?','Natural response: Good idea. I could use some coffee.','Good idea. I could use some coffee.','Ý hay. Tôi cũng muốn uống cà phê.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"How about we take a break before the next session?","response":"Good idea. I could use some coffee.","response_vi":"Ý hay. Tôi cũng muốn uống cà phê.","transcript":"How about we take a break before the next session?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','5d7728f5b758288ea54a9181d90530c5f4d84f09',1),
('hbk-listening-p2-037','LISTENING_RECOGNITION','Don''t forget to lock up when you leave.','Đừng quên khóa cửa khi rời đi nhé.','Natural response: I always do.','I always do.','Tôi luôn làm vậy mà.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Don''t forget to lock up when you leave.","response":"I always do.","response_vi":"Tôi luôn làm vậy mà.","transcript":"Don''t forget to lock up when you leave.","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','fee00bfef15311c61e229de263fbb77cdeb98de6',1),
('hbk-listening-p2-038','LISTENING_RECOGNITION','I can''t seem to connect to the Wi-Fi.','Tôi không kết nối được Wi-Fi.','Natural response: The password was changed this morning.','The password was changed this morning.','Mật khẩu đã đổi sáng nay.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"I can''t seem to connect to the Wi-Fi.","response":"The password was changed this morning.","response_vi":"Mật khẩu đã đổi sáng nay.","transcript":"I can''t seem to connect to the Wi-Fi.","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','ab08ab53fc60ee098a2a560715eb995bf3a4ef26',1),
('hbk-listening-p2-039','LISTENING_RECOGNITION','Why don''t we invite the marketing team to the meeting?','Sao chúng ta không mời đội marketing vào cuộc họp?','Natural response: I''ll send them an email right away.','I''ll send them an email right away.','Tôi sẽ gửi email cho họ ngay.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"Why don''t we invite the marketing team to the meeting?","response":"I''ll send them an email right away.","response_vi":"Tôi sẽ gửi email cho họ ngay.","transcript":"Why don''t we invite the marketing team to the meeting?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','0bffbb6eddaa7e81a1690b28ca1677c2ffe9f3ad',1),
('hbk-listening-p2-040','LISTENING_RECOGNITION','The new hire starts next Monday, right?','Nhân viên mới bắt đầu thứ Hai tuần sau, đúng không?','Natural response: Actually, it''s been pushed back to Wednesday.','Actually, it''s been pushed back to Wednesday.','Thực ra đã lùi lại đến thứ Tư.','TOEIC Part 2','B1','{"handbook_code":"listening-800","handbook_section":"listening-part2","toeic_part":2,"audio_text":"The new hire starts next Monday, right?","response":"Actually, it''s been pushed back to Wednesday.","response_vi":"Thực ra đã lùi lại đến thứ Tư.","transcript":"The new hire starts next Monday, right?","tags":"toeic,800-plus,listening,part2","source":"TOEIC Listening 100 câu user handbook"}','a39b76dc2fa976330518b6d1a0f98e28482281a1',1),
('hbk-listening-p3-group-01','LISTENING_RECOGNITION','Part 3 · Đặt phòng họp','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','W: Do we have a conference room booked for the client meeting tomorrow?
M: I checked, and Room B is available from 10 to 12.
W: That should work. Can you also order some refreshments?','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"W: Do we have a conference room booked for the client meeting tomorrow?\\nM: I checked, and Room B is available from 10 to 12.\\nW: That should work. Can you also order some refreshments?","transcript":"W: Do we have a conference room booked for the client meeting tomorrow?\\nM: I checked, and Room B is available from 10 to 12.\\nW: That should work. Can you also order some refreshments?","questions":[{"question":"What are the speakers discussing?","answer":"Chuẩn bị cho cuộc họp khách hàng."},{"question":"What time is Room B available?","answer":"Từ 10 đến 12 giờ."},{"question":"What does the woman ask the man to do?","answer":"Đặt đồ ăn nhẹ."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','b579e5230e3c1e9775772e75a6dee1e977710ebc',1),
('hbk-listening-p3-group-02','LISTENING_RECOGNITION','Part 3 · Vấn đề giao hàng','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M: I just got a call from the shipping company. Our delivery will be two days late.
W: That''s going to cause problems. We promised the client it''d arrive by Friday.
M: I know. I''ll contact them to see if there''s a faster option.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M: I just got a call from the shipping company. Our delivery will be two days late.\\nW: That''s going to cause problems. We promised the client it''d arrive by Friday.\\nM: I know. I''ll contact them to see if there''s a faster option.","transcript":"M: I just got a call from the shipping company. Our delivery will be two days late.\\nW: That''s going to cause problems. We promised the client it''d arrive by Friday.\\nM: I know. I''ll contact them to see if there''s a faster option.","questions":[{"question":"What is the problem?","answer":"Giao hàng bị trễ 2 ngày."},{"question":"When was the delivery originally promised?","answer":"Trước thứ Sáu."},{"question":"What will the man do next?","answer":"Liên hệ công ty vận chuyển."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','4529d770d7bef151a5b0ce55c93f6abcaac29370',1),
('hbk-listening-p3-group-03','LISTENING_RECOGNITION','Part 3 · Nhân viên mới','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M: Have you met the new marketing manager?
W: Not yet. I heard she transferred from the Singapore office.
M: Yes. She''ll be introduced at the staff meeting this afternoon.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M: Have you met the new marketing manager?\\nW: Not yet. I heard she transferred from the Singapore office.\\nM: Yes. She''ll be introduced at the staff meeting this afternoon.","transcript":"M: Have you met the new marketing manager?\\nW: Not yet. I heard she transferred from the Singapore office.\\nM: Yes. She''ll be introduced at the staff meeting this afternoon.","questions":[{"question":"What are they talking about?","answer":"Quản lý marketing mới."},{"question":"Where did the new manager come from?","answer":"Văn phòng Singapore."},{"question":"When will she be introduced?","answer":"Tại cuộc họp chiều nay."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','4a4849a904114a63b78e527bb734e1aeba71be5d',1),
('hbk-listening-p3-group-04','LISTENING_RECOGNITION','Part 3 · Sự cố kỹ thuật','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','W: The printer on the second floor isn''t working again.
M: Did you submit a maintenance request?
W: Yes, but they said a technician won''t be available until tomorrow.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"W: The printer on the second floor isn''t working again.\\nM: Did you submit a maintenance request?\\nW: Yes, but they said a technician won''t be available until tomorrow.","transcript":"W: The printer on the second floor isn''t working again.\\nM: Did you submit a maintenance request?\\nW: Yes, but they said a technician won''t be available until tomorrow.","questions":[{"question":"What is the problem?","answer":"Máy in tầng 2 hỏng."},{"question":"What did the woman already do?","answer":"Gửi yêu cầu bảo trì."},{"question":"When will the technician come?","answer":"Ngày mai."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','a9c2d769ae35bde556982a3978b820f66ca49fb0',1),
('hbk-listening-p3-group-05','LISTENING_RECOGNITION','Part 3 · Đào tạo','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M: Are you attending the software training session next week?
W: I''d like to, but it conflicts with my sales presentation.
M: They''re offering a second session on Thursday. You could sign up for that one.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M: Are you attending the software training session next week?\\nW: I''d like to, but it conflicts with my sales presentation.\\nM: They''re offering a second session on Thursday. You could sign up for that one.","transcript":"M: Are you attending the software training session next week?\\nW: I''d like to, but it conflicts with my sales presentation.\\nM: They''re offering a second session on Thursday. You could sign up for that one.","questions":[{"question":"Why can''t the woman attend the training?","answer":"Trùng lịch thuyết trình bán hàng."},{"question":"What does the man suggest?","answer":"Đăng ký buổi thứ Năm."},{"question":"What is the training about?","answer":"Phần mềm."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','00ef379c275533989832ce5f41a4d9afd0996fdb',1),
('hbk-listening-p3-group-06','LISTENING_RECOGNITION','Part 3 · Thay đổi chính sách','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','W: Did you see the memo about the new expense policy?
M: Yes. All travel expenses over $200 now need director approval.
W: That''s going to slow things down. I''ll bring it up at the next team meeting.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"W: Did you see the memo about the new expense policy?\\nM: Yes. All travel expenses over $200 now need director approval.\\nW: That''s going to slow things down. I''ll bring it up at the next team meeting.","transcript":"W: Did you see the memo about the new expense policy?\\nM: Yes. All travel expenses over $200 now need director approval.\\nW: That''s going to slow things down. I''ll bring it up at the next team meeting.","questions":[{"question":"What changed in the expense policy?","answer":"Chi phí trên $200 cần giám đốc duyệt."},{"question":"What is the woman''s concern?","answer":"Quy trình sẽ bị chậm lại."},{"question":"What will the woman do?","answer":"Nêu vấn đề tại cuộc họp nhóm."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','d8ad0c128d1a6dd040c48a3c0c1bb39da3f8614b',1),
('hbk-listening-p3-group-07','LISTENING_RECOGNITION','Part 3 · Thuê địa điểm tổ chức sự kiện','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?
W: The Grand Hotel has a nice banquet hall that can hold up to 200 people.
M: That sounds perfect. I''ll call them today to check availability.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?\\nW: The Grand Hotel has a nice banquet hall that can hold up to 200 people.\\nM: That sounds perfect. I''ll call them today to check availability.","transcript":"M: I''m looking for a venue for our annual company dinner. Do you have any suggestions?\\nW: The Grand Hotel has a nice banquet hall that can hold up to 200 people.\\nM: That sounds perfect. I''ll call them today to check availability.","questions":[{"question":"What is the man planning?","answer":"Bữa tiệc công ty hàng năm."},{"question":"How many people can the banquet hall hold?","answer":"200 người."},{"question":"What will the man do next?","answer":"Gọi điện kiểm tra lịch trống."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','8cbb0728e45d07c1617fc80e506c0c7af704b697',1),
('hbk-listening-p3-group-08','LISTENING_RECOGNITION','Part 3 · Phỏng vấn xin việc','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','W: How did your job interview go this morning?
M: Pretty well, I think. They said they''ll let me know by the end of the week.
W: That''s fast. They must have been impressed.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"W: How did your job interview go this morning?\\nM: Pretty well, I think. They said they''ll let me know by the end of the week.\\nW: That''s fast. They must have been impressed.","transcript":"W: How did your job interview go this morning?\\nM: Pretty well, I think. They said they''ll let me know by the end of the week.\\nW: That''s fast. They must have been impressed.","questions":[{"question":"What did the man do this morning?","answer":"Đi phỏng vấn."},{"question":"When will he hear back?","answer":"Trước cuối tuần."},{"question":"What does the woman imply?","answer":"Công ty có vẻ ấn tượng với anh ấy."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','868b4edcbe5328b89ffd187045a1c2685a269899',1),
('hbk-listening-p3-group-09','LISTENING_RECOGNITION','Part 3 · Chuyển văn phòng','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M: Our department is moving to the fifth floor next month.
W: Really? I hadn''t heard. Will we have more space?
M: Yes, and we''ll be closer to the IT team, which should make collaboration easier.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M: Our department is moving to the fifth floor next month.\\nW: Really? I hadn''t heard. Will we have more space?\\nM: Yes, and we''ll be closer to the IT team, which should make collaboration easier.","transcript":"M: Our department is moving to the fifth floor next month.\\nW: Really? I hadn''t heard. Will we have more space?\\nM: Yes, and we''ll be closer to the IT team, which should make collaboration easier.","questions":[{"question":"What will happen next month?","answer":"Phòng ban chuyển lên tầng 5."},{"question":"What is one advantage of the new location?","answer":"Gần đội IT hơn, dễ hợp tác."},{"question":"How does the woman react to the news?","answer":"Ngạc nhiên vì chưa biết."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','ecd0471c889a509596a79ac4b2334717ceab901d',1),
('hbk-listening-p3-group-10','LISTENING_RECOGNITION','Part 3 · Phản hồi khách hàng','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','W: We''ve been getting a lot of complaints about our new app update.
M: What''s the main issue?
W: Users say it crashes frequently. I think we need to release a patch this week.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"W: We''ve been getting a lot of complaints about our new app update.\\nM: What''s the main issue?\\nW: Users say it crashes frequently. I think we need to release a patch this week.","transcript":"W: We''ve been getting a lot of complaints about our new app update.\\nM: What''s the main issue?\\nW: Users say it crashes frequently. I think we need to release a patch this week.","questions":[{"question":"What are customers complaining about?","answer":"Bản cập nhật ứng dụng mới."},{"question":"What is the main problem?","answer":"Ứng dụng hay bị văng (crash)."},{"question":"What does the woman suggest?","answer":"Phát hành bản vá tuần này."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','5d20f713cd2b9b8f0684bb89831206c12afe7042',1),
('hbk-listening-p3-group-11','LISTENING_RECOGNITION','Part 3 · Đặt hàng văn phòng phẩm','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M: We''re running low on printer paper and toner cartridges.
W: I placed an order yesterday, but the supplier said delivery might take a week.
M: A week? Maybe we should try a different supplier.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M: We''re running low on printer paper and toner cartridges.\\nW: I placed an order yesterday, but the supplier said delivery might take a week.\\nM: A week? Maybe we should try a different supplier.","transcript":"M: We''re running low on printer paper and toner cartridges.\\nW: I placed an order yesterday, but the supplier said delivery might take a week.\\nM: A week? Maybe we should try a different supplier.","questions":[{"question":"What is running low?","answer":"Giấy in và mực in."},{"question":"When did the woman place the order?","answer":"Hôm qua."},{"question":"What does the man suggest?","answer":"Thử nhà cung cấp khác."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','dad966d9d134153a577fe96867768bba767f0482',1);
INSERT IGNORE INTO global_learning_items (external_key,item_type,term,meaning_vi,definition_en,example_en,example_vi,topic,level,metadata_json,content_hash,is_active) VALUES
('hbk-listening-p3-group-12','LISTENING_RECOGNITION','Part 3 · Hội thoại 3 người','Hội thoại TOEIC Part 3 — nghe và trả lời 3 câu hỏi.','Đọc câu hỏi trước khi nghe; câu hỏi thường đi theo thứ tự nội dung.','M1: The client wants to move the project deadline up by two weeks.
W: That''s really tight. We''d have to bring in additional staff.
M2: Or we could outsource part of the design work. That might be faster.','','TOEIC Part 3','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part3","toeic_part":3,"audio_text":"M1: The client wants to move the project deadline up by two weeks.\\nW: That''s really tight. We''d have to bring in additional staff.\\nM2: Or we could outsource part of the design work. That might be faster.","transcript":"M1: The client wants to move the project deadline up by two weeks.\\nW: That''s really tight. We''d have to bring in additional staff.\\nM2: Or we could outsource part of the design work. That might be faster.","questions":[{"question":"What does the client want?","answer":"Đẩy sớm hạn 2 tuần."},{"question":"What does the woman suggest?","answer":"Thêm nhân sự."},{"question":"What is the second man''s alternative?","answer":"Thuê ngoài phần thiết kế."}],"tags":"toeic,800-plus,listening,part3","source":"TOEIC Listening 100 câu user handbook"}','016a84707c7e762acd067429cd6f70523eaa7afa',1),
('hbk-listening-p4-group-01','LISTENING_RECOGNITION','Part 4 · Tin nhắn thoại (Telephone message)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference.","transcript":"Hi, this is Laura from Greenfield Supplies. I''m calling to let you know that the office furniture you ordered has arrived at our warehouse. You can pick it up anytime between 9 A.M. and 6 P.M., or we can arrange delivery for an additional fee. Please call us back at 555-0172 to let us know your preference.","questions":[{"question":"Why is the speaker calling?","answer":"Thông báo hàng đã đến kho."},{"question":"What are the pickup hours?","answer":"9 giờ sáng đến 6 giờ chiều."},{"question":"What should the listener do?","answer":"Gọi lại để cho biết lựa chọn."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','d84b4e7bc0dfe592dc0048331bffb6c3c035816f',1),
('hbk-listening-p4-group-02','LISTENING_RECOGNITION','Part 4 · Thông báo nội bộ (Company announcement)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR.","transcript":"Attention, all employees. Starting next Monday, the company parking lot on Oak Street will be closed for resurfacing. This work is expected to take approximately two weeks. During this time, please use the public parking garage on Elm Street. The company will reimburse parking fees — just submit your receipts to HR.","questions":[{"question":"What will happen next Monday?","answer":"Bãi đỗ xe đóng cửa."},{"question":"How long will the work take?","answer":"Khoảng hai tuần."},{"question":"How can employees get reimbursed?","answer":"Nộp biên lai cho HR."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','bdc2686ddbfa113815fddb4634ccf3e236def25e',1),
('hbk-listening-p4-group-03','LISTENING_RECOGNITION','Part 4 · Quảng cáo (Advertisement)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com.","transcript":"Are you looking for a way to improve your team''s productivity? TaskMaster Pro is the project management tool used by over 10,000 companies worldwide. With features like real-time collaboration, automated reporting, and mobile access, your team can work smarter, not harder. Sign up for a free 30-day trial at taskmaster.com.","questions":[{"question":"What is being advertised?","answer":"Công cụ quản lý dự án."},{"question":"How many companies use the product?","answer":"Hơn 10.000."},{"question":"What is offered to new users?","answer":"Dùng thử miễn phí 30 ngày."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','0effbb451fb93bd1c90c92c6feba5f3283828c25',1),
('hbk-listening-p4-group-04','LISTENING_RECOGNITION','Part 4 · Hướng dẫn tour (Tour guide)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes.","transcript":"Welcome to the Riverside Museum of Art. Today''s tour will begin in the East Wing, where we''ll see the new contemporary art exhibition. Then we''ll move to the sculpture garden on the second floor. Please note that photography is not permitted in the East Wing, but you''re welcome to take photos in all other areas. The tour will last approximately 90 minutes.","questions":[{"question":"Where will the tour start?","answer":"Cánh Đông (East Wing)."},{"question":"What is NOT allowed in the East Wing?","answer":"Chụp ảnh."},{"question":"How long is the tour?","answer":"Khoảng 90 phút."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','c855698fc82851a30dbc44c178c973e1999bd5e4',1),
('hbk-listening-p4-group-05','LISTENING_RECOGNITION','Part 4 · Tin tức (News report)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year.","transcript":"In local business news, Hartfield Industries announced today that it will open a new manufacturing plant in Riverside County. The facility is expected to create over 500 jobs in the area. Construction will begin in March, with operations scheduled to start by the end of the year.","questions":[{"question":"What did Hartfield Industries announce?","answer":"Mở nhà máy mới."},{"question":"How many jobs will be created?","answer":"Hơn 500."},{"question":"When will construction begin?","answer":"Tháng 3."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','4b5ab427613d173e334666b17abbb7e30c8d297c',1),
('hbk-listening-p4-group-06','LISTENING_RECOGNITION','Part 4 · Tin nhắn thoại (Voicemail)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today.","transcript":"Hello, Mr. Nakamura. This is Diane from City Auto Repair. Your car is ready for pickup. We replaced the brake pads and also noticed that your front tires are quite worn, so we''d recommend replacing those soon. Your total comes to $285. We''re open until 7 P.M. today.","questions":[{"question":"Why is the speaker calling?","answer":"Thông báo xe đã sửa xong."},{"question":"What additional recommendation is made?","answer":"Thay lốp trước."},{"question":"How much is the total?","answer":"$285."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','522a69823dd5dab75382a7bd19622c9aebeff0dd',1),
('hbk-listening-p4-group-07','LISTENING_RECOGNITION','Part 4 · Giới thiệu diễn giả (Introduction)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell.","transcript":"It''s my pleasure to introduce today''s keynote speaker, Dr. Sarah Mitchell. Dr. Mitchell is the author of three best-selling books on leadership and has over 20 years of experience in organizational management. She currently serves as the dean of the Business School at Western University. Please join me in welcoming Dr. Mitchell.","questions":[{"question":"Who is Dr. Mitchell?","answer":"Tác giả, diễn giả chính."},{"question":"How many books has she written?","answer":"3 cuốn."},{"question":"What is her current position?","answer":"Trưởng khoa Kinh doanh, ĐH Western."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','6a2e236d561ebf6af3d7dfe9a08948dd05f2e276',1),
('hbk-listening-p4-group-08','LISTENING_RECOGNITION','Part 4 · Thông báo tự động (Recorded message)','Bài nói TOEIC Part 4 — nghe và trả lời 3 câu hỏi.','Xác định dạng bài ngay đầu, chú ý purpose và next action.','Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience.','','TOEIC Part 4','B1-B2','{"handbook_code":"listening-800","handbook_section":"listening-part4","toeic_part":4,"audio_text":"Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience.","transcript":"Thank you for calling Sunrise Airlines. Due to the severe weather conditions, all flights departing from Terminal 2 have been delayed by approximately two hours. Passengers are advised to check our website or mobile app for the latest updates. We apologize for any inconvenience.","questions":[{"question":"Why are flights delayed?","answer":"Thời tiết xấu."},{"question":"How long is the delay?","answer":"Khoảng 2 tiếng."},{"question":"What are passengers advised to do?","answer":"Kiểm tra website hoặc app."}],"tags":"toeic,800-plus,listening,part4","source":"TOEIC Listening 100 câu user handbook"}','0fec314df881c6b0e8c495bff4726884f74e4f1b',1);
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-01',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-01';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-02',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-02';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-03',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-03';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-04',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-04';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-05',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-05';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-06',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-06';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-07',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-07';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-08',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-08';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-09',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-09';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-10',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-10';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-11',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-11';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-12',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-12';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-13',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-13';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-14',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-14';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-15',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-15';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-grammar-16',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='grammar-800' AND s.section_key='grammar-16';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-accommodate',1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-acknowledge',2 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-acquire',3 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-address',4 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-administer',5 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-advertise',6 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-advise',7 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-afford',8 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-allocate',9 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-announce',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-anticipate',11 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-apologize',12 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-apply',13 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-apply',13 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-appoint',14 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-appreciate',15 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-approve',16 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-arise',17 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-assemble',18 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-assess',19 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-assign',20 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-assist',21 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-attach',22 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-attend',23 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-attend',23 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-authorize',24 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-bear',25 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-beat',26 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-become',27 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-begin',28 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-bend',29 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-bid',30 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-bind',31 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-boost',32 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-break',33 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-bring',34 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-broadcast',35 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-build',36 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-buy',37 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-calculate',38 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-catch',39 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-charge',40 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-choose',41 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-clarify',42 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-collaborate',43 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-come',44 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-commend',45 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-commit',46 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-communicate',47 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-compensate',48 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-compete',49 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-comply',50 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-comply',50 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-conduct',51 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-confirm',52 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-consider',53 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-consult',54 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-contribute',55 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-contribute',55 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-coordinate',56 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-correspond',57 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-cost',58 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-cut',59 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-deal',60 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-decline',61 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-delegate',62 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-deliver',63 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-demolish',64 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-demonstrate',65 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-deposit',66 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-designate',67 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-detect',68 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-determine',69 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-develop',70 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-discard',71 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-disclose',72 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-discount',73 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-dismiss',74 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-dispatch',75 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-display',76 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-dispose',77 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-distribute',78 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-do',79 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-dominate',80 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-draw',81 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-drink',82 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-drive',83 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-eat',84 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-eliminate',85 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-emphasize',86 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-encounter',87 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-encourage',88 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-enforce',89 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-engage',90 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-enhance',91 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-enroll',92 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-ensure',93 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-equip',94 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-establish',95 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-estimate',96 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-evaluate',97 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-exceed',98 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-exchange',99 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-execute',100 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-expand',101 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-facilitate',102 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-fall',103 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-feed',104 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-feel',105 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-fight',106 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-finance',107 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-find',108 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-fly',109 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-forbid',110 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-forecast',111 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-forecast',111 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-forget',112 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-forgive',113 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-forward',114 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-freeze',115 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-generate',116 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-get',117 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-give',118 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-go',119 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-grow',120 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-guarantee',121 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-have',122 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-hear',123 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-hide',124 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-hit',125 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-hold',126 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-hurt',127 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-implement',128 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-impose',129 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-indicate',130 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-initiate',131 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-inquire',132 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-inspect',133 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-install',134 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-instruct',135 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-interview',136 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-invest',137 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-invoice',138 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-keep',139 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-know',140 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-launch',141 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-lay',142 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-lead',143 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-leave',144 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-lend',145 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-let',146 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-lie',147 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-load',148 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-locate',149 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-lose',150 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-maintain',151 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-make',152 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-manufacture',153 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-maximize',154 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-mean',155 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-meet',156 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-mention',157 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-merge',158 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-minimize',159 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-mistake',160 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-modify',161 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-monitor',162 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-negotiate',163 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-notify',164 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-obtain',165 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-occupy',166 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-operate',167 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-organize',168 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-outline',169 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-outsource',170 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-overcome',171 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-overlook',172 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-oversee',173 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-overtake',174 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-owe',175 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-participate',176 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-pay',177 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-pay',177 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-permit',178 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-persuade',179 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-postpone',180 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-praise',181 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-prefer',182 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-preserve',183 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-proceed',184 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-process',185 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-prohibit',186 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-promote',187 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-propose',188 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-purchase',189 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-put',190 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-quit',191 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-quote',192 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-read',193 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-recommend',194 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-reconstruct',195 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-recruit',196 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-reduce',197 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-refer',198 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-refer',198 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-refund',199 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-refurbish',200 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-register',201 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-regulate',202 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-reimburse',203 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-release',204 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-relocate',205 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-remind',206 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-remodel',207 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-renew',208 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-renovate',209 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-repair',210 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-replace',211 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-represent',212 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-request',213 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-require',214 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-reserve',215 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-resign',216 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-resolve',217 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-respond',218 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-restore',219 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-restrict',220 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-resume',221 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-retain',222 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-retrieve',223 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-revise',224 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-ride',225 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-rise',226 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-run',227 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-say',228 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-schedule',229 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-schedule',229 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-secure',230 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-see',231 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-seek',232 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-sell',233 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-send',234 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-set',235 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-shake',236 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-ship',237 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-show',238 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-shrink',239 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-shut',240 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-sit',241 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-speak',242 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-specify',243 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-spend',244 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-split',245 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-sponsor',246 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-spread',247 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-stand',248 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-steal',249 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-stick',250 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-stock',251 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-store',252 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-streamline',253 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-strike',254 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-submit',255 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-submit',255 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-collocations';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-subscribe',256 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-suggest',257 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-supervise',258 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-supply',259 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-surpass',260 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-suspend',261 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-sustain',262 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-swear',263 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-sweep',264 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-swim',265 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-take',266 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-teach',267 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-tear',268 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-tell',269 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-terminate',270 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-think',271 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-throw',272 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-transfer',273 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-transform',274 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-undergo',275 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-understand',276 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-undertake',277 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-undo',278 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-update',279 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-upgrade',280 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-uphold',281 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-utilize',282 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-validate',283 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-verify',284 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-volunteer',285 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-waive',286 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-wear',287 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-win',288 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-withdraw',289 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-withhold',290 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-withstand',291 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-wrap',292 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-essential';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-verb-write',293 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='verb-800' AND s.section_key='verb-irregular';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-001',1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-002',2 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-003',3 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-004',4 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-005',5 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-006',6 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-007',7 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-008',8 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-009',9 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p1-010',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part1';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-011',11 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-012',12 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-013',13 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-014',14 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-015',15 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-016',16 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-017',17 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-018',18 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-019',19 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-020',20 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-021',21 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-022',22 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-023',23 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-024',24 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-025',25 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-026',26 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-027',27 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-028',28 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-029',29 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-030',30 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-031',31 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-032',32 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-033',33 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-034',34 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-035',35 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-036',36 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-037',37 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-038',38 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-039',39 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p2-040',40 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part2';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-01',1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-02',2 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-03',3 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-04',4 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-05',5 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-06',6 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-07',7 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-08',8 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-09',9 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-10',10 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-11',11 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p3-group-12',12 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part3';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-01',1 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-02',2 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-03',3 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-04',4 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-05',5 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-06',6 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-07',7 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
INSERT IGNORE INTO handbook_section_items(section_id,item_external_key,sort_order) SELECT s.id,'hbk-listening-p4-group-08',8 FROM learning_handbook_sections s JOIN learning_handbooks h ON h.id=s.handbook_id WHERE h.code='listening-800' AND s.section_key='listening-part4';
