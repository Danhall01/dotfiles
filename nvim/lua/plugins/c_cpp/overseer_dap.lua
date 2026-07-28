---@class dh.plugins.c_cpp.overseer_dap
local overseer_dap = {}
local dap_logfile = nil
local log_index = 1

---@return string date
local function get_current_date()
    return tostring(os.date("_%y-%m-%d"))
end

---@param file string
---@param session_index number
local function overseer_review_debug_log(file, session_index)
    local overseer = require "overseer"
    return overseer.new_task {
        name = "GDB Debug Log#" .. tostring(session_index),
        cmd = "cat \"" .. file .. "\"",
        cwd = vim.fn.getcwd()
    }
end

---@param config dh.plugins.config.overseer.debug_log
local function log_all(config)
    local overseer = require "overseer"
    local cwd = vim.fn.getcwd()
    local content = vim.fn.glob(cwd .. "/" .. config.path .. "*", false, true)
    if vim.tbl_isempty(content) then return end

    log_index = #content + 1
    table.sort(content, function(s1, s2) return s1:match("_(%d+)%.log") > s2:match("_(%d+)%.log") end)

    local task_list = {}
    local i = log_index - 1
    for _, file in pairs(content) do
        local index = i
        local ordering_index = log_index - i - 1
        table.insert(task_list, {
            name = ordering_index .. ":GDB Debug Log#" .. tostring(index),
            cmd = "cat \"" .. file .. "\"",
            cwd = vim.fn.getcwd()
        })
        i = i - 1
    end

    local task = overseer.new_task {
        name = "Display old debugg records",
        cmd = "",
        strategy = {
            "orchestrator",
            tasks = task_list,
        },
    }
    vim.schedule(function() task:start() end)
end

---@param config dh.plugins.config.overseer.debug_log
local function attach_log_task(config)
    local function dump_buffer()
        if not dap_logfile then return end
        dap_logfile.file:flush()
        dap_logfile.file:close()

        -- Dispatch task
        overseer_review_debug_log(dap_logfile.name, log_index):start()
        log_index = log_index + 1
        dap_logfile = nil
    end

    -- Attach DAP to overseer tasks
    local dap = require "dap"
    local cwd = vim.fn.getcwd()
    dap.listeners.after.event_initialized["overseer-debug-output"] = function()
        vim.fn.mkdir(cwd .. "/" .. config.path, "p") -- Ensure log path exists
        dap_logfile = {
            name = cwd ..
                "/" ..
                config.path ..
                config.log_name .. get_current_date() .. string.format("_%03d", log_index) .. ".log"
        }
        dap_logfile.file = io.open(dap_logfile.name, "w")
        if not dap_logfile.file then
            vim.notify("Could not create logfile for DAP session: " .. dap_logfile.name, vim.diagnostic.severity.ERROR)
            return
        end
        vim.notify("Created logfile: " .. dap_logfile.name)
    end
    dap.listeners.after.event_output["overseer-debug-output"] = function(_, body)
        if not dap_logfile then return end
        if body.output then
            local write_block = string.gsub(body.output, "\\033", '\27')
            dap_logfile.file:write(write_block)
            dap_logfile.file:flush()
        end
    end
    dap.listeners.after.event_terminated["overseer-debug-output"] = dump_buffer
    dap.listeners.after.event_exited["overseer-debug-output"] = dump_buffer
end

---@param config dh.plugins.config.overseer.debug_log
local function register_user_commands(config)
    local cwd = vim.fn.getcwd()
    vim.api.nvim_create_user_command("OverseerCreateLogTask", function(argv)
        local index = tonumber(argv.args)
        if not index or index % 1 ~= 0 then return end
        local fname = cwd ..
            "/" ..
            config.path ..
            config.log_name .. get_current_date() .. string.format("_%03d", log_index) .. ".log"
        overseer_review_debug_log(fname, index):start()
    end, {
        desc = "(ext) Runs a task to open the log file of given index in overseer",
        nargs = 1,
    })
end

---@param config dh.plugins.config
function overseer_dap.setup(config)
    if config.overseer.debug_log.enabled then
        log_all(config.overseer.debug_log)
        attach_log_task(config.overseer.debug_log)
        register_user_commands(config.overseer.debug_log)
    end
end

return overseer_dap
