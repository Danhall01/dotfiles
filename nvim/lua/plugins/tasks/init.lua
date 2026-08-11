---@type dh.plugins.tasks.config
local config = require("plugins.tasks.config")

---@type dh.plugins.tasks.overseer
require("plugins.tasks.overseer").setup(config)
---@type dh.plugins.tasks.cmake
require("plugins.tasks.cmake").setup(config)
---@type dh.plugins.tasks.dap_logs
require("plugins.tasks.dap_logs").setup(config)
---@type dh.plugins.tasks.autocmd
require("plugins.tasks.autocmd").setup(config)
