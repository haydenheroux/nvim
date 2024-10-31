return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>fm", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>fj", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fg", builtin.git_files)
			vim.keymap.set("n", "<leader>fs", builtin.live_grep)
		end,
	},
}
