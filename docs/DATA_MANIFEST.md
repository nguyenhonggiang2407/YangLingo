# Data Manifest

Counts are derived from files bundled in this release.

## Global Knowledge Library

Source: `database/seeds/adaptive_global_learning_1449.csv`

| Type | Active source records |
|---|---:|
| Vocabulary | 410 |
| Collocations | 260 |
| Sentence Patterns | 193 |
| Grammar Micro Lessons | 53 |
| Listening Recognition | 340 |
| Paraphrase pairs | 193 |
| **Global Knowledge total** | **1,449** |

## Connected Speech

| Source | Records |
|---|---:|
| Existing migration 007 | 6 |
| Existing seed 014 | 12 |
| Added seed 015 | 82 |
| **Final clean-install active total** | **100** |

Added seed 015 distribution: Linking 20, Weak Forms 16, Assimilation/Coalescence 14, Contractions 20, Reductions 12.

## TOEIC

Adaptive pack `toeic_adaptive_300.csv`:

| Part | Records |
|---|---:|
| Part 2 | 70 |
| Part 5 | 100 |
| Part 6 | 50 |
| Part 7 | 80 |
| **Adaptive pack total** | **300** |

Historical starter rows in migrations are not included in this 300 count.

## Aptis

Baseline pack: 608 rows. Seed 016 retires 110 rows and inserts 110 replacements, preserving an **active target of 608** plus **110 retired historical rows** on a clean install after the fidelity upgrade.

Active skill totals remain:

| Skill | Active |
|---|---:|
| Grammar | 150 |
| Vocabulary | 150 |
| Reading | 90 |
| Listening | 90 |
| Speaking | 64 |
| Writing | 64 |
| **Active total** | **608** |

Vocabulary active distribution after replacement: definition 28, usage 28, synonym 27, collocation 27, word matching 10, word combination 10, meaning in context 10, word pairs 10.

Reading active distribution after replacement: sentence ordering 20, text cohesion 20, long text 20, opinion matching 15, heading matching 15.


## HELEN TOEIC Part 1 Vocabulary (Google Sheet)

Source snapshot: `assets/handbooks/helen-toeic-part1-vocabulary.csv`.

| Source tab | Rows |
|---|---:|
| Eye-controlled action | 12 |
| Manual operation | 33 |
| Movement, Sports & Posture | 20 |
| Clothing & Daily Life | 15 |
| Objects & Equipment | 28 |
| Scenes & Surroundings | 13 |
| Object States & Arrangements | 20 |
| **Total source rows** | **141** |

There are **140 normalized unique terms** because `Fasten` appears in two source tabs. The handbook preserves both source occurrences. `022_helen_toeic_part1_vocabulary.sql` creates 141 recall items and 141 dedupe-aware Knowledge Hub relations. The number of newly inserted Global Knowledge rows is intentionally not hard-coded: on an upgrade, existing matching terms are reused rather than duplicated.

## Content lifecycle

- Global curriculum rows are shared; they are not cloned per learner.
- User progress is stored separately.
- Content seeds are checksum-tracked in `content_seeds`.
- Global rows use `external_key` and `content_hash` uniqueness.
- Retired Aptis rows are not deleted, preserving attempt history.

## Summary

For the principal curriculum/practice sets requested in the final prompt:

- Global Knowledge: **1,449**
- Connected Speech: **100**
- TOEIC adaptive pack: **300**
- Aptis active: **608**
- Aptis retired history-preserving rows after fidelity upgrade: **110**

Do not interpret the simple sum as a claim of unique linguistic concepts because some categories intentionally reinforce the same knowledge through different modalities.
