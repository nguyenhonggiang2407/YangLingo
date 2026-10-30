# YangLingo Import Format V2

## Recommended template

Use:

`templates/learning-content-import-template.csv`

Save text/CSV data as UTF-8. The supplied template includes a UTF-8 BOM for spreadsheet compatibility.

## V2 columns

1. `card_type`
2. `term`
3. `definition`
4. `ipa`
5. `part_of_speech`
6. `cefr`
7. `topic`
8. `subtopic`
9. `toeic_part`
10. `difficulty`
11. `example_en`
12. `example_vi`
13. `collocations`
14. `word_family`
15. `pattern`
16. `explanation`
17. `audio_text`
18. `tags`
19. `source`
20. `notes`

## Required content

`term` and `definition` are the core fields. Advanced metadata is optional unless a specific learning mode needs it.

## Allowed card types

- `VOCABULARY`
- `COLLOCATION`
- `SENTENCE_PATTERN`
- `GRAMMAR`
- `LISTENING_CHUNK`
- `MISTAKE_CARD`

Unrecognized/blank card types are normalized to the safe default where applicable instead of forcing old data to be re-imported.

## TOEIC Part

Use integer `1` through `7`, or leave blank if not tied to a specific TOEIC Part.

## Difficulty

Use an integer from `1` (easier) to `5` (harder).

## Multi-value text

`collocations`, `word_family` and `tags` are stored as compact text metadata. Keep the format consistent within your dataset, e.g. semicolon-separated values:

`submit an application; submit a report; submit a request`

## Examples

### Vocabulary

`VOCABULARY,submit,nộp / trình,/səbˈmɪt/,verb,B1,Office,Documents,5,2,Please submit your application by Friday.,Vui lòng nộp đơn trước thứ Sáu.,submit an application; submit a report,submission,,send or present something formally,Please submit your application by Friday.,office;documents,YangLingo,`

### Sentence pattern

`SENTENCE_PATTERN,be responsible for + N/V-ing,chịu trách nhiệm về,,,,Grammar,Prepositions,5,2,She is responsible for training new employees.,Cô ấy chịu trách nhiệm đào tạo nhân viên mới.,,,be responsible for + N/V-ing,for is a preposition,,,,`

### Listening chunk

Put the full target sentence in `audio_text`; transcript/chunking metadata can be expanded in the learning content fields as needed.

## Backward compatibility

The existing importer still accepts the previous compact formats. You do **not** need to rewrite and re-import the old vocabulary library just to upgrade the site. New metadata may be added gradually through Admin/edit/import.

## Validation behavior

The importer/parser and server-side save path validate/normalize data such as card type, TOEIC Part and difficulty. Duplicate detection and import result reporting remain part of the existing import workflow.

## TOEIC Question Bank

This release manages TOEIC questions through the Admin Question Bank. Bulk TOEIC-question CSV import is **not** implemented, so do not use the learning-card CSV template as if it were a full TOEIC exam importer.

## Sentence Pattern bulk import (v3)

The **Cấu trúc câu → Import hàng loạt** modal accepts the normal Learning V2 format and also directly recognizes this specialized header:

`category,title,pattern,meaning_vi,grammar_note,example_en,example_vi,cloze_question,correct_answer,distractors,toeic_part,difficulty,tags,sort_order`

Mapping:

- `title` → `term`
- `meaning_vi` → `definition`
- `category` → `topic`
- `grammar_note` → `explanation`
- `pattern` → `pattern`
- missing `card_type` → automatically `SENTENCE_PATTERN`
- `cloze_question`, `correct_answer`, `distractors` → preserved in `notes`

Each valid row must contain a structure, Vietnamese meaning, English example and Vietnamese example. Duplicate personal pattern formulas are skipped.
