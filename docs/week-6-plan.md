# Week 6 Execution Plan — Testing, Hardening, Deployment

## Goal
By end of Week 6, you will have:
- Fully tested MVP
- Major bugs fixed
- Performance + security sanity checks
- Production deployment (frontend + backend + DB)
- Monitoring and backups
- Live, usable product

## Testing Strategy
### Backend tests
- Unit tests: rules engine, scoring, URL normalization, parser functions
- Integration tests: project → scan → pages → issues → score
- API tests: auth, projects, scans, reports

Tools: Pytest (or stack equivalent), Postman/Hoppscotch for manual API checks

### Frontend tests
- Critical flows: signup → login → create project → run scan → view results → download report
- UI checks: loading, empty, and error states
- Cross-browser smoke tests: Chrome, Edge, mobile responsive

### Real-world test cases
- Small site (5–10 pages)
- Medium site (50 pages)
- Broken site (404s, redirects, missing metadata)
- Slow site
- Site with noindex

## Bug Fixing & Hardening
- Prevent crawler crashes, infinite loops, duplicate URLs
- Validate score calculations
- Guard PDF layout breaks
- Add timeouts + retries + safer fallbacks
- Improve error handling and user-facing messages

## Performance Checks
- Limit max pages per scan
- Index critical columns:
  - scans.project_id
  - pages.scan_id
  - seo_issues.page_id
- Cache scan summaries and dashboard stats
- Ensure background jobs do not block API
- Make PDF generation async

## Security Basics
- Password hashing (bcrypt/argon2)
- Protect private APIs (auth middleware)
- Validate URLs before crawling
- Rate limit: login + scan start
- SSRF protection: block internal IP ranges
- Use env vars for secrets

## Deployment Plan
### Infra
- Frontend: Vercel/Netlify
- Backend: Railway/Render/Fly.io
- DB: Managed PostgreSQL
- Redis: Managed Redis
- Storage: S3-compatible (PDFs)

### Environments
- Staging
- Production

### Steps
1. Setup CI (GitHub Actions)
2. Run tests on push
3. Build Docker images
4. Deploy backend
5. Migrate DB
6. Deploy frontend
7. Test production flows

## Monitoring & Backups
- Logging: API errors, crawler errors, job failures
- Monitoring: uptime, CPU/memory
- DB backups: daily automatic backups
- Error tracking: Sentry (optional)

## Day-by-day breakdown
- Day 1: backend tests + fix critical bugs
- Day 2: frontend flow testing + UI fixes
- Day 3: load + edge-case testing
- Day 4: security checks + rate limits
- Day 5: infra setup + backend deploy
- Day 6: frontend deploy + E2E prod testing
- Day 7: buffer for hotfixes + performance polish
