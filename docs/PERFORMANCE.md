# Performance Notes

Production response-time benchmarks were **NOT MEASURED** in the build sandbox because there is no MariaDB runtime. No latency numbers are estimated or fabricated.

## Static asset sizes in this release

| File | Bytes |
|---|---:|
| `assets/app.js` | 176,004 |
| `assets/adaptive.js` | 8,429 |
| `assets/aptis-v5.js` | 29,361 |
| `assets/app.css` | 56,842 |
| `assets/aptis-v5.css` | 8,425 |
| Global Knowledge CSV | 781,600 |
| TOEIC adaptive CSV | 108,124 |
| Aptis baseline CSV | 205,517 |
| Aptis fidelity replacement CSV | 58,832 |

The seed CSV files are setup/deployment data, not browser payloads during normal authenticated study sessions.

## Static optimizations present

- PHP + Vanilla JS avoids a production Node runtime and large framework bundles.
- API/list queries are bounded rather than returning the entire curriculum.
- Knowledge Map aggregates learner evidence server-side.
- Speaking audio remains in the browser by default; it is not uploaded as a large media library.
- Aptis Speaking demo media consists of nine lightweight local SVG files.
- PWA caching focuses on static shell assets; authenticated API responses are not intentionally cached.
- Large professionally recorded audio corpora are not bundled into HelioHost storage.
- Global curriculum is stored once and linked to per-user progress rather than cloned per learner.

## Database query/index review

Indexes are targeted at actual access paths such as user/time attempts, global content type/topic, user-item progress, mistake user/status/time paths and knowledge-link targets. The release intentionally avoids indexing every column because excessive indexes increase storage and write cost on shared hosting.

## What to measure on HelioHost

After MariaDB validation, measure with real requests instead of estimates:

1. authenticated Dashboard load;
2. Daily Plan generation;
3. Knowledge Map load;
4. Mistake Remediation load;
5. TOEIC/Aptis question fetch;
6. first-load static asset transfer size.

Record median and slow-tail results only after testing on the actual hosting environment.

## Remaining technical debt

`Repository.php` and `assets/app.js` remain comparatively large. Further modularization is a roadmap item after production behavior is proven. The final release prioritizes **stability over architectural churn**.
