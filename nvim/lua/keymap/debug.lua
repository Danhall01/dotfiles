---@class dh.keymap.debug
local debug = {}

---@param config dh.keymap.config.debug
local function runner(config)
    local debug_commands = {
        c = function() vim.cmd("CMakeDebug") end,
        cpp = function() vim.cmd("CMakeDebug") end,
        lua = nil,
    }
    if not config.run.disabled then
        vim.keymap.set('n', config.run.keybind, function()
            local cmd = debug_commands[vim.bo.filetype]
            if cmd then
                vim.notify("Debug session started for filetype: " .. tostring(vim.bo.filetype), vim.log.levels.INFO)
                cmd()
            else
                vim.notify("No debug runner configured for filetype: " .. tostring(vim.bo.filetype), vim.log.levels
                    .ERROR)
            end
        end, { desc = "Start debugger from selected file" })
    end
end

---@param config dh.keymap.config.debug
local function runner_current(config)
    local debug_commands = {
        c = function() vim.cmd("CMakeDebugCurrentFile") end,
        cpp = function() vim.cmd("CMakeDebugCurrentFile") end,
        lua = nil,
    }
    if not config.run_current.disabled then
        vim.keymap.set('n', config.run_current.keybind, function()
            local cmd = debug_commands[vim.bo.filetype]
            if cmd then
                vim.notify("Debug session started for filetype: " .. tostring(vim.bo.filetype), vim.log.levels.INFO)
                cmd()
            else
                vim.notify("No debug runner configured for filetype: " .. tostring(vim.bo.filetype), vim.log.levels
                    .ERROR)
            end
        end, { desc = "Start debugger from current file" })
    end
end

---@param config dh.keymap.config.debug
local function debug_adapter_protocol(config)
    if not config.toggle_breakpoint.disabled then
        vim.keymap.set('n', config.toggle_breakpoint.keybind, function() require("dap").toggle_breakpoint() end,
            { desc = "dap: Set breakpoint" })
    end

    if not config.toggle_breakpoint_cond.disabled then
        vim.keymap.set('n', config.toggle_breakpoint_cond.keybind, function() require("dap").toggle_breakpoint() end,
            { desc = "dap: Set conditional breakpoint" })
    end

    if not config.continue.disabled then
        vim.keymap.set('n', config.continue.keybind, function() require("dap").continue() end,
            { desc = "dap: Continue execution" })
    end

    if not config.restart.disabled then
        vim.keymap.set('n', config.restart.keybind, function() require("dap").restart() end,
            { desc = "dap: Restart execution" })
    end

    if not config.step_over.disabled then
        vim.keymap.set('n', config.step_over.keybind, function() require("dap").step_over() end,
            { desc = "dap: Step over" })
    end

    if not config.step_into.disabled then
        vim.keymap.set('n', config.step_into.keybind, function() require("dap").step_into() end,
            { desc = "dap: Step into" })
    end

    if not config.step_out.disabled then
        vim.keymap.set('n', config.step_out.keybind, function() require("dap").step_out() end,
            { desc = "dap: Step out" })
    end

    if not config.inspect.disabled then
        vim.keymap.set('n', config.inspect.keybind, function() require("dap.ui.widgets").hover() end,
            { desc = "dap: Inspect" })
    end
end

---@param config dh.keymap.config
function debug.setup(config)
    runner(config.debug)
    runner_current(config.debug)
    debug_adapter_protocol(config.debug)
end

return debug
