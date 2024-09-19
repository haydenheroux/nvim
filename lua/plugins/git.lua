return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")

			gitsigns.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "-" },
					topdelete = { text = "-" },
				},
				signs_staged = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "-" },
					topdelete = { text = "-" },
				},
			})

			vim.keymap.set("n", "<leader>gs", gitsigns.stage_buffer)
			vim.keymap.set("n", "<leader>gr", gitsigns.reset_buffer)

			vim.keymap.set("n", "<leader>gS", gitsigns.stage_hunk)
			vim.keymap.set("n", "<leader>gR", gitsigns.reset_hunk)
		end,
	},
}
