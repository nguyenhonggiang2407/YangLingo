-- Personal learning preferences, course/module/lesson catalog, and TOEIC question architecture.
CREATE TABLE IF NOT EXISTS learning_preferences (
    user_id BIGINT UNSIGNED NOT NULL,
    new_words_goal INT NOT NULL DEFAULT 15,
    grammar_goal INT NOT NULL DEFAULT 5,
    listening_goal INT NOT NULL DEFAULT 10,
    toeic_goal INT NOT NULL DEFAULT 10,
    mistake_review_goal INT NOT NULL DEFAULT 5,
    backlog_pause_threshold INT NOT NULL DEFAULT 60,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id),
    CONSTRAINT fk_learning_pref_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS learning_courses (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    code VARCHAR(64) NOT NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id), UNIQUE KEY uq_learning_course_code (code), KEY idx_learning_course_sort (is_active,sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS learning_modules (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    course_id BIGINT UNSIGNED NOT NULL,
    code VARCHAR(64) NOT NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    sort_order INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id), UNIQUE KEY uq_learning_module (course_id,code), KEY idx_learning_module_sort (course_id,sort_order),
    CONSTRAINT fk_learning_module_course FOREIGN KEY (course_id) REFERENCES learning_courses(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS learning_lessons (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    module_id BIGINT UNSIGNED NOT NULL,
    code VARCHAR(64) NOT NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    sort_order INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id), UNIQUE KEY uq_learning_lesson (module_id,code), KEY idx_learning_lesson_sort (module_id,sort_order),
    CONSTRAINT fk_learning_lesson_module FOREIGN KEY (module_id) REFERENCES learning_modules(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS learning_lesson_cards (
    lesson_id BIGINT UNSIGNED NOT NULL,
    card_id BIGINT UNSIGNED NOT NULL,
    position INT NOT NULL DEFAULT 0,
    PRIMARY KEY (lesson_id,card_id), KEY idx_learning_lesson_cards_pos (lesson_id,position), KEY idx_learning_lesson_card (card_id),
    CONSTRAINT fk_learning_lesson_cards_lesson FOREIGN KEY (lesson_id) REFERENCES learning_lessons(id) ON DELETE CASCADE,
    CONSTRAINT fk_learning_lesson_cards_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS toeic_questions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_by BIGINT UNSIGNED NULL,
    part TINYINT UNSIGNED NOT NULL,
    question_type VARCHAR(40) NOT NULL DEFAULT 'multiple_choice',
    difficulty TINYINT UNSIGNED NOT NULL DEFAULT 1,
    question TEXT NOT NULL,
    option_a TEXT NULL,
    option_b TEXT NULL,
    option_c TEXT NULL,
    option_d TEXT NULL,
    correct_option CHAR(1) NULL,
    correct_answer TEXT NULL,
    explanation TEXT NULL,
    transcript MEDIUMTEXT NULL,
    audio_url VARCHAR(500) NULL,
    passage MEDIUMTEXT NULL,
    image_url VARCHAR(500) NULL,
    topic VARCHAR(120) NULL,
    grammar_category VARCHAR(120) NULL,
    tags VARCHAR(500) NULL,
    is_published TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_toeic_part (part,is_published,difficulty), KEY idx_toeic_topic (topic), KEY idx_toeic_grammar (grammar_category),
    CONSTRAINT fk_toeic_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS toeic_attempts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    question_id BIGINT UNSIGNED NOT NULL,
    selected_answer TEXT NULL,
    is_correct TINYINT(1) NOT NULL DEFAULT 0,
    duration_seconds INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_toeic_attempt_user (user_id,created_at), KEY idx_toeic_attempt_question (question_id),
    CONSTRAINT fk_toeic_attempt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_toeic_attempt_question FOREIGN KEY (question_id) REFERENCES toeic_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO learning_courses(code,title,description,sort_order) VALUES
('VOCAB_FOUNDATION','Vocabulary Foundation','Từ vựng, collocation và sentence pattern nền tảng.',10),
('GRAMMAR_FOUNDATION','Grammar Foundation','Ngữ pháp TOEIC theo pattern recognition.',20),
('LISTENING_FOUNDATION','Listening Foundation','Word → phrase → sentence → dictation → shadowing.',30),
('TOEIC_FOUNDATION','TOEIC Foundation','Làm quen TOEIC Part 1–7 theo nền tảng.',40),
('TOEIC_PRACTICE','TOEIC Practice','Luyện tập, error analysis và test preparation.',50)
ON DUPLICATE KEY UPDATE title=VALUES(title),description=VALUES(description),sort_order=VALUES(sort_order);
