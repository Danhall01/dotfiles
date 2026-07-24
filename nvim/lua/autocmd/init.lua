---@type dh.autocmd.config
local config = require "autocmd.config"

---@type dh.autocmd.templates
require "autocmd.templates".setup(config)

---@type dh.autocmd.behaviour
require "autocmd.behaviour".setup(config)
