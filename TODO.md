# TODO: prose linting for markdown (breadcrumb from Sep 30 discussion)

Discussion summary: evaluated language/grammar linters against
`sysadmin-docs/procedures/new-user.md`. Bottom line — pick by tier,
tune the config, and remember that pronoun reference, logical
contradiction, and sentence repetition (issues 5, 6, 8 from that
review) are **judgment calls no linter can make**.

## What each tool caught on the test file

| tool | tier | result on new-user.md |
| --- | --- | --- |
| **markdownlint** (recommended) | structural | caught missing top-level heading (MD041 = "no title!"), 11x line length (MD013) |
| **LanguageTool** (recommended) | real grammar engine | (not installed) — only tool that would catch *missing-word* errors |
| **write-good** (already wired in!) | style heuristics | 10 hits, all noise for a how-to doc (passive voice x6, "all of", "However", "additional", "successfully") — almost all false positives |
| **proselint** | style heuristics | 1 hit: uses `...` instead of `…` |
| **hunspell / aspell** (installed) | spelling | would catch real typo `monitioring` in `sysadmin-docs/Acadia VMs` |

Linter limits: no tool catches ambiguous pronouns, contradictory
clauses, or repeated sentence templates — those need a human (or LLM)
review pass. Recommended checklist lives in the docs repo discussion
(grammar checklist for issues 5-8).

## TODO

- [ ] **Add markdownlint** via nvim-lint (or `markdownlint-cli2` on save)
      — `MD041`/`MD013` give real signal. Decision needed: repo
      `sysadmin-docs` wraps prose at ~80 cols; either keep MD013, set
      `line_length: 80`, or disable MD013 repo-wide in a
      `.markdownlint.jsonc` committed to `sysadmin-docs`.
- [ ] **Install LanguageTool** (needs JRE; macOS `brew install
      languagetool`, Linux needs java + jar). Wire via nvim-lint
      (`language_tool` has a lint source in nvim-lint) or
      vim-languagetool. This is the tier that catches actual grammar
      errors (missing words, agreement, punctuation) that write-good
      can't.
- [ ] **Tune or drop write-good** (already configured in
      `lua/plugins/formatter.lua`). Its passive-voice rule is noise for
      imperative how-to docs. Options: keep with rules disabled, or
      replace the `try_lint("write_good")` call for markdown ft with
      the new tools above.
- [ ] For `sysadmin-docs` specifically: fix `Acadia VMs` typo
      ("monitioring"), and wire whatever tools survive into a `make
      lint` or pre-commit hook in that repo.
- [ ] Optional: Vale.sh with custom rules if we want *project-specific*
      voice rules (e.g. enforce "FreeIPA", fqdn hostnames).

## Where to wire things (this config)

- `lua/plugins/formatter.lua` — nvim-lint config lives here
  (autocmd already runs `write_good` on markdown/tex/gitcommit)
- `lua/plugins/lsp.lua` — LSP servers via mason (markdown LSP
  `marksman`/`mdl` could also be added here; markdownlint-cli2 has a
  `markdownlint-cli2` LSP-less CLI, so nvim-lint is the easier path)
- `lua/config/options.lua` — any global defaults