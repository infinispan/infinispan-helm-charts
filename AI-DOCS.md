# Documentation Instructions

The `documentation/` directory holds the AsciiDoc guide for the chart, authored in Red Hat Modular Documentation style. Separately, `README.md` and `README-tls.md` are chart-level docs (`README.md` is **generated** — see `AI-CODE.md`).

## Content Organization

```
Title (guide)        →  documentation/asciidoc/titles/helm-chart.asciidoc
  └── Story (assembly)  →  documentation/asciidoc/stories/assembly_*.adoc
      └── Topic (reusable content)  →  documentation/asciidoc/topics/{con,proc,ref}_*.adoc
          └── Examples  →  documentation/asciidoc/topics/{yaml,java,properties,images,attributes}/
```

### Title
- `documentation/asciidoc/titles/helm-chart.asciidoc` is the guide entry point.
- It sets document attributes, includes the attribute files, and includes `stories.adoc`.
- `titles/stories.adoc` lists the assemblies that make up the guide.

### Stories (Assemblies)
- Located in `documentation/asciidoc/stories/`, named `assembly_*.adoc`.
- Assemble multiple topics into a user journey (for example `assembly_configuring_encryption.adoc`).
- Set and restore `:context:` for anchor scoping, and include topics with `include::{topics}/proc_*.adoc[leveloffset=+N]`.

### Topics
- Located in `documentation/asciidoc/topics/`, with strict naming prefixes:
  - **`con_*`** — Concept: what something is and why it matters.
  - **`proc_*`** — Procedure: step-by-step instructions (`.Procedure` header, numbered steps).
  - **`ref_*`** — Reference: tables, option lists, defaults.
- Each topic must start with an ID that includes the context: `[id='descriptive-name_{context}']`.
- Topics are designed for reuse across assemblies.

### Examples and Attributes
- YAML examples (values snippets, manifests): `topics/yaml/` — include with `include::yaml/example.yaml[]`.
- Java client examples: `topics/java/`. Properties files: `topics/properties/`. Images: `topics/images/`.
- Shared attributes: `topics/attributes/` (`community-attributes.adoc`, `kubectl_cmds.adoc`).
- Keep examples as separate files and `include::` them; do not inline long examples.

## Writing Style

### Voice and Tense
- Active voice, present tense, second person ("you"). Never first person ("we", "I").
- No contractions ("do not", not "don't"). American English spelling.

### Formatting
- **One sentence per line** (hard wrap at sentence boundaries, not at a column width).
- File paths, values keys, resource kinds, commands: backticks.
- GUI elements: bold (`*Install*`). First occurrence of a term: italics.
- Numbers below 10: spell out; 10 and above: numerals.
- Avoid Latin abbreviations (use "for example", not "e.g."). Avoid "simply".

### Admonitions and Code Blocks
```asciidoc
[NOTE]
====
Note content.
====
```
Use `NOTE`, `TIP`, `WARNING`, `IMPORTANT` as appropriate.

```asciidoc
[source,yaml,options="nowrap",subs=attributes+]
----
include::yaml/certmanager_endpoint.yaml[]
----
```

## Branding and Conditional Content

Documentation is branded through attributes, not hardcoded names — the same source produces the **community** (Infinispan) and **downstream** (Red Hat Data Grid / RHDG) guides. This community-vs-downstream split is **product branding**, independent of the Kubernetes-vs-OpenShift platform distinction.

- Use `{brandname}` / `{fullbrandname}` for the product name, never hardcode "Infinispan".
- Use `{k8s}`, `{openshift}`, `{ocp}` and the other platform attributes from `topics/attributes/community-attributes.adoc` rather than hardcoding platform names.
- Gate build-specific content with conditionals:

```asciidoc
ifdef::community[]
Community-only content.
endif::community[]

ifdef::downstream[]
Downstream (RHDG) only content.
endif::downstream[]
```

`community-attributes.adoc` sets `:community:` and the community attribute values; the downstream build supplies its own attributes.

## When Creating New Documentation
1. Decide whether the content is a concept, procedure, or reference and use the correct `con_`/`proc_`/`ref_` prefix.
2. Place the topic in `documentation/asciidoc/topics/` with `[id='descriptive-name_{context}']` at the top.
3. Include it from the relevant assembly in `documentation/asciidoc/stories/`; add a new assembly to `titles/stories.adoc` if needed.
4. Put code and YAML examples in the matching `topics/<format>/` subdirectory and `include::` them.
5. Write all product and platform names through attributes, and wrap build-specific text in `ifdef` conditionals.
