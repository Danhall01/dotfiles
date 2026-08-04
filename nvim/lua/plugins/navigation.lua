---@class dh.plugins.navigation
local navigation = {}

---@param config dh.plugins.config
local function telescope(config)
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})
end

---@param config dh.plugins.config
local function telescope_fzf(config)
	require("telescope").load_extension("fzf")
end

---@param config dh.plugins.config.oil
local function oil_setup(config)
	local oil = require("oil")
	oil.setup({
		watch_for_changes = true,
		view_options = {
			show_hidden = true,
		},
		lsp_file_methods = {
			enabled = true,
		},
		keymaps = {
			[config.keybinds.help.keybind] = { "actions.show_help", mode = "n" },
			[config.keybinds.action.keybind] = "actions.select",
			[config.keybinds.action_split_vert.keybind] = {
				"actions.select",
				opts = { vertical = true, split = "belowright" },
			},
			[config.keybinds.action_split_hor.keybind] = { "actions.select", opts = { horizontal = true } },
			[config.keybinds.toggle_preview.keybind] = { "actions.preview", opts = { split = "belowright" } },
			[config.keybinds.close.keybind] = { "actions.close", mode = "n" },
			[config.keybinds.refresh.keybind] = "actions.refresh",
			[config.keybinds.dir_up.keybind] = { "actions.parent", mode = "n" },
			[config.keybinds.dir_cwd.keybind] = { "actions.open_cwd", mode = "n" },
			[config.keybinds.open_external.keybind] = "actions.open_external",
			[config.keybinds.toggle_hidden.keybind] = { "actions.toggle_hidden", mode = "n" },
			[config.keybinds.toggle_trash.keybind] = { "actions.toggle_trash", mode = "n" },
		},
		use_default_keymaps = false,

		git = {
			add = function(path)
				if not config.auto_git.add then
					return false
				end
				return true
			end,
			mv = function(src_path, dest_path)
				if not config.auto_git.mv then
					return false
				end
				return true
			end,
			rm = function(path)
				if not config.auto_git.rm then
					return false
				end
				return true
			end,
		},
	})
	-- Auto toggle preview
	vim.api.nvim_create_autocmd("User", {
		pattern = "OilEnter",
		callback = vim.schedule_wrap(function(args)
			if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
				oil.open_preview({ split = "belowright" })
			end
		end),
	})
end

---@param config dh.plugins.config
function navigation.setup(config)
	telescope(config)
	telescope_fzf(config)

	oil_setup(config.oil)
end

return navigation
