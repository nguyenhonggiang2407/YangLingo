# TOEIC 800+ Handbooks Integration

## Source package

This release integrates three user-provided PDFs plus one user-provided Google Sheet without replacing or silently rewriting their educational content:

1. **TOEIC Grammar 800+** — complete grammar handbook for a beginner-to-800+ Reading path.
2. **TOEIC Listening 100 câu 800+** — Part 1–4 learning material built around recognition, dictation and shadowing.
3. **TOEIC 800+ Verb Master** — `-ed` pronunciation, V1/V2/V3, TOEIC verbs by context and collocations.
4. **HELEN TOEIC Part 1 Vocabulary** — 141 source rows across seven Part 1 vocabulary/chunk categories.

The original PDFs are bundled in `assets/handbooks/`. A local CSV snapshot of the Google Sheet is bundled as `assets/handbooks/helen-toeic-part1-vocabulary.csv`.

## Data model

Migration `013_toeic_800_handbooks.sql` creates:

- `learning_handbooks` — handbook catalog;
- `learning_handbook_sections` — source-preserving chapter text;
- `user_handbook_progress` — per-user completion only;
- `handbook_practice_items` — source self-check/listening practice;
- `handbook_section_items` — relations to Global Knowledge.

PDF handbook content is versioned in `database/seeds/021_toeic_800_handbooks.sql`. The Google-Sheet vocabulary integration is versioned separately in `database/seeds/022_helen_toeic_part1_vocabulary.sql`, so already-applied production seeds are never edited.

## Content counts

- Handbooks: **4**
- Sections: **42** (35 PDF sections + 7 Part 1 vocabulary sections)
- Listening self-check items: **100**
  - Part 1 source sentences: 10
  - Part 2 question-response: 30
  - Part 3 questions: 36 under 12 conversations
  - Part 4 questions: 24 under 8 talks
- Global Knowledge additions: **369**
  - Verb Master: 293 unique verbs
  - Grammar Lesson: 16
  - Listening Recognition: 60 (10 + 30 + 12 grouped conversations + 8 grouped talks)
- Handbook → knowledge relations: **378** for the PDF package plus **141 dedupe-aware Part 1 relations**.
- HELEN Part 1 source: **141 rows / 140 normalized unique terms / 141 recall items**.

## Integrity rules

- Existing users, SRS, attempts, mistakes and adaptive data are untouched.
- Chapter completion does not equal SRS mastery.
- Listening questions without source distractors are rendered as self-check; no fake answer choices are generated.
- Part 3 and Part 4 retain the supplied conversation/talk grouping.
- Verb source metadata is carried into personal SRS when saved.
- HELEN source rows preserve the supplied IPA, Vietnamese meaning and example. Knowledge Hub term insertion checks the live database first and reuses an existing term instead of creating an obvious duplicate.
- Vocabulary-only source rows are not converted into fabricated Part 1 photograph questions.

## Recommended study path

```text
Daily Plan due/relearning first
→ Handbook chapter
→ Active Recall / Listening blind attempt
→ reveal source answer/transcript
→ save weak/high-value item to SRS
→ TOEIC application
→ Mistake Book remediation
```
