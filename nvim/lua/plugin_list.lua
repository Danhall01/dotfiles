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
	neoplug:add({
		github("Badhi/nvim-treesitter-cpp-tools"),
		dependencies = {
			github("nvim-treesitter/nvim-treesitter"),
		},
	})

	neoplug:add(github("stevearc/conform.nvim"))
	neoplug:add(github("mfussenegger/nvim-lint"))

	-- Debug
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

local function plug_features()
	-- Typing
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

	-- Session
	neoplug:add({
		github("stevearc/resession.nvim"),
		dependencies = github("stevearc/overseer.nvim"),
	})

	-- Tasks
	neoplug:add({
		github("stevearc/overseer.nvim"),
		dependencies = {
			{ github("akinsho/toggleterm.nvim"), version = "*" },
		},
	})
	neoplug:add({
		github("Civitasv/cmake-tools.nvim"),
		dependencies = {
			github("stevearc/overseer.nvim"),
			github("akinsho/toggleterm.nvim"),
		},
	})
end

local function plug_tools()
	-- Git
	neoplug:add({
		github("NeogitOrg/neogit"),
		dependencies = {
			{ github("sindrets/diffview.nvim"), dependencies = github("nvim-tree/nvim-web-devicons") },
			github("m00qek/baleia.nvim"),
			github("nvim-telescope/telescope.nvim"),
		},
	})
	neoplug:add({
		github("olacin/telescope-cc.nvim"),
		dependencies = {
			github("nvim-telescope/telescope.nvim"),
		},
	})

	-- C/C++
	neoplug:add(github("J-Cowsert/classlayout.nvim"))
	neoplug:add({
		github("madskjeldgaard/cppman.nvim"),
		dependencies = { github("MunifTanjim/nui.nvim") },
	})

	-- Code analysis
	neoplug:add(github("dlyongemallo/sanity.nvim"))
	neoplug:add(github("t-troebst/perfanno.nvim"))

	-- Tests
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
	neoplug:add(github("folke/tokyonight.nvim"))
end

function plugins.setup()
	plug_LSP()
	plug_navigation()
	plug_features()
	plug_tools()
	plug_ui()

	neoplug:submit({ verbal = true })
end

return plugins
