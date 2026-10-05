# Technical Evaluation

This evaluation is an **algorithmic scenario simulation**, not a clinical or educational efficacy study with real learners.

## Method

We compare a non-adaptive baseline (“always allow the same new-item target”) with `AdaptiveLearningService` using deterministic fixtures.

| Scenario | Input | Expected adaptive behavior | Result |
|---|---|---|---|
| A. High backlog | 70 due, 62% retention | SRS prioritized; new content ≤3 and reduced further by low retention | PASS |
| B. Strong/low backlog | 5 due, 91% retention | Normal new content, small controlled increase | PASS |
| C. Weak Listening | Listening error/recurrence severity far above Grammar | Listening priority score higher than Grammar | PASS |
| D. Recurred mistake | Previously resolved concept answered incorrectly | status becomes `RECURRED`; recurrence increases priority | PASS (repository/source regression) |

Automated assertions are included in `tests/adaptive_test.php` and the broader learning regression suite.

## Baseline vs adaptive selection

A fixed non-adaptive plan cannot react to an SRS backlog or a concentrated weak skill. In the scenarios above the adaptive engine changes selection by:

- throttling new content under backlog pressure;
- preserving review-first priority;
- increasing priority for repeated/recurred errors;
- preferring the weak skill when evidence differs materially;
- returning explainable reasons for the selected plan items.

## What this evaluation does not prove

It does not prove a percentage improvement in language ability, retention, TOEIC score or Aptis score. Such claims would require a real-user study with a defined protocol, comparison group and outcome measures.

## Future evaluation

A later study can compare plan adherence, due-card backlog, error recurrence, retention, time-on-task and exam-practice accuracy across several weeks while respecting learner privacy.
