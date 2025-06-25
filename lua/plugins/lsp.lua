return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("mason").setup()

			require("mason-lspconfig").setup()

			local configs = {
				basedpyright = require("lsp.basedpyright"),
				clangd = require("lsp.clangd"),
				cssls = {},
				digestif = {},
				eslint = {},
				html = {},
				gopls = {},
				lua_ls = require("lsp.lua_ls"),
				r_language_server = {},
				ts_ls = {},
				tailwindcss = {},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- NOTE If the language server does not have a config defined in `configs`, it is not set up
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
				edit = "e",
				-- tabe = "t",
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
					sign = false,
				},
				ui = {
					code_action = "",
				},
			})

			vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next, { desc = "Jump to next diagnostic" })
			vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_prev, { desc = "Jump to previous diagnostic" })
			vim.keymap.set("n", "<leader>..", "<cmd>Lspsaga code_action<cr>", { desc = "Perform code action" })
			vim.keymap.set("n", "<leader>.f", "<cmd>Format<cr>", { desc = "Format this buffer" })
			vim.keymap.set("n", "<leader>h", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover the symbol" })
			vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename ++project<cr>", { desc = "Rename the symbol" })
            vim.keymap.set("n", '<leader>`', '<cmd>Lspsaga term_toggle<cr>', { desc = "Open a temporary terminal" })


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
	-- TODO Considering removing `lsp_lines`; not sure how useful it actually is
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
		config = require("lsp.r_nvim"),
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
