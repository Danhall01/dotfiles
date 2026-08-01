---@class dh.keymap.style
local debug = {}

---@param config dh.keymap.config.style
local function colorizer(config)
	if not config.toggle_colorizer.disabled then
		vim.keymap.set("n", config.toggle_colorizer.keybind, function()
			vim.cmd("ColorizerToggle")
		end)
	end
end

---@param config dh.keymap.config
function debug.setup(config)
	colorizer(config.style)
end

return debug
