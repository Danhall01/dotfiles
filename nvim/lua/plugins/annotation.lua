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

---@class dh.plugins.config
---@field blink_cmp dh.plugins.config.blink_cmp
---@field overseer dh.plugins.config.overseer
