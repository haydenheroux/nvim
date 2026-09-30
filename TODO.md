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

- [x] **Add markdownlint** via nvim-lint (`markdownlint-cli2`, installed + wired in
      `lua/plugins/lint.lua`). `MD041`/`MD013` give real signal. MD013 wraps at the
      80-col default; if `sysadmin-docs` wants different, drop a
      `.markdownlint-cli2.yaml` in that repo and markdownlint-cli2 auto-discovers it.
- [x] **Install LanguageTool** (6.6 standalone jar, `java -jar`; wrapper at
      `~/.local/bin/languagetool`). Wired via nvim-lint in `lua/plugins/lint.lua`,
      run **on save only** for plain-prose fts (JVM is slow). Catches actual
      grammar errors (word repetition, missing words, concise rewrites) that
      write-good can't.
- [x] **Tune write-good** (`lua/plugins/lint.lua`): passive/weasel/adverb rules
      disabled (noise for imperative how-to prose); runs at INFO severity.
      write-good is now on the fast path alongside proselint/vale/markdownlint.
- [x] **Other linters added**: `proselint`, `vale` (Microsoft/Google/write-good
      styles, default at `~/.config/nvim/vale/`), `chktex` (LaTeX structural),
      and `typos` (misspellings inside code comments across all filetypes).
- [ ] For `sysadmin-docs` specifically: fix `Acadia VMs` typo
      ("monitioring"), optionally adopt `~/.config/nvim/vale/.vale.ini` + a repo
      `.vale.ini` for project voice, and wire tools into a `make lint`/
      pre-commit hook in that repo.
- [x] **Vale.sh** shipped with Microsoft/Google/write-good styles as the default
      (project-specific voice rules can override via a repo `.vale.ini`).

## Where things are wired (this config)

- `lua/plugins/lint.lua` — the nvim-lint prose-linting setup.
- `lua/config/options.lua` — PATH (`~/.local/bin`, mason/bin) + `VALE_CONFIG_PATH`.
- `~/.config/nvim/vale/` — fallback Vale config + synced styles.
- Binaries: write-good (mason), markdownlint-cli2 + proselint + vale + typos +
  languagetool wrapper in `~/.local/bin`, chktex (system).