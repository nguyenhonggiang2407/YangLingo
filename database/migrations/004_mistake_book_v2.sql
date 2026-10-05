-- Mistake Book V2 supports both flashcard-backed and standalone TOEIC/listening questions.
CREATE TABLE IF NOT EXISTS mistake_book_v2 (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_key VARCHAR(190) NOT NULL,
    source_id VARCHAR(190) NULL,
    card_id BIGINT UNSIGNED NULL,
    question TEXT NOT NULL,
    user_answer TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    error_type VARCHAR(48) NOT NULL DEFAULT 'UNKNOWN',
    topic VARCHAR(120) NULL,
    toeic_part TINYINT UNSIGNED NULL,
    wrong_count INT NOT NULL DEFAULT 1,
    first_wrong_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_wrong_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at DATETIME NULL,
    mastery_status VARCHAR(24) NOT NULL DEFAULT 'OPEN',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_mistake_v2_source (user_id,source_type,source_key),
    KEY idx_mistake_v2_open (user_id,resolved_at,last_wrong_at),
    KEY idx_mistake_v2_error (user_id,error_type,last_wrong_at),
    KEY idx_mistake_v2_card (card_id),
    CONSTRAINT fk_mistake_v2_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_mistake_v2_card FOREIGN KEY (card_id) REFERENCES flashcards(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO mistake_book_v2(user_id,source_type,source_key,source_id,card_id,question,user_answer,correct_answer,explanation,error_type,topic,toeic_part,wrong_count,first_wrong_at,last_wrong_at,resolved_at,mastery_status)
SELECT m.user_id,m.module,CONCAT('card:',m.card_id),CAST(m.card_id AS CHAR),m.card_id,
       COALESCE(c.term,''),'',COALESCE(c.definition,''),COALESCE(c.example_en,''),
       CASE WHEN m.module='listening' THEN 'LISTENING_RECOGNITION' WHEN m.module='fill' THEN 'VOCABULARY' WHEN m.module='quiz' THEN 'VOCABULARY' ELSE 'UNKNOWN' END,
       c.topic,c.toeic_part,m.wrong_count,m.created_at,m.last_wrong_at,m.resolved_at,
       CASE WHEN m.resolved_at IS NULL THEN 'OPEN' ELSE 'RESOLVED' END
FROM mistake_book m
LEFT JOIN flashcards c ON c.id=m.card_id
ON DUPLICATE KEY UPDATE
wrong_count=GREATEST(mistake_book_v2.wrong_count,VALUES(wrong_count)),
last_wrong_at=GREATEST(mistake_book_v2.last_wrong_at,VALUES(last_wrong_at)),
resolved_at=VALUES(resolved_at),
mastery_status=VALUES(mastery_status);
