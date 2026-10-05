# Data Audit — Irregular Verbs v33

## Decision

YangLingo does **not** chase a cosmetic “360 irregular verbs” number. The production learning set is normalized into:

- **Core 120** irregular verbs for high-frequency/general/TOEIC use.
- **Extended 40** irregular verbs for broader Business English recognition.
- **160 unique V1 keys total** across Core + Extended.
- **9 Verb Trap cards** kept separately for confusing contrasts such as `rise/raise`, `lie/lay`, `find/found`, and `oversee/overlook`.

## Data-quality rules

1. `be → was/were → been` is present.
2. `oversee → oversaw → overseen` is present.
3. `overlook → overlooked → overlooked` is **not** classified as irregular; it is taught only in the contrast/trap book.
4. Accepted modern variants are preserved with `/`, e.g. `burned/burnt`, `learned/learnt`, `got/gotten`.
5. Core and Extended contain no duplicate V1 terms.
6. No IPA is fabricated where the release does not have a verified pronunciation source. TTS/audio text remains available from the V1/V2/V3 string.
7. Existing production cards are synchronized **in place** where the V1 key matches. Card IDs and `srs_progress` rows are not replaced.
8. Missing canonical cards are append-only. Legacy cards that are no longer part of the canonical source are not deleted automatically.

## Production safety

The existing `verb_irregular_800_book` source type is retained for Core 120. This means an already-installed learner book is upgraded rather than replaced. On first Library/Flashbook sync after v33:

- matching legacy irregular cards can have content normalized in place;
- missing Core cards are appended;
- the new Extended 40 book is created only if absent;
- the Verb Trap book receives the new `oversee vs overlook` card if absent;
- no SRS/progress reset occurs.

## Expected catalog impact

Historical v29/v32 catalog baseline: **10 books / 802 source cards**.

v33 canonical catalog target on a full installation: **11 books / 857 source cards**.

The increase is:

- Core irregular: 106 → 120 (**+14** canonical cards),
- Extended irregular: **+40** new cards,
- Verb Traps: 8 → 9 (**+1** card).

Net: **+55 source cards**.
