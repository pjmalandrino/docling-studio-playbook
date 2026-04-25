# Monitoring

> **When to use**: Standing up a Docling Studio deployment, debugging a production incident (pair with [Incident Response](incident-response.md)), and as a continuous reference for what oncall watches.

The single primary signal is `GET /api/health`. Everything else in this doc
is either a refinement of that signal or a saturation check on the host.

## Health endpoint

```bash
curl -s http://localhost:3000/api/health
```

Expected response:

```json
{
  "status": "ok",
  "engine": "local",
  "version": "0.X.Y",
  "deploymentMode": "self-hosted"
}
```

**Alert if**: `status != "ok"`, endpoint unreachable, or response time > 5s
across two consecutive probes.

## Four golden signals

### 1. Latency

| Endpoint | Expected | Alert threshold |
|----------|----------|-----------------|
| `GET /api/health` | < 100ms | > 1s |
| `POST /api/documents` (upload) | < 2s | > 10s |
| `POST /api/analyses` (create — queuing only) | < 500ms | > 5s |
| `GET /api/analyses/:id` (results) | < 500ms | > 3s |

### 2. Traffic

| Metric | What to watch |
|---|---|
| Requests per minute | Baseline for normal usage |
| Uploads per hour | Capacity planning |
| Concurrent analyses | Must stay ≤ `MAX_CONCURRENT_ANALYSES` |

### 3. Errors

| Signal | Alert threshold |
|---|---|
| HTTP 5xx rate | > 1% of requests |
| Analysis failure rate | > 10% of analyses |
| Rate limit hits (429) | Sudden spike — possible abuse |

### 4. Saturation

| Resource | Check command | Alert threshold |
|---|---|---|
| CPU | `docker stats` | > 90% sustained |
| Memory | `docker stats` | > 85% (especially in `local` target with PyTorch loaded) |
| Disk (SQLite + uploads) | `du -sh data/` | > 80% of mounted volume |
| Container restarts | `docker inspect --format='{{.RestartCount}}' <id>` | > 0 |

## Docker health check

`docker-compose.yml` ships a built-in probe — keep it enabled, don't
disable it for "noisy logs":

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:3000/api/health"]
  interval: 30s
  timeout: 10s
  retries: 3
```

Container is marked `unhealthy` after 3 consecutive failures (≈90s).

## Log monitoring

### Backend (uvicorn)

```bash
docker compose logs -f backend
```

Watch for: `ERROR` / `CRITICAL` levels, `TimeoutError` from Docling
processing, `sqlite3.OperationalError` (DB issues), 429 spikes.

### Frontend (nginx)

```bash
docker compose logs -f frontend
```

Watch for: `502 Bad Gateway` (backend down), `413 Request Entity Too Large`
(upload past `MAX_UPLOAD_MB`).

## Recommended production setup

1. **Uptime monitor** — ping `/api/health` every 60s (UptimeRobot,
   Healthchecks.io, or any equivalent).
2. **Log aggregation** — ship Docker logs to a central store (Loki,
   CloudWatch, ELK).
3. **Alerting** — page on container restart, health-check failure, or 5xx
   spike. Page only on durable signals (≥2 consecutive failures), not
   single probes.

## Red flags

- Health-check is disabled or `interval` raised to mask flapping —
  hides incidents instead of fixing them
- Alerts fire on a single probe failure — pages get ignored within a week
- No oncall dashboard ties traffic + errors + saturation together —
  you'll diagnose latency without seeing the cause
- 5xx rate creeps up over weeks with no investigation — entropy wins
- Logs only inspected after an incident, never proactively — by then
  the root cause has rotated out
- `MAX_CONCURRENT_ANALYSES` regularly hit at peak — capacity is under-
  provisioned, not "working as intended"

## Anti-rationalizations

| Excuse | Why it doesn't hold |
|--------|---------------------|
| "We're small, we don't need monitoring yet" | First incident teaches you exactly which dashboard you should have built before it. Build it now |
| "The health endpoint is enough" | Health endpoint detects "down". Latency / error / saturation detect "degraded" — usually the more common failure mode |
| "Alerts are noisy, I muted them" | Mute = blind. Tune thresholds instead — `> 1% 5xx for 2 minutes` beats `any 5xx` |
| "I'll grep the logs when something breaks" | Log aggregation costs less than 30 min of post-incident archeology |
| "We'll add monitoring after the next release" | Monitoring is what tells you whether the release went well |

## Verification

- [ ] `curl /api/health` returns `status: ok` with version matching the deployed tag
- [ ] Docker `healthcheck` is enabled and returning healthy
- [ ] Uptime monitor configured against `/api/health`
- [ ] Logs are shipped off-host (not just on the container's disk)
- [ ] At least one alert exists per golden signal (latency, traffic, errors, saturation)
- [ ] Oncall has a runbook entry that references this doc
- [ ] On a weekly basis, someone reads the error log even when nothing has paged
