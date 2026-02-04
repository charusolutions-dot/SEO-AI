-- MVP database schema

CREATE TABLE users (
  id UUID PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE projects (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  url TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE scans (
  id UUID PRIMARY KEY,
  project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  status TEXT NOT NULL CHECK (status IN ('pending', 'running', 'done', 'failed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  finished_at TIMESTAMPTZ,
  site_score NUMERIC(5, 2) NOT NULL DEFAULT 0,
  total_pages INTEGER NOT NULL DEFAULT 0,
  error_count INTEGER NOT NULL DEFAULT 0,
  warning_count INTEGER NOT NULL DEFAULT 0,
  info_count INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE pages (
  id UUID PRIMARY KEY,
  scan_id UUID NOT NULL REFERENCES scans(id) ON DELETE CASCADE,
  url TEXT NOT NULL,
  status_code INTEGER,
  title TEXT,
  meta_description TEXT,
  h1 TEXT,
  h1_count INTEGER NOT NULL DEFAULT 0,
  h2_count INTEGER NOT NULL DEFAULT 0,
  canonical TEXT,
  robots_meta TEXT,
  images_total INTEGER NOT NULL DEFAULT 0,
  images_without_alt INTEGER NOT NULL DEFAULT 0,
  internal_links_count INTEGER NOT NULL DEFAULT 0,
  external_links_count INTEGER NOT NULL DEFAULT 0,
  page_score NUMERIC(5, 2) NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE seo_issues (
  id UUID PRIMARY KEY,
  page_id UUID NOT NULL REFERENCES pages(id) ON DELETE CASCADE,
  severity TEXT NOT NULL CHECK (severity IN ('error', 'warning', 'info')),
  code TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE reports (
  id UUID PRIMARY KEY,
  scan_id UUID NOT NULL REFERENCES scans(id) ON DELETE CASCADE,
  file_url TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('pending', 'ready', 'failed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX seo_issues_page_id_idx ON seo_issues(page_id);
CREATE INDEX pages_scan_id_idx ON pages(scan_id);
CREATE INDEX scans_project_id_idx ON scans(project_id);
