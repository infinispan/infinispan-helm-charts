# Project Context: Infinispan Helm Charts

This repository contains a Helm chart that builds and deploys [Infinispan](https://infinispan.org/) clusters on Kubernetes and OpenShift. The chart renders Infinispan server configuration from user-supplied `values.yaml` and provisions the StatefulSet, Services, Secrets, and optional TLS/cert-manager resources needed to run a cluster.

## Shared guidelines
- Use the project's established patterns and terminology. When in doubt, follow the conventions of the existing templates and values.
- Prefer clarity over cleverness. This is a long-lived open-source project with many contributors.
- Be aware of backward compatibility implications — `values.yaml` is a public API. Renaming, removing, or changing the type of a value breaks existing user release values. Add new values with safe defaults instead.
- Several files are generated, not hand-edited. Never edit `README.md`, `values.schema.json`, or `templates/NOTES.txt` directly — edit the corresponding `.tpl` and regenerate (see `AI-CODE.md`).

## Coding instructions
When planning and writing chart templates, values, or configuration, read and follow the instructions in `AI-CODE.md`.

## Testing instructions
When writing or modifying tests, read and follow the instructions in `AI-TEST.md`.

## Documentation instructions
When writing or editing documentation, read and follow the instructions in `AI-DOCS.md`.

## Issue creation instructions
When creating GitHub issues, read and follow the instructions in `AI-ISSUES.md`.

## Pull request review instructions
When reviewing PRs, read and follow the instructions in `REVIEW.md`.

## Maintaining AI context files
When making changes that alter the chart structure, the set of templates, the build/branding process, or development conventions, check whether the relevant AI context files need updating: `AGENTS.md`, `AI-CODE.md`, `AI-TEST.md`, `AI-DOCS.md`, `AI-ISSUES.md`, and `REVIEW.md`. Examples that warrant updates: adding or removing templates, introducing new top-level `values.yaml` sections, changing `brand.sh` or the generated-file set, changing CI workflows, or updating the documentation structure.
