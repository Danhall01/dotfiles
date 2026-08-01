---@class dh.keymap.shortcut
local shortcut = {}

---@param config dh.keymap.config
function shortcut.setup(config)
	-- Select entire file
	vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select everything from normal mode" })
end

return shortcut
