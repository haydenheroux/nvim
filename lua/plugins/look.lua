return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					icons_enabled = true,
					-- comment these lines to show slants
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = {}, -- {'progress'} -- show % progress thru file
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.cmd("highlight GitGutterAdd guifg=#a6da95 guibg=#24273a")
			vim.cmd("highlight GitGutterChange guifg=#7dc4e4 guibg=#24273a")
			vim.cmd("highlight GitGutterDelete guifg=#ed8796 guibg=#24273a")
		end,
	},
}
