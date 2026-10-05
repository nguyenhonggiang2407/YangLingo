# HelioHost MariaDB Integration Test

This checklist converts the three build-environment `NOT EXECUTED` statuses into real MariaDB results. Use a **separate test database**, not the production database, for the clean-migration test.

## What each status means

- **Clean migration PASS**: the database starts completely empty and all schema/migration files complete in order.
- **Seed integration PASS**: all content seeds load successfully and a second seed run does not duplicate data.
- **Repository DB integration PASS**: real application flows read/write MariaDB correctly through the PHP repository/application layer.

`NOT EXECUTED` is not the same as `FAIL`; it means the required MariaDB runtime was unavailable in the build container.

## A. Create a separate test database

1. In HelioHost, create a new MariaDB/MySQL **test** database.
2. Do not point this clean-install test at your current production database.
3. Create/assign a database user with the permissions required by the application.
4. Copy `config.example.php` to `config.local.php` if your deployment workflow uses that file, or use the project's normal local configuration mechanism.
5. Enter only the test DB host, database name, user and password on the server. Never commit this file to Git or copy it back into the ZIP.

## B. Environment diagnostic

1. Log in to YangLingo as an **ADMIN**.
2. Open `admin/db-check.php`.
3. Confirm:
   - PDO extension: `available`
   - `pdo_mysql`: `available`
   - PDO drivers include `mysql`
   - `SELECT 1 smoke test`: `PASS`
   - Database connection: `connected`
   - Database charset is `utf8mb4`
4. Confirm the page does **not** display a DB password, API key, session ID or full DSN.

The diagnostic is read-only and admin-only. After validation, leave it protected behind ADMIN authentication or delete `admin/db-check.php` if you do not need ongoing diagnostics.

## C. Clean migration test

A clean migration test means:

```text
EMPTY TEST DATABASE
→ schema.sql
→ every migration in lexical order
→ final schema created successfully
```

1. Start with the new test DB completely empty.
2. Open YangLingo/setup path according to `DEPLOY_HELIOHOST.md`, or open the app so `Database::ensureSchema()` initializes the schema.
3. Re-open `admin/db-check.php` after ADMIN login.
4. Verify `schema_migrations` exists.
5. Verify a latest migration is shown.
6. Verify the key tables shown by the diagnostic are `present`.
7. If any migration throws an error, mark **MariaDB clean migration: FAIL** and preserve the exact server error before changing the schema.
8. If the complete empty→final-schema path succeeds, mark **MariaDB clean migration: PASS**.

Do not use a database that had already been migrated to claim a clean-migration PASS.

## D. Seed idempotency test

1. Record these counts after the first successful initialization:
   - Global Knowledge
   - Connected Speech
   - TOEIC questions
   - Aptis active
   - Aptis retired
   - Applied content seeds
2. Trigger the normal initialization a second time by loading the app again.
3. Re-open `admin/db-check.php`.
4. Compare the counts.
5. The curriculum counts must remain stable. Example: Global Knowledge must **not** change from 1,449 to 2,898 merely because initialization ran twice.
6. If counts duplicate, mark **MariaDB seed integration: FAIL**.
7. If the second run is stable, mark **MariaDB seed integration: PASS**.

## E. Repository/application integration flow

Use a new test user and perform the following against the MariaDB test database:

```text
Register test user
→ Login
→ Load Adaptive Daily Plan
→ Open global learning content
→ Review a flashcard/SRS item
→ Answer one TOEIC/Aptis question incorrectly
→ Confirm Mistake Book entry exists
→ Confirm Weakness/priority data changes
→ Open Mistake Remediation
→ Complete a remedial question correctly
→ Confirm mistake status/progress changes
→ Re-open Knowledge Map
→ Confirm learner evidence is reflected
```

Then test:

1. Flashcard / SRS review.
2. Collocation Builder (include one wrong answer).
3. Listening Recognition / Connected Speech.
4. TOEIC practice.
5. Aptis Grammar/Vocabulary/Reading/Listening.
6. Aptis Speaking: image, preparation timer, response timer, local recording, playback/retry, rubric save.
7. Aptis Writing: countdown, autosave/restore, word count, rubric save.
8. Admin content page.
9. CSV/XLSX/DOCX import with a small safe sample.
10. Logout and verify protected routes require authentication.

If the complete real DB flow works, mark **Repository DB integration: PASS**.

## F. Optional CLI test

If HelioHost provides PHP CLI for the same configured test database:

```bash
php tests/db_integration_test.php
```

Use its output as additional evidence. Do not substitute SQLite for this test.

## G. Update final test status

Only after the real HelioHost test succeeds, change your deployment/test notes to:

```text
MariaDB clean migration: PASS
MariaDB seed integration: PASS
Repository DB integration: PASS
```

If a real execution fails, use `FAIL`, diagnose the server error, fix it, and rerun. Never convert `NOT EXECUTED` to PASS without actually executing the MariaDB checks.
