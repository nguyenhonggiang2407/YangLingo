-- YangLingo remediation / knowledge-linking schema. Schema only.
CREATE TABLE IF NOT EXISTS knowledge_item_links (
    source_item_id BIGINT UNSIGNED NOT NULL,
    target_item_id BIGINT UNSIGNED NOT NULL,
    relation_type VARCHAR(40) NOT NULL DEFAULT 'RELATED',
    weight DECIMAL(5,2) NOT NULL DEFAULT 1.00,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (source_item_id,target_item_id,relation_type),
    KEY idx_knowledge_link_target (target_item_id,relation_type),
    CONSTRAINT fk_knowledge_link_source FOREIGN KEY (source_item_id) REFERENCES global_learning_items(id) ON DELETE CASCADE,
    CONSTRAINT fk_knowledge_link_target FOREIGN KEY (target_item_id) REFERENCES global_learning_items(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mistake_remediation_attempts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    mistake_id BIGINT UNSIGNED NOT NULL,
    question_source VARCHAR(20) NOT NULL,
    question_id BIGINT UNSIGNED NULL,
    prompt TEXT NOT NULL,
    selected_answer TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    explanation TEXT NULL,
    is_correct TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_remediation_user_mistake (user_id,mistake_id,created_at),
    KEY idx_remediation_mistake_result (mistake_id,is_correct,created_at),
    CONSTRAINT fk_remediation_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_remediation_mistake FOREIGN KEY (mistake_id) REFERENCES mistake_book_v2(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS aptis_question_media (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    question_id BIGINT UNSIGNED NOT NULL,
    media_role VARCHAR(24) NOT NULL DEFAULT 'image',
    media_path VARCHAR(500) NOT NULL,
    alt_text VARCHAR(300) NOT NULL DEFAULT '',
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_aptis_question_media (question_id,media_role,media_path(190)),
    KEY idx_aptis_media_question (question_id,media_role,sort_order),
    CONSTRAINT fk_aptis_media_question FOREIGN KEY (question_id) REFERENCES aptis_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
