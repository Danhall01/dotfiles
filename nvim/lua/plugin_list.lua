-- Full list of all plugins used, plugins are configured in /plugins
-- Any hooks required by the plugin is registered in the hooks.lua file

---@class dh.plugin_list
local plugins = {}

-- Shorthand helpers
local function github(plugin)
    return "https://github.com/" .. plugin
end

function plugins.setup()
    vim.pack.add {
        -- Dependencies
        { src = github("nvim-tree/nvim-web-devicons") },                                --Required by telescope && lualine && theme(s)
        { src = github("nvim-lua/plenary.nvim") },                                      --Required by telescope
        { src = github("nvim-treesitter/nvim-treesitter"),          version = "main" }, --Required by nvim-dap-virtual-text && indent-blankline && noice
        { src = github("MunifTanjim/nui.nvim") },                                       --Required by noice

        -- Typing
        { src = github("folke/lazydev.nvim") },           --Required by blink.cmp && nvim-dap-ui
        { src = github("xzbdmw/colorful-menu.nvim") },    --Required by blink.cmp
        { src = github("rafamadriz/friendly-snippets") }, --Required by blink.cmp
        { src = github("saghen/blink.lib") },             --Required by blink.cmp
        { src = github("saghen/blink.cmp") },             --Required by nvim-lspconfig (Core Module)
        { src = github("windwp/nvim-autopairs") },        -- MAYBE_UNUSED

        -- LSP
        { src = github("neovim/nvim-lspconfig") },          --Required by mason-lspconfig (Core Module)
        { src = github("mason-org/mason.nvim") },           --Required by mason-tool-installer
        { src = github("mason-org/mason-lspconfig.nvim") }, --Required by mason-tool-installer
        { src = github("jay-babu/mason-nvim-dap.nvim") },   --Required by mason-tool-installer
        { src = github("WhoIsSethDaniel/mason-tool-installer.nvim") },

        -- LSP-Debug
        { src = github("jbyuki/one-small-step-for-vimkind") }, --Required by nvim-dap (LUA adapter)
        { src = github("mfussenegger/nvim-dap") },             --Required by nvim-dap-ui && nvim-dap-virtual-text (Core Module)
        { src = github("nvim-neotest/nvim-nio") },             --Required by nvim-dap-ui
        { src = github("rcarriga/nvim-dap-ui") },
        { src = github("theHamsta/nvim-dap-virtual-text") },

        -- LSP-Build
        { src = github("akinsho/toggleterm.nvim"),                  version = "*" }, --Required by cmake-tools && overseer
        { src = github("stevearc/overseer.nvim") },                                  --Required by cmake-tools
        { src = github("Civitasv/cmake-tools.nvim") },

        --Navigation
        { src = github("nvim-telescope/telescope-fzf-native.nvim") }, --Required by telescope
        { src = github("nvim-telescope/telescope.nvim") },

        -- UI / Style
        { src = github("SmiteshP/nvim-navic") },  --Required by lualine
        { src = github("nvim-lualine/lualine.nvim") },
        { src = github("rcarriga/nvim-notify") }, --Required by noice
        { src = github("folke/noice.nvim") },
        { src = github("catgoose/nvim-colorizer.lua") },
        { src = github("lukas-reineke/indent-blankline.nvim") },
        { src = github("nvim-treesitter/nvim-treesitter-context") },

        -- Themes
        { src = github("olivercederborg/poimandres.nvim") },
        { src = github("projekt0n/github-nvim-theme") },
    }
end

return plugins
