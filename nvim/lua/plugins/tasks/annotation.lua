---@class dh.plugins.tasks.config.overseer.debug_log
---@field enabled boolean
---@field path string Output path for dump files, relative to cwd
---@field log_name string Name of the log file created by DAP
---@field display_all_on_enter boolean Creates a task to display all debug logs on "VimEnter"

---@class dh.plugins.tasks.config.overseer.timeouts
---@field build_events number|nil Timeout in seconds for cmake build and generate events
---@field log_events number|"exit"|nil Timeout in seconds for user or automatic debug log display events
---@field destroy_on_exit boolean Destroy any task on exit

---@class dh.plugins.tasks.config.overseer
---@field keybinds dh.keymap.config.overseer
---@field debug_log dh.plugins.tasks.config.overseer.debug_log
---@field timeouts dh.plugins.tasks.config.overseer.timeouts
---@field open_on_enter boolean Automatically open overseer when entering c/c++ files
---@field close_on_leave boolean Automatically close overseer when leaving c/c++ files
---@field open_on_debug_exit boolean Automatically open overseer when debugging session ends
---@field close_on_debug_enter boolean Automatically close overseer when debugging starts

---@class dh.plugins.tasks.config
---@field overseer dh.plugins.tasks.config.overseer
---@field runners_by_ft table<string, string|function>
---@field debugger_by_ft table<string, string|function>
