---@type dh.plugins.config
local config = require("plugins.config")

---@type dh.plugins.dependencies
require("plugins.dependencies").setup(config)

---@type dh.plugins.navigation
require("plugins.navigation").setup(config)
---@type dh.plugins.typing
require("plugins.typing").setup(config)
---@type dh.plugins.treesitter
require("plugins.treesitter").setup(config)

---@type dh.plugins.cpptools
require("plugins.cpptools").setup(config)

---@type dh.plugins.session
require("plugins.session").setup(config)

---@type dh.plugins.git
require("plugins.git").setup(config)

---@type dh.plugins.tests
require("plugins.tests").setup(config)
---@type dh.plugins.code_analysis
require("plugins.code_analysis").setup(config)

-- Task manager
---@type dh.plugins.tasks.task_manager
require("plugins.task_manager").setup(config.tasks)

--- Automatically import all tasks
local task_cmds = {}
local config_path = vim.fn.stdpath("config") .. "/lua"
local tasks = vim.fn.glob(config_path .. "/plugins/tasks/*.lua", false, true)
for _, path in pairs(tasks or {}) do
	local plugin = vim.fs.relpath(config_path, path)
	if not plugin then
		error(("Failed to parse task import path for %s"):format(path))
	end
	plugin = plugin:gsub("%.lua$", "")
	plugin = plugin:gsub("[/\\]", ".")

	local task = require(plugin)
	if type(task) ~= "table" or task.register == nil then
		error(('Unable to find register function for task: "%s"'):format(plugin))
	end
	task.register(config.tasks)
	vim.list_extend(task_cmds, task.cmds)
end
