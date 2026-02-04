# SEO Audit SaaS MVP

A focused MVP for an SEO audit web app: auth, projects, scans, crawler, rules engine, dashboard, and report export—no fluff.

## MVP Scope

### Must-have features
- Auth: signup/login.
- Projects: add a website, list projects, run scans, scan history.
- Crawler: fetch homepage and crawl internal links (cap at 50 pages), respecting robots.txt and rate limits.
- Analyzer: detect SEO issues, compute scores, and store per-page + site-level results.
- Dashboard: health score, issues summary, and page breakdown.
- Report export: HTML/PDF report with score and top issues.

### Clickable wireframes
Open `docs/wireframes/index.html` to browse the low-fi clickable MVP layout screens:
- Login
- Signup
- Dashboard
- Add Project
- Project Overview

### Tech stack
- **Frontend:** Next.js, Tailwind CSS, Recharts
- **Auth:** Clerk or Auth.js
- **Backend:** FastAPI
- **Background jobs:** Celery or RQ with Redis
- **DB:** PostgreSQL
- **Crawler:** httpx + BeautifulSoup (or Scrapy)
- **Reports:** HTML -> PDF, stored in S3-compatible storage
- **Infra:** Docker; deploy on Railway/Render/AWS

## System architecture (MVP)
```
[ Next.js Frontend ]
          |
        [ API ]
          |
  ------------------
  | Auth | Scans   |
  ------------------
          |
      [ Queue ]
          |
     [ Crawler ]
          |
     [ Analyzer ]
          |
     [ Postgres ]
```

## Core flow
1. User adds website project.
2. User clicks “Run Audit”.
3. Job is enqueued.
4. Crawler collects pages and stores raw data.
5. Analyzer evaluates rules, stores issues and scores.
6. Dashboard renders results; user downloads report.

## Scoring system
- Start at **100 points**.
- **-5** per error.
- **-2** per warning.
- Minimum score is **0**.

Score interpretation:
- **90–100:** Good
- **70–89:** Needs improvement
- **<70:** Poor

## Roadmap
- **Week 1:** UI wireframes, DB schema, auth + projects
- **Week 2:** Crawler MVP, parser, store data
- **Week 3:** SEO rules engine, issue detection, scoring
- **Week 4:** Dashboard UI, charts, scan history
- **Week 5:** Report generator, PDF export, UX polish
- **Week 6:** Testing, bug fixes, deploy

## Week 1 checklist
- [ ] User can sign up & log in
- [ ] User sees dashboard
- [ ] User can create a project (website)
- [ ] User can see list of projects
- [ ] User can open project page
- [ ] DB schema is ready for scans
- [ ] UI wireframes approved

## Week 2 plan
See `docs/week-2-plan.md` for the crawler, parser, storage, and API milestones.

## Week 3 plan
See `docs/week-3-plan.md` for the rules engine, issues, and scoring milestones.

## Week 4 plan
See `docs/week-4-plan.md` for the dashboard, charts, and scan history milestones.

## Week 5 plan
See `docs/week-5-plan.md` for reports, PDF export, and UX polish milestones.

## Week 6 plan
See `docs/week-6-plan.md` for testing, hardening, and deployment milestones.

## Compliance
- Respect robots.txt
- Apply crawl limits and rate limiting
- Custom UI and scoring (no SEMrush copy)
