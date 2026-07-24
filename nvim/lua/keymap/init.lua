---@type dh.keymap.config
local config = require "keymap.config"

---@type dh.keymap.navigation
require "keymap.navigation".setup(config)
---@type dh.keymap.lsp
require "keymap.lsp".setup(config)
---@type dh.keymap.debug
require "keymap.debug".setup(config)
---@type dh.keymap.cmake
require "keymap.cmake".setup(config)

---@type dh.keymap.remap
require "keymap.remap".setup(config)
---@type dh.keymap.shortcut
require "keymap.shortcut".setup(config)
