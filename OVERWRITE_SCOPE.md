# v32 Overwrite Scope

The user-provided ZIP was `YangLingo_TOEIC_800_Library_Books_AUTO_SYNC_OVERWRITE.zip`.

It is intentionally **not** a complete YangLingo repository. The uploaded artifact contains only the files needed by the recent Flashcard Book/library patch plus documentation/tests. The following full-project dependencies are referenced but absent from this overlay, including examples such as:

- `lib/bootstrap.php`, `lib/compat.php`, `lib/Auth.php`, `lib/Database.php`, `lib/SRS.php`;
- `lib/AdaptiveLearningService.php` and other services;
- most CSS/JS assets;
- `database/migrations/`, `database/seeds/`;
- `assets/flashbooks/`, handbook PDFs/CSV snapshots;
- admin/setup files and the full test suite.

Therefore this v32 artifact is packaged and labelled as a **SAFE OVERWRITE**, not falsely as a complete fresh-install `Production Final` source tree. It is designed to be extracted over the existing full production installation while preserving the live database.

## v33 note

This overlay now includes the two new irregular-verb CSV assets required by v33. It still relies on the existing full production tree for historical handbook assets, original PDF-derived flashbook CSVs, `lib/compat.php`, database/bootstrap classes, CSS, migrations/seeds and other unchanged application modules.
