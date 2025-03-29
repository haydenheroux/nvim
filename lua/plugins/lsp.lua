return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mfussenegger/nvim-lint",
			"mhartington/formatter.nvim",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
		},
		opts = {
			autoformat = true,
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("mason").setup()

			require("formatter").setup({
				filetype = {
					c = {
						require("formatter.filetypes.cpp").clangformat,
					},
					cpp = {
						require("formatter.filetypes.cpp").clangformat,
					},
					go = {
						require("formatter.filetypes.go").gofmt,
					},
					html = {
						require("formatter.filetypes.html").prettier,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					python = {
						require("formatter.filetypes.python").black,
					},
					haskell = {
						require("formatter.filetypes.haskell").ormolu,
					},
					tex = {
						require("formatter.filetypes.tex").latexindent,
					},
					java = {
						require("formatter.filetypes.java").google_java_format,
					},
					typescript = {
						require("formatter.filetypes.typescriptreact").prettierd,
					},
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").prettierd,
					},
				},
			})

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
				callback = function(opts)
					local ft = vim.bo[opts.buf].filetype
					if ft == "markdown" or ft == "tex" or ft == "gitcommit" then
						require("lint").try_lint("write_good")
					end
				end,
			})

			require("mason-lspconfig").setup()

			local configs = {
				basedpyright = require("lsp.basedpyright"),
				clangd = require("lsp.clangd"),
				digestif = {},
				eslint = {},
				gopls = {},
				lua_ls = require("lsp.lua_ls"),
				r_language_server = {},
				ts_ls = {},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- NOTE If the language server does not have a config defined in configs, it is not set up
			for lsp, config in pairs(configs) do
				config.capabilities = capabilities
				lspconfig[lsp].setup(config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				---@diagnostic disable-next-line: unused-local
				callback = function(event)
					vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next, { desc = "Jump to next diagnostic" })
					vim.keymap.set(
						"n",
						"<leader>[d",
						vim.diagnostic.goto_prev,
						{ desc = "Jump to previous diagnostic" }
					)
					vim.keymap.set("n", "<leader>..", vim.lsp.buf.code_action, { desc = "Perform code action" })
					vim.keymap.set("n", "<leader>.f", ":Format<CR>", { desc = "Format this buffer" })
					vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { desc = "Hover the symbol" })
					vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename the symbol" })

					local builtin = require("telescope.builtin")
					vim.keymap.set(
						"n",
						"<leader>i",
						builtin.lsp_implementations,
						{ desc = "Jump to the symbol implementations" }
					)
					vim.keymap.set(
						"n",
						"<leader>rf",
						builtin.lsp_references,
						{ desc = "Jump to the symbol references" }
					)
					vim.keymap.set(
						"n",
						"<leader>d",
						builtin.lsp_definitions,
						{ desc = "Display the symbol definitions" }
					)
					vim.keymap.set(
						"n",
						"<leader>s",
						builtin.lsp_document_symbols,
						{ desc = "Display the buffer symbols" }
					)
				end,
			})
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()

			local expand = function()
				vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				CONFIG_expand_diagnostics = true
			end

			local compact = function()
				vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				CONFIG_expand_diagnostics = false
			end

			local toggle = function()
				if CONFIG_expand_diagnostics then
					compact()
				else
					expand()
				end
			end

			compact()

			vim.keymap.set("", "<leader>;", toggle, { desc = "Toggle multiline diagnostics" })
		end,
	},
	{
		"mrcjkb/haskell-tools.nvim",
		version = "^4",
		lazy = false,
	},
	{
		"R-nvim/R.nvim",
		config = function()
			local config = {
				hook = {
					on_filetype = function()
						local tabstop = 2
						vim.opt.tabstop = tabstop
						vim.opt.shiftwidth = tabstop
						vim.opt.softtabstop = tabstop
						vim.opt.expandtab = true
						-- NOTE The keymap for starting the R terminal is `<localleader>rf`
						vim.keymap.set(
							"n",
							"<Enter>",
							"<Plug>RDSendLine",
							{ desc = "Execute the current line in the R terminal" }
						)
						vim.keymap.set(
							"v",
							"<Enter>",
							"<Plug>RSendSelection",
							{ desc = "Execute the selected lines in the R terminal" }
						)
					end,
				},
				R_args = { "--quiet", "--no-save" },
			}
			if vim.env.R_AUTO_START == "true" then
				config.auto_start = "on startup"
				config.objbr_auto_start = true
			end
			require("r").setup(config)
		end,
		lazy = false,
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
	},
}
