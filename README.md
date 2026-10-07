# nvim

Neovim configuration. 

## plugins 

| plugin | purpose |
| --- | --- |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | snippets |
| [R-nvim/R.nvim](https://github.com/R-nvim/R.nvim) | R integration |
| [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) | file navigation |
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | theme |
| [folke/lazy.nvim](https://github.com/folke/lazy.nvim) | plugin manager |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | completion |
| [kdheepak/cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols) | LaTeX symbol completion | 
| [lervag/vimtex](https://github.com/lervag/vimtex) | LaTeX filetype plugin | 
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git integration|
| [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) | linter integration |
| [mhartington/formatter.nvim](https://github.com/mhartington/formatter.nvim) | formatter integration |
| [micangl/cmp-vimtex](https://github.com/micangl/cmp-vimtex) | LaTeX reference completion |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | statusline |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | fuzzy finder |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Tree-sitter integration |
| [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | snippet completion |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |
| [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | LSP configuration |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | LSP installation |

## todo

- TODO.md in this directory: breadcrumb + task list for prose linting
  (markdownlint, LanguageTool, tuning the nvim-lint/write-good setup).

## technical writing

Prose linting (via nvim-lint) runs everywhere English is expected:

| tool | role | when it runs |
| --- | --- | --- |
| [markdownlint-cli2][mdl] | structural (MD041 title, MD013 line length) | markdown — open/save |
| [vale][vale] | voice/style (Microsoft/Google/write-good styles) | markdown/tex/text — open/save |
| [proselint][proselint] | usage nits (weasel, hedging, repetition) | markdown/tex — open/save |
| [write-good][wg] | light heuristics (passive/weasel/adverbs off) | markdown/tex — open/save |
| [chktex][chktex] | LaTeX structural warnings | tex — open/save |
| [typos][typos] | misspellings in code comments/strings | all code fts — open/save |
| [LanguageTool][lg] | real grammar engine (repetition, missing words) | markdown/plaintex/tex/gitcommit — **save only** |

Markdown and LaTeX get the same prose-linting feature set: vale + proselint +
write-good + typos always, plus LanguageTool on save (returns real grammar hits
through TeX control words), with LaTeX adding chktex for structure and Markdown
adding markdownlint.

**On by demand:** prose linting is **off by default**. Turn it on when you want
feedback, then off again when you don't:

| control | effect |
| --- | --- |
| `:ProseLint` | enable for the session (runs linters on current buffers) |
| `:ProseLintOff` | disable and clear diagnostics |
| `:ProseLintToggle` / `\lp` | toggle (localleader = `\`) |

State is exposed as `vim.g.prose_linting_enabled`, `toggle_prose_linting()`, and
`set_prose_linting(bool)`.

- Config lives in `lua/plugins/lint.lua`; PATH + `VALE_CONFIG_PATH` in
  `lua/config/options.lua`.
- Binaries: `~/.local/bin` (markdownlint-cli2, proselint, vale, typos, a
  `languagetool` JRE wrapper), mason (write-good), system (chktex).
- Vale uses `~/.config/nvim/vale/.vale.ini` (+ synced styles) as the fallback;
  a project can override by committing its own `.vale.ini`/`styles/`.

[mdl]: https://github.com/DavidAnson/markdownlint-cli2
[vale]: https://vale.sh
[proselint]: http://proselint.com
[wg]: https://github.com/btford/write-good
[chktex]: https://www.nongnu.org/chktex/
[typos]: https://github.com/crate-ci/typos
[lg]: https://languagetool.org


## inspiration
 - [0 to LSP : Neovim RC From Scratch](https://youtu.be/w7i4amO_zaE)
 - [A guide to supercharged mathematical typesetting](https://ejmastnak.com/tutorials/vim-latex/intro/)
 - [ConsistencyPLS Reddit comment](https://www.reddit.com/r/neovim/comments/v31ft4/comment/iavqkcn/)
 - [How to Do 90% of What Plugins Do (With Just Vim)](https://www.youtube.com/watch?v=XA2WjJbmmoM)
