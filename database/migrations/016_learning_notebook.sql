-- Personal notes are independent of flashcards, books and all SRS/history tables.
CREATE TABLE IF NOT EXISTS learning_notebook_notes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(160) NOT NULL,
    body TEXT NOT NULL,
    own_sentence VARCHAR(500) NOT NULL DEFAULT '',
    kind ENUM('word','phrase','grammar','listening','other') NOT NULL DEFAULT 'word',
    is_pinned TINYINT(1) NOT NULL DEFAULT 0,
    is_archived TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_notebook_user (user_id,is_archived,is_pinned,updated_at),
    CONSTRAINT fk_notebook_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
