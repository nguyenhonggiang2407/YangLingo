# v33 SAFE_OVERWRITE additions

New/changed v33 artifacts:

- `lib/Repository.php` — Core/Extended irregular catalog, append-only/in-place safe sync, book integrity metadata.
- `assets/app.js` — book integrity UI and safe-sync feedback.
- `assets/flashbooks/toeic-irregular-verbs-core-v33.csv` — 120 rows.
- `assets/flashbooks/toeic-irregular-verbs-extended-v33.csv` — 40 rows.
- `tests/irregular_verbs_v33_test.php`.
- `DATA_AUDIT_IRREGULAR_V33.md`.
- `index.php` / `service-worker.js` — cache v33.

Canonical full-tree flashbook target after v33: **11 books / 857 source cards** (historical 802 + 55). Existing learner databases may show additional legacy cards because v33 intentionally does not delete them.

# Release Manifest — YangLingo TOEIC 800+ Handbooks + Part 1 Vocabulary

## v32 changed files in this overwrite

- `lib/Repository.php` — exact Daily Plan priority, disjoint SRS queues, TOEIC weakness dimensions, Part 5 structured feedback.
- `api.php` — routes `study_cards` to `due/relearning/hard/new` priority queues.
- `assets/app.js` — action-first “Hôm nay” dashboard, dedicated Daily Plan routes, Part 5 step rendering.
- `index.php` — “Hôm nay” naming and app cache v32.
- `service-worker.js` — PWA cache v32.
- `tests/adaptive_toeic_daily_plan_v32_test.php` — new regression coverage.
- `tests/lesson_full_session_test.php`, existing v31 patch tests — cache/route expectations updated for v32.
- docs in the overwrite package — current data-safety/deployment/test notes.

**Database:** no migration/seed added by v32.

> **Scope note:** sections below describing handbooks, migrations, seeds, and historical full-source QA are inherited release history from the existing YangLingo installation. Those assets are **not duplicated inside this SAFE_OVERWRITE ZIP** unless listed in the v32 changed-file section above. Deploy this package only over the existing full production tree.


Release target: **HelioHost / PHP 8.x / MariaDB/MySQL**

## Integrated source handbooks

- **Grammar 800+** — `assets/handbooks/toeic-grammar-800-plus.pdf` — 301,311 bytes — SHA-256 `6623fde4ffc941e94d09fe81f35eb0828ae02f866e870d699f47191acdcd2938`
- **Listening 100 câu 800+** — `assets/handbooks/toeic-listening-100-cau-800-plus.pdf` — 331,128 bytes — SHA-256 `ac98e919cda269b527b0863576b906d47d4d9872fb6e3c29b04802e9ab1f8061`
- **Verb Master 800+** — `assets/handbooks/toeic-verb-master-800-plus.pdf` — 752,117 bytes — SHA-256 `03cd83cd9a742ffd8c87bf777d40da4005a1d3e68a793ac2ee469f44913fc798`

- **HELEN TOEIC Part 1 Vocabulary** — `assets/handbooks/helen-toeic-part1-vocabulary.csv` — 16,627 bytes — SHA-256 `ba8e5f122d83686b84054f463fe1fefd06bda1aa780eb1245e05316d7bd0de86`

## Database additions

- `database/migrations/013_toeic_800_handbooks.sql` — additive handbook/progress/practice schema.
- `database/seeds/021_toeic_800_handbooks.sql` — separately tracked/idempotent PDF handbook and linked knowledge content.
- `database/seeds/022_helen_toeic_part1_vocabulary.sql` — fourth handbook, 141 source-preserving recall items and live-term-deduplicated Knowledge Hub links.

## Integrated content counts

- 4 handbooks
- 42 handbook sections (35 PDF + 7 HELEN Part 1)
- 100 Listening self-check items
- 293 Verb Master Global Knowledge items
- 16 Grammar Lesson Global Knowledge items
- 60 Listening Recognition Global Knowledge items
- 378 PDF-handbook → knowledge relations
- HELEN Part 1: 141 source rows, 140 normalized unique terms, 141 recall items and 141 dedupe-aware relations

## Release QA

- PHP syntax: PASS across 41 PHP files.
- JavaScript syntax: PASS across 4 project JS files.
- Full non-DB regression suite: PASS.
- Static migration/seed/security/data-quality audits: PASS.
- Local HTTP delivery: handbook PDFs, JS, CSS, PWA assets returned HTTP 200.
- MariaDB runtime integration: NOT EXECUTED in build sandbox because there is no MariaDB server / `pdo_mysql`; use `tests/db_integration_test.php` on a separate host/test DB.

## Upgrade safety

- No `config.local.php` is bundled.
- Existing users/SRS/attempts/mistakes are not dropped or reset.
- Upgrade is performed by overwriting application files while retaining the live DB and live `config.local.php`.
- `Database::ensureSchema()` tracks migrations and content seeds by checksum.

See `DEPLOY_HELIOHOST.md`, `DATABASE_MIGRATION_GUIDE.md`, `TEST_REPORT.md` and `docs/HANDBOOKS_800_INTEGRATION.md`.


### v27 Flashcard Book additions
- `tests/helen_flashbook_test.php`
- Repository/API/UI support for `flashcard_books` and `flashcard_book_install`
- New sidebar route `#flashbooks`
- Uses existing `assets/handbooks/helen-toeic-part1-vocabulary.csv` as the immutable packaged source snapshot


### v28 PDF Flashcard Book additions
- `assets/flashbooks/toeic-verb-master-800-flashcards.csv` — 337 cards
- `assets/flashbooks/toeic-listening-vocab-800-flashcards.csv` — 85 cards
- `assets/flashbooks/toeic-grammar-800-flashcards.csv` — 233 cards
- `tools/build_pdf_flashbooks.py` — reproducible source-to-CSV builder
- `tests/pdf_flashbooks_test.php`
- Generic four-book installer/catalog in `lib/Repository.php`
- Learner-facing classification renamed to `Bộ Flashcard TOEIC` / `Bộ Flashcard TOEIC 800+`
- PWA cache `yanglingo-static-v28`

### v29 additions
- `database/migrations/014_flashcard_book_section_titles.sql` – safe legacy title normalization only.
- Verb Master catalog split into PDF-section books (1, 3, 4, 5.1–5.4).
- Exact section 5 titles: Kinh doanh & Quản lý; Nhân sự & Giao tiếp; Tài chính & Mua sắm; Vận hành & Hậu cần.
- Explicit lesson mode returns the full 20-card unit.
- `tests/verb_section_books_test.php`.
- PWA cache `yanglingo-static-v29`.

## v30 lesson-session fix
- `assets/app.js`: selected set/lesson opens the full lesson slice instead of the due-only subset.
- `index.php`: app asset cache-bust bumped to `v=30`.
- `service-worker.js`: static cache bumped to `yanglingo-static-v30`.
- `tests/lesson_full_session_test.php`: regression guard for 20/20 lesson mode.


## v31 changed files
- `lib/Repository.php` – packaged book ensure/sync
- `api.php` – `flashcard_books_sync`
- `assets/app.js` – Library auto-sync before folder/set loading
- `index.php`, `service-worker.js` – cache v31
- `tests/library_flashbook_sync_test.php`
