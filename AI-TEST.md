# Testing Instructions

The chart is tested at two levels: static validation (lint + schema + Red Hat chart-verifier) and a real install against a Kind cluster. Both run in CI on every pull request.

## Test Assets

| Location                                   | Purpose                                                        |
|--------------------------------------------|---------------------------------------------------------------|
| `templates/tests/test-connection.yaml`     | Helm test hook (`helm.sh/hook: test`) — run with `helm test`. |
| `test/tls_secret.yaml`                      | Pre-created server TLS Secret for the manual-TLS scenario.     |
| `test/transport_tls_secret.yaml`           | Pre-created transport (cross-node) TLS Secret.                 |
| `test/tls_values.snippet.yaml`             | Values overlay enabling manual TLS.                           |
| `test/certmanager_tls_values.snippet.yaml` | Values overlay enabling cert-manager TLS.                     |

Values snippets are layered on top of `values.yaml` with repeated `-f` flags, for example:
`helm install example-infinispan . -f values.yaml -f test/tls_values.snippet.yaml`.

## CI Workflows

### `.github/workflows/test-chart.yml` (Testsuite)
Runs on pushes to `main` and all pull requests:
1. `helm lint .`
2. Creates a Kind cluster.
3. **Plain install** — installs the chart with `deploy.replicas=2` and waits for the StatefulSet rollout.
4. **Manual TLS** — applies `test/tls_secret.yaml` and `test/transport_tls_secret.yaml`, installs with `test/tls_values.snippet.yaml`, waits for rollout.
5. **cert-manager TLS** — installs cert-manager, installs the chart with `test/certmanager_tls_values.snippet.yaml`, waits for the `Certificate` to become `Ready`, then for the StatefulSet rollout.

Each scenario installs into a fresh `helm-test` namespace and uninstalls afterward.

### `.github/workflows/chart-verifier.yml` (Chart Verifier)
Runs on pushes to `main` and all pull requests:
1. **Verifies branded files are up to date** — runs `./brand.sh infinispan.conf` and fails if any tracked file changes. Always regenerate and commit after editing a `.tpl`.
2. Packages the chart and runs Red Hat `chart-verifier`; fails only on non-certification errors ("Image is not Red Hat certified" warnings are ignored).

## Running Tests Locally

```sh
# Static checks
helm lint .
helm template example-infinispan .            # catch rendering errors

# Full install smoke test (needs a cluster, e.g. Kind)
kubectl create namespace helm-test
helm install example-infinispan . -n helm-test --set deploy.replicas=2
kubectl -n helm-test rollout status --watch --timeout=300s statefulset/example-infinispan
helm test example-infinispan -n helm-test     # runs templates/tests hooks
helm uninstall example-infinispan -n helm-test
kubectl delete namespace helm-test
```

## Writing Tests

* **New install scenario** (new values combination): add a values snippet under `test/`, plus any prerequisite manifests (Secrets, Issuers), then add a step to `test-chart.yml` that installs with the snippet and waits for the relevant resources (`kubectl rollout status`, `kubectl wait --for=condition=Ready`).
* **New Helm test hook:** add a manifest under `templates/tests/` annotated with `helm.sh/hook: test`.
* Mirror the existing steps: create a fresh namespace, install, wait for readiness, uninstall, delete the namespace. Keep timeouts in line with the existing `300s` rollout / `120s` readiness values.
* When a new feature needs TLS or cert-manager, follow the existing manual-TLS and cert-manager-TLS steps as templates.
