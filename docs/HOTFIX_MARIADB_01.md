# MariaDB Hotfix 01

This hotfix was created from a live HelioHost diagnostic after the production upgrade.

## Fixes

1. `admin/db-check.php` now checks the real core table names used by YangLingo:
   - `flashcards` instead of the obsolete diagnostic label `cards`
   - `srs_progress` instead of the obsolete diagnostic label `reviews`
2. The diagnostic separates:
   - total TOEIC rows (including 19 historical starter questions on upgraded databases)
   - the 300-row adaptive TOEIC pack (`tags LIKE '%adaptive%'`)
3. `020_aptis_writing_14_hotfix.sql` restores 14 Aptis Writing prompts skipped by MariaDB's `UNIQUE(module,prompt(190))` prefix index.

## Root cause of the Aptis count

Seed 013 contains two groups of eight long Writing prompts. Inside each group, the first 190 characters are identical. Because the table uses a unique index on `(module,prompt(190))`, MariaDB inserts one prompt from each group and `INSERT IGNORE` skips the remaining seven in each group: 14 skipped rows total.

Seed 020 rephrases only those 14 skipped prompts so their unique prefixes differ. No existing Aptis attempts or historical rows are deleted.

## Deploy on an existing YangLingo site

Extract the patch at the YangLingo web root so the two paths below are overwritten/added:

- `admin/db-check.php`
- `database/seeds/020_aptis_writing_14_hotfix.sql`

Then open any authenticated YangLingo page once. `Database::runContentSeeds()` will see the new seed name and apply it exactly once.

After that, log in as ADMIN and open `/admin/db-check.php`.

Expected key results on the upgraded database:

- Global Knowledge: 1449
- Connected Speech: 100
- TOEIC adaptive pack: 300
- Aptis active: 608
- Aptis retired: 110
- Latest content seed: `020_aptis_writing_14_hotfix.sql`

The total TOEIC table may be 319 on an upgraded database because migrations 006/007 include 19 historical starter questions in addition to the 300 adaptive-pack rows.
