-- Load config files
---@type dh.lsp.config
local config = require("lsp.config")
vim.api.nvim_create_augroup("dh.lsp", { clear = true })

-- Install all requirements
---@type dh.lsp.installer
require("lsp.installer").setup(config)

-- Configuration
---@type dh.lsp.diagnostics
require("lsp.diagnostics").setup(config)
---@type dh.lsp.debug
require("lsp.debug").setup(config)

-- Extra functionality
---@type dh.lsp.linting
require("lsp.linting").setup(config)
---@type dh.lsp.formatting
require("lsp.formatting").setup(config)

--- Enables the lsp servers
---@type dh.lsp.server_attach
require("lsp.server_attach").setup(config)
