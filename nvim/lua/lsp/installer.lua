---@class dh.lsp.installer
local installer = {}

---@param out_list table<string> Output list of all the valid entires
---@param options table<string, dh.lsp.config.mason.install_entry>
local function check_install(out_list, options)
    for _, info in pairs(options) do
        if info.install ~= nil then
            ---@class lsp_mason_install_entry
            local install_item = {
                info.install,
                version = info.version or nil,
                auto_update = info.auto_update or nil,
                condition = info.condition or nil,
            }
            table.insert(out_list, install_item)
        end
    end
end

---@param config dh.lsp.config
local function get_install_modules(config)
    local ensure_installed = {}
    check_install(ensure_installed, config.formatters)
    check_install(ensure_installed, config.dap)
    check_install(ensure_installed, config.lsps)
    return ensure_installed
end

---@param config dh.lsp.config
local function install_packages(config)
    require "mason".setup {
        firewall = {
            enabled = true,
        }
    }
    require "mason-lspconfig".setup {} --Requires mason
    require "mason-nvim-dap".setup {} --Requires mason

    -- The installer script
    require "mason-tool-installer".setup {
        ensure_installed = get_install_modules(config),
        run_on_start = true,
        start_delay = 1000, -- 1 second delay
        debounce_hours = 24,
    }

    -- Setup notifications
    vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        group = "lsp",
        callback = function()
            vim.schedule(function()
                vim.notify("mason-tool-installer starting")
            end)
        end
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        group = "lsp",
        callback = function(info)
            vim.schedule(function()
                vim.notify(tostring(#info.data) .. " programs installed")
                vim.notify(vim.inspect(info.data))
            end)
        end
    })
end


---@param config dh.lsp.config
local function install_treesitter(config)
    require "nvim-treesitter".install(config.treesitter.install)
end


---@param config dh.lsp.config
function installer.setup(config)
    -- Mason setup
    if config.mason_install then
        install_packages(config)
    end

    -- Treesitter setup
    if config.treesitter_install then
        install_treesitter(config)
    end
end

return installer
