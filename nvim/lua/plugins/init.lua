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

-- General Behaviour
---@type dh.plugins.session
require("plugins.session").setup(config)

-- Task manager
require("plugins.tasks.init")
