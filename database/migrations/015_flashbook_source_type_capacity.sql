-- Some packaged book identifiers contain 31 characters, while the original
-- source_type column allows 30. Keep all identities and learner content intact.
-- Only widen a smaller column; an already wider hosting column is left alone.
SET @yl_flashbook_source_width := (
    SELECT CHARACTER_MAXIMUM_LENGTH
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA=DATABASE()
      AND TABLE_NAME='flashcard_sets'
      AND COLUMN_NAME='source_type'
);
SET @yl_flashbook_source_sql := IF(
    @yl_flashbook_source_width < 64,
    'ALTER TABLE flashcard_sets MODIFY COLUMN source_type VARCHAR(64) NOT NULL DEFAULT ''manual''',
    'DO 0'
);
PREPARE yl_flashbook_source_capacity FROM @yl_flashbook_source_sql;
EXECUTE yl_flashbook_source_capacity;
DEALLOCATE PREPARE yl_flashbook_source_capacity;
