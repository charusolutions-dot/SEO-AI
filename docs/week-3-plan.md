# Week 3 Execution Plan — Rules Engine + Issues + Scoring

## Goal
By end of Week 3, you will have:
- SEO rules engine
- Automatic issue detection per page
- Issue categorization (error / warning / info)
- Site + page scoring system
- Issues stored in DB
- Issues visible in UI

## System Flow
```
Crawler stores pages
→ Analyzer runs rules on each page
→ Issues are generated
→ Issues saved in DB
→ Scores calculated
→ Frontend shows: errors, warnings, score
```

## Rules Engine (MVP)
Define a simple rule interface:
```python
class Rule:
    code: str
    severity: "error" | "warning" | "info"
    message: str

    def check(page) -> Optional[Issue]:
        ...
```

Each rule returns `None` if OK or an `Issue` object when it fails.

## MVP Rules List
### Errors
- MISSING_TITLE
- MISSING_META_DESCRIPTION
- MISSING_H1
- BROKEN_PAGE (status_code >= 400)

### Warnings
- TITLE_TOO_LONG (> 60 chars)
- TITLE_TOO_SHORT (< 30 chars)
- MULTIPLE_H1
- NO_CANONICAL
- NOINDEX_DETECTED
- IMAGES_WITHOUT_ALT

### Info
- META_DESCRIPTION_TOO_LONG

## Analyzer Pipeline
```python
for page in pages:
    for rule in rules:
        issue = rule.check(page)
        if issue:
            save_issue(issue)
```

## Scoring System
- Base score: 100
- Error: -5
- Warning: -2
- Info: -0.5
- Clamp 0–100

**Page score:** calculated per page.
**Site score:** average of page scores.

Optional grade:
- 90–100 → Excellent
- 75–89 → Good
- 50–74 → Needs improvement
- <50 → Poor

## API Endpoints (Week 3)
- `GET /scans/{id}/issues`
- `GET /scans/{id}/summary` → total_pages, errors, warnings, infos, site_score
- `GET /pages/{id}/issues`
- `GET /pages/{id}/score`

## Frontend (Week 3 UI)
Project → Latest Scan page:
- Site health score
- Errors / warnings / info counts
- Pages table: URL, status, page score, issues count
- Page details: issue list with severity badges

## Performance & Design
- Run analyzer in background job
- Store results (avoid recompute on every request)
- Add indexes: `seo_issues.page_id`, `pages.scan_id`

## Day-by-day breakdown
- Day 1: rule interface + 5–6 core rules
- Day 2: full MVP rules + issue model
- Day 3: analyzer pipeline + persistence
- Day 4: scoring logic + storage
- Day 5: API endpoints
- Day 6: frontend UI
- Day 7: testing + tuning
