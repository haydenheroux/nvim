-- Technical-writing lens: grammar checkers, linters, and style guides.
--
-- Goals (from TODO.md):
--   * run everywhere English is expected: Markdown, LaTeX, git commit messages,
--     and English in code comments/identifiers.
--   * real grammar signal (LanguageTool) without the noise (write-good tuned
--     off its noisiest heuristics).
--   * project-configurable, not just global (markdownlint-cli2 auto-discovers
--     repo config; Vale only activates when a `.vale.ini` exists in the project).
--
-- Linters used per filetype (via nvim-lint):
--   markdown/mdown : markdownlint-cli2 + vale + proselint + write_good + typos
--   tex/plaintex   : chktex + vale + proselint + write_good + typos   (chktex = structural)
--   rnoweb         : chktex + vale + proselint + write_good + typos
--   gitcommit      : proselint + write_good + typos
--   code filetypes : typos (catches comment/string/identifier misspellings)
--
-- LaTeX gets the same prose linters as Markdown (vale + LanguageTool + proselint +
-- write-good) plus chktex for structure. vale and LanguageTool both understand
-- LaTeX: they ignore \commands, math, and \texttt so only running prose is judged.
-- LanguageTool (JVM-backed, slow) runs on save only.
return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			-- write-good: imperative how-to prose reads as "passive" a lot. Disable
			-- its noisiest heuristics (passive voice, weasel / "very"-class, adverbs)
			-- and keep the rest at INFO so it never hogs the diagnostic gutter.
			lint.linters.write_good.args = { "--parse", "--no-passive", "--no-weasel", "--no-adverbs" }

			-- chktex exits non-zero when it finds warnings (its entire purpose); suppress
			-- nvim-lint's "exited with code" notification so the in-buffer diagnostics speak.
			lint.linters.chktex.ignore_exitcode = true

			-- Give LanguageTool diagnostics a proper source label (its parser leaves
			-- `source` nil, so they'd otherwise show as `[nil]` in the diagnostic gutter).
			local lt = lint.linters.languagetool
			if lt and lt.parser then
				local base_parser = lt.parser
				lt.parser = function(output, bufnr)
					local res = base_parser(output, bufnr)
					for _, d in ipairs(res) do
						d.source = "languagetool"
					end
					return res
				end
			end

			-- Cheap linters, run on the live path (open, save, leave insert).
			lint.linters_by_ft = {
				-- Prose
				markdown  = { "markdownlint-cli2", "vale", "proselint", "write_good", "typos" },
				mdown     = { "markdownlint-cli2", "vale", "proselint", "write_good", "typos" },
				tex       = { "chktex", "vale", "proselint", "write_good", "typos" },
				plaintex  = { "chktex", "vale", "proselint", "write_good", "typos" },
				context   = { "chktex", "vale", "proselint", "write_good", "typos" },
				rnoweb    = { "chktex", "vale", "proselint", "write_good", "typos" },
				gitcommit = { "proselint", "write_good", "typos" },
				text      = { "vale", "proselint", "write_good", "typos" },
				-- English in code comments/strings/identifiers
				lua       = { "typos" },
				python    = { "typos" },
				c         = { "typos" },
				cpp       = { "typos" },
				go        = { "typos" },
				java      = { "typos" },
				javascript = { "typos" },
				typescript = { "typos" },
				sh        = { "typos" },
				zsh       = { "typos" },
				rust      = { "typos" },
				ruby      = { "typos" },
				vim       = { "typos" },
			}

			-- Slow linter (LanguageTool = JVM spin-up): save-time only, on plain-English
			-- prose. LaTeX is included: LanguageTool understands TeX and ignores control
			-- words/math, so it flags genuine prose (word repetition, agreement, missing
			-- words) the same way it does for Markdown.
			local slow_linter_by_ft = {
				markdown  = "languagetool",
				mdown     = "languagetool",
				tex       = "languagetool",
				plaintex  = "languagetool",
				text      = "languagetool",
				gitcommit = "languagetool",
				rnoweb    = "languagetool",
			}

			-- Module-level (not buffer-local) enabled flag so it applies to every buffer
			-- and the autocmd guards below can check it.
			local prose_enabled = true
			vim.g.prose_linting_enabled = true

			-- Fast path: cheap linters on open / save / leaving insert mode.
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					if not prose_enabled then
						return
					end
					lint.try_lint()
				end,
			})

			-- Save-only pass for the slow JVM-backed linter.
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					if not prose_enabled then
						return
					end
					local slow = slow_linter_by_ft[vim.bo.filetype]
					if slow then
						lint.try_lint(slow)
					end
				end,
			})

			local names = vim.tbl_keys(lint.linters_by_ft)
			local function clear_all_lint_diags()
				for _, ft in ipairs(names) do
					for _, linter in ipairs(lint.linters_by_ft[ft] or {}) do
						local ns = lint.get_namespace(linter)
						if ns then
							vim.diagnostic.reset(ns)
						end
					end
				end
				-- Same for the slow path's linter names.
				for _, linter in ipairs(vim.tbl_values(slow_linter_by_ft)) do
					local ns = lint.get_namespace(linter)
					if ns then
						vim.diagnostic.reset(ns)
					end
				end
			end

			local function set_prose_enabled(v)
				prose_enabled = v
				vim.g.prose_linting_enabled = v
				if v then
					-- Re-run the fast linters so current buffers pick up diagnostics again.
					lint.try_lint()
				else
					clear_all_lint_diags()
				end
				vim.notify("Prose linting " .. (v and "enabled" or "disabled"),
					vim.log.levels.INFO, { title = "nvim-lint" })
			end

			local function toggle()
				set_prose_enabled(not prose_enabled)
			end

			vim.keymap.set("n", "<localleader>lp", toggle,
				{ desc = "Toggle prose linting" })
			-- Also expose for `vim`/`:lua` use.
			_G.toggle_prose_linting = toggle
			_G.set_prose_linting = set_prose_enabled
		end,
	},
}