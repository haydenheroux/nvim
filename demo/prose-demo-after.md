# Prose-linting demo

This file intentionally contains errors. Each plugin exercises a
different tool in the technical writing pipeline. Fix them and watch the
diagnostics in the gutter and with `:lua vim.diagnostic.open_float()`.

Open it, then run `:write`—that triggers the save-only LanguageTool pass.

## Spelling (typos + your built-in hunspell)

- This sentence contains a spelling error.
- And here sits a monitoring typo (hunspell catches this one, but typos misses it).
- The quick brown fox.

## Version recovered

### The servers have good uptime

### Successfully used to benefit that users

Most Markdown linters classify this as a code block, but
it contains real text. Vale and LanguageTool still judge it.

## Repeated word and bad punctuation

The system performs admirably. This sentence contained two preceding spaces.
The linter needs to flag AlsoThisNoSpace. A sentence ending with a colon:

- good list item

This sentence tests the weasel-word detector and the adverb detector:

## Line too long + no title heading

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris.

This file has no top-level `# heading` except the preceding title.
That triggers MD041 on saved markdown if you remove the first `#`.

## The linter won't flag math / code

Grammar tools should ignore references to `$e^{i\pi}$` or a \emph{term} or `\texttt{var\_name}`
The linter ignores `someVariableName123` too.

`# now a fenced block`
Lorem ipsum works here too, though typos would still scan it.

Wait—actually typos checks a `monitioring` misspelling inside a backtick.
This reflects an intentional design decision: don't hide typos in code.
