---@class dh.keymap.navigation
local navigation = {}

---@param config dh.keymap.config.navigation
local function file_explorer(config)
	-- Shortcut for default ex navigation
	if not config.file_explorer.disabled then
		vim.keymap.set("n", config.file_explorer.keybind, vim.cmd.Ex)
	end
end

---@param config dh.keymap.config.navigation.window
local function window(config)
	if not config.up.disabled then
		vim.keymap.set("n", config.up.keybind, "<C-W>k", { desc = "Move to to the window above" })
	end
	if not config.down.disabled then
		vim.keymap.set("n", config.down.keybind, "<C-W>j", { desc = "Move to the window below" })
	end
	if not config.left.disabled then
		vim.keymap.set("n", config.left.keybind, "<C-W>h", { desc = "Move to the window to the left" })
	end
	if not config.right.disabled then
		vim.keymap.set("n", config.right.keybind, "<C-W>l", { desc = "Move to the window to the right" })
	end

	-- <leader>N #Go to buffer index N
	if not (type(config.number_prefix) == "boolean" and not config.number_prefix) then
		local prefix = "<leader>"
		if type(config.number_prefix) == "string" then
			prefix = config.number_prefix
		end
		for i = 1, 9 do -- Only keymap 1-9
			local lhs = prefix .. tostring(i)
			local rhs = tostring(i) .. "<C-W>w"
			vim.keymap.set("n", lhs, rhs, { desc = "Move to window " .. tostring(i) })
		end
	end
end

---@param config dh.keymap.config.navigation.telescope
local function telescope(config)
	if not config.find_files.disabled then
		vim.keymap.set("n", config.find_files.keybind, function()
			require("telescope.builtin").find_files()
		end, { desc = "Navigate files with telescope" })
	end

	if not config.grep_live.disabled then
		vim.keymap.set("n", config.grep_live.keybind, function()
			require("telescope.builtin").live_grep()
		end, { desc = "Search cwd with live grep" })
	end

	if not config.grep_selected.disabled then
		vim.keymap.set("n", config.grep_selected.keybind, function()
			require("telescope.builtin").grep_string()
		end, { desc = "Grabs the currently selected area into the search" })
	end

	if not config.get_keymaps then
		vim.keymap.set("n", config.get_keymaps.keybind, function()
			require("telescope.builtin").keymaps()
		end, { desc = "Get current keymaps (Help)" })
	end

	if not config.find_references.disabled then
		vim.keymap.set("n", config.find_references.keybind, function()
			require("telescope.builtin").lsp_references()
		end, { desc = "Get all references through telescope" })
	end

	if not config.find_definitions.disabled then
		vim.keymap.set("n", config.find_definitions.keybind, function()
			require("telescope.builtin").lsp_definitions()
		end, { desc = "Find definition, open telescope if there are multiple" })
	end

	if not config.find_type_definitions.disabled then
		vim.keymap.set("n", config.find_type_definitions.keybind, function()
			require("telescope.builtin").lsp_type_definitions()
		end, { desc = "Find type definitions, open telescope if multiple" })
	end

	if not config.git_branches.disabled then
		vim.keymap.set("n", config.git_branches.keybind, function()
			require("telescope.builtin").git_branches()
		end, { desc = "List all branches with telescope" })
	end

	if not config.list_functions.disabled then
		vim.keymap.set("n", config.list_functions.keybind, function()
			require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
		end, { desc = "Lists functions from treesitter" })
	end

	if not config.list_symbols.disabled then
		vim.keymap.set("n", config.list_symbols.keybind, function()
			require("telescope.builtin").lsp_document_symbols({})
		end, { desc = "Lists all lsp symbols from treesitter" })
	end
end

---@param config dh.keymap.config
function navigation.setup(config)
	file_explorer(config.navigation)
	window(config.navigation.window)
	telescope(config.navigation.telescope)
end

return navigation
