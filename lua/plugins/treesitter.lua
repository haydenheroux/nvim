return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local installed = require("nvim-treesitter.config").get_installed()
			local ensure_installed = {
				"bash",
				"comment",
				"lua",
				"markdown",
				"markdown_inline",
				"r",
				"rnoweb",
				"yaml",
				"latex",
				"csv",
			}
			local installed_set = {}
			for _, lang in ipairs(installed) do
				installed_set[lang] = true
			end
			local to_install = {}
			for _, lang in ipairs(ensure_installed) do
				if not installed_set[lang] then
					table.insert(to_install, lang)
				end
			end
			if #to_install > 0 then
				require("nvim-treesitter.install").install(to_install, { summary = true })
			end
		end,
	},
    {
        "VPavliashvili/json-nvim",
        ft = "json",
    }
}
