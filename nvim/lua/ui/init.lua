---@type dh.ui.config
local config = require("ui.config")

---@type dh.ui.theme
require("ui.theme").setup(config)
---@type dh.ui.status_line
require("ui.status_line").setup(config)
---@type dh.ui.style
require("ui.style").setup(config)
