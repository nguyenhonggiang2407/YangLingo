# Final Changelog

## v33 — Irregular Verb Data Quality + Book Integrity

### Added
- `assets/flashbooks/toeic-irregular-verbs-core-v33.csv` — 120 canonical Core verbs.
- `assets/flashbooks/toeic-irregular-verbs-extended-v33.csv` — 40 Extended verbs.
- 9th Verb Trap card: `oversee–oversaw–overseen ↔ overlook–overlooked–overlooked`.
- `tests/irregular_verbs_v33_test.php` and `DATA_AUDIT_IRREGULAR_V33.md`.
- Flashbook integrity fields: `missing_count`, `extra_count`, `integrity_status`.

### Changed
- Existing `verb_irregular_800_book` becomes **3A. Irregular Verbs Core – TOEIC (120)** while retaining the same source type for backward compatibility.
- Added **3B. Irregular Verbs Extended – TOEIC (40)**.
- Existing Core content can be normalized in place by V1 key; matching card IDs are not recreated.
- PWA/app cache bumped to v33.

### Fixed
- Added missing high-value irregular forms including `be` and `oversee`.
- Prevented `overlook` from being taught as an irregular verb; it remains a regular-verb contrast.
- Existing installed Core/Trap books can append missing canonical cards without resetting SRS.

### Database / Data Safety
- No schema migration.
- No DROP/TRUNCATE/reset.
- No deletion of legacy cards.
- No replacement of matching card IDs or SRS rows.

## v32 — Adaptive TOEIC Focus

### Added
- Dedicated SRS priority queues: `due`, `relearning`, `hard`, `new`.
- Real TOEIC weakness dimensions by Part and grammar category from `toeic_attempts`.
- Structured TOEIC Part 5 feedback: Step 1–4 + Final Answer.
- `tests/adaptive_toeic_daily_plan_v32_test.php`.
- `DATABASE_CHANGELOG.md` and `OVERWRITE_SCOPE.md`.

### Changed
- Daily Plan priority is now: Due SRS → Relearning → Mistakes → Weakness → Hard Cards → Listening → TOEIC → Collocation → Sentence Pattern → New Knowledge.
- Dashboard renamed to **Hôm nay** and moved to action-first layout; statistics appear afterwards.
- Daily Plan TOEIC task no longer counts Aptis attempts.
- PWA/app cache bumped to v32.

### Fixed
- Relearning/Hard/New can now open dedicated review queues instead of being only metadata inside one generic review task.
- New-item daily allowance remains stable while cards learned earlier the same day leave the “new” pool.
- Weakness UI can show real accuracy when the evidence comes from TOEIC attempts.

### Security
- No new external API dependency.
- Existing CSRF-protected `study_cards` GET flow and ownership-constrained repository queries are reused.

### Database
- **No schema migration or seed in v32.** No destructive SQL was introduced.

### UI/UX
- “Bắt đầu buổi học” is the primary action.
- Zero-work Daily Plan rows are hidden from the action list to reduce dashboard clutter.


## HELEN TOEIC Part 1 Vocabulary — Google Sheet Integration
- integrated **141 source rows** from the user-provided Google Sheet `HELEN TOEIC - TỪ VỰNG HAY GẶP PART 1 TOEIC`;
- preserved all 7 source tabs: Eye-controlled action, Manual operation, Movement/Sports/Posture, Clothing/Daily Life, Objects/Equipment, Scenes/Surroundings and Object States/Arrangements;
- added a fourth **Học liệu 800+** handbook with 7 tracked sections and 141 vocabulary-recall practice items;
- each practice row keeps the supplied term/chunk, IPA, Vietnamese meaning and English example; TTS plays the supplied example sentence;
- added `database/seeds/022_helen_toeic_part1_vocabulary.sql`; Knowledge Hub insertion is additive and deduplicates by normalized live-database term while handbook practice preserves every source row;
- `Fasten` appears in two source tabs, so the source has 141 rows but 140 normalized unique terms; both source occurrences remain in their original sections;
- bundled `assets/handbooks/helen-toeic-part1-vocabulary.csv` as a local source snapshot;
- did not fabricate Part 1 image questions or distractors from vocabulary-only source data;
- source wording is preserved, including source typos, because this integration does not silently rewrite user-provided material.


## TOEIC 800+ Handbook Integration — 3 user-provided PDFs
- added a dedicated **Học liệu 800+** area without replacing the existing SRS/TOEIC/Aptis architecture;
- integrated the complete source text of the Grammar, Listening and Verb Master PDFs into 35 tracked handbook sections;
- bundled the three original PDFs under `assets/handbooks/` so each chapter can open its source document;
- added exactly **100 Listening self-check items** from the Listening handbook (10 Part 1 sentences, 30 Part 2 question-response items, 36 Part 3 questions grouped under 12 conversations, and 24 Part 4 questions grouped under 8 talks);
- added **293 source-derived Verb Master knowledge items** with V1/V2/V3, `-ed` pronunciation, topic/example/collocation metadata when present;
- added **16 source-derived Grammar Lesson items** and **60 Listening Recognition items** to Global Knowledge;
- linked 378 handbook-section → Global Knowledge relations so handbook reading can continue directly into personal SRS;
- added per-user chapter completion/progress without altering existing learner history;
- no fabricated Listening distractors were added: source question/answer/transcript material is presented as self-check where the PDF does not provide full MCQ options.

## Adaptive Learning
- extracted deterministic workload/priority rules into `AdaptiveLearningService`;
- review-first Daily Plan now includes explainable reasons;
- low/medium/high backlog policies and retention adaptation;
- Knowledge Map uses real evidence and shows “Chưa đủ dữ liệu” when necessary.

## Error Remediation
- mistake lifecycle standardized to NEW/LEARNING/REVIEWING/RESOLVED/RECURRED;
- fixed API response for a resolved mistake that recurs;
- related knowledge and targeted remedial questions;
- remedial attempts influence mistake status;
- collocation practice now records study events and mistakes.

## Knowledge Linking
- added relational `knowledge_item_links` and topic fallback;
- Global Knowledge remains shared while user progress stays separate.

## Connected Speech
- expanded clean-install curriculum from 18 to 100 cues;
- categories: Linking, Weak Forms, Assimilation/Coalescence, Contractions, Reductions;
- removed a duplicate “pick it up” expansion and replaced it with “fill it out”.

## Aptis
- active target remains 608; 110 repetitive tasks are retired and 110 higher-fidelity tasks inserted without deleting history;
- added real word-matching JSON renderer/validation and higher-fidelity Reading types;
- Speaking Part 1–4 selector, 9 local original SVG media assets, preparation/response timer, local MediaRecorder playback/retry and six-dimension rubric;
- Writing Part 1–4 selector, countdown, scoped local autosave/restore, word count and six-dimension rubric;
- Aptis fetch limit raised so all 64 productive prompts are reachable.

## Content Quality
- seed 018 contains 459 keyed corrections;
- all 53 Grammar Micro Lessons now use concrete examples, common-mistake guidance and drills instead of generic “apply the rule” text;
- automated duplicate/answer/JSON/placeholder checks expanded.

## Database
- schema/content remain separated into migrations/seeds;
- content seed execution now runs in per-seed transactions plus checksum tracking;
- added remediation/media schema migration.

## Security
- preserved import ZIP/XML/XLSX resource limits;
- admin-only DB self-check exposes no credentials or arbitrary SQL;
- credential/junk scan included in release process.

## Testing / Documentation
- added adaptive scenario, productive-skill, seed and UI/PWA static tests;
- added Adaptive Algorithm, Academic Rationale, Evaluation, Performance and final Content Quality documentation;
- Defense Q&A expanded to 80 questions.

## MariaDB Hotfix 01

- Corrected DB diagnostic core-table names (`flashcards`, `srs_progress`).
- DB diagnostic now separates total TOEIC rows from the 300-row adaptive pack.
- Added seed `020_aptis_writing_14_hotfix.sql` to restore 14 Writing prompts skipped by MariaDB's `(module,prompt(190))` unique-prefix index.
- Existing Aptis attempts/history are preserved; no destructive migration is used.


## Flashcard Book v27 – HELEN TOEIC Part 1
- Added a dedicated **Flashcard Books** route, separate from Học liệu 800+.
- Added one-click personal book installer for **HELEN TOEIC Part 1 – Flashcard Book**.
- The installer copies all **141 source rows / 7 topics** into the logged-in learner’s normal flashcard/SRS system.
- Preserves both source occurrences of `Fasten` because they belong to different source topics/examples; the source has 140 unique normalized terms but 141 learning rows.
- Each card keeps IPA, Vietnamese meaning, source example, source category, TOEIC Part 1 metadata and example audio text.
- Installation is lazy/idempotent per user and does not modify existing sets, SRS or history.
- PWA cache bumped to `yanglingo-static-v27`.


## v28 – PDF Vocabulary & Grammar Flashcard Books
- Renamed the learner-facing route from **Flashcard Books** to **Bộ Flashcard TOEIC** and the user folder to **Bộ Flashcard TOEIC 800+**.
- Preserved the existing HELEN 141-card book and Vietnamese-localized its seven topic names.
- Added **TOEIC Verb Master 800+ – Flashcard Book** with **337** source-grounded cards. It includes the 293 structured Verb Master items plus explicit -ed practice/special forms and source-listed verb pairs that were not yet represented as standalone items.
- Added **TOEIC Listening 800+ – Từ vựng & Cụm nghe** with **85** cards from the PDF's explicit Part 1–4 vocabulary/chunk lists.
- Added **TOEIC Grammar 800+ – Cấu trúc & Từ dễ nhầm** with **233** cards from word-form cues, fixed preposition phrases, verb/adjective + preposition, connectors, gerund/infinitive triggers, subjunctive triggers and confusing-word groups.
- Every one of the four handbook landing pages now links to **Học bằng Flashcard**.
- Book installer is now generic/idempotent per user, uses dynamic counts, and preserves existing SRS/history.
- Added immutable packaged CSV snapshots under `assets/flashbooks/` plus reproducible build script `tools/build_pdf_flashbooks.py`.
- Added `tests/pdf_flashbooks_test.php` and updated HELEN regression.
- PWA cache bumped to `yanglingo-static-v28`.
- No database schema migration is introduced by v28.

## v29 – Verb Master books split by PDF headings + 20-card lesson fix
- Replaced the single combined Verb Master catalog entry with books matching the source PDF headings: Mục 1, 3, 4, 5.1, 5.2, 5.3 and 5.4.
- Mục 5 books are named exactly: **5.1 Kinh doanh & Quản lý**, **5.2 Nhân sự & Giao tiếp**, **5.3 Tài chính & Mua sắm**, **5.4 Vận hành & Hậu cần**.
- Added an 8-card contrast book for Mục 4 (read, lead, pay, -ought group, rise/raise, lie/lay, find/found, overlook).
- An explicit lesson started from **Lộ trình học** now loads the complete 20-card lesson instead of applying the global due/new-card cap; normal **Ôn tập** still shows only cards currently due.
- Legacy combined Verb Master sets are preserved and renamed **TOEIC Verb Master 800+ – Tổng hợp (bản cũ)** by migration 014; SRS rows are untouched.
- Lesson labels changed from “Nhóm cá nhân” to the clearer “Bài 1 / Bài 2 / …”.
- PWA cache bumped to `yanglingo-static-v29`.

## v30 - Lesson 20/20 routing fix
- Fixed the confusing flow where a selected lesson displayed 20 cards in the roadmap but `#review` still loaded only the due SRS subset (for example 7/20).
- Entering a set/lesson now opens the complete lesson slice (20 cards, except the final partial lesson).
- Direct sidebar **Ôn tập** remains a true due-only SRS queue.
- Added an explicit `Chế độ bài học · đủ N/N thẻ` indicator and regression coverage.
- Bumped PWA cache to `yanglingo-static-v30`.


## v31 – Library Flashcard Book auto-sync fix
- Fixed the mismatch where packaged TOEIC books appeared only in `Bộ Flashcard TOEIC` catalog but not in `Thư viện`.
- Opening `Thư viện` now idempotently materializes every missing packaged TOEIC book for the authenticated learner, including 5.1–5.4 Verb Master sections, Listening, Grammar, and HELEN.
- Existing sets/SRS are detected by `source_type` and are not duplicated or reset.
- Renames the legacy folder to `Bộ Flashcard TOEIC 800+` during first sync.
- PWA cache bumped to v31.
