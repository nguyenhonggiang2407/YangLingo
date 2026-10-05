# Aptis Module — YangLingo v5

YangLingo v5 integrates Aptis practice into the existing account, database and learning workflow.

## Learner flows
- Grammar / Vocabulary / Reading / Listening: server-side answer checking; wrong answers feed Mistake Book V2.
- Speaking: browser MediaRecorder for local playback; only duration, self-score and notes are stored. Audio is not uploaded by default.
- Writing: response text, word count, self-score and notes are stored.
- Mini Mock: 20 mixed auto-scored questions with a 30-minute timer.
- History: recent auto-scored attempts and module accuracy.

## Admin import
Open `#aptis` as an admin and upload `templates/aptis-question-import-template.csv`. `options` uses `|` as the separator. Duplicate module+prompt rows are updated rather than duplicated.

## Data provenance
The bundled starter bank is original demonstration/practice content from YangAptis. It is not copied from the credentialed third-party site mentioned in chat.


## v6 — Guided key-learning workflow

YangLingo v6 adds a study guide based on the learning resources supplied by the user. The key principle is: **Listening and Reading must be translated and understood, not memorized by answer position.**

Workflow: translate meaning → identify keywords/synonyms → notice paraphrases → answer → send mistakes to Mistake Book/SRS → retry later.

Speaking uses flexible idea frames (place/action/feeling/atmosphere/weather; compare pictures; situation-result-opinion). Writing separates B1 and B2 guidance and treats templates as structural scaffolds rather than fixed scripts. External Drive/Docs resources are linked from the guide page but are not bundled into the ZIP.
