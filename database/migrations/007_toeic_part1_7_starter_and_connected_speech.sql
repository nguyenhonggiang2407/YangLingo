-- Migration 007: TOEIC Part 1-7 starter practice items and Connected Speech seeds.
-- Additive and idempotent; safe for existing production databases.

CREATE TABLE IF NOT EXISTS connected_speech_examples (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	pattern_key VARCHAR(64) NOT NULL,
	title VARCHAR(160) NOT NULL,
	explanation VARCHAR(500) NOT NULL,
	phrase VARCHAR(255) NOT NULL,
	spoken_form VARCHAR(255) NOT NULL,
	category VARCHAR(80) NOT NULL DEFAULT 'linking',
	sort_order INT NOT NULL DEFAULT 0,
	is_active TINYINT(1) NOT NULL DEFAULT 1,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	UNIQUE KEY uq_connected_speech_pattern (pattern_key),
	KEY idx_connected_speech_active (is_active,sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO connected_speech_examples(pattern_key,title,explanation,phrase,spoken_form,category,sort_order,is_active)
VALUES
('consonant-vowel-linking','Phụ âm nối nguyên âm','Nối phụ âm cuối của từ trước vào nguyên âm đầu của từ sau.','pick it up','pick_it_up','linking',10,1),
('intrusive-y','Âm /y/ nối nhẹ','Sau nguyên âm /iː/ hoặc /aɪ/, một âm /y/ nhẹ có thể xuất hiện khi nối.','see it','see_y_it','linking',20,1),
('intrusive-w','Âm /w/ nối nhẹ','Sau nguyên âm tròn môi, âm /w/ nhẹ giúp chuyển sang nguyên âm kế tiếp.','go out','go_w_out','linking',30,1),
('t-flap','T mềm trong giọng Mỹ','/t/ giữa hai âm tiết có trọng âm thường nghe gần giống một âm /d/ rất nhanh.','water bottle','wader_bottle','reduction',40,1),
('and-reduction','Giảm âm trong and','Trong nhịp nói tự nhiên, and thường được rút gọn thành /ən/ hoặc /n/.','bread and butter','bread_n_butter','reduction',50,1),
('schwa-function-word','Schwa ở từ chức năng','Từ chức năng không nhấn thường giảm về âm schwa /ə/.','I can do it','I kən do it','reduction',60,1)
ON DUPLICATE KEY UPDATE title=VALUES(title),explanation=VALUES(explanation),phrase=VALUES(phrase),spoken_form=VALUES(spoken_form),category=VALUES(category),sort_order=VALUES(sort_order),is_active=VALUES(is_active);

-- Seed TOEIC Part 1 (Photographs)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,image_url,topic,grammar_category,tags,is_published)
SELECT 1,'multiple_choice',1,'Look at the office meeting image. Which statement best describes the scene?','A woman is writing notes on a whiteboard.','The team members are shaking hands.','The office desks are completely empty.','A technician is repairing a computer projector.','A','The presenter is actively writing on the whiteboard while colleagues listen. Options B, C, and D describe actions not present.','assets/toeic/part1-office-meeting.svg','Office','DISTRACTOR','part1,image,office',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=1 AND question='Look at the office meeting image. Which statement best describes the scene?');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,image_url,topic,grammar_category,tags,is_published)
SELECT 1,'multiple_choice',2,'Look at the warehouse image. Which statement best describes the scene?','Boxes are stacked neatly on wooden pallets.','A truck is driving through the warehouse doors.','Workers are assembling office furniture.','The warehouse floor is being mopped by a cleaner.','A','Boxes are clearly stacked on storage pallets. Watch out for distractors describing moving vehicles or unrelated maintenance.','assets/toeic/part1-warehouse-pallets.svg','Logistics','DISTRACTOR','part1,image,warehouse',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=1 AND question='Look at the warehouse image. Which statement best describes the scene?');

-- Seed TOEIC Part 2 (Question-Response)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,transcript,topic,grammar_category,tags,is_published)
SELECT 2,'multiple_choice',2,'When is the quarterly financial report due?','Yes, it was reported yesterday.','By the end of business on Friday.','In the main conference room on the second floor.','Mr. Harrison wrote it last week.','B','The question asks "When" (time deadline), so "By the end of business on Friday" directly answers. "Yes" cannot answer a WH-question, and "In the conference room" answers "Where".','Q: When is the quarterly financial report due?\n(A) Yes, it was reported yesterday.\n(B) By the end of business on Friday.\n(C) In the main conference room on the second floor.','Finance','PREPOSITIONS','part2,wh-question,deadline',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=2 AND question='When is the quarterly financial report due?');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,transcript,topic,grammar_category,tags,is_published)
SELECT 2,'multiple_choice',2,'Could you help me set up the projector for the presentation?','Certainly, I will be right there.','No, the presentation was very interesting.','The projector cost about five hundred dollars.','Turn left at the reception desk.','A','This is a polite request ("Could you help me...?"). "Certainly, I will be right there" accepts the request appropriately.','Q: Could you help me set up the projector for the presentation?\n(A) Certainly, I will be right there.\n(B) No, the presentation was very interesting.\n(C) The projector cost about five hundred dollars.','Office','LISTENING_RECOGNITION','part2,request,polite',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=2 AND question='Could you help me set up the projector for the presentation?');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,transcript,topic,grammar_category,tags,is_published)
SELECT 2,'multiple_choice',3,'Why hasn''t the shipment arrived yet?','The delivery driver got stuck in severe traffic.','At two o''clock this afternoon.','Yes, I shipped the package via express mail.','Twenty boxes in total.','A','The question asks for the reason of delay ("Why hasn''t the shipment arrived?"). Traffic congestion provides the logical reason.','Q: Why hasn''t the shipment arrived yet?\n(A) The delivery driver got stuck in severe traffic.\n(B) At two o''clock this afternoon.\n(C) Yes, I shipped the package via express mail.','Shipping','LISTENING_RECOGNITION','part2,why-question,shipping',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=2 AND question='Why hasn''t the shipment arrived yet?');

-- Seed TOEIC Part 3 (Conversations)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,transcript,topic,grammar_category,tags,is_published)
SELECT 3,'multiple_choice',2,'What problem does the woman mention regarding the client meeting?','The meeting room has been double-booked.','The client cancelled the contract.','The presentation slides contain errors.','The catering service arrived late.','A','The woman explains that another team is currently occupying Room 302 because of a scheduling conflict.','Man: Hi Sarah, are we ready for the 3 PM client presentation in Conference Room 302?\nWoman: Actually, Mark, we have a problem. The marketing team is holding their workshop there until 4 PM. It seems the room was double-booked.\nMan: Let me check with reception to see if Room 204 is available.','Meetings','LISTENING_RECOGNITION','part3,conversation,problem',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=3 AND question='What problem does the woman mention regarding the client meeting?');

-- Seed TOEIC Part 4 (Talks)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,transcript,topic,grammar_category,tags,is_published)
SELECT 4,'multiple_choice',2,'What is the main purpose of this announcement?','To notify employees of upcoming software maintenance.','To introduce a new marketing manager.','To announce a company holiday schedule.','To invite staff to an annual dinner.','A','The speaker announces that the internal server and email system will undergo scheduled maintenance tonight at 10 PM.','Attention all staff. Please be reminded that our IT department will be performing routine server maintenance tonight starting at 10 PM. During this four-hour window, company email and cloud storage will be temporarily inaccessible. Please save all work before leaving today.','Technology','LISTENING_RECOGNITION','part4,talk,announcement',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=4 AND question='What is the main purpose of this announcement?');

-- Seed TOEIC Part 5 (Incomplete Sentences - High Frequency Patterns)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'The marketing director requested that all department managers ____ their quarterly budgets by Monday.','finalize','finalized','finalizes','finalizing','A','Subjunctive mood after verbs of request/demand (request that S + V-bare). Therefore, the bare infinitive "finalize" is required regardless of the plural subject.','Office','WORD_FORMS','part5,subjunctive,request',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='The marketing director requested that all department managers ____ their quarterly budgets by Monday.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'Mr. Davies was commended for handling the client dispute ____ and professionally.','diplomatic','diplomatically','diplomacy','diplomat','B','The adverb "diplomatically" is needed to modify the gerund/action "handling", parallel with the adverb "professionally".','Customer Service','WORD_FORMS','part5,adverb,parallel',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='Mr. Davies was commended for handling the client dispute ____ and professionally.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',3,'____ the severe storm caused delays, the maintenance crew successfully restored power within two hours.','Although','Because','Despite','Unless','A','We need a subordinating conjunction introducing a clause of concession (subject + verb: "the storm caused..."). "Although" is correct; "Despite" takes a noun phrase.','Maintenance','CONJUNCTIONS','part5,conjunction,concession',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='____ the severe storm caused delays, the maintenance crew successfully restored power within two hours.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'The newly appointed CEO has implemented several policies to increase employee ____.','produce','productive','productivity','productively','C','After the noun modifier "employee", a noun is required to form a compound noun ("employee productivity" = năng suất nhân viên).','Management','WORD_FORMS','part5,noun,word-form',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='The newly appointed CEO has implemented several policies to increase employee ____.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'Neither the branch manager nor his assistants ____ informed about the change in regional policy.','was','were','is','have','B','With "Neither ... nor ...", the verb agrees with the closer subject ("his assistants" -> plural past verb "were").','Management','SUBJECT_VERB_AGREEMENT','part5,agreement,neither-nor',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='Neither the branch manager nor his assistants ____ informed about the change in regional policy.');

-- Seed TOEIC Part 6 (Text Completion)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,passage,topic,grammar_category,tags,is_published)
SELECT 6,'multiple_choice',2,'Select the best word to complete blank [1] in the email.','renovation','renovate','renovated','renovating','A','The noun "renovation" is needed after the adjective "extensive" as the subject of the sentence ("The extensive renovation of our headquarters...").','Dear Employees,\n\nWe are pleased to announce that the extensive [1] ____ of our central office will conclude ahead of schedule next Friday. All staff members are invited to inspect the new collaborative workspaces.\n\nSincerely,\nFacilities Management','Facilities','WORD_FORMS','part6,text-completion,noun',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=6 AND question='Select the best word to complete blank [1] in the email.');

-- Seed TOEIC Part 7 (Reading Comprehension)
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,passage,topic,grammar_category,tags,is_published)
SELECT 7,'multiple_choice',2,'According to the memo, what should employees do before leaving on Thursday?','Submit their expense receipts to accounting.','Back up all local computer files to the cloud.','Turn in their office security badges.','Attend a mandatory safety training session.','B','The memo explicitly states: "All personnel must ensure that local files are backed up to the secure cloud directory before departure on Thursday evening."','MEMORANDUM\nTo: All Staff\nFrom: Information Security Team\nDate: October 14\nSubject: Scheduled System Upgrade\n\nPlease note that our main network servers will undergo a security upgrade this Thursday at 7:00 PM. To prevent data loss, all personnel must ensure that local files are backed up to the secure cloud directory before departure on Thursday evening. Normal operations will resume at 8:00 AM on Friday.','Technology','READING_COMPREHENSION','part7,reading,detail',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=7 AND question='According to the memo, what should employees do before leaving on Thursday?');
