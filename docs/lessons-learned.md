# Problems encountered and fixes

| Problem | Cause | Fix |
|---|---|---|
| minikube segfaulted on every command | Interrupted download left a truncated binary (missing ELF section headers) | Re-downloaded with `curl -C -` and verified with the published sha256 |
| `pip install` failed with `pg_config not found` | Local Python 3.14 has no psycopg2-binary wheel | Ran tests in a python:3.12-slim container, matching the image runtime |
| Docker pulls failed with DNS errors (`getaddrinfow`) | Intermittent name resolution for the registry and CDN hosts | Retried pulls in a loop (layers are kept between attempts); DNS servers can also be set in Docker Engine settings |
| Large downloads stalled partway | Unreliable connection | Resumed with `curl -C -` and verified checksums before installing |
| Earlier attempt used a stand-in app | Source diverged from the official ShopFlow app (hard-coded products, swapped /health and /ready) | Replaced with the official source; old work kept under tag attempt-1-simplified-app |
| CI failed after the repo restructure | Old workflow referenced deleted paths (tests/, helm/, docker/Dockerfile.*) | Rewrote the workflow for the new layout |
| CI lint failed on the provided source | Ruff's active rules were broader than expected and unpinned | Selected an explicit rule set in ruff.toml and pinned Ruff 0.17.4; left the intentional broad `except` in /ready alone |
| pip-audit failed CI | Flask 3.1.2 and pytest 8.4.2 had known advisories | Upgraded to Flask 3.1.3 and pytest 9.0.3; see docs/security.md |
| Docker commands failed with "cannot connect to the docker API" | Docker Desktop was not running after a restart | Started Docker Desktop; added a guard so an empty version variable could not corrupt ci.yml |
| db-init exited with code 2 and the backend never started | SQLAlchemy 2.1.8 (unpinned, newest release) tried the `psycopg` driver, but only `psycopg2-binary` is installed (`ModuleNotFoundError: psycopg`) | Named the driver in the URL (`postgresql+psycopg2://`) and pinned SQLAlchemy==2.1.8 |
| Unit tests passed but the real database path was broken | Tests use in-memory SQLite and never load the Postgres driver | Verified the full stack with Docker Compose against real Postgres; keep this check in the workflow |

## Lessons
- Pin transitive dependencies that affect behaviour (SQLAlchemy), not only direct ones.
- Passing unit tests do not prove the integration path works; run the real stack.
- Verify downloads with checksums, and resume interrupted ones instead of restarting.
