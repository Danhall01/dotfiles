---@type dh.modules.config
local config = require("modules.config")

---@type dh.modules.nvim_settings
require("modules.nvim_settings").setup(config)
---@type dh.modules.auto_fold
require("modules.auto_fold").setup(config)
