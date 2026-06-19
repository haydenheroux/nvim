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
			local make_entry = require("telescope.make_entry")
			local conf = require("telescope.config").values
			vim.keymap.set("n", "<leader>fg", function()
				local files = vim.fn.systemlist("git ls-files")
				local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if git_root and git_root:match("go/src/merge$") then
					local ignore_patterns = {
						"_templ%.go$",
						"main%.css$",
					}
					files = vim.tbl_filter(function(f)
						for _, pat in ipairs(ignore_patterns) do
							if f:match(pat) then return false end
						end
						return true
					end, files)
				end
				if #files == 0 then return end
				require("telescope.pickers").new({}, {
					prompt_title = "Git Files",
					finder = require("telescope.finders").new_table({
						results = files,
						entry_maker = make_entry.gen_from_file({}),
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				}):find()
			end, { desc = "Find files tracked by Git" })
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
