-- Hooks
---@type dh.plugin_hooks
require("plugin_hooks").setup()

-- pack.add
---@type dh.plugin_list
require("plugin_list").setup()

-- Plugin Setup / Config
require("plugins.init")

-- LSP Configuration / Installation
require("lsp.init")

-- Commands & Automation
require("commands.init")
require("autocmd.init")

-- My Plugins / Custom Setup
require("modules.init")

-- UI
require("ui.init")

-- Keymaps
require("keymap.init")
