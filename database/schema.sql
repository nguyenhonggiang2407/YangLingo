CREATE TABLE IF NOT EXISTS users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(190) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('user','admin') NOT NULL DEFAULT 'user',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    english_level VARCHAR(8) NOT NULL DEFAULT 'A2',
    daily_goal INT NOT NULL DEFAULT 20,
    bio VARCHAR(500) NOT NULL DEFAULT '',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login_at DATETIME NULL,
    PRIMARY KEY (id), UNIQUE KEY uq_users_email (email), KEY idx_users_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS folders (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(120) NOT NULL,
    icon VARCHAR(16) NOT NULL DEFAULT '📁',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_folders_user (user_id),
    CONSTRAINT fk_folders_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS flashcard_sets (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    folder_id BIGINT UNSIGNED NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    source_type VARCHAR(30) NOT NULL DEFAULT 'manual',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_sets_user (user_id), KEY idx_sets_folder (folder_id), KEY idx_sets_title (title),
    CONSTRAINT fk_sets_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_sets_folder FOREIGN KEY (folder_id) REFERENCES folders(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS flashcards (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    set_id BIGINT UNSIGNED NOT NULL,
    term VARCHAR(255) NOT NULL,
    definition TEXT NOT NULL,
    ipa VARCHAR(255) NOT NULL DEFAULT '',
    part_of_speech VARCHAR(80) NOT NULL DEFAULT '',
    cefr VARCHAR(8) NOT NULL DEFAULT '',
    example_en TEXT NOT NULL,
    example_vi TEXT NOT NULL,
    notes TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_cards_set (set_id), KEY idx_cards_term (term(120)),
    CONSTRAINT fk_cards_set FOREIGN KEY (set_id) REFERENCES flashcard_sets(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS srs_progress (
    user_id BIGINT UNSIGNED NOT NULL,
    card_id BIGINT UNSIGNED NOT NULL,
    state ENUM('new','learning','review','relearning','mastered') NOT NULL DEFAULT 'new',
    due_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_reviewed_at DATETIME NULL,
    interval_days DOUBLE NOT NULL DEFAULT 0,
    ease_factor DOUBLE NOT NULL DEFAULT 2.5,
    stability_days DOUBLE NOT NULL DEFAULT 0.3,
    difficulty DOUBLE NOT NULL DEFAULT 5,
    repetitions INT NOT NULL DEFAULT 0,
    lapses INT NOT NULL DEFAULT 0,
    correct_streak INT NOT NULL DEFAULT 0,
    total_reviews INT NOT NULL DEFAULT 0,
    correct_reviews INT NOT NULL DEFAULT 0,
    last_rating TINYINT NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, card_id), KEY idx_srs_due (user_id, due_at),
    CONSTRAINT fk_srs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_srs_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS study_events (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    set_id BIGINT UNSIGNED NULL,
    card_id BIGINT UNSIGNED NULL,
    mode VARCHAR(32) NOT NULL,
    result TINYINT NULL,
    score DOUBLE NULL,
    xp INT NOT NULL DEFAULT 0,
    duration_seconds INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_events_user_date (user_id, created_at), KEY idx_events_mode (mode),
    CONSTRAINT fk_events_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_events_set FOREIGN KEY (set_id) REFERENCES flashcard_sets(id) ON DELETE SET NULL,
    CONSTRAINT fk_events_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ai_threads (
    id CHAR(32) NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    mode VARCHAR(30) NOT NULL DEFAULT 'tutor',
    title VARCHAR(180) NOT NULL DEFAULT 'Cuộc trò chuyện mới',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_threads_user (user_id, updated_at),
    CONSTRAINT fk_threads_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ai_messages (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    thread_id CHAR(32) NOT NULL,
    role ENUM('user','assistant','system') NOT NULL,
    content MEDIUMTEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_messages_thread (thread_id, id),
    CONSTRAINT fk_messages_thread FOREIGN KEY (thread_id) REFERENCES ai_threads(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS pronunciation_attempts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    target_text TEXT NOT NULL,
    transcript TEXT NOT NULL,
    score DOUBLE NOT NULL DEFAULT 0,
    feedback TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_pron_user (user_id, created_at),
    CONSTRAINT fk_pron_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS imports (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    filename VARCHAR(255) NOT NULL,
    format VARCHAR(16) NOT NULL,
    cards_imported INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_import_user (user_id, created_at),
    CONSTRAINT fk_import_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Admin-created practice quizzes. Questions keep a snapshot so a quiz remains usable
-- even if the source flashcard is later edited or removed.
CREATE TABLE IF NOT EXISTS admin_quizzes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_by BIGINT UNSIGNED NOT NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    available_date DATE NULL,
    is_published TINYINT(1) NOT NULL DEFAULT 0,
    save_state VARCHAR(20) NOT NULL DEFAULT 'ready',
    expected_count INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_admin_quiz_publish (is_published, available_date), KEY idx_admin_quiz_creator (created_by),
    CONSTRAINT fk_admin_quiz_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS admin_quiz_questions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    quiz_id BIGINT UNSIGNED NOT NULL,
    card_id BIGINT UNSIGNED NULL,
    position INT NOT NULL DEFAULT 0,
    question TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    wrong_answer_1 TEXT NOT NULL,
    wrong_answer_2 TEXT NOT NULL,
    wrong_answer_3 TEXT NOT NULL,
    explanation TEXT NOT NULL,
    PRIMARY KEY (id), KEY idx_admin_quiz_question (quiz_id, position), KEY idx_admin_quiz_card (card_id),
    CONSTRAINT fk_admin_quiz_question_quiz FOREIGN KEY (quiz_id) REFERENCES admin_quizzes(id) ON DELETE CASCADE,
    CONSTRAINT fk_admin_quiz_question_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- One curated flashcard assignment per calendar day. Admin can choose cards from the
-- complete vocabulary bank without copying them into every learner's personal library.
CREATE TABLE IF NOT EXISTS admin_daily_sets (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_by BIGINT UNSIGNED NOT NULL,
    study_date DATE NOT NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    is_published TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), UNIQUE KEY uq_admin_daily_date (study_date), KEY idx_admin_daily_publish (is_published, study_date),
    CONSTRAINT fk_admin_daily_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS admin_daily_cards (
    daily_set_id BIGINT UNSIGNED NOT NULL,
    card_id BIGINT UNSIGNED NOT NULL,
    position INT NOT NULL DEFAULT 0,
    PRIMARY KEY (daily_set_id, card_id), KEY idx_admin_daily_position (daily_set_id, position), KEY idx_admin_daily_card (card_id),
    CONSTRAINT fk_admin_daily_cards_set FOREIGN KEY (daily_set_id) REFERENCES admin_daily_sets(id) ON DELETE CASCADE,
    CONSTRAINT fk_admin_daily_cards_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Admin-managed practice packs for Listening, Fill-in-the-blank, Matching and Speaking.
CREATE TABLE IF NOT EXISTS admin_practice_packs (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_by BIGINT UNSIGNED NOT NULL,
    practice_type ENUM('listening','fill','matching','speaking') NOT NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    available_date DATE NULL,
    is_published TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_admin_practice_type (practice_type, is_published, available_date),
    KEY idx_admin_practice_creator (created_by),
    CONSTRAINT fk_admin_practice_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS admin_practice_items (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    pack_id BIGINT UNSIGNED NOT NULL,
    position INT NOT NULL DEFAULT 0,
    prompt TEXT NOT NULL,
    answer TEXT NOT NULL,
    wrong_answer_1 TEXT NOT NULL,
    wrong_answer_2 TEXT NOT NULL,
    wrong_answer_3 TEXT NOT NULL,
    audio_text TEXT NOT NULL,
    audio_path VARCHAR(255) NOT NULL DEFAULT '',
    hint TEXT NOT NULL,
    explanation TEXT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_admin_practice_item (pack_id, position),
    CONSTRAINT fk_admin_practice_item_pack FOREIGN KEY (pack_id) REFERENCES admin_practice_packs(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Temporary staging tables for reliable large quiz saves on shared/free hosting.
-- The browser uploads questions in small chunks, then the server atomically replaces
-- the final quiz only after every expected question is present.
CREATE TABLE IF NOT EXISTS admin_quiz_save_jobs (
    upload_id CHAR(32) NOT NULL,
    admin_id BIGINT UNSIGNED NOT NULL,
    target_quiz_id BIGINT UNSIGNED NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    available_date DATE NULL,
    is_published TINYINT(1) NOT NULL DEFAULT 0,
    expected_count INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (upload_id),
    KEY idx_quiz_save_admin (admin_id, created_at),
    CONSTRAINT fk_quiz_save_admin FOREIGN KEY (admin_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS admin_quiz_save_questions (
    upload_id CHAR(32) NOT NULL,
    position INT NOT NULL,
    card_id BIGINT UNSIGNED NULL,
    question TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    wrong_answer_1 TEXT NOT NULL,
    wrong_answer_2 TEXT NOT NULL,
    wrong_answer_3 TEXT NOT NULL,
    explanation TEXT NOT NULL,
    PRIMARY KEY (upload_id, position),
    KEY idx_quiz_save_card (card_id),
    CONSTRAINT fk_quiz_save_questions_job FOREIGN KEY (upload_id) REFERENCES admin_quiz_save_jobs(upload_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS app_sessions (
    session_id VARCHAR(128) NOT NULL,
    session_data MEDIUMBLOB NOT NULL,
    expires_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (session_id),
    KEY idx_app_sessions_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- V10 isolated quiz storage. This deliberately has no foreign keys to the legacy
-- admin_quizzes tables, so deleting/recreating an old quiz cannot corrupt the new list.
CREATE TABLE IF NOT EXISTS quiz_packs_v10 (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    owner_user_id BIGINT UNSIGNED NOT NULL,
    legacy_source_id BIGINT UNSIGNED NULL,
    title VARCHAR(180) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    available_date DATE NULL,
    is_published TINYINT(1) NOT NULL DEFAULT 0,
    pending_publish TINYINT(1) NOT NULL DEFAULT 0,
    save_state VARCHAR(20) NOT NULL DEFAULT 'ready',
    expected_count INT NOT NULL DEFAULT 0,
    active_batch_id CHAR(32) NULL,
    pending_batch_id CHAR(32) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_quiz_v10_legacy (legacy_source_id),
    KEY idx_quiz_v10_owner (owner_user_id),
    KEY idx_quiz_v10_publish (is_published, available_date),
    KEY idx_quiz_v10_pending (pending_batch_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS quiz_items_v10 (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    quiz_id BIGINT UNSIGNED NOT NULL,
    batch_id CHAR(32) NOT NULL,
    position INT NOT NULL DEFAULT 0,
    card_id BIGINT UNSIGNED NULL,
    question TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    wrong_answer_1 TEXT NOT NULL,
    wrong_answer_2 TEXT NOT NULL,
    wrong_answer_3 TEXT NOT NULL,
    explanation TEXT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_quiz_v10_batch_pos (quiz_id, batch_id, position),
    KEY idx_quiz_v10_items (quiz_id, batch_id, position),
    KEY idx_quiz_v10_card (card_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Authentication throttle to slow brute-force login attempts without storing raw IPs.
CREATE TABLE IF NOT EXISTS auth_login_throttle (
    throttle_key CHAR(64) NOT NULL,
    failures INT NOT NULL DEFAULT 0,
    first_failure_at DATETIME NULL,
    last_failure_at DATETIME NULL,
    locked_until DATETIME NULL,
    PRIMARY KEY (throttle_key),
    KEY idx_auth_lock (locked_until),
    KEY idx_auth_last_failure (last_failure_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mistake_book (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    card_id BIGINT UNSIGNED NOT NULL,
    module VARCHAR(32) NOT NULL,
    wrong_count INT NOT NULL DEFAULT 1,
    last_wrong_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_mistake_user_card_module (user_id, card_id, module),
    KEY idx_mistake_user_open (user_id, resolved_at, last_wrong_at),
    CONSTRAINT fk_mistake_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_mistake_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
