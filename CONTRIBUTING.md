# Submitting PRs
All PRs that require modifications to the `README.md` or `values.schema.json` files should update the respective `.tpl` file.

The `brand.sh` script should then be executed using the upstream properties, i.e. `./brand.sh infinispan.conf`, and all
modified `*.tpl`, `*.md` and `*.json` files added to the commit.


# Creating a Release
1. Update `Chart.yaml`
    - `.version` should be set to the version of the chart released
    - `.appVersion` should be updated to the Infinispan server `major.minor` associated with the chart
2. Commit the changes, `git commit -m "Releasing <x.y.z>"`
3. Tag the release, `git tag <x.y.z>`
4. Push the tag and commit to https://github.com/infinispan/infinispan-helm-charts
5. Relase the chart at https://github.com/openshift-helm-charts/charts
    a. Create a PR to add your username to the `OWNERS` file at https://github.com/openshift-helm-charts/charts/blob/main/charts/community/infinispan/infinispan/OWNERS
    b. Package the chart, `helm package .`
    c. Create a PR for https://github.com/openshift-helm-charts/charts with the `infinispan-*.tgz` added to `charts/community/infinispan/infinispan/<x.y.z>`
