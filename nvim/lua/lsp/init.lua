-- Load config files
---@type dh.lsp.config
local config = require "lsp.config"
vim.api.nvim_create_augroup("lsp", { clear = true, });

---@type dh.lsp.installer
require "lsp.installer".setup(config)
---@type dh.lsp.diagnostics
require "lsp.diagnostics".setup(config)
---@type dh.lsp.debug
require "lsp.debug".setup(config)
---@type dh.lsp.autocmd
require "lsp.autocmd".setup(config)

--- Enables the lsp servers
---@type dh.lsp.activation
require "lsp.activation".setup(config)
