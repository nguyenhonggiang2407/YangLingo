# YangLingo Learning System

## v32 Daily Learning Loop

```text
Due SRS
→ Relearning
→ Recent Mistakes
→ Weak Skill
→ Hard Cards
→ Listening Recognition
→ TOEIC Practice
→ Collocation
→ Sentence Pattern / Grammar
→ New Knowledge
```

The first four SRS-related groups are intentionally separated. `due`, `relearning` and `hard` are disjoint live queues; `new` is admitted only after the adaptive workload policy has considered current backlog and 7-day recall retention. Weak Skill is an overlay recommendation: it routes the learner to TOEIC, Listening, Patterns or Knowledge Hub according to evidence, and is excluded from the aggregate progress denominator to avoid double-counting work already represented by those modules.

TOEIC Weakness Analysis uses two evidence families: unresolved/recurred Mistake Book patterns and real `toeic_attempts` accuracy grouped by Part/grammar category. Accuracy is displayed only when the system actually has correct/incorrect attempt data.


## Core loop

```text
Learn → Active Recall → Practice
→ Mistake → Error Classification
→ Root / Related Knowledge → Micro Lesson
→ Remedial Practice → SRS → Retest → Mastery
```

## SRS and mastery

Cards use New/Learning/Review/Relearning behavior. `Again` creates/continues relearning and a shorter retry. Mastery requires successful repetitions, stability and a correct streak; exposure count alone is not sufficient.

## Adaptive Daily Plan

Core decisions live in `AdaptiveLearningService.php`. The plan is deterministic and explainable.

Priority:
1. due/overdue SRS;
2. relearning;
3. mistakes, with recurrence weighted strongly;
4. weak skill;
5. hard cards;
6. listening maintenance;
7. relevant TOEIC/Aptis;
8. grammar/pattern/collocation;
9. controlled new vocabulary.

Backlog and retention change the new-item allowance. Every major plan row includes a learner-facing reason.

## Weakness and Knowledge Map

Mistakes are aggregated by error type/topic. Aptis/TOEIC attempts provide module/topic breakdowns. Skills with insufficient evidence are reported as unknown (“Chưa đủ dữ liệu”), not 0%.

`knowledge_item_links` provides explicit relations among Global Knowledge items, with topic fallback when a direct link is unavailable.

## Mistake remediation

Status flow:

```text
NEW → LEARNING → REVIEWING → RESOLVED
                         ↘
                          RECURRED (if the concept fails again)
```

A mistake lesson can return:
- error type/topic;
- correct answer/explanation;
- a matching Grammar Micro Lesson;
- related knowledge;
- up to three related TOEIC/Aptis remedial questions.

Two recent successful remedial attempts can move the mistake to `RESOLVED`. A later failure from a resolved concept becomes `RECURRED`.

## Collocation practice

Build the Collocation is backed by real global items. Each answer is posted to the backend as a learning event. Wrong collocation choices are stored in Mistake Book so collocation weakness affects future plans.

## Listening and Connected Speech

Listening Recognition is paired with 100 recognition cues across Linking, Weak Forms, Assimilation/Coalescence, Contractions and Reductions. Spoken cues such as “couldja” are explicitly described as listening aids, not formal spelling.

## TOEIC 800+ Handbooks

The three user-provided PDF handbooks plus the HELEN TOEIC Part 1 Google-Sheet vocabulary handbook are integrated as a source-preserving layer on top of the existing adaptive engine:

```text
Read source chapter
→ Active Recall / Listening self-check
→ Reveal answer or transcript only after an attempt
→ Save selected Grammar / Verb / Listening knowledge to personal SRS
→ Review through the normal Due → Relearning → Mistake → Weakness priority loop
→ apply in TOEIC Part 1–7 practice
```

The source PDFs and the local HELEN CSV snapshot remain available from the handbook UI. Chapter completion is user-scoped and is deliberately separate from SRS mastery: marking a chapter complete means “read/covered”, not “mastered”.

Listening content keeps the source structure. Where the supplied PDF gives a question and correct response/answer but not a full set of distractors, YangLingo uses **self-check** rather than inventing options. Part 3/4 items remain grouped by their original conversation/talk so the context is not broken apart.

Verb Master items retain V1/V2/V3, regular `-ed` pronunciation when supplied, examples and collocations. When a Verb Master item is saved to personal SRS it maps to a vocabulary card while carrying those source fields as review metadata.

## TOEIC and Aptis

Both exam engines reuse the same study-event, Mistake Book and weakness infrastructure. Aptis auto-graded tasks include multi-format JSON mapping/order types; Speaking/Writing use self-rubrics and local browser features but do not claim official scoring.

## Evaluation scope

`docs/EVALUATION.md` tests algorithmic behavior with deterministic learner fixtures. It does not claim real-world educational efficacy.


### HELEN TOEIC Part 1 vocabulary

The 141-row source is kept as seven source-tab sections. Each row supports example-sentence TTS, answer reveal and SRS linking. Knowledge Hub insertion is dedupe-aware by normalized active term so an upgrade reuses existing knowledge instead of multiplying obvious duplicate flashcards. Vocabulary-only rows are not converted into fake photograph questions.


## Bộ Flashcard TOEIC
Học liệu nguồn có hai lớp: **Handbook để hiểu/nghe/đọc** và **Flashcard Book để nhớ bằng Active Recall + SRS**. Catalog v29 có **10 book / 802 thẻ nguồn**: HELEN Part 1 (141), Verb Master Mục 1 (42), Mục 3 (106), Mục 4 (8), Mục 5.1 (109), Mục 5.2 (38), Mục 5.3 (14), Mục 5.4 (26), Listening 800+ (85), Grammar 800+ (233). Mỗi tài khoản chỉ tạo book mình muốn học.

Thư mục người dùng được chuẩn hóa thành `Bộ Flashcard TOEIC 800+`. Nếu tài khoản đã cài HELEN bằng release v27, thư mục cũ `TOEIC Flashcard Books` được đổi tên an toàn khi cài/mở book mới; set và SRS hiện tại không bị reset.

## v29 – PDF section books and lesson-vs-review semantics
Verb Master flashcards are grouped by the original PDF structure rather than one mixed book. Mục 5.1–5.4 are separate SRS sets. **Lộ trình học → Học 20 từ này** is an explicit lesson session and loads the whole 20-card unit. **Ôn tập** is still an SRS queue and intentionally shows only currently due/new-allowed cards.


## Library packaged-book sync
Từ v31, `#sets` gọi endpoint CSRF-protected `flashcard_books_sync` trước khi lấy folder/set. Endpoint chỉ materialize book thiếu; book đã cài được nhận diện bằng `flashcard_sets.source_type`, giữ nguyên SRS/progress.
