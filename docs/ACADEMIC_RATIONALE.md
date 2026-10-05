# Academic Rationale

YangLingo is designed around established learning principles without claiming that this specific implementation has proven educational efficacy in a controlled human study.

## Spaced Repetition

Review intervals are adjusted from learner performance so unstable material returns sooner while stable material is reviewed less frequently. This reduces unnecessary repetition and protects against an uncontrolled review backlog.

## Active Recall

Flashcards, cloze questions, listening recognition, dictation and exam tasks require the learner to retrieve information before seeing the answer. The system therefore records attempts rather than treating passive exposure as mastery.

## Mastery Learning

YangLingo does not mark an item “mastered” merely because it was viewed many times. Mastery uses successful repetitions, stability and correct streak signals.

## Error-Driven Learning

Wrong answers are converted into structured mistakes. The learner sees the correct answer, error category, root knowledge, a micro lesson and related/remedial practice. A mistake can move through `NEW → LEARNING → REVIEWING → RESOLVED`, and may become `RECURRED` after a later failure.

## Deliberate Practice

Weak concepts receive targeted practice rather than only more random questions. Remedial questions are selected from related TOEIC/Aptis content where possible and are intended to test the same knowledge unit in a different context.

## Adaptive Practice

Daily workload depends on review backlog, retention and weakness evidence. This is an explainable rule engine, not machine learning. It is deliberately simple enough to defend, test and run reliably on shared PHP/MySQL hosting.

## Why one learning core for TOEIC and Aptis?

Vocabulary, collocations, grammar, paraphrases and listening recognition are reusable knowledge units. TOEIC and Aptis practice feed the same Mistake Book/SRS/weakness engine so exam preparation does not become an isolated question bank.

## Limitations

- No controlled human-user efficacy study has been completed.
- Rule weights are product/engineering choices and should be calibrated with future usage data.
- Speaking/Writing self-rubrics are coaching tools, not official Aptis scores.
- TTS/connected-speech cues support recognition but do not replace high-quality native audio.
