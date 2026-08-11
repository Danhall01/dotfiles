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

---@class dh.plugins.config
---@field blink_cmp dh.plugins.config.blink_cmp
---@field oil dh.plugins.config.oil
---@field session dh.plugins.config.session
