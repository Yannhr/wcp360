# 🤝 Contributing to WCP 360

Thank you for your interest in contributing to **WCP 360** 🚀  

WCP 360 is a modern, secure, Linux-native infrastructure control platform.  
We welcome serious contributors who care about clean architecture, security, and long-term sustainability.

---

# 🌍 Project Philosophy

WCP 360 is:

- 🔐 Security-first  
- 🧩 Modular by design  
- 🐧 Linux-native  
- ⚡ Performance-oriented  
- 🏗 Infrastructure-grade  

This is not a hobby control panel.  
It is a long-term infrastructure project built for serious server operators.

All contributions should respect these principles.

---

# 🧭 Ways to Contribute

There are many ways to contribute to WCP 360.

## 💻 Backend (Go)

- Core engine improvements  
- REST API development  
- Isolation engine (cgroups v2 / systemd slices)  
- Module system architecture  
- Security hardening  
- Performance optimization  

## 🎨 Frontend (React + TypeScript)

- UI improvements  
- Dashboard components  
- UX enhancements  
- Admin / Client interfaces  
- Webmail integration layer  
- Accessibility improvements  

## 🔐 Security

- Threat modeling  
- Attack surface review  
- WAF integration improvements  
- Abuse detection logic  
- Code auditing  
- Privilege boundary validation  

## 🧪 Testing

- Unit tests  
- Integration tests  
- Load testing  
- Performance benchmarks  
- Security validation tests  

## 📚 Documentation

- README improvements  
- API documentation  
- Installation guides  
- Architecture diagrams  
- Tutorials  
- Translations  

Even small documentation fixes are valuable.

---

## How to contribute

1. Fork & clone the repo
2. Create a branch: `git checkout -b feat/xxx` or `fix/xxx`
3. Make your changes
4. Add tests if relevant (go test, pnpm test)
5. Commit with conventional style: `type(scope): message`  
   Exemples: `fix(readme): correct clone url`, `docs(readme): add badges`, `feat(cli): add version command`
6. Push & open a PR against main

---

## Development setup

```bash
# Backend
go mod tidy
go build ./cmd/...

# Frontend
pnpm install
pnpm dev
Branch naming examples:

- `feature/web-server-module`
- `fix/nginx-config-bug`
- `security/isolation-improvement`
- `docs/api-update`

---

# 🏗 Development Setup

## Backend (Go)

Install dependencies and build:

```bash
go mod tidy
make build
make dev
```

Backend runs on:

```
http://localhost:8080
```

Health endpoint:

```
/health
```

---

## Frontend (Panel)

```bash
cd panel
pnpm install
pnpm dev
```

Frontend runs on:

```
http://localhost:5173
```

---

# 🧪 Code Standards

## Go Guidelines

- Follow idiomatic Go  
- Keep functions small and focused  
- Avoid unnecessary abstractions  
- Avoid global state  
- Always handle errors explicitly  
- Prefer composition over inheritance patterns  
- Write unit tests whenever possible  

Formatting:

```bash
go fmt ./...
```

Linting (recommended):

```bash
golangci-lint run
```

---

## Frontend Guidelines

- Use strict TypeScript  
- Avoid `any`  
- Keep components small and composable  
- Prefer hooks over class components  
- No business logic in presentation components  
- Separate UI from API calls  

Formatting:

```bash
pnpm lint
```

---

# 🔐 Security Requirements

WCP 360 is infrastructure software. Security is mandatory.

- No unsafe shell execution  
- No silent privilege escalation  
- No root execution from the UI layer  
- All destructive operations must require explicit confirmation  
- Isolation logic must be testable  
- Sensitive changes require review  

Security-related pull requests are reviewed carefully.

---

# 📦 Module Contributions

Modules must:

- Not modify the core directly  
- Respect the defined module API  
- Be independently installable  
- Avoid tight coupling with other modules  
- Include documentation  

Planned module packaging format: `.wcp`

The ecosystem must grow without bloating the core.

---

# 📝 Commit Message Convention

Use clear, conventional commit messages:

```
feat: add nginx config generator
fix: correct cgroup memory limit
docs: update installation guide
security: prevent privilege escalation in API
refactor: simplify domain lifecycle handler
```

Guidelines:

- Keep commits atomic  
- Keep messages clear and descriptive  
- Avoid unrelated changes in one commit  

---

# 🔄 Pull Request Process

Before opening a PR:

- Ensure your branch is up to date with `main`
- Run formatting and linting
- Ensure the project builds successfully
- Run tests if applicable

When opening a PR, clearly describe:

- What you changed  
- Why you changed it  
- Any breaking changes  
- Screenshots (if frontend changes)  

PRs may be reviewed for:

- Security impact  
- Architectural consistency  
- Performance implications  
- Maintainability  

---

# 🧠 Roadmap Alignment

Before implementing large features:

1. Open an issue  
2. Discuss architecture  
3. Align with project direction  

We prioritize:

- Core stability  
- Security  
- Modularity  
- Clean architecture  

Unaligned large PRs may be rejected.

---

# 🏆 Good First Issues

If you are new to the project, look for:

- Documentation improvements  
- Minor refactors  
- Test coverage improvements  
- Small UI enhancements  

Beginner-friendly issues will be labeled accordingly.

---

# 📜 Code of Conduct

- Be respectful  
- No toxic behavior  
- Constructive technical discussions only  
- Focus on infrastructure quality  

We aim to build a professional open-source environment.

---

# 🌱 Long-Term Vision

WCP 360 aims to become:

- A serious alternative to legacy hosting panels  
- A secure Linux-native infrastructure control layer  
- A modular ecosystem  
- A sustainable open-source project  

If you believe hosting infrastructure deserves better tools —

You are welcome here.

---

# 🙌 Thank You

Every contribution matters.

Even a documentation typo helps.

Let’s build something serious.


