---@type dh.plugins.config
local config = require "plugins.config"

---@type dh.plugins.dependencies
require "plugins.dependencies".setup(config)
---@type dh.plugins.navigation
require "plugins.navigation".setup(config)
---@type dh.plugins.typing
require "plugins.typing".setup(config)
---@type dh.plugins.treesitter
require "plugins.treesitter".setup(config)
---@type dh.plugins.workflow_c_cpp
require "plugins.workflow_c_cpp".setup(config)
