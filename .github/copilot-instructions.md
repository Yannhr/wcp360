# Copilot / AI agent instructions for WCP 360

Purpose
- Help AI coding agents become productive quickly in this repository. Use this file as the primary source for repository-specific conventions, architecture notes, and search hints.

Big picture (from README.md)
- WCP 360 is a modular, Linux-native web control platform. The repository separates a small immutable core from installable modules. Important capabilities: user/domain lifecycle, resource isolation (cgroups v2 + systemd), dynamic Nginx config generation, ACME/SSL automation, WAF (Coraza + OWASP CRS), API gateway (REST +/- GraphQL), and plugin/module management.

Where to look first
- [README.md](README.md) — high-level architecture and design rationale.
- Top-level directories to inspect: `core/`, `modules/`, `api/`, `sdk/`, `web/`, `installer/`, `deployments/`, `packaging/`, `scripts/`, `tests/`, `security/`.

Key principles for making changes
- Preserve the modular core: avoid embedding business logic in `core/`. Prefer adding or updating a module under `modules/` or a plugin.
- Follow the event-driven / plugin patterns described in the README: locate the event bus or plugin loader in `core/` before changing lifecycle behaviors.
- Respect system integration points: cgroups/systemd slices, Redis for abuse detection, Nginx template generation, and ACME hooks. Search the repo for keywords like `cgroups`, `systemd`, `ACME`, `Coraza`, `WAF`, `Nginx`, and `Redis` to find implementation locations.

Developer workflows (how to find them)
- There is no single top-level build script in the repo root. Look in `packaging/`, `installer/`, `web/` and `scripts/` for project-specific build/test commands and CI hooks.
- CI workflows are in `.github/workflows/` (see `ci.yml`, `release.yml`). Use those to learn what CI installs and tests.

Patterns & conventions to follow
- Modules: expect each module to live under `modules/<name>/` and to include metadata and a small interface to register with the core. If you add a module, update any module registry used by the installer.
- APIs: changes in `api/` commonly require updates in `sdk/` or client code under `web/` — search for generated clients.
- Configs: central configuration is under `configs/`. Avoid scattering new global config keys; add module-scoped config when possible.

Testing & validation
- Tests live in `tests/`. If you add behavior, add unit tests adjacent to the package (or an integration test under `tests/`). If uncertain how tests run, open `.github/workflows/ci.yml` to see test steps and tools used.

Commit & PR guidance for AI agents
- Make minimal, focused changes. If modifying core behavior, provide a short architectural justification in the PR body and list affected subsystems.
- Update README or module docs when adding features. Link to relevant `README.md` sections.

Search tips (examples)
- To find where SSL is implemented: search `ACME` and `certbot` or `acme`
- To find WAF integration: search `Coraza`, `OWASP`, or `CRS`
- To find resource isolation: search `cgroup`, `systemd`, `slice`

When stuck
- Ask: "Should this change live in `core/` or as a `module/`?" Prefer modules for business logic.
- If a build/test step is unclear, check `packaging/`, `installer/`, `web/`, and `.github/workflows/ci.yml`.

If you find additional agent conventions (AGENT.md, CLAUDE.md, etc.), add or merge them into this file and notify maintainers in the PR.

---
Please review these instructions and tell me which sections need more detail or examples from specific files.
