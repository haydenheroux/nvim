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
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			local keys = {
				edit = "<cr>",
				tabe = "t",
				vsplit = "v",
				split = "s",
			}

			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				definition = {
					keys = keys,
				},
				finder = {
					keys = keys,
				},
				rename = {
					auto_save = true,
				},
				beacon = {
					enable = false,
				},
				lightbulb = {
					enable = false,
				},
			})

			vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next, { desc = "Jump to next diagnostic" })
			vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_prev, { desc = "Jump to previous diagnostic" })
			vim.keymap.set("n", "<leader>..", "<cmd>Lspsaga code_action<cr>", { desc = "Perform code action" })
			vim.keymap.set("n", "<leader>.f", "<cmd>Format<cr>", { desc = "Format this buffer" })
			vim.keymap.set("n", "<leader>h", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover the symbol" })
			vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<cr>", { desc = "Rename the symbol" })

			vim.keymap.set(
				"n",
				"<leader>u",
				"<cmd>Lspsaga finder<cr>",
				{ desc = "Find usages for the symbol underneath the cursor" }
			)
			vim.keymap.set(
				"n",
				"<leader>d",
				"<cmd>Lspsaga peek_definition<cr>",
				{ desc = "View the symbol definition" }
			)
			vim.keymap.set(
				"n",
				"<leader>D",
				"<cmd>Lspsaga goto_definition<cr>",
				{ desc = "Jump to the symbol definition" }
			)
			vim.keymap.set(
				"n",
				"<leader>s",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "Display the buffer symbols" }
			)
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
