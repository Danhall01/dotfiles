---@class dh.plugins.c_cpp.overseer_autocmd
local overseer_autocmd = {}
local overseer = require "overseer"
local dap = require "dap"

---@param config dh.plugins.config.overseer
local function open_on_enter(config)
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
        group = "dh.overseer",
        callback = function()
            if not config.open_on_enter then return end
            if dap.status() ~= "" then return end
            overseer.open({ enter = false })
        end
    })
end

---@param config dh.plugins.config.overseer
local function close_on_leave(config)
    vim.api.nvim_create_autocmd("BufLeave", {
        pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
        group = "dh.overseer",
        callback = function()
            if not config.close_on_leave then return end
            if dap.status() ~= "" then return end
            overseer.close()
        end
    })
end

---@param config dh.plugins.config.overseer
local function open_on_debug_exit(config)
    dap.listeners.before.event_terminated.overseer_config = function()
        if not config.open_on_debug_exit then return end
        overseer.open({ enter = false })
    end
    dap.listeners.before.event_exited.overseer_config = function()
        if not config.open_on_debug_exit then return end
        overseer.open({ enter = false })
    end
end

---@param config dh.plugins.config.overseer
local function close_on_debug_enter(config)
    dap.listeners.before.attach.overseer_config = function()
        if not config.close_on_debug_enter then return end
        overseer.close()
    end
    dap.listeners.before.launch.overseer_config = function()
        if not config.close_on_debug_enter then return end
        overseer.close()
    end
end

---@param config dh.plugins.config
function overseer_autocmd.setup(config)
    vim.api.nvim_create_augroup("dh.overseer", { clear = false })
    open_on_enter(config.overseer)
    close_on_leave(config.overseer)
    open_on_debug_exit(config.overseer)
    close_on_debug_enter(config.overseer)
end

return overseer_autocmd
