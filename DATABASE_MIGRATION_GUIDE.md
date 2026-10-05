# Database Migration Guide

This public source copy supports a **fresh installation**. Runtime configuration and production database exports are not included.

## Actual bootstrap workflow

`setup.php` writes `config.local.php`, instantiates `Database`, calls `ensureSchema()`, creates the chosen admin, then writes `storage/installed.lock`. `lib/bootstrap.php` calls the same `ensureSchema()` when the app starts with valid database configuration.

1. `database/schema.sql` supplies the base schema. `app_meta` tracks its hash; a changed schema is applied using the additive compatibility path.
2. Every `.sql` file directly inside `database/migrations/` is sorted by filename and executed if absent from `schema_migrations`.
3. Every `.sql` file directly inside `database/seeds/` is sorted by filename and executed if absent from `content_seeds`.

Recorded files are checksum-checked and skipped. Changing one raises a checksum error. Migrations execute statement by statement because MySQL/MariaDB DDL may implicitly commit; content seeds use transactions.

CSV/JSON files are source data/reports, not executable seeds. `database/seed.sql` is optional starter content outside the tracked seed directory. It is not auto-executed and needs an existing active admin; run manually only after setup if wanted.

## Migration files

```text
001_auth_login_throttle.sql
002_mistake_book.sql
003_learning_content_types.sql
004_mistake_book_v2.sql
005_personalized_learning_toeic.sql
006_taxonomies_and_toeic_seed.sql
007_toeic_part1_7_starter_and_connected_speech.sql
008_sentence_pattern_library.sql
009_toeic_vocabulary_expansion.sql
011_adaptive_learning_schema.sql
012_knowledge_remediation.sql
013_toeic_800_handbooks.sql
014_flashcard_book_section_titles.sql
015_flashbook_source_type_capacity.sql
```

There is no migration 010. The runner does not exclude migration 009 by number.

Migration 009 is historical user-scoped content. In this public copy its selector is `learner@example.test`; both personal INSERT operations require an existing owner/set. With no example learner, personal inserts are skipped instead of attempting owner ID 0 or a null set ID. It creates no fixed account or password. Shared curriculum loads from tracked content seeds.

Sanitization changes migration 009's checksum. The original deployment file is unchanged. **Do not overwrite a recorded migration in an existing installation with this sanitized file.** Keep that installation's history and add numbered migrations for future changes.

## Content seeds and books

Tracked SQL seeds run from `011_global_learning_library.sql` through `022_helen_toeic_part1_vocabulary.sql`, in filename order. They cover shared knowledge, TOEIC/Aptis, connected speech, corrections, media and handbooks. `009_seed_report.json` is a historical report with a safe example email, not an account-creating seed.

Packaged JSON/CSV flashbooks are materialized for learners by Repository's library/book operations. Student English needs no new SQL migration.

## Verification

```bash
php tests/migration_audit_test.php
php tests/seed_audit_test.php
php tests/db_integration_test.php
```

Integration requires `pdo_mysql` and configured MySQL/MariaDB; it can create/update tables and content. Use a separate local QA database. Static audits do not substitute for a real fresh install.
