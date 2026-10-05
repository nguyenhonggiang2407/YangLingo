-- v29: split Verb Master Flashcard Book catalog by the original PDF headings.
-- Preserve all existing cards/SRS; only clarify the title of a previously installed combined set.
UPDATE flashcard_sets
SET title='TOEIC Verb Master 800+ – Tổng hợp (bản cũ)',
    description=CONCAT(description, CASE WHEN description LIKE '%bản cũ%' THEN '' ELSE ' · Bản tổng hợp cũ được giữ nguyên SRS sau khi catalog được tách theo Mục 1, 3, 4, 5.1–5.4.' END),
    updated_at=NOW()
WHERE source_type='verb_master_800_book'
  AND title='TOEIC Verb Master 800+ – Flashcard Book';
