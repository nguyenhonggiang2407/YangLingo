-- YangLingo learning content metadata. Additive only; safe for existing user data.
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS card_type VARCHAR(32) NOT NULL DEFAULT 'VOCABULARY' AFTER notes;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS topic VARCHAR(120) NULL AFTER card_type;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS subtopic VARCHAR(120) NULL AFTER topic;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS toeic_part TINYINT UNSIGNED NULL AFTER subtopic;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS difficulty TINYINT UNSIGNED NOT NULL DEFAULT 1 AFTER toeic_part;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS pattern TEXT NULL AFTER difficulty;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS collocations TEXT NULL AFTER pattern;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS word_family TEXT NULL AFTER collocations;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS explanation TEXT NULL AFTER word_family;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS audio_text TEXT NULL AFTER explanation;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS tags VARCHAR(500) NULL AFTER audio_text;
ALTER TABLE flashcards ADD COLUMN IF NOT EXISTS source VARCHAR(120) NULL AFTER tags;

CREATE INDEX IF NOT EXISTS idx_cards_type ON flashcards(card_type);
CREATE INDEX IF NOT EXISTS idx_cards_topic ON flashcards(topic);
CREATE INDEX IF NOT EXISTS idx_cards_toeic_part ON flashcards(toeic_part);
CREATE INDEX IF NOT EXISTS idx_cards_difficulty ON flashcards(difficulty);
CREATE INDEX IF NOT EXISTS idx_srs_state_due ON srs_progress(user_id,state,due_at);
