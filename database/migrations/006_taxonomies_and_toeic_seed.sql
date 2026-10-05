-- Lightweight taxonomies for TOEIC learning; no user data is modified.
CREATE TABLE IF NOT EXISTS learning_topics (
    code VARCHAR(64) NOT NULL,
    title VARCHAR(120) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    PRIMARY KEY (code), KEY idx_learning_topic_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS grammar_topics (
    code VARCHAR(64) NOT NULL,
    title VARCHAR(120) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    PRIMARY KEY (code), KEY idx_grammar_topic_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO learning_topics(code,title,sort_order) VALUES
('OFFICE','Office',10),('WORKPLACE','Workplace',20),('MEETINGS','Meetings',30),('HR','HR',40),('RECRUITMENT','Recruitment',50),('BUSINESS','Business',60),('CONTRACTS','Contracts',70),('BANKING','Banking',80),('FINANCE','Finance',90),('MARKETING','Marketing',100),('ADVERTISING','Advertising',110),('SALES','Sales',120),('CUSTOMER_SERVICE','Customer Service',130),('SHOPPING','Shopping',140),('RETAIL','Retail',150),('RESTAURANTS','Restaurants',160),('HOTELS','Hotels',170),('TRAVEL','Travel',180),('AIRPORTS','Airports',190),('TRANSPORTATION','Transportation',200),('SHIPPING','Shipping',210),('DELIVERY','Delivery',220),('MANUFACTURING','Manufacturing',230),('CONSTRUCTION','Construction',240),('TECHNOLOGY','Technology',250),('HEALTHCARE','Healthcare',260),('CONFERENCE','Conference',270),('EVENTS','Events',280),('REAL_ESTATE','Real Estate',290),('MAINTENANCE','Maintenance',300)
ON DUPLICATE KEY UPDATE title=VALUES(title),sort_order=VALUES(sort_order);

INSERT INTO grammar_topics(code,title,sort_order) VALUES
('PARTS_OF_SPEECH','Parts of Speech',10),('WORD_FORMS','Word Forms',20),('SUBJECT_VERB_AGREEMENT','Subject–Verb Agreement',30),('TENSES','Tenses',40),('PASSIVE_VOICE','Passive Voice',50),('PREPOSITIONS','Prepositions',60),('CONJUNCTIONS','Conjunctions',70),('GERUNDS','Gerunds',80),('INFINITIVES','Infinitives',90),('RELATIVE_CLAUSES','Relative Clauses',100),('PARTICIPLES','Participles',110),('PRONOUNS','Pronouns',120),('COMPARATIVES','Comparatives',130),('CONDITIONALS','Conditionals',140),('NOUN_CLAUSES','Noun Clauses',150),('ADVERB_CLAUSES','Adverb Clauses',160)
ON DUPLICATE KEY UPDATE title=VALUES(title),sort_order=VALUES(sort_order);

INSERT INTO learning_modules(course_id,code,title,description,sort_order)
SELECT id,'OFFICE','Office & Workplace','Vocabulary and collocations for office communication.',10 FROM learning_courses WHERE code='VOCAB_FOUNDATION'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_modules(course_id,code,title,description,sort_order)
SELECT id,'GRAMMAR_CORE','Grammar Core','High-frequency TOEIC grammar patterns.',10 FROM learning_courses WHERE code='GRAMMAR_FOUNDATION'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_modules(course_id,code,title,description,sort_order)
SELECT id,'LISTENING_RECOGNITION','Listening Recognition','Word → phrase → sentence → dictation → shadowing.',10 FROM learning_courses WHERE code='LISTENING_FOUNDATION'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_modules(course_id,code,title,description,sort_order)
SELECT id,'PART_1_7','TOEIC Part 1–7','Architecture and practice flow for all TOEIC parts.',10 FROM learning_courses WHERE code='TOEIC_FOUNDATION'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);

INSERT INTO learning_lessons(module_id,code,title,description,sort_order)
SELECT id,'OFFICE_BASICS','Office Basics','Core office vocabulary and common collocations.',10 FROM learning_modules WHERE code='OFFICE'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_lessons(module_id,code,title,description,sort_order)
SELECT id,'MEETINGS','Meetings','Meeting vocabulary, scheduling and announcements.',20 FROM learning_modules WHERE code='OFFICE'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_lessons(module_id,code,title,description,sort_order)
SELECT id,'WORD_FORMS','Word Forms','Recognize noun/verb/adjective/adverb forms in TOEIC Part 5.',10 FROM learning_modules WHERE code='GRAMMAR_CORE'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_lessons(module_id,code,title,description,sort_order)
SELECT id,'PREPOSITIONS','Prepositions','High-frequency preposition patterns.',20 FROM learning_modules WHERE code='GRAMMAR_CORE'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
INSERT INTO learning_lessons(module_id,code,title,description,sort_order)
SELECT id,'SHORT_SENTENCES','Short Sentences','Blind listening, transcript check, chunking and shadowing.',10 FROM learning_modules WHERE code='LISTENING_RECOGNITION'
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);

-- Small high-quality Part 5 seed. This exists only to prove the TOEIC architecture works without an external API.
INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',1,'Employees are responsible ____ maintaining office equipment.','at','for','with','to','B','The pattern is “be responsible for + N/V-ing”.','Office','PREPOSITIONS','pattern,part5',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='Employees are responsible ____ maintaining office equipment.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',1,'We look forward to ____ from you soon.','hear','hearing','heard','have heard','B','“look forward to” is followed by a noun or V-ing.','Business','GERUNDS','pattern,part5',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='We look forward to ____ from you soon.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'The manager asked the staff ____ the report before noon.','submit','submitted','to submit','submitting','C','“ask someone to + V” is the required pattern.','Office','INFINITIVES','pattern,part5',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='The manager asked the staff ____ the report before noon.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'The conference room ____ before the guests arrived.','prepared','was prepared','has preparing','prepare','B','The room receives the action, so passive voice is needed.','Conference','PASSIVE_VOICE','part5,passive',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='The conference room ____ before the guests arrived.');

INSERT INTO toeic_questions(part,question_type,difficulty,question,option_a,option_b,option_c,option_d,correct_option,explanation,topic,grammar_category,tags,is_published)
SELECT 5,'multiple_choice',2,'Please submit the application ____ Friday.','by','during','among','beside','A','“by Friday” means no later than Friday.','Recruitment','PREPOSITIONS','part5,deadline',1
WHERE NOT EXISTS (SELECT 1 FROM toeic_questions WHERE part=5 AND question='Please submit the application ____ Friday.');
