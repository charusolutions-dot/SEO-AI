# Week 4 Execution Plan — Dashboard UI + Charts + History

## Goal
By end of Week 4, you will have:
- Clean dashboard UI
- Visual charts for SEO health & issues
- Scan history per project
- Drill-down: Project → Scan → Pages → Issues
- Client-ready interface

## UX Flow
```
Login
 → Dashboard (Projects list + quick stats)
   → Click Project
     → Project Overview (Latest Scan Summary + Charts)
       → Scan History
         → Click Scan
           → Pages List
             → Click Page
               → Issues List
```

## Dashboard UI (Main Screens)
### Global Dashboard
- Projects list
- Latest site score
- Last scan date
- Errors / warnings counts
- “Run Scan” button

### Project Overview Page
- Project name + URL
- Site health score
- Summary cards: errors, warnings, info, pages scanned
- Charts: issues distribution, score trend
- “Run New Scan” button

### Scan History Section
Table columns:
- Scan date
- Status
- Pages scanned
- Site score
- Errors / warnings
- “View Details”

## Charts
- Issues breakdown (donut): errors, warnings, info
- Score trend (line): scan date vs site score
- Optional: page score distribution (bar)

## Backend API (Week 4)
- `GET /projects/{id}/scans` → scan history
- `GET /scans/{id}/summary` → site_score, total_pages, errors, warnings, infos
- `GET /scans/{id}/pages` → url, page_score, errors_count, warnings_count
- `GET /projects/{id}/stats` → latest scan summary + score trend

## Database (MVP extensions)
Add to `scans`:
- `site_score` (float)
- `total_pages` (int)
- `error_count` (int)
- `warning_count` (int)
- `info_count` (int)

## Frontend Components (example)
```
components/
  DashboardStats.tsx
  ProjectCard.tsx
  ScoreBadge.tsx
  IssuesDonutChart.tsx
  ScoreTrendChart.tsx
  ScanHistoryTable.tsx
  PagesTable.tsx
  IssuesList.tsx
```

## UX Polish
- Skeleton loaders for charts
- Empty states (“No scans yet”)
- Status badges (pending/running/done)
- Auto-refresh scan status (polling)
- Cache heavy endpoints

## Day-by-day breakdown
- Day 1: dashboard wireframes + UX flow
- Day 2: dashboard + project overview pages
- Day 3: scan history table + navigation
- Day 4: charts integration
- Day 5: API wiring + loading states
- Day 6: polish spacing/typography
- Day 7: testing with real data
