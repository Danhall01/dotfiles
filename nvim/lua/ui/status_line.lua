---@class dh.ui.status_line
local status_line = {}

---@param config dh.ui.config
local function navic(config)
    require "nvim-navic".setup {
        lsp = {
            auto_attach = true,
        },
        separator = "  ",
    }
end

---@param config dh.ui.config
local function lualine(config)
    require "lualine".setup {
        options = {
            icons_enabled = true,
            --theme = "horizon",
            theme = "poimandres",
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            }
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "overseer", label = "overseer: " } },
            lualine_x = { "encoding", "filetype" },
            lualine_y = { "lsp_status", "progress" },
            lualine_z = { "location", "fileformat" }
        },
        inactive_sections = {
            lualine_a = { function()
                return "wnd:" .. tostring(vim.api.nvim_win_get_number(0))
            end },
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {
            lualine_a = { "filename" },
            lualine_b = { function()
                local nav = require "nvim-navic"
                if nav.is_available() then
                    local path = nav.get_location()
                    if path ~= "" then
                        return path
                    end
                end
                return "󰌗 global"
            end },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

---@param config dh.ui.config
function status_line.setup(config)
    navic(config)
    lualine(config)
end

return status_line
