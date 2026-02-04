# Week 2 Execution Plan — Crawler + Parser + Storage

## Goal
By end of Week 2, you will have:
- A working crawler that fetches pages
- HTML parser that extracts SEO data
- Internal link discovery
- Crawl limits + safety
- Data stored in DB (`pages` table)
- Connected to projects/scans system

## System Flow (MVP)
```
User clicks "Run Audit"
→ Create Scan (status = pending)
→ Push Job to Queue
→ Crawler starts
→ Fetch pages
→ Parse SEO data
→ Save to DB
→ Mark Scan = done
```

## Crawler MVP (Python)
**Tech:** httpx or requests, BeautifulSoup/lxml, urllib.parse

**Rules:**
- Start from homepage
- Same-domain only
- Max pages (e.g. 50)
- Respect robots.txt (basic)
- Timeout + retries
- Skip PDFs/images/archives + mailto/tel links

**Pseudo-flow:**
```python
queue = [start_url]
visited = set()

while queue and len(visited) < MAX_PAGES:
    url = queue.pop(0)
    if url in visited:
        continue

    html = fetch(url)
    visited.add(url)

    data = parse(html, url)
    save_page(data)

    links = extract_internal_links(html, base_domain)
    for link in links:
        if link not in visited:
            queue.append(link)
```

## Parser (SEO data extraction)
Extract per page:
- URL
- Status code
- Title
- Meta description
- H1 (first)
- H1 count
- H2 count
- Canonical
- Meta robots
- Images: total + missing alt
- Internal links count
- External links count

## DB Storage (MVP fields)
Use existing tables with the following page fields:
- `url`, `status_code`, `title`, `meta_description`, `h1`
- `h1_count`, `h2_count`, `canonical`, `robots_meta`
- `images_total`, `images_without_alt`
- `internal_links_count`, `external_links_count`

## Job System (simple)
- `POST /projects/{id}/scan`
- Create scan row (pending)
- Enqueue `run_scan(scan_id)`
- Worker runs crawler, stores pages, updates scan status

## API Endpoints (Week 2)
- `POST /projects/{id}/scan` → start scan
- `GET /scans/{id}` → scan status
- `GET /scans/{id}/pages` → list pages

## Frontend (Week 2 minimal)
Project page:
- “Run Audit” button
- Scan status: pending/running/done
- Table: URL, Title, H1, Status code

## Safety & Quality
- Set User-Agent
- 10s timeout (configurable)
- Max depth or max pages
- Same-domain only
- Basic robots.txt respect
- Handle 4xx/5xx gracefully

## Day-by-day breakdown
- Day 1–2: crawler queue + fetch + link extraction
- Day 3: parser + extraction
- Day 4: DB integration (store pages)
- Day 5: job integration + start scan endpoint
- Day 6: frontend status + pages list
- Day 7: tests + bug fixes
