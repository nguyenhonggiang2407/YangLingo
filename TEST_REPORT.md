
## v33 Irregular Verb data-quality regression

Executed on the SAFE_OVERWRITE package:

- PHP syntax: all PHP files in the package PASS.
- JavaScript syntax: `assets/app.js` and `service-worker.js` PASS.
- `tests/irregular_verbs_v33_test.php`: PASS — Core=120, Extended=40, 160 unique V1 keys, `be`/`oversee` present, `overlook` excluded, required patterns/meanings present, append-only sync and v33 cache verified.
- `tests/adaptive_toeic_daily_plan_v32_test.php`: PASS after cache expectation update to v33.
- `tests/daily_plan_logic_v32_test.php`: PASS.
- `tests/lesson_full_session_test.php`: PASS.
- `tests/library_flashbook_sync_test.php`: PASS.
- `tests/pdf_flashbooks_test.php`: NOT EXECUTED in the overlay because full-tree `lib/compat.php` is absent.
- `tests/verb_section_books_test.php`: NOT EXECUTED in the overlay because the original full-tree Verb Master CSV is absent.

There are **0 executed-test failures** in the overlay. Full-tree/runtime DB verification remains required after deployment because this package deliberately does not contain the complete production repository or live database.
# YangLingo Release Verification

## Current validation — v32 overwrite source

| Check | Status | Evidence |
| --- | --- | --- |
| PHP syntax — all PHP files contained in this overwrite | PASS | `php -l` |
| JavaScript syntax — contained JS files | PASS | `node --check` |
| Adaptive TOEIC Daily Plan v32 static regression | PASS | `tests/adaptive_toeic_daily_plan_v32_test.php` |
| Adaptive Daily Plan v32 dynamic logic (fake DB) | PASS | `tests/daily_plan_logic_v32_test.php` — priority, due/relearning/hard split, retention cap, TOEIC-only accounting, weakness accuracy |
| Lesson/full-session regression | PASS | `tests/lesson_full_session_test.php` |
| Library Flashcard auto-sync regression | PASS | `tests/library_flashbook_sync_test.php` |
| PDF Flashbook runtime test | NOT EXECUTED | overwrite package does not contain `lib/compat.php` or the underlying full flashbook assets |
| Verb-section runtime test | NOT EXECUTED | overwrite package does not contain the underlying full CSV assets |
| MariaDB migration/seed integration | NOT EXECUTED | v32 adds no migration/seed; sandbox has no configured production MariaDB |
| Live HelioHost end-to-end login/database regression | NOT EXECUTED | no hosting filesystem/database mutation was performed from this environment |

**Interpretation:** the two missing-asset tests are not marked FAIL because the uploaded artifact itself is explicitly an OVERWRITE package. They must be rerun against the complete production tree after deployment. Historical v31 full-source results remain below for traceability; they are not re-labelled as v32 runtime PASS.


## v30 - Lesson 20/20 routing regression

- PASS: entering a selected set/lesson switches to `lesson` mode and requests the exact 20-card lesson slice.
- PASS: sidebar `Ôn tập` without a selected set remains due-only SRS.
- PASS: same-route lesson selection re-renders immediately even when the URL is already `#review`.
- PASS: UI labels distinguish `Chế độ bài học · đủ N/N thẻ` from `SRS đến hạn`.
- PASS: app asset version `v=30`; PWA cache `yanglingo-static-v30`.
- PASS: 24 non-DB PHP regression tests.
- NOT EXECUTED: MariaDB integration test because `pdo_mysql`/MariaDB runtime is unavailable in this sandbox.

# YangLingo Final Test Report

This report reflects the **current source at packaging time**. Status values are limited to `PASS`, `FAIL`, and `NOT EXECUTED`.

## Final status

| Area | Status | Evidence |
|---|---|---|
| PHP syntax (all `.php`) | PASS | `php -l` across project |
| JavaScript syntax (all project JS) | PASS | `node --check` across `assets/**/*.js` |
| TOEIC 800+ Handbooks | PASS | `tests/handbooks_test.php` |
| HELEN TOEIC Part 1 vocabulary | PASS | `tests/helen_part1_vocab_test.php` |
| Adaptive Learning | PASS | `tests/adaptive_test.php` |
| Learning System / Daily Plan | PASS | `tests/learning_system_test.php` |
| SRS | PASS | `tests/srs_test.php` |
| Mastery | PASS | `tests/mastery_test.php` |
| Mistake Book | PASS | `tests/mistake_book_test.php` |
| Mistake Remediation / RECURRED flow | PASS | `tests/adaptive_test.php`, `tests/mistake_book_test.php` |
| Knowledge Map | PASS | `tests/adaptive_test.php`, `tests/ui_quality_test.php` |
| Knowledge Links | PASS | `tests/adaptive_test.php` |
| Sentence Patterns | PASS | `tests/sentence_patterns_test.php` |
| Collocation Builder wiring | PASS | `tests/adaptive_test.php` |
| Listening / Connected Speech source | PASS | `tests/data_quality_test.php`, `tests/toeic_test.php` |
| TOEIC | PASS | `tests/toeic_test.php`, `tests/toeic_v4_seed_test.php` |
| Aptis Engine | PASS | `tests/aptis_v5_test.php` |
| Aptis Speaking | PASS | `tests/aptis_productive_test.php` |
| Aptis Writing | PASS | `tests/aptis_productive_test.php` |
| Aptis media (9 SVG) | PASS | `tests/aptis_productive_test.php` |
| Importer CSV/XLSX/DOCX parsing | PASS | `tests/importer_test.php` |
| Import/archive security | PASS | `tests/security_final_audit.php` |
| Data Quality | PASS | `tests/data_quality_test.php` |
| Migration static audit | PASS | `tests/migration_audit_test.php` |
| Seed static audit | PASS | `tests/seed_audit_test.php` |
| Security final audit | PASS | `tests/security_final_audit.php` |
| DB diagnostic security | PASS | `tests/db_check_security_test.php` |
| Static release audit | PASS | `tests/static_audit.php` |
| Responsive/accessibility/PWA static QA | PASS | `tests/ui_quality_test.php` |
| Local HTTP static/source delivery | PASS | local HTTP server + `curl` (`app.js`, service worker, HELEN CSV, PDF all HTTP 200) |
| MariaDB clean migration | NOT EXECUTED | sandbox has no `pdo_mysql` / MariaDB server |
| MariaDB seed integration | NOT EXECUTED | sandbox has no MariaDB-compatible runtime |
| Repository DB integration | NOT EXECUTED | no configured MariaDB runtime in sandbox |


## HELEN TOEIC Part 1 vocabulary verification

`tests/helen_part1_vocab_test.php` returned:

```text
HELEN PART1 VOCAB OK: rows=141, unique_terms=140, sheets=7, practice=141, dedupe_knowledge_candidates=141
```

Verification covers:

- **141** source rows preserved from 7 Google Sheet tabs;
- expected distribution: 12 + 33 + 20 + 15 + 28 + 13 + 20;
- **140 normalized unique terms** because `Fasten` occurs in two source tabs;
- 141 `VOCABULARY_RECALL` handbook practice items;
- 141 dedupe-aware Knowledge Hub candidates and 141 handbook → knowledge links;
- local source snapshot `assets/handbooks/helen-toeic-part1-vocabulary.csv`;
- no fabricated photograph questions or distractors;
- source wording is preserved rather than silently corrected;
- PWA cache key bumped to `yanglingo-static-v26` so the updated handbook UI is not masked by the previous cached `app.js`.

## TOEIC 800+ handbook verification

`tests/handbooks_test.php` returned:

```text
HANDBOOKS OK: books=3, sections=35, listening_self_check=100, global_items=369 (verb=293, grammar=16, listening=60), relations=378
```

Additional packaging verification:

- the 3 bundled PDFs are byte-identical to the 3 supplied source uploads (SHA-256 pairs match);
- migration `013_toeic_800_handbooks.sql` is additive and passed the project migration/security audits;
- seed `021_toeic_800_handbooks.sql` passed the seed/security audits;
- all 100 source Listening items are self-check content; no missing PDF distractors were invented;
- database integration was deliberately **not executed** in this sandbox because no isolated MariaDB test instance is configured and the release must not mutate a live/external database.

## Final content-quality counts

`tests/data_quality_test.php` returned:

```text
DATA QUALITY OK: global=1449, TOEIC=300, Aptis_active=608, Aptis_retired=110, connected=100, corrected=459
```

Key source counts:

- Global Knowledge baseline adaptive CSV: **1,449**; PDF-handbook seed adds **369** source-derived items. HELEN Part 1 adds dedupe-aware candidates, so the exact number of new Global Knowledge rows depends on matching terms already present in the live DB
- Connected Speech: **100** clean-install active rows
- TOEIC adaptive pack: **300**
- Aptis active: **608**
- Aptis retired/history-preserved: **110**
- Content correction updates: **459**

## Aptis productive-skill verification

Static/behavior regression verifies:

- Speaking Part 1–4 navigation and prompt rotation;
- nine valid bundled SVG assets used by Speaking Part 2/3 media mappings;
- preparation timer and response timer;
- browser-local `MediaRecorder`, stop, playback and retry/delete behavior;
- six-dimension Speaking self-rubric;
- Writing Part 1–4 navigation;
- countdown timer;
- local autosave/restore/clear draft using a user+task scoped key;
- word counter;
- Writing self-rubric and local draft removal after successful submit;
- dedicated Aptis `word_matching` renderer rather than forced A/B/C/D rendering.

Self-rubrics are coaching signals and are **not official Aptis scores**.

## Security verification

Automated/static review covers:

- PDO native prepared statements with emulation disabled;
- password hashing/verification;
- login throttling;
- session fixation protections and strict/HttpOnly/SameSite cookies;
- CSRF checks on mutation endpoints;
- role/ownership checks;
- bounded import/archive handling against traversal and decompression abuse;
- DOCX/XLSX XML/row/column limits;
- upload extension/MIME controls;
- generic production error responses;
- absence of a production `config.local.php` from the release;
- admin-only `admin/db-check.php` with no GET/POST SQL input, no arbitrary SQL endpoint, CSP, no wildcard CORS and no credential rendering.

## MariaDB — why NOT EXECUTED

The final build environment reports:

```text
PDO drivers: (none)
pdo_mysql: unavailable
```

No MariaDB/MySQL server is available in the sandbox. SQLite was deliberately **not** used as a substitute because it would not validate MariaDB-specific behavior.

The release contains:

- `tests/db_integration_test.php`
- `admin/db-check.php`
- `docs/HELIOHOST_MARIADB_INTEGRATION_TEST.md`

Use a separate HelioHost test database to turn these three statuses into real PASS/FAIL results.

## Release cleanliness

Packaging validation requires and checks:

- source, migrations, seeds, tests and docs present;
- 9 Aptis SVG assets present;
- no `.git/`, `.env`, `node_modules/`, cache, logs, nested old ZIP or private DB backup;
- no production `config.local.php`;
- no real personal Gmail address or production credential in source;
- ZIP can be reopened and listed successfully.
- HELEN CSV source snapshot is included and HTTP-readable.
- new seed `022_helen_toeic_part1_vocabulary.sql` passes seed/security audits.


## v27 Flashcard Book regression
- Added dedicated HELEN TOEIC Part 1 Flashcard Book path, separate from handbook reading.
- Source integrity: **141 rows / 7 topics / 140 unique normalized terms** (the source contains `Fasten` in two distinct contexts).
- Personal installer is idempotent by `source_type=helen_part1_book`; it creates a normal learner-owned set with all 141 source rows and does not mutate existing SRS/history.
- Cards keep term, IPA, Vietnamese meaning, source example, source topic, TOEIC Part 1 metadata, and example sentence as `audio_text`.
- Full non-DB regression after v27: **21 test files PASS**, **0 FAIL**, `db_integration_test.php` NOT EXECUTED because this environment has no MariaDB runtime.
- PHP syntax scan: PASS. JavaScript syntax scan: PASS.
- PWA cache key: `yanglingo-static-v27`.

## v28 PDF Flashcard Books regression

- Packaged catalog: **4 books / 796 source cards**.
- HELEN Part 1: **141 rows / 7 source topics / 140 unique normalized terms**.
- Verb Master 800+: **337 cards / 337 unique terms**.
- Listening vocabulary/chunks 800+: **85 cards / 84 unique term strings across source categories**.
- Grammar structures/confusing words 800+: **233 cards / 231 unique term strings across source categories**.
- `tests/pdf_flashbooks_test.php`: PASS.
- Updated `tests/helen_flashbook_test.php`: PASS.
- PHP syntax audit: PASS.
- JavaScript syntax audit: PASS.
- Full non-DB regression after v28: **22 test files PASS / 0 FAIL**.
- `db_integration_test.php`: NOT EXECUTED in this sandbox because no MariaDB runtime / production credentials are used here.
- PWA cache: `yanglingo-static-v28`.

## v29 Verb section books + 20-card lesson regression
- Catalog target: **10 books / 802 source cards**.
- Verb Master section counts validated from packaged CSV: Mục 1 = 42, Mục 3 = 106, Mục 4 = 8 contrast cards, Mục 5.1 = 109, Mục 5.2 = 38, Mục 5.3 = 14, Mục 5.4 = 26.
- Exact Mục 5 titles are present in the catalog.
- Explicit roadmap lesson mode is wired through API/UI so **Học 20 từ này** loads the complete 20-card unit. Standalone SRS Review remains due-only.
- Legacy combined Verb Master title migration is additive and preserves card IDs/SRS.
- PHP syntax: PASS for changed PHP files.
- JavaScript syntax: PASS for `assets/app.js`.
- Full non-DB regression after v29: **23 test files PASS / 0 FAIL / 1 DB integration test skipped** (MariaDB runtime unavailable in sandbox).
- PWA cache: `yanglingo-static-v29`.


## v31 Library Flashcard Book sync
- Added `tests/library_flashbook_sync_test.php`.
- Verifies repository sync, API route, library-before-list synchronization, section names 5.1–5.4 and PWA cache v31.
- MariaDB runtime integration still requires the deployment host.


### Final v31 regression summary
- Non-DB PHP test files: **25 PASS / 0 FAIL**.
- MariaDB runtime integration: **NOT EXECUTED** in sandbox; requires deployment host with `pdo_mysql`.
- PHP syntax and JavaScript syntax are checked again before ZIP packaging.
