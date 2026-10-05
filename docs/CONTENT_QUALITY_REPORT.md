# Content Quality Report

This report is derived from the source/seed files bundled in the release. It is not a claim that every item has been reviewed by a human examiner.

## Final source scan

- Global Knowledge rows scanned: **1,449**
- TOEIC adaptive rows scanned: **300**
- Aptis baseline rows scanned: **608**
- Aptis fidelity replacement rows scanned: **110**
- Connected Speech clean-install active set: **100**
- Content correction updates in seed 018: **459**
- Aptis tasks retired with history preserved: **110**
- Aptis replacement tasks added: **110**
- Aptis active target after fidelity seed: **608**

## Automated final checks

- duplicate global type+term/source keys: **0 detected**
- duplicate TOEIC adaptive question text: **0 detected**
- TOEIC answer/option alignment errors: **0 detected**
- duplicate Aptis replacement `module+type+prompt` keys: **0 detected**
- malformed `word_matching` JSON in replacement pack: **0 detected**
- missing Aptis replacement explanations: **0 detected**
- placeholder/lorem patterns in final adaptive source packs: **0 detected**
- generic grammar correction patterns targeted by the quality pass: **0 remaining in correction seed**
- connected-speech expansion key duplicates: **0 detected**
- missing/broken bundled Aptis SVG files: **0 detected**
- invalid SVG structure in the nine Aptis media files: **0 detected**

## Corrections

`database/seeds/018_content_quality_corrections.sql` contains **459 idempotent UPDATE statements**, keyed by global `external_key`. The updates improve generic examples/metadata while preserving learner progress and historical attempts.

The final quality pass also replaces generic collocation wording with direct contextual use of the target collocation rather than meta-sentences that merely describe the phrase.

## Aptis fidelity/lifecycle

Seed 016 retires 110 low-fidelity/repetitive rows through `is_active=0` and inserts 110 stronger replacements. Rows are retired rather than deleted so historical attempts can continue to reference them.

The active bank remains **608** tasks/prompts.

## Manual-review limitation

Automated checks are effective for duplicate keys, malformed answers/JSON, placeholders and known template problems, but they cannot prove every pedagogical nuance across thousands of records. The release therefore makes no claim of official ETS/British Council validation. Continued human editorial review and real learner feedback remain appropriate future work.
