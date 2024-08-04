return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>f", builtin.find_files)
			vim.keymap.set("n", "<leader>gf", builtin.git_files)
			vim.keymap.set("n", "<leader>s", function()
				builtin.grep_string({ search = vim.fn.input("grep: ") })
			end)
		end,
	},
}
