---@class dh.plugins.typing
local typing = {}

---@param config dh.plugins.config.blink_cmp
local function blink_cmp(config)
	local cmp = require("blink.cmp")
	cmp.build():pwait()

	---@module "blink.cmp"
	---@type blink.cmp.Config
	cmp.setup({
		keymap = {
			preset = "default",
			[config.keybinds.forward.keybind] = { "snippet_forward", "fallback" },
			[config.keybinds.backward.keybind] = { "snippet_backward", "fallback" },
			[config.keybinds.accept.keybind] = { "accept", "fallback" },
			[config.keybinds.show.keybind] = { "show", "show_documentation", "hide_documentation" },
			[config.keybinds.close.keybind] = { "hide", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "normal",

			kind_icons = {
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},

		-- Custom
		completion = {
			list = {
				selection = {
					preselect = function()
						return vim.fn.mode() == "i"
					end,
					auto_insert = false,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				treesitter_highlighting = true,
				window = {
					border = "double",
					winblend = 0,
					scrollbar = false,
				},
			},
			ghost_text = { enabled = true, show_with_selection = true, show_without_selection = false },
			menu = {
				enabled = true,
				border = "rounded",
				winblend = 0,
				scrollbar = false,
				auto_show = true,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				draw = {
					treesitter = { "lsp" },
					padding = 2,
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							width = { fill = true, max = 60 },
							text = function(ctx)
								local highlights_info = require("colorful-menu").blink_highlights(ctx)
								if highlights_info ~= nil then
									-- Or you want to add more item to label
									return highlights_info.label
								else
									return ctx.label
								end
							end,
							highlight = function(ctx)
								local highlights = {}
								local highlights_info = require("colorful-menu").blink_highlights(ctx)
								if highlights_info ~= nil then
									highlights = highlights_info.highlights
								end
								for _, idx in ipairs(ctx.label_matched_indices) do
									table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
								end
								-- Do something else
								return highlights
							end,
						},
					},
				},
			},
		},
	})
end

---@param config dh.plugins.config.blink_cmp
local function blink_extended_colours(config)
	require("colorful-menu").setup({
		ls = {
			lua_ls = {
				extra_info_hl = "@comment",
				align_type_to_right = true,
				-- Maybe you want to dim arguments a bit.
				arguments_hl = "@comment",
			},
			clangd = {
				-- Such as "From <stdio.h>".
				extra_info_hl = "@comment",
				-- Similar to the same setting of gopls.
				align_type_to_right = true,
				-- the hl group of leading dot of "•std::filesystem::permissions(..)"
				import_dot_hl = "@comment",
			},
			fallback = true,
		},
		fallback_highlight = "@variable",
		max_width = 60,
	})
end

local function lazy_dev()
	local ldev = require("lazydev")
	ldev.setup({
		library = {
			"nvim-dap-ui",
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end

local function auto_pairs()
	require("nvim-autopairs").setup({})
end

---@param config dh.plugins.config
function typing.setup(config)
	lazy_dev()

	blink_cmp(config.blink_cmp)
	blink_extended_colours(config.blink_cmp)

	auto_pairs()
end

return typing
