# Prose-linting demo

This file intentionally contains errors. Each one is picked to exercise a
different tool in the technicial writing pipeline. Fix them and watch the
diagnostics in the gutter (and with `:lua vim.diagnostic.open_float()`).

Open it, then run `:write` — that triggers the save-only LanguageTool pass.

## Spelling (typos + your built-in hunspell)

- This sentence contains a speling error.
- And here is a monitioring typo (hunspell catches this one; typos misses it).
- Teh quick brown fox.

## Version recovered

### We have the the bestest uptime of all of the time and it was very
### successfully utilized in order to ensure that users will benefit.
(This block is commented in most markdownlinters as a code block, but here
it's real text. Vale and LanguageTool still judge it.)

## Repeated word and BAD punctuation

The the system performs admirably.  There is two spaces after this period.
AlsoThisNoSpace is wrong. A sentence ending with a colon:

- good list item

This is merely a test of the weasel-word detector and the adverb detector:
really, quickly, utterly, and very.

## Line too long + no title heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.

This file has no top-level `# heading` except the title above — that triggers
MD041 on saved markdown if you remove the first `#`.

## Math / code that should NOT be flagged

A reference to `$e^{i\pi}$` or a \emph{term} or `\texttt{var\_name}` should be
ignored by the grammar tools. So should `someVariableName123`.

`# now a fenced block`
Lorem ipsum is fine to ignore here too, though typos would still scan it.

Wait — actually a `monitioring` misspelling inside a backtick is still checked
by typos (it scans raw text). That's by design: don't hide typos in code.

