-- TOEIC 800+ Handbook integration. Additive only; no existing learner data is removed.
CREATE TABLE IF NOT EXISTS learning_handbooks (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    code VARCHAR(80) NOT NULL,
    title VARCHAR(220) NOT NULL,
    subtitle VARCHAR(500) NOT NULL DEFAULT '',
    description TEXT NULL,
    source_pdf_path VARCHAR(500) NULL,
    source_note VARCHAR(255) NOT NULL DEFAULT 'User-provided learning material',
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_learning_handbook_code (code),
    KEY idx_learning_handbook_active (is_active,sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS learning_handbook_sections (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    handbook_id BIGINT UNSIGNED NOT NULL,
    section_key VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body_text LONGTEXT NOT NULL,
    metadata_json LONGTEXT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_handbook_section (handbook_id,section_key),
    KEY idx_handbook_section_sort (handbook_id,is_active,sort_order),
    CONSTRAINT fk_handbook_section_book FOREIGN KEY (handbook_id) REFERENCES learning_handbooks(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_handbook_progress (
    user_id BIGINT UNSIGNED NOT NULL,
    section_id BIGINT UNSIGNED NOT NULL,
    is_completed TINYINT(1) NOT NULL DEFAULT 0,
    completed_at DATETIME NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id,section_id),
    KEY idx_handbook_progress_section (section_id),
    CONSTRAINT fk_handbook_progress_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_handbook_progress_section FOREIGN KEY (section_id) REFERENCES learning_handbook_sections(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS handbook_practice_items (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    section_id BIGINT UNSIGNED NOT NULL,
    item_no INT UNSIGNED NULL,
    item_type VARCHAR(40) NOT NULL DEFAULT 'SELF_CHECK',
    group_key VARCHAR(100) NULL,
    audio_text MEDIUMTEXT NULL,
    prompt TEXT NOT NULL,
    answer TEXT NULL,
    translation TEXT NULL,
    explanation TEXT NULL,
    metadata_json LONGTEXT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_handbook_practice_number (section_id,item_no),
    KEY idx_handbook_practice_sort (section_id,is_active,sort_order),
    CONSTRAINT fk_handbook_practice_section FOREIGN KEY (section_id) REFERENCES learning_handbook_sections(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS handbook_section_items (
    section_id BIGINT UNSIGNED NOT NULL,
    item_external_key VARCHAR(190) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    PRIMARY KEY (section_id,item_external_key),
    KEY idx_handbook_section_item_key (item_external_key),
    CONSTRAINT fk_handbook_section_item_section FOREIGN KEY (section_id) REFERENCES learning_handbook_sections(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
