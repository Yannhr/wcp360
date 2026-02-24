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

# 🌿 Branch Naming Convention

To keep **WCP360** organized, scalable, and easy to navigate for all contributors, we follow a strict branching convention. Adhering to these rules ensures a clean commit history and smoother Pull Requests.

---

### 📝 General Rules

* **Kebab-case only**: Always use lowercase letters.
* **Hyphen separated**: Use dashes (`-`) to separate words (no spaces, no underscores).
* **Mandatory Prefix**: Every branch must start with a category prefix followed by a slash `/`.
* **Descriptive & Concise**: Aim for 5–50 characters. It should be readable at a glance.

---

### 🛠️ Recommended Prefixes

| Prefix | Use Case | Examples |
| :--- | :--- | :--- |
| `feature/` | New functionality or major evolution. | `feature/core-minimal`, `feature/nginx-module` |
| `bugfix/` | Fixing a bug in the code. | `bugfix/jwt-expiration`, `bugfix/db-connection-leak` |
| `refactor/` | Code improvements without changing behavior. | `refactor/config-loader`, `refactor/error-handling` |
| `docs/` | Documentation updates or additions. | `docs/add-code-of-conduct`, `docs/update-roadmap` |
| `chore/` | Maintenance, CI/CD, dependencies, or formatting. | `chore/github-actions-ci`, `chore/update-deps` |
| `hotfix/` | Urgent production fixes (rare/critical). | `hotfix/security-patch-api` |
| `experiment/` | Research, PoC, or temporary testing. | `experiment/redis-pubsub` |

---

### ✅ Good vs. ❌ Bad Examples

* ❌ `feature/Core-Minimal` (Uppercase/Mixed) → ✅ **`feature/core-minimal`**
* ❌ `bugfix/fix jwt bug` (Spaces) → ✅ **`bugfix/jwt-token-expiration`**
* ❌ `docs/code` (Too vague) → ✅ **`docs/update-contributing-guide`**
* ❌ `123-fix` (Starting with numbers) → ✅ **`bugfix/issue-123-ui-alignment`**

---

### 🔄 Recommended Workflow



1.  **Sync your local environment**:
    ```bash
    git checkout main
    git pull origin main
    ```

2.  **Create your branch with the correct prefix**:
    ```bash
    git checkout -b feature/core-minimal-api
    ```

3.  **Push and track the branch on GitHub**:
    ```bash
    git push -u origin feature/core-minimal-api
    ```

4.  **Open a Pull Request (PR)**:
    Once your work is ready, open a PR from your branch to `main`. Ensure your branch name follows the convention above to speed up the review process.

---
