---@class dh.ui.theme
local theme = {}

local function poimandres()
	require("poimandres").setup({
		disable_background = true, -- disable background
	})
end

local function github_dark()
	local opts = {
		transparent = true,
		styles = {
			comments = "italic",
			functions = "bold",
		},
	}
	-- "Mint skyline" - Nick // @Creator Daniel Häll
	local spec = {
		github_dark = {
			syntax = {
				--bracket = "#900000",
				--builtin0 = "#900000",
				--builtin1 = "#900000",
				--builtin2 = "#900000",
				comment = "#7390aa",
				conditional = "#135048",
				const = "#31EAEA",
				--dep = "#900000",
				--field = "#900000",
				func = "#399AA8",
				--ident = "#900000",
				keyword = "#9A67FF",
				number = "#31EAEA",
				--operator = "#900000",
				preproc = "#6C58A6",
				regex = "#e2bec6",
				--statement = "#900000",
				string = "#91b4d5",
				type = "#26867d",
				variable = "#A9CAE9",
			},
		},
	}
	require("github-theme").setup({
		options = opts,
		specs = spec,
	})

	-- Ensure colorscheme is updated properly
	vim.api.nvim_create_autocmd({ "ColorScheme" }, {
		desc = "Updates certain items for color schemes",
		pattern = { "github_dark" },
		callback = function()
			--vim.api.nvim_set_hl(0, "normal", {fg = "#2C8A86", bg="NONE"}); -- Default colors
			vim.api.nvim_set_hl(0, "@lsp.typemod.macro.globalscope.c", { fg = "#57F5EF", bg = "none" }) -- Macro
			vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = "#A9CAE9" })

			vim.api.nvim_set_hl(0, "cStorageClass", { fg = "#1D8A99" }) -- E.g static

			vim.api.nvim_set_hl(0, "@lsp.typemod.class.filescope.c", { fg = "#7153AC" }) -- struct / class
			vim.api.nvim_set_hl(0, "@lsp.typemod.property.classScope.c", { fg = "#86B3DF" }) -- class.property (Higher order in c/c++)
			vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = "#86B3DF" }) -- table.property

			vim.api.nvim_set_hl(0, "@lsp.typemod.function.definition.c", { fg = "#025A66" }) -- ... fname(...){}
			vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.functionScope.c", { fg = "#81B6EA" }) -- ...(type Param)

			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#232323" }) -- Hover window

			vim.api.nvim_set_hl(0, "CursorLine", {
				bg = "#232632",
			})
		end,
	})
end

---@param theme string
local function set_active_theme(theme)
	vim.cmd("colorscheme " .. theme)
end

local function setup_themes()
	poimandres()
	github_dark()
end

---@param config dh.ui.config
function theme.setup(config)
	setup_themes()
	set_active_theme(config.startup_theme)
end

return theme
