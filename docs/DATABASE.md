# Database

## Main domains

### Identity
- `users`
- `sessions`
- `auth_login_throttle`

### Vocabulary / SRS
- `folders`
- `flashcard_sets`
- `flashcards`
- `srs_progress`

### Personalized learning
- `learning_preferences`
- `learning_courses`
- `learning_modules`
- `learning_lessons`
- `learning_lesson_cards`
- `learning_topics`
- `grammar_topics`

### Learning telemetry / errors
- `study_events`
- legacy `mistake_book`
- `mistake_book_v2`
- `pronunciation_attempts`

### TOEIC
- `toeic_questions`
- `toeic_attempts`

### AI
- `ai_threads`
- `ai_messages`

### Content/practice
Existing quiz, daily-assignment and practice-pack tables are retained. `Database.php` also keeps compatibility logic for older public schema versions.

### Operations
- `imports`
- `app_meta`
- `schema_migrations`

## Migration policy

- Prefer additive `CREATE` / `ALTER` operations.
- Do not DROP/reset user databases during startup.
- Record migration filename + checksum after success.
- Stop if the checksum of an already-applied migration changes.
- Back up the live database before every deployment.

See root `DATABASE_MIGRATION_GUIDE.md` for the exact 003–007 upgrade sequence and rollback approach.
