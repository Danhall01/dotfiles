---@class dh.keymap.remap
---@function setup(config: keymap_config)
local remap = {}

local function improved_insert_mode()
	-- Insert mode with indentation
	vim.keymap.set("n", "i", function()
		return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
	end, { expr = true, noremap = true })
end
local function delete_to_void()
	-- Delete into void instead of cpy buffer
	vim.keymap.set("x", "<leader>p", '"_dP')
	vim.keymap.set("n", "<leader>d", '"_d')
	vim.keymap.set("v", "<leader>d", '"_d')
end

local function copy_to_clipboard()
	-- Copy to clipboard
	vim.keymap.set("n", "<leader>y", '"+y')
	vim.keymap.set("v", "<leader>y", '"+y')
end

---@param config dh.keymap.config
function remap.setup(config)
	improved_insert_mode()
	delete_to_void()
	copy_to_clipboard()
end

return remap
