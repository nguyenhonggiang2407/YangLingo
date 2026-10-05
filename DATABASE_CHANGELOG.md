# Database Changelog — v32 Adaptive TOEIC Focus

## Summary

v32 intentionally introduces **no database schema change**. The current live database is treated as the source of truth because it may already contain vocabulary, Flashcard Books, sentence patterns, users, SRS state, mistakes and attempts added after the last full source archive.

## Tables reused (read/write behavior only)

- `srs_progress` — reads state/due/difficulty for disjoint Daily Plan queues; normal review writes remain unchanged.
- `flashcards`, `flashcard_sets` — ownership-scoped card queues; no IDs are rewritten.
- `study_events` — reads today's completed learning activity; existing writes remain unchanged.
- `mistake_book_v2` — reads unresolved/recurred mistakes for priority/weakness.
- `toeic_attempts`, `toeic_questions` — reads real Part/grammar accuracy; existing attempt insert remains unchanged.
- `global_learning_items` — reads collocation availability only.

## Tables added

None.

## Columns added/changed

None.

## Indexes added/changed

None.

## Migrations/seeds

None in v32. Existing tracked migrations/seeds on production must not be edited or re-run manually.

## Backward compatibility

- No URL/auth/session/user-role change.
- No password hash change.
- No user/card/question ID change.
- No `DROP`, `TRUNCATE`, destructive `DELETE`, or AUTO_INCREMENT reset.
- Existing v31 Flashcard Book `source_type` deduplication remains intact.

## Rollback

Rollback requires restoring the previous source files only. Because v32 has no DB migration, a database rollback is not required.

## v33

- Schema changes: **none**.
- New packaged data files: Core 120 + Extended 40 irregular verbs.
- Existing Core sync is application-level and preserves card IDs/SRS. Missing canonical cards are appended; legacy extras are retained.
- New Extended book uses a new `source_type=verb_irregular_extended_800_book`; it is created only if absent for the learner.
