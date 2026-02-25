# WCP360 Project Governance

This document outlines the governance model for the WCP360 project. It defines the roles, responsibilities, and decision-making processes to ensure transparency and sustainability.

## 1. Governance Philosophy
WCP360 follows a **Liberal Contribution** model. We believe that those who do the work should have the most influence over the project's direction. Our goals are:
* **Transparency:** All major technical decisions are discussed in public.
* **Merit:** Influence is earned through consistent, high-quality contributions.
* **Efficiency:** We aim for a "consensus-seeking" process rather than bureaucratic voting.

---

## 2. Roles and Responsibilities

### 🏆 Project Leads (Core Maintainers)
The Project Leads are the original creators and high-level architects.
* **Authority:** Final say on architecture, security policy, and branding.
* **Duties:** Manage release cycles, oversee security disclosures, and mentor new maintainers.

### 🛠️ Maintainers
Maintainers are contributors who have shown deep technical knowledge and commitment to the project.
* **Authority:** Write access to the repository, ability to merge Pull Requests (PRs).
* **Duties:** Review code, triage issues, and ensure the `main` branch remains stable.
* **Becoming a Maintainer:** Contributors who consistently provide high-quality PRs and reviews over a period of 3-6 months may be invited by existing maintainers.

### 👤 Contributors
Anyone who submits a PR, reports a bug, or improves documentation.
* **Rights:** All contributions are valued and reviewed.
* **Path to Leadership:** Contributors are encouraged to "climb the ladder" by taking on more complex tasks and helping others in the community.

---

## 3. Decision-Making Process

### Technical Decisions
Small changes (bug fixes, doc updates) require **one maintainer approval** to be merged.
Major changes (API changes, new core modules, architectural shifts) follow this flow:
1. **Proposal:** An issue or "RFC" (Request for Comments) is created to discuss the change.
2. **Consensus:** We seek a "Lazy Consensus"—if no major objections are raised within 72 hours, the proposal is considered accepted.
3. **Escalation:** If maintainers cannot agree, the Project Leads make the final decision.

### Non-Technical Decisions
Decisions regarding branding, the Code of Conduct, or project partnerships are handled exclusively by the Project Leads.

---

## 4. Security Governance
Security is our highest priority.
* **Private Reporting:** Security vulnerabilities must NOT be reported via public GitHub issues. Use the instructions in `SECURITY.md`.
* **Security Team:** A subset of Maintainers forms the Security Team, responsible for private patching and coordinated disclosure.

---

## 5. Conflict Resolution
In the event of a dispute:
1. **Discuss:** Maintainers should attempt to resolve the issue through technical data and civil discussion.
2. **Mediate:** A Project Lead will act as a mediator.
3. **Final Decision:** If mediation fails, the Project Leads will make a binding decision based on the long-term health of the project.

---

## 6. Modifying Governance
This document is a living framework. Changes to this governance model can be proposed via a PR and require a **unanimous vote** from the Project Leads.
