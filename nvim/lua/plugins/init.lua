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

-- C/C++ config
---@type dh.plugins.c_cpp.overseer_cmake
require("plugins.c_cpp.overseer_cmake").setup(config)
---@type dh.plugins.c_cpp.overseer_dap
require("plugins.c_cpp.overseer_dap").setup(config)
---@type dh.plugins.c_cpp.overseer_autocmd
require("plugins.c_cpp.overseer_autocmd").setup(config)
