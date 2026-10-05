-- Migration 008: Curated TOEIC sentence-pattern library with examples shown directly under each pattern.
-- Additive and idempotent. Does not alter user flashcards or SRS progress.

CREATE TABLE IF NOT EXISTS sentence_pattern_library (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    pattern_key VARCHAR(80) NOT NULL,
    pattern VARCHAR(255) NOT NULL,
    meaning_vi VARCHAR(500) NOT NULL,
    grammar_note VARCHAR(1000) NULL,
    example_en VARCHAR(700) NOT NULL,
    example_vi VARCHAR(700) NOT NULL,
    topic VARCHAR(120) NOT NULL DEFAULT 'General',
    toeic_part TINYINT UNSIGNED NULL,
    difficulty TINYINT UNSIGNED NOT NULL DEFAULT 2,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_sentence_pattern_key (pattern_key),
    KEY idx_sentence_pattern_active_topic (is_active,topic,sort_order),
    KEY idx_sentence_pattern_part (toeic_part,is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO sentence_pattern_library
(pattern_key,pattern,meaning_vi,grammar_note,example_en,example_vi,topic,toeic_part,difficulty,sort_order,is_active)
VALUES
('be-responsible-for','be responsible for + N/V-ing','chịu trách nhiệm về / chịu trách nhiệm làm việc gì','"for" là giới từ nên theo sau bởi danh từ hoặc V-ing.','She is responsible for training new employees.','Cô ấy chịu trách nhiệm đào tạo nhân viên mới.','Office',5,1,10,1),
('look-forward-to','look forward to + N/V-ing','mong chờ điều gì / mong được làm gì','"to" trong cấu trúc này là giới từ, không phải dấu hiệu của động từ nguyên mẫu.','We look forward to hearing from you soon.','Chúng tôi mong sớm nhận được phản hồi từ bạn.','Email',5,1,20,1),
('be-required-to','be required to + V','được yêu cầu / bắt buộc phải làm gì','Sau "to" dùng động từ nguyên mẫu. Thường xuất hiện trong quy định và thông báo.','All visitors are required to wear an identification badge.','Tất cả khách đến thăm được yêu cầu đeo thẻ nhận dạng.','Policy',5,1,30,1),
('be-scheduled-to','be scheduled to + V','được lên lịch để làm gì','Dùng cho sự kiện, cuộc họp, chuyến bay hoặc công việc đã có lịch.','The conference is scheduled to begin at nine o’clock.','Hội nghị được lên lịch bắt đầu lúc chín giờ.','Meetings',5,1,40,1),
('be-expected-to','be expected to + V','được kỳ vọng / dự kiến sẽ làm gì','Có thể diễn tả nghĩa vụ nhẹ hoặc dự đoán theo kế hoạch.','Employees are expected to submit their reports by Friday.','Nhân viên được yêu cầu nộp báo cáo trước thứ Sáu.','Office',5,2,50,1),
('be-eligible-for','be eligible for + N','đủ điều kiện nhận / tham gia điều gì','"eligible" thường đi với giới từ "for".','Full-time employees are eligible for the annual bonus.','Nhân viên toàn thời gian đủ điều kiện nhận thưởng hằng năm.','HR',5,2,60,1),
('be-aware-of','be aware of + N','nhận thức / biết về điều gì','"aware" đi với "of" khi nói về thông tin, rủi ro hoặc tình huống.','Please be aware of the revised parking regulations.','Vui lòng lưu ý các quy định đỗ xe đã được sửa đổi.','Policy',5,2,70,1),
('be-likely-to','be likely to + V','có khả năng sẽ làm / xảy ra','Dùng để diễn tả xác suất hoặc dự đoán.','Sales are likely to increase during the holiday season.','Doanh số có khả năng tăng trong mùa lễ hội.','Sales',5,2,80,1),
('be-able-to','be able to + V','có thể / có khả năng làm gì','Có thể thay cho "can" ở những thì mà "can" không dùng được.','Staff will be able to process orders faster with the new software.','Nhân viên sẽ có thể xử lý đơn hàng nhanh hơn với phần mềm mới.','Technology',5,1,90,1),
('be-interested-in','be interested in + N/V-ing','quan tâm / hứng thú với điều gì','"in" là giới từ nên theo sau bởi danh từ hoặc V-ing.','Several clients are interested in purchasing the upgraded package.','Một số khách hàng quan tâm đến việc mua gói nâng cấp.','Sales',5,1,100,1),
('be-in-charge-of','be in charge of + N/V-ing','phụ trách / chịu trách nhiệm quản lý','Dùng để nói người trực tiếp phụ trách một bộ phận, nhiệm vụ hoặc hoạt động.','Mr. Lee is in charge of coordinating the annual conference.','Ông Lee phụ trách điều phối hội nghị thường niên.','Office',5,1,110,1),
('be-familiar-with','be familiar with + N','quen thuộc / thông thạo điều gì','"familiar" thường đi với "with" khi nói về kiến thức hoặc kinh nghiệm.','Applicants should be familiar with spreadsheet software.','Ứng viên nên quen thuộc với phần mềm bảng tính.','HR',5,2,120,1),
('ask-someone-to','ask + someone + to + V','yêu cầu / nhờ ai làm gì','Sau tân ngữ chỉ người dùng "to + V".','The manager asked the staff to submit the report before noon.','Quản lý yêu cầu nhân viên nộp báo cáo trước buổi trưa.','Office',5,1,130,1),
('allow-someone-to','allow + someone + to + V','cho phép ai làm gì','Không dùng "allow someone doing" trong cấu trúc chuẩn này.','The new policy allows employees to work remotely twice a week.','Chính sách mới cho phép nhân viên làm việc từ xa hai ngày mỗi tuần.','Policy',5,2,140,1),
('encourage-someone-to','encourage + someone + to + V','khuyến khích ai làm gì','Động từ "encourage" thường theo sau bởi tân ngữ + to-infinitive.','Supervisors encourage staff to attend professional training courses.','Các giám sát viên khuyến khích nhân viên tham gia các khóa đào tạo chuyên môn.','HR',5,2,150,1),
('remind-someone-to','remind + someone + to + V','nhắc ai làm gì','Dùng cho lời nhắc về nhiệm vụ hoặc thời hạn.','Please remind the client to sign the revised contract.','Vui lòng nhắc khách hàng ký hợp đồng đã sửa đổi.','Email',5,1,160,1),
('enable-someone-to','enable + someone + to + V','giúp / cho phép ai có khả năng làm gì','Thường dùng trong ngữ cảnh công nghệ, quy trình và năng lực.','The mobile app enables customers to track deliveries in real time.','Ứng dụng di động cho phép khách hàng theo dõi giao hàng theo thời gian thực.','Technology',5,2,170,1),
('prevent-someone-from','prevent + someone/something + from + V-ing','ngăn ai / điều gì làm việc gì','Sau "from" dùng V-ing.','Regular maintenance prevents the equipment from breaking down unexpectedly.','Bảo trì thường xuyên giúp ngăn thiết bị hỏng đột ngột.','Maintenance',5,2,180,1),
('apologize-for','apologize for + N/V-ing','xin lỗi vì điều gì / vì đã làm gì','Sau "for" dùng danh từ hoặc V-ing.','We apologize for causing any inconvenience during the renovation.','Chúng tôi xin lỗi vì đã gây bất tiện trong thời gian cải tạo.','Customer Service',5,1,190,1),
('thank-someone-for','thank + someone + for + N/V-ing','cảm ơn ai vì điều gì / vì đã làm gì','Sau "for" dùng danh từ hoặc V-ing.','Thank you for taking the time to complete our survey.','Cảm ơn bạn đã dành thời gian hoàn thành khảo sát của chúng tôi.','Customer Service',5,1,200,1),
('due-to','due to + N','do / bởi vì điều gì','"due to" theo sau bởi danh từ/cụm danh từ; không dùng trực tiếp trước một mệnh đề đầy đủ.','The flight was delayed due to severe weather conditions.','Chuyến bay bị hoãn do điều kiện thời tiết xấu.','Travel',5,1,210,1),
('because-of','because of + N/V-ing','bởi vì / do','Khác với "because + clause", "because of" đi với danh từ hoặc V-ing.','The meeting was postponed because of a scheduling conflict.','Cuộc họp bị hoãn do xung đột lịch trình.','Meetings',5,1,220,1),
('in-order-to','in order to + V','để / nhằm làm gì','Dùng để diễn tả mục đích; trang trọng hơn "to + V".','The company upgraded its servers in order to improve system security.','Công ty nâng cấp máy chủ nhằm cải thiện bảo mật hệ thống.','Technology',5,1,230,1),
('so-that','so that + S + can/could/will/would + V','để mà / nhằm để một chủ thể có thể làm gì','Sau "so that" là một mệnh đề đầy đủ có chủ ngữ và động từ.','Please arrive early so that we can begin the presentation on time.','Vui lòng đến sớm để chúng ta có thể bắt đầu bài thuyết trình đúng giờ.','Meetings',5,2,240,1),
('as-soon-as','as soon as + clause','ngay khi','Dùng để nối hai hành động; trong mệnh đề thời gian nói về tương lai thường dùng hiện tại đơn.','We will contact you as soon as the shipment arrives.','Chúng tôi sẽ liên hệ với bạn ngay khi lô hàng đến.','Shipping',5,2,250,1),
('unless','unless + clause','trừ khi / nếu không','"unless" mang nghĩa gần với "if ... not".','The order will be cancelled unless payment is received by Monday.','Đơn hàng sẽ bị hủy nếu không nhận được thanh toán trước thứ Hai.','Sales',5,2,260,1),
('provided-that','provided that + clause','miễn là / với điều kiện là','Dùng để nêu điều kiện cần được đáp ứng.','Employees may work from home provided that their manager approves the request.','Nhân viên có thể làm việc tại nhà với điều kiện quản lý phê duyệt yêu cầu.','Policy',5,3,270,1),
('although','although + clause','mặc dù','Theo sau bởi một mệnh đề đầy đủ. Không dùng "although + noun".','Although demand was high, the company maintained stable prices.','Mặc dù nhu cầu cao, công ty vẫn duy trì mức giá ổn định.','Sales',5,1,280,1),
('despite','despite + N/V-ing','mặc dù / bất chấp','Khác với "although", "despite" theo sau bởi danh từ hoặc V-ing.','Despite experiencing delays, the team completed the project on time.','Mặc dù gặp chậm trễ, nhóm vẫn hoàn thành dự án đúng hạn.','Projects',5,2,290,1),
('neither-nor','neither + N + nor + N + V','cả ... lẫn ... đều không','Động từ thường hòa hợp với chủ ngữ gần nó nhất trong cấu trúc neither...nor.','Neither the manager nor the assistants were informed of the change.','Cả quản lý lẫn các trợ lý đều không được thông báo về thay đổi.','Grammar',5,3,300,1),
('either-or','either + N + or + N + V','hoặc ... hoặc ...','Động từ thường hòa hợp với chủ ngữ gần nó nhất.','Either the supervisor or the technicians are available to assist you.','Hoặc giám sát viên hoặc các kỹ thuật viên có thể hỗ trợ bạn.','Grammar',5,3,310,1),
('not-only-but-also','not only + A + but also + B','không chỉ ... mà còn ...','Hai thành phần A và B nên song song về mặt ngữ pháp.','The new system is not only faster but also more secure.','Hệ thống mới không chỉ nhanh hơn mà còn an toàn hơn.','Technology',5,2,320,1),
('the-more-the-more','the + comparative..., the + comparative...','càng ... thì càng ...','Hai vế đều dùng dạng so sánh hơn.','The more efficiently we process orders, the more satisfied our customers become.','Chúng ta xử lý đơn hàng càng hiệu quả thì khách hàng càng hài lòng.','Customer Service',5,3,330,1),
('too-to','too + adjective/adverb + to + V','quá ... để có thể làm gì','Diễn tả mức độ khiến hành động phía sau không thể hoặc khó xảy ra.','The package is too large to fit in the standard mailbox.','Gói hàng quá lớn để vừa hộp thư tiêu chuẩn.','Shipping',5,2,340,1),
('adj-enough-to','adjective/adverb + enough + to + V','đủ ... để làm gì','"enough" đứng sau tính từ/trạng từ trong mẫu này.','The conference room is large enough to accommodate fifty guests.','Phòng hội nghị đủ lớn để chứa năm mươi khách.','Meetings',5,2,350,1),
('have-something-done','have + object + past participle','nhờ / thuê người khác làm việc gì cho mình','Dùng khi chủ thể sắp xếp để người khác thực hiện dịch vụ.','We had the office air conditioner repaired yesterday.','Hôm qua chúng tôi đã cho sửa máy điều hòa văn phòng.','Office',5,3,360,1),
('recommend-v-ing','recommend + V-ing / recommend that + S + V','đề nghị / khuyến nghị làm gì','Không dùng "recommend someone to do" trong cách dùng chuẩn thông dụng.','The consultant recommends reviewing the contract before signing it.','Chuyên gia tư vấn khuyến nghị xem lại hợp đồng trước khi ký.','Business',5,3,370,1),
('suggest-v-ing','suggest + V-ing / suggest that + S + V','đề xuất làm gì','Sau "suggest" thường dùng V-ing hoặc mệnh đề that; không dùng "suggest to do".','She suggested moving the meeting to Friday afternoon.','Cô ấy đề xuất chuyển cuộc họp sang chiều thứ Sáu.','Meetings',5,2,380,1),
('avoid-v-ing','avoid + V-ing','tránh làm gì','"avoid" theo sau bởi V-ing, không dùng to-infinitive.','Please avoid using personal devices on the secure network.','Vui lòng tránh sử dụng thiết bị cá nhân trên mạng bảo mật.','Technology',5,1,390,1),
('consider-v-ing','consider + V-ing','cân nhắc làm gì','"consider" thường theo sau bởi V-ing khi nói về một hành động được cân nhắc.','The company is considering opening a new branch downtown.','Công ty đang cân nhắc mở một chi nhánh mới ở trung tâm.','Business',5,2,400,1)
ON DUPLICATE KEY UPDATE
pattern=VALUES(pattern),meaning_vi=VALUES(meaning_vi),grammar_note=VALUES(grammar_note),example_en=VALUES(example_en),example_vi=VALUES(example_vi),topic=VALUES(topic),toeic_part=VALUES(toeic_part),difficulty=VALUES(difficulty),sort_order=VALUES(sort_order),is_active=VALUES(is_active);
