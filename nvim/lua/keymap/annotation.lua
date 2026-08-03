---@class dh.keymap.config.keybind
---@field keybind? string
---@field disabled? boolean

---@class dh.keymap.config.navigation.telescope
---@field find_files dh.keymap.config.keybind
---@field grep_live dh.keymap.config.keybind
---@field grep_selected dh.keymap.config.keybind
---@field get_keymaps dh.keymap.config.keybind
---@field find_references dh.keymap.config.keybind
---@field find_definitions dh.keymap.config.keybind
---@field find_type_definitions dh.keymap.config.keybind
---@field git_branches dh.keymap.config.keybind
---@field list_functions dh.keymap.config.keybind
---@field list_symbols dh.keymap.config.keybind

---@class dh.keymap.config.navigation.auto_complete
---@field forward dh.keymap.config.keybind
---@field backward dh.keymap.config.keybind
---@field accept dh.keymap.config.keybind
---@field show dh.keymap.config.keybind
---@field close dh.keymap.config.keybind

---@class dh.keymap.config.navigation.window
---@field up dh.keymap.config.keybind
---@field down dh.keymap.config.keybind
---@field left dh.keymap.config.keybind
---@field right dh.keymap.config.keybind
---@field number_prefix string

---@class dh.keymap.config.navigation.oil
---@field help dh.keymap.config.keybind
---@field action dh.keymap.config.keybind
---@field action_split_vert dh.keymap.config.keybind
---@field action_split_hor dh.keymap.config.keybind
---@field toggle_preview dh.keymap.config.keybind
---@field close dh.keymap.config.keybind
---@field refresh dh.keymap.config.keybind
---@field dir_up dh.keymap.config.keybind
---@field dir_cwd dh.keymap.config.keybind
---@field open_external dh.keymap.config.keybind
---@field toggle_hidden dh.keymap.config.keybind
---@field toggle_trash dh.keymap.config.keybind

---@class dh.keymap.config.navigation
---@field file_explorer dh.keymap.config.keybind
---@field window dh.keymap.config.navigation.window
---@field auto_complete dh.keymap.config.navigation.auto_complete
---@field telescope dh.keymap.config.navigation.telescope
---@field oil dh.keymap.config.navigation.oil

---@class dh.keymap.config.lsp
---@field next_error dh.keymap.config.keybind
---@field prev_error dh.keymap.config.keybind
---@field toggle_header dh.keymap.config.keybind
---@field goto_definition dh.keymap.config.keybind
---@field goto_type_definition dh.keymap.config.keybind
---@field goto_declaration dh.keymap.config.keybind
---@field goto_implementation dh.keymap.config.keybind
---@field find_references dh.keymap.config.keybind
---@field hover_info dh.keymap.config.keybind
---@field rename dh.keymap.config.keybind
---@field code_action dh.keymap.config.keybind

---@class dh.keymap.config.debug
---@field run dh.keymap.config.keybind
---@field run_current dh.keymap.config.keybind
---@field toggle_breakpoint dh.keymap.config.keybind
---@field toggle_breakpoint_cond dh.keymap.config.keybind
---@field continue dh.keymap.config.keybind
---@field restart dh.keymap.config.keybind
---@field step_over dh.keymap.config.keybind
---@field step_into dh.keymap.config.keybind
---@field step_out dh.keymap.config.keybind
---@field inspect dh.keymap.config.keybind

---@class dh.keymap.config.cmake
---@field build dh.keymap.config.keybind
---@field run dh.keymap.config.keybind
---@field set_build_type dh.keymap.config.keybind

---@class dh.keymap.config.overseer
---@field actions dh.keymap.config.keybind
---@field open_float dh.keymap.config.keybind

---@class dh.keymap.config.style
---@field toggle_colorizer dh.keymap.config.keybind

---@class dh.keymap.config
---@field navigation dh.keymap.config.navigation
---@field lsp dh.keymap.config.lsp
---@field debug dh.keymap.config.debug
---@field cmake dh.keymap.config.cmake
---@field overseer dh.keymap.config.overseer
---@field style dh.keymap.config.style
