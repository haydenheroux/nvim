local workspace_directory = function ()
	local home = os.getenv("HOME")
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	return home .. "/.local/share/eclipse/" .. project_name
end

local language_server_command = function()
	local home = os.getenv("HOME")

	local java = "/usr/lib/jvm/java-21-openjdk/bin/java"
	local jar = vim.fn.glob("/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
    -- TODO This is a hack because the /usr/share/java/ directory is not writable
	local configuration = home .. "/jdtls/pkg/jdtls/usr/share/java/jdtls/config_linux"
	local data_directory = workspace_directory()

	return {
		java,
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g", -- Use 4 gigabytes
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jar,
		"-configuration",
		configuration,
		"-data",
		data_directory,
	}
end

local find_root_dir = function()
	local root_dir_files = { "gradlew", ".git", "mvnw" }
	-- NOTE In theory, these methods are equivalent
	-- local matches = vim.fs.find(root_dir_files, { upward = true })
	-- return vim.fs.dirname(matches[1])
	return vim.fs.root(0, root_dir_files)
end

local config = {
	cmd = language_server_command(),
	root_dir = find_root_dir(),
	settings = {
		java = {},
	},
	init_options = {
		bundles = {},
	},
}

require("jdtls").start_or_attach(config)
