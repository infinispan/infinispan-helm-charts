# Submitting PRs
All PRs that require modifications to the `README.md` or `values.schema.json` files should update the respective `.tpl` file.

The `brand.sh` script should then be executed using the upstream properties, i.e. `./brand.sh infinispan.conf`, and all
modified `*.tpl`, `*.md` and `*.json` files added to the commit.
