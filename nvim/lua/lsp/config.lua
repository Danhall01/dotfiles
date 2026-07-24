---@type dh.lsp.config
local lsp_config = {
    mason_install = false,
    treesitter_install = true,

    lsps = {
        clangd = {
            install = "clangd",
            config = require "lsp.servers.clangd",
        },
        cmake = {
            install = "cmake",
            config = require "lsp.servers.cmake",
        },
        slangd = {
            install = "slangd",
            config = require "lsp.servers.slangd",
        },
        bashls = {
            install = "bash-language-server",
            config = require "lsp.servers.bashls",
        },
        lua_ls = {
            install = "lua-language-server",
            config = require "lsp.servers.lua_ls",
        },
    },

    formatters = {
        stylua = {
            install = "stylua",
            filetypes = { "lua" },
        },
    },

    dap = {},

    treesitter = {
        install = { "c", "cpp", "make", "cmake", "bash", "lua", "slang", "markdown", "vim", "regex", "markdown_inline" }
    },

    diagnostic = {
        min = vim.diagnostic.severity.ERROR,
        max = vim.diagnostic.severity.WARN,

        icons = {
            [vim.diagnostic.severity.HINT] = "󰰂 ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.ERROR] = "E",
        },
        text = {
            [vim.diagnostic.severity.HINT] = "Hint",
            [vim.diagnostic.severity.INFO] = "Info",
            [vim.diagnostic.severity.WARN] = "Warn",
            [vim.diagnostic.severity.ERROR] = "Error",
        },
    },
}
return lsp_config
