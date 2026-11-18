# Pull Request Reviewing Instructions

## Verify the basics

- Commit messages reference the related GitHub issue (`#number`).
- The branch is based on `origin/main` and named `issueid/short_summary`.
- Tests are included or updated for behavior changes, or a convincing justification is given.

## What Important means here

Reserve Important for findings that would break a deployment, break existing user releases, or leak secrets:
- **Generated files out of sync** — `README.md`, `values.schema.json`, or `templates/NOTES.txt` edited directly, or not regenerated after a `.tpl` change. CI (`chart-verifier.yml`) fails on this, and it is a common mistake.
- **`values.yaml` backward incompatibility** — renaming, removing, or retyping an existing value, or adding a required value with no safe default, breaks `helm upgrade` for existing releases.
- **Template correctness** — rendering errors, wrong resource names/labels, missing `{{- if }}` guards so optional resources (TLS, cert-manager, Route, ServiceMonitor) render when they should not (or vice versa).
- **Platform breakage** — OpenShift-only resources (Routes) not conditional, or changes that assume one platform.
- **Security** — secrets or credentials rendered into plain ConfigMaps/logs, overly permissive defaults, TLS disabled or weakened unintentionally.
- **Schema drift** — new or changed values not reflected in `values.schema.json.tpl`.

Style, naming, and formatting suggestions are Nit at most.

## Chart-specific checks

- If any `.tpl` changed, confirm `./brand.sh infinispan.conf` was run and the generated output is committed alongside the source.
- If `values.yaml` changed, confirm `values.schema.json.tpl` was updated and regenerated.
- Confirm branding goes through placeholders/attributes — no hardcoded "Infinispan" in `.tpl` files or in attribute-driven docs.
- For new install behavior, confirm a matching scenario (values snippet + CI step) was added under `test/` and `test-chart.yml`.

## Cap the nits

Report at most five Nits per review. If you found more, say "plus N similar items" in the summary. If everything you found is a Nit, lead the summary with "No blocking issues."

## Do not report

- Anything CI already enforces: `helm lint` errors, chart-verifier failures, branded-file drift (flag only if the author appears unaware).
- Test-only manifests that intentionally differ from production templates.

## CI Failures

- If CI has run, look at the results and determine whether any failures are related to the changes — especially the branded-files check and the Kind install/TLS/cert-manager scenarios.
