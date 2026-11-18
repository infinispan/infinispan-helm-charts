# Issue Creation Instructions

The Infinispan Helm Charts project uses plain GitHub issues (no issue templates are currently defined). Use a descriptive title and a body with the information below.

## Required Information by Type

### Bug Report
- **Title** — concise description of the bug.
- **Description** — what is broken.
- **Expected behavior** — what should happen.
- **Actual behavior** — what happens instead.
- **How to reproduce** — the `values.yaml` overrides / install command used, and the cluster steps to reproduce.
- **Environment** — chart version (`Chart.yaml` `version`), Infinispan server version (`appVersion` / image tag), Helm version, and Kubernetes or OpenShift version.

Note: security vulnerabilities should be reported privately to security@infinispan.org, not as public issues.

### Feature / Enhancement
- **Title** — concise description of the feature.
- **Description** — what the feature does and why it is needed.
- **Implementation ideas** (optional) — affected templates, new `values.yaml` options, backward-compatibility considerations.

### Housekeeping
- **Title** — concise description of the task.
- **Description** — what needs to be done (cleanup, refactor, dependency/version bump).

## Conventions

- Keep issue titles concise and descriptive.
- Reference related issues and PRs using `#number`.
- When filing from code investigation, include file paths (templates, values keys) and the chart version.
- Commit messages and branches reference the issue — commits use `#number`; branches use `issueid/short_summary`.

## External Resources

- Community discussions: [GitHub Discussions](https://github.com/infinispan/infinispan/discussions)
- Live chat: [Infinispan Zulip](https://infinispan.zulipchat.com/)
