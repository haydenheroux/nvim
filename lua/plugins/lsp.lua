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
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					python = {
						require("formatter.filetypes.python").black,
					},
					haskell = {
						require("formatter.filetypes.haskell").ormolu,
					},
				},
			})

			vim.api.nvim_create_augroup("__formatter__", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWrite",
			})

			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local configs = {
				basedpyright = require("lsp.basedpyright"),
				clangd = require("lsp.clangd"),
				digestif = require("lsp.digestif"),
				lua_ls = require("lsp.lua_ls"),
				r_language_server = require("lsp.r_language_server"),
			}

			for lsp, config in pairs(configs) do
				config.capabilities = capabilities
				lspconfig[lsp].setup(config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				---@diagnostic disable-next-line: unused-local
				callback = function(event)
					local options = { buffer = true, remap = false }

					vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_next, options)
					vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_prev, options)
					vim.keymap.set("n", "<leader>..", vim.lsp.buf.code_action, options)
					vim.keymap.set("n", "<leader>.f", vim.lsp.buf.format, options)
					vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, options)
					vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, options)

					local builtin = require("telescope.builtin")
					vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, options)
					vim.keymap.set("n", "<leader>rf", builtin.lsp_references, options)
					vim.keymap.set("n", "<leader>d", builtin.lsp_definitions, options)
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

			vim.keymap.set("", "<leader>;", toggle)
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
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
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
}
