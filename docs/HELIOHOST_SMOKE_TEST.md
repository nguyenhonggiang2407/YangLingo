# HelioHost Smoke Test

1. Create a MariaDB database and user in HelioHost/Plesk.
2. Upload/extract the ZIP in the site document root.
3. Open `/setup.php`, enter DB credentials and create the first admin.
4. Confirm setup reports schema/migrations/content seeds without error.
5. Register or log in as a learner.
6. Dashboard: verify Daily Plan, reasons and due count.
7. Flashcards/SRS: review a card and reload.
8. Mistake Book: answer one practice item incorrectly, open its micro lesson and complete a remedial item.
9. Knowledge Map: verify skills show real percentages only where data exists; otherwise “Chưa đủ dữ liệu”.
10. Listening: verify Connected Speech filters and recognition cues.
11. Học liệu 800+: confirm all 4 handbook cards appear; open one PDF handbook and the HELEN TOEIC Part 1 Vocabulary handbook, mark a section complete, and open a bundled source file.
12. Listening handbook: play/reveal one source self-check and verify Part 3/4 context is grouped correctly.
13. Grammar/Verb/HELEN handbook: save one related source item to SRS and verify it appears in the learner Knowledge Hub set; in HELEN Manual operation verify the section reports 33 recall items.
14. TOEIC: submit one Part 2/5/6/7 item and verify explanation appears only after submit.
15. Aptis: test MCQ, word matching, Reading ordering, Speaking recording/media/timer and Writing draft/timer.
16. Admin: test content search/CRUD/import with a small safe CSV/XLSX/DOCX sample.
17. Log out and verify authenticated APIs are inaccessible.

## Optional database CLI check

If SSH/CLI PHP is available:

```bash
php tests/db_integration_test.php
```

The expected successful result begins with `DB INTEGRATION PASS`. If CLI is unavailable, use phpMyAdmin to confirm `schema_migrations`, `content_seeds`, `global_learning_items`, `toeic_questions` and `aptis_questions` are populated.
