# Database ERD

This diagram is based on tables declared in `database/schema.sql` and active migrations. It focuses on the learning/adaptive path rather than listing every legacy admin helper table.

```mermaid
erDiagram
  users ||--o{ flashcard_sets : owns
  flashcard_sets ||--o{ flashcards : contains
  users ||--o{ srs_progress : reviews
  flashcards ||--o{ srs_progress : has_state
  users ||--o{ study_events : generates

  users ||--o{ mistake_book_v2 : makes
  flashcards o|--o{ mistake_book_v2 : optional_source
  users ||--o{ mistake_remediation_attempts : performs
  mistake_book_v2 ||--o{ mistake_remediation_attempts : remediated_by

  global_learning_items ||--o{ user_global_learning : tracked_by
  users ||--o{ user_global_learning : owns_progress
  flashcards o|--o{ user_global_learning : saved_as
  global_learning_items ||--o{ knowledge_item_links : source
  global_learning_items ||--o{ knowledge_item_links : target

  users ||--o{ toeic_attempts : answers
  toeic_questions ||--o{ toeic_attempts : receives

  users ||--o{ aptis_attempts : answers
  aptis_questions ||--o{ aptis_attempts : receives
  aptis_questions ||--o{ aptis_question_media : has
  users ||--o{ aptis_writing_submissions : writes
  aptis_questions o|--o{ aptis_writing_submissions : task
  users ||--o{ aptis_speaking_sessions : records_metadata
  aptis_questions o|--o{ aptis_speaking_sessions : task
```

## Key tables

### Base learning
- `users`: account/RBAC identity.
- `flashcard_sets`, `flashcards`: learner-owned flashcard content.
- `srs_progress`: interval/stability/repetition state by user/card.
- `study_events`: learning activity events used for plans/analytics.

### Error remediation
- `mistake_book_v2`: structured wrong-answer record, error type/topic, recurrence and mastery status.
- `mistake_remediation_attempts`: learner attempts on targeted remedial questions.

### Global curriculum
- `global_learning_items`: shared vocabulary/collocation/pattern/grammar/listening/paraphrase content with `external_key` and `content_hash` uniqueness.
- `user_global_learning`: per-user exposure/progress and optional saved SRS card.
- `knowledge_item_links`: many-to-many related-knowledge edges; source and target both reference `global_learning_items`.

### TOEIC
- `toeic_questions`: question bank.
- `toeic_attempts`: per-user attempt history.

### Aptis
- `aptis_questions`: module/type-based question/prompt bank.
- `aptis_attempts`: graded auto-practice history.
- `aptis_question_media`: local/external media paths by question role (`image`, `image_a`, `image_b`).
- `aptis_writing_submissions`: text, word count, self-rubric summary/notes.
- `aptis_speaking_sessions`: duration/self-rubric summary/notes; raw audio is not uploaded by default.

## Referential-integrity strategy

User-owned progress/attempt rows generally cascade on user deletion. Historical exam questions are retired with `is_active=0` rather than deleted so existing attempts remain valid. Related-knowledge edges cascade when a global content item is removed.
