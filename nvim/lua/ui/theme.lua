---@class dh.ui.theme
local theme = {}

local function setup_themes()
	require("github-theme").setup({
		options = {
			transparent = true,
			styles = {
				comments = "italic",
				functions = "bold",
			},
		},
	})
	require("poimandres").setup({
		disable_background = true, -- disable background
	})
	require("tokyonight").setup({
		transparent = true,
		styles = {
			functions = { bold = true },
			comments = { italic = true },
		},
	})
end

---@param startup_theme string
local function set_active_theme(startup_theme)
	vim.cmd("colorscheme " .. startup_theme)
end

---@param config dh.ui.config
function theme.setup(config)
	setup_themes()
	set_active_theme(config.startup_theme)
end

return theme
