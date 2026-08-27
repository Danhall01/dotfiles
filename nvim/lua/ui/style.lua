---@class dh.ui.style
local style = {}

---@param config dh.ui.config
local function indent_blankline(config)
	require("ibl").setup({
		indent = { char = { "┆", "▎" } },
		scope = { enabled = true },
	})
end

---@param config dh.ui.config
local function context_dropdown(config)
	require("treesitter-context").setup({
		max_lines = 6,
		multiline_threshold = 6,
	})
end

---@param config dh.ui.config
local function nvim_notify(config)
	require("notify").setup({
		merge_duplicates = true,
		background_color = "NotifyBackground",
		fps = 165,
		timeout = 1200,
		top_down = true,
		render = "compact", -- "default", "minimal", "simple", "compact", "wrapped-compact"
		stages = "slide",
	})
	vim.notify = require("notify")
end

---@param config dh.ui.config
local function noice(config)
	local opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = false, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		-- FOR NOW, THIS BREAKS THE CMDLINE SO THAT I CANNOT SEE ANYTHING: REMOVE WHEN FIXED
		cmdline = {
			enabled = true,
		},
		messages = {
			enabled = true,
		},
	}
	require("noice").setup(opts)
end

---@param config dh.ui.config
local function nvim_colorizer(config)
	require("colorizer").setup({})
end

---@param config dh.ui.config
function style.setup(config)
	indent_blankline(config)
	nvim_colorizer(config)
	context_dropdown(config)

	nvim_notify(config)
	noice(config)
end

return style
