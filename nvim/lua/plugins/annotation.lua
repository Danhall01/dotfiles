---@class dh.plugins.config.blink_cmp
---@field keybinds dh.keymap.config.navigation.auto_complete

---@class dh.plugins.config.oil.auto_git
---@field add boolean
---@field rm boolean
---@field mv boolean

---@class dh.plugins.config.oil
---@field keybinds dh.keymap.config.navigation.oil
---@field auto_git dh.plugins.config.oil.auto_git

---@class dh.plugins.config.session.autosave
---@field enabled boolean
---@field interval number The interval given in seconds
---@field notify boolean

---@class dh.plugins.config.session
---@field save_on_exit boolean Automatically saves session on exit
---@field load_on_enter boolean Automatically reattaches previous session on launch
---@field auto_save dh.plugins.config.session.autosave

---@class dh.plugins.config.tasks.overseer.debug_log
---@field enabled boolean
---@field path string Output path for dump files, relative to cwd
---@field log_name string Name of the log file created by DAP
---@field display_all_on_enter boolean Creates a task to display all debug logs on "VimEnter"

---@class dh.plugins.config.tasks.overseer.timeouts
---@field build_events number|nil Timeout in seconds for cmake build and generate events
---@field log_events number|"exit"|nil Timeout in seconds for user or automatic debug log display events
---@field destroy_on_exit boolean Destroy any task on exit

---@class dh.plugins.config.tasks.overseer
---@field keybinds dh.keymap.config.overseer
---@field debug_log dh.plugins.config.tasks.overseer.debug_log
---@field timeouts dh.plugins.config.tasks.overseer.timeouts
---@field open_on_enter boolean Automatically open overseer when entering c/c++ files
---@field close_on_leave boolean Automatically close overseer when leaving c/c++ files
---@field open_on_debug_exit boolean Automatically open overseer when debugging session ends
---@field close_on_debug_enter boolean Automatically close overseer when debugging starts

---@class dh.plugins.config.tasks.runners
---@field keybinds dh.keymap.config.tasks
---@field runners_by_ft table<string, string|table<string>|function>
---@field builder_by_ft table<string, string|table<string>|function>
---@field builder_config_by_ft table<string, string|table<string>|function>
---@field debugger_by_ft table<string, string|table<string>|function>
---@field debugger_current_by_ft table<string, string|table<string>|function>

---@class dh.plugins.config.tasks
---@field overseer dh.plugins.config.tasks.overseer
---@field runners dh.plugins.config.tasks.runners

---@class dh.plugins.config.cpptools
---@field keybinds dh.keymap.config.cpp

---@class dh.plugins.config
---@field blink_cmp dh.plugins.config.blink_cmp
---@field oil dh.plugins.config.oil
---@field session dh.plugins.config.session
---@field tasks dh.plugins.config.tasks
---@field cpptools dh.plugins.config.cpptools
