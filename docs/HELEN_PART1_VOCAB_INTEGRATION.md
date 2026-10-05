# HELEN TOEIC Part 1 Vocabulary Integration

## Source

Google Sheet title: **HELEN TOEIC - TỪ VỰNG HAY GẶP PART 1 TOEIC**.

Local source snapshot: `assets/handbooks/helen-toeic-part1-vocabulary.csv`  
SHA-256: `ba8e5f122d83686b84054f463fe1fefd06bda1aa780eb1245e05316d7bd0de86`

## Source fidelity

YangLingo preserves the supplied term/chunk, IPA, Vietnamese meaning, example sentence and source-tab organization. It does **not** invent missing translations, CEFR levels, distractors or photograph questions. Source wording is not silently corrected; this makes the local snapshot auditable against the user-provided sheet.

## Structure

- 7 source tabs → 7 handbook sections.
- 141 source rows → 141 `VOCABULARY_RECALL` practice items.
- 140 normalized unique terms because `Fasten` occurs in two tabs.
- Example sentences are used as TTS context audio.
- Each row links into Knowledge Hub/SRS.

## Deduplication

`database/seeds/022_helen_toeic_part1_vocabulary.sql` checks the **live database** by normalized active term before adding a new Global Knowledge row. If a term already exists, the handbook row is linked to the existing item. This prevents obvious duplicate flashcards while preserving all source rows in the handbook.

## TOEIC scope

The source is a vocabulary/chunk bank for TOEIC Part 1. YangLingo exposes it as vocabulary recall + contextual listening + SRS material. It is **not** converted into fabricated Part 1 photograph questions because the source does not include the necessary images/options.
