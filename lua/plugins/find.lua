return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find files tracked by Git" })
			vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string (from prompt)" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			vim.keymap.set("n", "<leader>fm", function()
				harpoon:list():add()
			end, { desc = "Mark file in jump list" })

			local config = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Jump To",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = config.file_previewer({}),
						sorter = config.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "fj", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Open jump list" })

			vim.keymap.set("n", "fl", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Open jump list" })
		end,
	},
}
