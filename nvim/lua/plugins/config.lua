---@type dh.plugins.config
local config = {
    blink_cmp = {
        keybinds = require "keymap.config".navigation.auto_complete,
    },
    overseer = {
        keybinds = require "keymap.config".overseer,
        debug_log = {
            enabled = true,
            path = "bin/",
            log_name = "dap",
        },
        cmake_build_timeout = 3,
    },
}

return config
