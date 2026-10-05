# Deploy YangLingo on HelioHost

## v33 — SAFE OVERWRITE: Irregular Verb normalization

1. Export a fresh production DB backup.
2. Keep the existing `config.local.php` and live database.
3. Upload/extract the v33 ZIP over the current full YangLingo tree.
4. **Do not run setup, do not import an old SQL dump, do not DROP/TRUNCATE tables.**
5. Hard refresh so `yanglingo-static-v33` replaces v32.
6. Log in and open **Thư viện** or **Bộ Flashcard TOEIC** once. The CSRF-protected packaged-book sync will:
   - preserve the existing `verb_irregular_800_book` set ID;
   - normalize matching Core card content in place where needed;
   - append canonical Core cards that are missing;
   - create the new Extended 40 book only if absent;
   - append the new `oversee vs overlook` trap if missing.
7. In **Bộ Flashcard TOEIC**, verify the integrity badge. Core should show **120 thẻ chuẩn** and `✓ Đủ`; a `+N legacy` badge is safe and means old cards were preserved rather than deleted.
8. Verify one previously reviewed irregular card still has its prior SRS state/due date.

**Rollback:** restore the previous source files. v33 has no DB schema migration. If v33 already appended new cards, leaving them is safe; if you require an exact data rollback, restore the DB backup rather than manually deleting cards with SRS relations.

## v32 — SAFE OVERWRITE (khuyến nghị cho site hiện tại)

**Điều kiện:** site đã có full YangLingo v31-compatible source. Gói v32 này là overlay, không phải fresh-install ZIP.

1. Backup database production thành một file `.sql` ở vị trí riêng tư; không để file backup trong `public_html`.
2. Backup các file production hiện tại, đặc biệt `config.local.php`.
3. **Không chạy lại `setup.php`, không DROP/TRUNCATE bảng, không import lại full seed/database.**
4. Upload ZIP v32 vào document root và extract đè lên source hiện tại.
5. Giữ nguyên `config.local.php`, uploads và database live.
6. Mở site, đăng nhập, vào **Hôm nay** và kiểm tra Daily Plan.
7. Test lần lượt `#review/due`, `#review/relearning`, `#review/hard`, `#review/new`, Mistake Book, Listening và TOEIC Part 5.
8. Hard refresh (`Ctrl+F5`) hoặc đóng/mở PWA để cache `yanglingo-static-v32` thay thế v31.
9. Nếu có lỗi, rollback **file source** về backup. Vì v32 không có schema migration nên không cần rollback database.

### Data-safety contract

v32 không thêm migration/seed, không đổi user/card IDs, không reset AUTO_INCREMENT và không xóa learning progress. Những vocabulary, Flashcard Books, sentence patterns, SRS, mistakes và attempts bạn đã thêm hôm nay được giữ trong database hiện tại.


## 1. Backup an existing installation

Export the existing database and save the current server-side `config.local.php` before overwriting files.

## 2. Upload

Upload `YangLingo_TOEIC_800_Part1_Vocabulary_Production_Final.zip` into the domain document root (`public_html` or the domain root in Plesk) and extract it. The ZIP does not require Node/Composer/XAMPP to run.

## 3. Database

Create/identify a MariaDB database, database user and host in HelioHost/Plesk. Use a dedicated DB user with only the permissions needed by the application.

## 4A. New installation

Open `/setup.php`, enter DB settings and create the initial admin. Setup writes `config.local.php` on the server and applies base schema, migrations and content seeds.

## 4B. Upgrade

Preserve the existing production `config.local.php`, overwrite source files, then open the site. `Database::ensureSchema()` applies only untracked migration/seed files and verifies checksums for files already applied.

**Do not edit an already-applied migration/seed on production.** Add a new numbered file instead.

## 5. Smoke test

Follow `docs/HELIOHOST_SMOKE_TEST.md`.

For this handbook release, also verify after login:

1. open **Học liệu 800+**;
2. confirm **4 handbooks** are listed; open the new `HELEN TOEIC Part 1 Vocabulary` handbook and one of its 7 sections;
3. mark/unmark a chapter as completed;
4. in Listening, play/reveal at least one source self-check item;
5. in Verb Master/Grammar, save one related item to personal SRS;
6. open at least one bundled PDF source and the HELEN local CSV source snapshot.

On first request after overwrite, the existing schema runner keeps previously tracked files untouched and applies the new tracked seed `022_helen_toeic_part1_vocabulary.sql` after the handbook schema/content already present. Keep the production database and `config.local.php`; do not manually drop/recreate tables.

Optional admin diagnostic after login:

`/admin/db-check.php`

It displays PHP/PDO state, connection success and safe table/seed counts without showing credentials or accepting SQL.

## 6. Database integration test

If HelioHost SSH/CLI PHP is available:

```bash
php tests/db_integration_test.php
```

For the full clean-migration, seed-idempotency and repository-flow procedure, follow `docs/HELIOHOST_MARIADB_INTEGRATION_TEST.md`. If CLI is unavailable, use the admin diagnostic plus the browser checklist there.

## 7. Post-deploy hygiene

- use HTTPS;
- change demo/temporary passwords;
- do not upload `.env`, database backups or local credential files;
- keep regular DB backups;
- optionally remove/rename the diagnostic endpoint after verification if you prefer a smaller exposed surface (it remains admin-only).

## Flashcard Books v27 upgrade
This release does **not** add a new database migration. After overwrite and hard refresh, open **Flashcard Books** in the sidebar. The HELEN TOEIC Part 1 book appears immediately as a packaged catalog item. Click **Tạo Book Flashcard** once for each learner account that wants a personal SRS copy. YangLingo then creates a normal user-owned set containing all 141 source rows; existing cards, SRS progress, mistakes and attempt history are untouched.


## Bộ Flashcard TOEIC v28 upgrade
This release adds no schema migration. If production is already on the previous HELEN Flashcard Book release, upload/extract the v28 **OVERWRITE** package and keep the existing database plus `config.local.php`. Hard refresh after deployment because the PWA cache key is now `yanglingo-static-v28`.

After login, open **Bộ Flashcard TOEIC**. Four catalog books should be visible: HELEN Part 1 (141), Verb Master 800+ (337), Listening Vocabulary/Chunks (85), Grammar Structures/Confusing Words (233). Click **Tạo Book Flashcard** only for the books wanted by that account. Existing HELEN sets, SRS progress, mistakes, TOEIC/Aptis attempts and handbook progress are not deleted. The old folder name `TOEIC Flashcard Books` is renamed to `Bộ Flashcard TOEIC 800+` on first book installation/use when applicable.

## v29 – Verb Master books by PDF headings
If production is already on v28, upload/extract the v29 **OVERWRITE** package over the existing site. Keep the live database and `config.local.php`. Open the site once so migration `014_flashcard_book_section_titles.sql` runs, then hard-refresh (`Ctrl+F5`) because the PWA cache key is `yanglingo-static-v29`.

In **Bộ Flashcard TOEIC**, verify the separate books **5.1 Kinh doanh & Quản lý**, **5.2 Nhân sự & Giao tiếp**, **5.3 Tài chính & Mua sắm**, and **5.4 Vận hành & Hậu cần**. If a combined Verb Master book was created previously, it remains in the library as **Tổng hợp (bản cũ)** and can be kept or deleted manually; no SRS is deleted automatically.

When a learner opens a 20-card lesson from **Lộ trình học**, all 20 cards are now loaded. The standalone **Ôn tập** page remains an SRS due queue, so seeing 7 there means 7 cards are due—not that 13 cards are missing.


## v31 – Library auto-sync
Sau overwrite + Ctrl+F5, mở **Thư viện** một lần. Lần tải đầu có thể chậm hơn vài giây vì YangLingo tạo các book TOEIC còn thiếu cho tài khoản. Sau đó phải thấy folder **Bộ Flashcard TOEIC 800+** và các set 5.1/5.2/5.3/5.4 cùng những book đóng gói khác. Không xóa DB và không import lại SQL.
