---@class dh.plugins.config.blink_cmp
---@field keybinds dh.keymap.config.navigation.auto_complete

---@class dh.plugins.config.overseer.debug_log
---@field path string Output path for dump files, relative to cwd
---@field log_name string Name of the log file created by DAP
---@field enabled boolean

---@class dh.plugins.config.overseer
---@field keybinds dh.keymap.config.overseer
---@field debug_log dh.plugins.config.overseer.debug_log
---@field cmake_build_timeout number Timeout period given in seconds
---@field open_on_enter boolean Automatically open overseer when entering c/c++ files
---@field close_on_leave boolean Automatically close overseer when leaving c/c++ files
---@field open_on_debug_exit boolean Automatically open overseer when debugging session ends
---@field close_on_debug_enter boolean Automatically close overseer when debugging starts

---@class dh.plugins.config
---@field blink_cmp dh.plugins.config.blink_cmp
---@field overseer dh.plugins.config.overseer
