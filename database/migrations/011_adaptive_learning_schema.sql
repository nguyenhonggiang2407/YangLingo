-- YangLingo Adaptive Learning schema. Schema only; learning content is loaded from database/seeds/.
CREATE TABLE IF NOT EXISTS global_learning_items (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    external_key VARCHAR(190) NOT NULL,
    item_type VARCHAR(40) NOT NULL,
    term VARCHAR(255) NOT NULL,
    meaning_vi TEXT NOT NULL,
    definition_en TEXT NULL,
    example_en TEXT NULL,
    example_vi TEXT NULL,
    topic VARCHAR(120) NULL,
    level VARCHAR(16) NULL,
    metadata_json LONGTEXT NULL,
    content_hash CHAR(40) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_global_learning_external (external_key),
    UNIQUE KEY uq_global_learning_hash (content_hash),
    KEY idx_global_learning_type (item_type,is_active),
    KEY idx_global_learning_topic (topic),
    KEY idx_global_learning_level (level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_global_learning (
    user_id BIGINT UNSIGNED NOT NULL,
    item_id BIGINT UNSIGNED NOT NULL,
    saved_card_id BIGINT UNSIGNED NULL,
    status VARCHAR(24) NOT NULL DEFAULT 'ACTIVE',
    exposures INT UNSIGNED NOT NULL DEFAULT 0,
    correct_streak INT UNSIGNED NOT NULL DEFAULT 0,
    last_result TINYINT NULL,
    last_seen_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id,item_id),
    KEY idx_user_global_item (item_id),
    KEY idx_user_global_saved (saved_card_id),
    CONSTRAINT fk_user_global_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_global_item FOREIGN KEY (item_id) REFERENCES global_learning_items(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_global_card FOREIGN KEY (saved_card_id) REFERENCES flashcards(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aptis_questions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    module ENUM('grammar','vocabulary','reading','listening','speaking','writing') NOT NULL,
    type VARCHAR(40) NOT NULL DEFAULT 'mcq',
    topic VARCHAR(120) NULL,
    difficulty VARCHAR(8) NOT NULL DEFAULT 'B1',
    prompt TEXT NOT NULL,
    passage MEDIUMTEXT NULL,
    options_json LONGTEXT NULL,
    correct_answer TEXT NULL,
    explanation TEXT NULL,
    audio_text MEDIUMTEXT NULL,
    time_limit_seconds INT UNSIGNED NULL,
    source_note VARCHAR(255) NOT NULL DEFAULT 'YangLingo original practice content',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_by BIGINT UNSIGNED NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_aptis_question_module (module,is_active,difficulty),
    UNIQUE KEY uq_aptis_question_prompt (module,prompt(190)),
    CONSTRAINT fk_aptis_question_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aptis_attempts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    question_id BIGINT UNSIGNED NOT NULL,
    module VARCHAR(30) NOT NULL,
    mode VARCHAR(20) NOT NULL DEFAULT 'practice',
    selected_answer MEDIUMTEXT NULL,
    is_correct TINYINT(1) NOT NULL DEFAULT 0,
    duration_seconds INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_aptis_attempt_user (user_id,created_at),
    KEY idx_aptis_attempt_question (question_id),
    KEY idx_aptis_attempt_module (user_id,module,created_at),
    CONSTRAINT fk_aptis_attempt_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_aptis_attempt_question FOREIGN KEY (question_id) REFERENCES aptis_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aptis_writing_submissions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    question_id BIGINT UNSIGNED NULL,
    response_text MEDIUMTEXT NOT NULL,
    word_count INT UNSIGNED NOT NULL DEFAULT 0,
    self_score TINYINT UNSIGNED NULL,
    notes TEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_aptis_writing_user (user_id,created_at),
    CONSTRAINT fk_aptis_writing_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_aptis_writing_question FOREIGN KEY (question_id) REFERENCES aptis_questions(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aptis_speaking_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    question_id BIGINT UNSIGNED NULL,
    duration_seconds INT UNSIGNED NOT NULL DEFAULT 0,
    self_score TINYINT UNSIGNED NULL,
    notes TEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_aptis_speaking_user (user_id,created_at),
    CONSTRAINT fk_aptis_speaking_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_aptis_speaking_question FOREIGN KEY (question_id) REFERENCES aptis_questions(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
