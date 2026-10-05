# Feature Map

| Module | Status | Data source |
|---|---|---|
| Register/Login/Logout | Implemented | MySQL users + DB-backed sessions |
| Admin RBAC | Implemented | `users.role` + backend checks |
| Flashcard sets/folders | Implemented | MySQL |
| TXT/CSV/DOCX/XLSX import | Implemented | Uploaded file → MySQL |
| Importer V2 metadata | Implemented | `flashcards` metadata + V2 template |
| Adaptive SRS | Implemented | `srs_progress` |
| Due-first/adaptive new-card cap | Implemented | Repository Daily Plan + SRS queue + recent recall signals |
| Card mastery | Implemented | SRS stability/repetitions/streak |
| Daily Plan “Hôm nay” + Quick Study | Implemented | preferences + SRS + study events |
| Course/Module/Lesson architecture | Implemented | learning catalog tables |
| Quiz | Implemented | cards/content tables + study events |
| Listening V2 | Implemented | word/sentence/dictation + practice packs |
| Connected Speech / Shadowing | Implemented | migration 007 + browser speech synthesis |
| Fill / Matching | Implemented | practice content |
| Speaking recognition | Implemented with browser caveat | Web Speech API + pronunciation attempts |
| Mistake Book V2 | Implemented | standalone/card-backed errors + search/filter/resolve/reopen |
| Weakness summary | Implemented, rule-based | Mistake Book V2 |
| TOEIC Part 1–7 architecture/UI | Implemented | `toeic_questions` / attempts; answer/transcript delayed until attempt |
| TOEIC Admin Question Bank | Implemented | Admin CRUD/soft archive |
| Part 1–7 starter data | Implemented, intentionally small | migrations 006–007; local Part 1 illustrations |
| Authentic Part 1–4 media corpus | Requires admin/licensed content | image/audio URLs supported |
| AI Tutor / AI cards | Optional | External API only when configured |
| XP/Streak/Stats | Implemented | `study_events` |
| Leaderboard | Implemented | `study_events` |
| Bulk TOEIC question import | Not implemented | Use Admin Question Bank |
| VSTEP-specific engine | Not implemented | Outside this release |
| SMTP Forgot Password | Not implemented | Requires mail integration |

The UI should not advertise unsupported controls as if they were functional.
