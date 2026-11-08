# ShopFlow DevOps Capstone

Started from the instructor-provided application source (zip); no starter repository was supplied.

## Branching strategy
- `main` is protected and always deployable; changes land only through pull requests.
- Work happens on short-lived branches: `feature/*`, `fix/*`, `chore/*`, `docs/*`.
- Every pull request must pass CI (lint, tests, dependency audit, secret scan, Docker build and image scan) before merge.
- Commit messages follow Conventional Commits (`feat:`, `fix:`, `ci:`, `docs:`, `chore:`).
Maintainer: Jesse James Kyemting (branch B)
