---@class dh.autocmd.behaviour
local behaviour = {}

local function buffer_update()
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
        desc = "Reloads buffer on update",
        pattern = { '*' },
        group = "autocmd_behaviour",
        command = "if mode() != 'c' | checktime | endif",
    })
end

---@param config dh.autocmd.config.colorcolumn
local function auto_color_column(config)
    vim.api.nvim_create_autocmd('InsertEnter', {
        desc = "Enabled colorcolumn when using insert mode.",
        group = "autocmd_behaviour",
        pattern = config.pattern,
        callback = function()
            vim.opt.colorcolumn = config.col
        end,
    })
    vim.api.nvim_create_autocmd('InsertLeave', {
        desc = "Removes the colorcolumn when leaving insert mode.",
        group = "autocmd_behaviour",
        pattern = config.pattern,
        callback = function()
            vim.opt.colorcolumn = ""
        end,
    })
end


---@param config dh.autocmd.config
function behaviour.setup(config)
    vim.api.nvim_create_augroup("autocmd_behaviour", { clear = true })
    buffer_update()
    auto_color_column(config.colorcolumn)
end

return behaviour
