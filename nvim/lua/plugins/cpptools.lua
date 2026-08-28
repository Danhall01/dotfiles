---@class dh.plugins.cpptools
local cpptools = {}

---@param config dh.plugins.config
function cpptools.setup(config)
	local keybinds = config.cpptools.keybinds
	require("nt-cpp-tools").setup({
		preview = {
			quit = "q",
			accept = "<CR>",
		},
	})

	local cppman = require("cppman")
	cppman.setup()
	if not keybinds.man_cursor then
		vim.keymap.set("n", keybinds.man_cursor.keybind, function()
			cppman.open_cppman_for(vim.fn.expand("<cword>"))
		end)
	end
	if not keybinds.man_search then
		vim.keymap.set("n", keybinds.man_search.keybind, function()
			cppman.input()
		end)
	end

	local cl_opts = {
		compiler = "clang",
		args = {},
		compile_commands = true,
		keymap = nil,
	}
	if not keybinds.class_layout_view.disabled then
		cl_opts.keymap = keybinds.class_layout_view.keybind
	end
	require("classlayout").setup(cl_opts)
end

return cpptools
