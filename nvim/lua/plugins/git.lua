---@class dh.plugins.git
local git = {}

---@param config dh.plugins.config
function git.setup(config)
	vim.api.nvim_create_user_command("CCommit", function()
		require("telescope").extensions.conventional_commits.conventional_commits()
	end, {})

	local neogit = require("neogit")
	neogit.setup({
		filewatcher = {
			interval = 500,
			enabled = true,
		},
		graph_style = "kitty",
		auto_refresh = true,
		kind = "vsplit",

		integrations = {
			telescope = true,
			diffview = true,
		},
		process_spinner = true,
	})
	vim.api.nvim_create_user_command("NeogitUpdate", function()
		neogit.refresh()
	end, {})
end

return git
