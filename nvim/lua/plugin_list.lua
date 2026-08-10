-- Full list of all plugins used, plugins are configured in /plugins
-- Any hooks required by the plugin is registered in the hooks.lua file

---@class dh.plugin_list
local plugins = {}

---@type dh.neoplug
local neoplug = require("neoplug")

--- Shorthand helper
---@param plugin string The name of the plugin path
local function github(plugin)
	return "https://github.com/" .. plugin
end

local function plug_typing()
	neoplug:add({
		github("saghen/blink.cmp"),
		dependencies = {
			github("saghen/blink.lib"),
			github("rafamadriz/friendly-snippets"),
			github("xzbdmw/colorful-menu.nvim"),
			github("folke/lazydev.nvim"),
		},
	})
	neoplug:add(github("windwp/nvim-autopairs"))
end

local function plug_navigation()
	neoplug:add({
		github("nvim-telescope/telescope.nvim"),
		dependencies = {
			github("nvim-tree/nvim-web-devicons"),
			github("nvim-lua/plenary.nvim"),
			github("nvim-telescope/telescope-fzf-native.nvim"),
		},
	})
	neoplug:add({
		github("stevearc/oil.nvim"),
		dependencies = {
			github("nvim-tree/nvim-web-devicons"),
		},
	})
end

local function plug_LSP()
	neoplug:add({
		github("neovim/nvim-lspconfig"),
		dependencies = {
			github("saghen/blink.cmp"),
		},
	})
	neoplug:add({
		github("WhoIsSethDaniel/mason-tool-installer.nvim"),
		dependencies = {
			github("mason-org/mason.nvim"),
			{ github("mason-org/mason-lspconfig.nvim"), dependencies = github("neovim/nvim-lspconfig") },
			github("jay-babu/mason-nvim-dap.nvim"),
		},
	})
	neoplug:add("https://git.sr.ht/~p00f/clangd_extensions.nvim")

	neoplug:add(github("stevearc/conform.nvim"))
	neoplug:add(github("mfussenegger/nvim-lint"))
end

local function plug_debug()
	neoplug:add({
		github("mfussenegger/nvim-dap"),
		dependencies = {
			github("jbyuki/one-small-step-for-vimkind"),
		},
	})
	neoplug:add({
		github("rcarriga/nvim-dap-ui"),
		dependencies = {
			github("mfussenegger/nvim-dap"),
			github("nvim-neotest/nvim-nio"),
			github("folke/lazydev.nvim"),
		},
	})
	neoplug:add({
		github("theHamsta/nvim-dap-virtual-text"),
		dependencies = {
			github("mfussenegger/nvim-dap"),
			{ github("nvim-treesitter/nvim-treesitter"), version = "main" },
		},
	})
end

local function plug_behaviour()
	neoplug:add({
		github("stevearc/resession.nvim"),
		dependencies = github("stevearc/overseer.nvim"),
	})
end

local function plug_ui()
	neoplug:add({
		github("nvim-lualine/lualine.nvim"),
		dependencies = {
			github("nvim-tree/nvim-web-devicons"),
			github("SmiteshP/nvim-navic"), -- Extended lsp path
			github("bwpge/lualine-pretty-path"), -- Pretty filepath
		},
	})
	neoplug:add({
		github("folke/noice.nvim"),
		dependencies = {
			github("nvim-treesitter/nvim-treesitter"),
			github("MunifTanjim/nui.nvim"),
			github("rcarriga/nvim-notify"),
		},
	})

	neoplug:add(github("catgoose/nvim-colorizer.lua"))
	neoplug:add(github("lukas-reineke/indent-blankline.nvim"))
	neoplug:add(github("nvim-treesitter/nvim-treesitter-context"))

	-- Themes
	neoplug:add(github("olivercederborg/poimandres.nvim"))
	neoplug:add(github("projekt0n/github-nvim-theme"))
end

local function plug_cpp()
	neoplug:add({
		github("Civitasv/cmake-tools.nvim"),
		dependencies = {
			{ github("akinsho/toggleterm.nvim"), version = "*" },
			{ github("stevearc/overseer.nvim"), dependencies = github("akinsho/toggleterm.nvim") },
		},
	})
end

function plugins.setup()
	plug_typing()
	plug_navigation()
	plug_LSP()
	plug_debug()
	plug_behaviour()
	plug_ui()
	plug_cpp()
	neoplug:submit()
end

return plugins
