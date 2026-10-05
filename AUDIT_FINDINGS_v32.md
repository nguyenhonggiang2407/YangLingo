# YangLingo v32 — Audit Findings

## Scope audited

Input artifact: `YangLingo_TOEIC_800_Library_Books_AUTO_SYNC_OVERWRITE.zip`.

The uploaded artifact is an overwrite patch rather than a complete fresh-install repository. It contains the current `index.php`, `api.php`, `lib/Repository.php`, `assets/app.js`, service worker, release documentation and a small regression-test subset. It references full-production dependencies that are intentionally not bundled in the overwrite package.

This release therefore preserves the existing production tree and database and only changes files present in the overlay. No production database was mutated during this audit.

## P0 findings and fixes

### 1. Dashboard hierarchy did not match the adaptive-learning goal

**Finding:** the dashboard presented statistics before the daily action path.

**Fix:** changed the learner dashboard to action-first. `Hôm nay` and the primary `Bắt đầu buổi học` flow now precede secondary statistics.

### 2. Daily Plan queues were not sufficiently separated

**Finding:** due review did not expose Relearning and Hard Cards as independent priority queues, making the requested P0 order difficult to enforce without double counting.

**Fix:** Daily Plan now uses disjoint regular-due, Relearning and Hard Card counts and exposes the exact priority order:

1. Due SRS
2. Relearning
3. Recent Mistakes
4. Weak Skills
5. Hard Cards
6. Listening
7. TOEIC
8. Collocation
9. Sentence Pattern / Grammar
10. New Knowledge

### 3. New-content workload needed stronger backlog/retention coupling

**Finding:** the existing adaptive policy existed, but the daily new-item allowance could drift as newly learned cards disappeared from the "new available" pool during the day.

**Fix:** reuse the existing `AdaptiveLearningService::workloadPolicy()` and stabilize the daily allowance by accounting for vocabulary study events already completed today. Existing backlog/retention logic remains the source of truth.

### 4. Dedicated review routes were missing

**Finding:** the UI could not directly start Due, Relearning, Hard or New queues from a Daily Plan task.

**Fix:** added `study_cards` modes `due`, `relearning`, `hard`, `new` and corresponding frontend routes.

## P1 findings and fixes

### 5. Weakness display could not always report real accuracy

**Finding:** mistake-only aggregation can show frequency/severity but cannot truthfully infer accuracy without knowing all attempts.

**Fix:** keep mistake-pattern severity, and additionally derive TOEIC Part and grammar-category accuracy from actual `toeic_attempts` joined to `toeic_questions`. Accuracy is displayed only where measurable.

### 6. TOEIC Part 5 feedback was not structured enough

**Finding:** the response returned correctness/explanation but not the requested explicit reasoning flow.

**Fix:** Part 5 responses now include four structured steps plus Final Answer. Existing question metadata/explanation is reused. When source content does not contain distractor-specific rationale, the UI explicitly avoids inventing one.

### 7. TOEIC daily accounting could mix exam families

**Fix:** the Daily Plan TOEIC task counts TOEIC study events only; Aptis is preserved for backward compatibility but is not counted toward the TOEIC daily target.

## Data safety

v32 intentionally adds **no database migration and no seed** because the required behavior can be implemented against the existing schema visible from the repository code. This is the lowest-risk choice for preserving current production data.

No executable `DROP TABLE`, `TRUNCATE TABLE`, user-table delete/reset, database re-seed, ID rewrite or destructive migration was introduced.

## Security / release hygiene

- Existing parameterized repository queries were preserved.
- User-owned card queues continue to scope by `user_id` and set ownership.
- No `.env`, production `config.local.php`, DB dump, log, nested ZIP or private key is bundled.
- Credential scan found no real credential in source. `you@example.com` is a UI placeholder.
- The package does not include or modify production credentials.

## Test result

Current overwrite package:

- PHP syntax: PASS — 9/9 PHP files.
- JavaScript syntax: PASS — 2/2 JS files.
- Regression test files: 4 PASS, 2 NOT EXECUTED, 0 FAIL.
- Dynamic Daily Plan fake-DB test: PASS.
- MariaDB/live HelioHost integration: NOT EXECUTED in this build environment.

The two NOT EXECUTED tests require full-source assets (`lib/compat.php` and the packaged Verb Master CSV) that are not present in the user-provided overwrite ZIP.

## Production-Final naming decision

The artifact is deliberately named `SAFE_OVERWRITE`, not `Production_Final`. A complete fresh-install repository and full live/full-tree regression were not available in the supplied ZIP. Calling this a complete Production Final would overstate what was actually verified.
