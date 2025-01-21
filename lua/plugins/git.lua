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

			vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
			vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
			vim.keymap.set("n", "<leader>gj", function()
				gitsigns.nav_hunk("next")
			end, { desc = "Jump to next hunk" })
			vim.keymap.set("n", "<leader>gk", function()
				gitsigns.nav_hunk("prev")
			end, { desc = "Jump to previous hunk" })

			vim.keymap.set("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage entire buffer" })
			vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset entire buffer" })
		end,
	},
}
