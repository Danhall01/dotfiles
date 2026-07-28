---@class dh.plugins.c_cpp.cmake_tools
local cmake_oversser = {}

---@param config dh.plugins.config
local function cmake_tools(config)
    local osys = require("cmake-tools.osys")
    require("cmake-tools").setup {
        cmake_regenerate_on_save = false,
        cmake_generate_options = {
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
            "-DCMAKE_C_COMPILER=clang",
        },
        cmake_command = "cmake",
        ctest_command = "ctest",

        cmake_build_directory = function()
            if osys.iswin32 then
                return "build\\${variant:buildType}"
            end
            return "build/${variant:buildType}"
        end,

        cmake_dap_configuration = {
            name = "dap debug c/cpp",
            type = "gdb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
        },

        cmake_executor = {
            name = "overseer",
            opts = {
                on_new_task = function(task)
                    require("overseer").open({
                        enter = false,
                    })
                end,
            },
        },
        cmake_runner = {
            name = "overseer",
            opts = {
                on_new_task = function(task)
                    require("overseer").open({
                        enter = false,
                    })
                end,

            },
        },
        cmake_notifications = {
            runner = { enabled = false },
            executor = { enabled = false },
            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            refresh_rate = 60,
        },
        cmake_virtual_text_support = true,
        cmake_use_scratch_buffer = true,
    }
end

---@param file string
---@param session_index number
local function overseer_review_debug_log(file, session_index)
    local overseer = require "overseer"
    local task = overseer.new_task {
        name = "GDB Debug Log#" .. tostring(session_index),
        cmd = "cat \"" .. file .. "\"",
        cwd = vim.fn.getcwd()
    }
    task:start()
end

local log_index = 1
---@param config dh.plugins.config.overseer
local function find_next_log_index(config)
    local cwd = vim.fn.getcwd()
    local content = vim.split(vim.fn.glob(cwd .. "/" .. config.path .. "*"), '\n', { trimempty = true })
    table.sort(content)

    for _, file in pairs(content) do
        overseer_review_debug_log(file, log_index)
        log_index = log_index + 1
    end
end

local dap_logfile = nil
---@param config dh.plugins.config.overseer
local function attach_log_task(config)
    local function dump_buffer()
        if not dap_logfile then return end
        dap_logfile.file:flush()
        dap_logfile.file:close()

        -- Dispatch task
        overseer_review_debug_log(dap_logfile.name, log_index)
        log_index = log_index + 1

        dap_logfile = nil
    end

    -- Attach DAP to overseer tasks
    local dap = require "dap"
    local cwd = vim.fn.getcwd()
    dap.listeners.after.event_initialized["overseer-debug-output"] = function()
        vim.fn.mkdir(cwd .. "/" .. config.path, "p") -- Ensure log path exists
        dap_logfile = {
            name = cwd .. "/" .. config.path .. config.log_name .. string.format("_%03d", log_index) .. ".log"
        }
        dap_logfile.file = io.open(dap_logfile.name, "w")
        if not dap_logfile.file then
            vim.notify("Could not create logfile for DAP session: " .. dap_logfile.name, vim.diagnostic.severity.ERROR)
            return
        end
        vim.notify("Created logfile: " .. dap_logfile.name, vim.diagnostic.severity.INFO)
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

---@param config dh.plugins.config.overseer
local function register_user_commands(config)
    local cwd = vim.fn.getcwd()
    local name = cwd .. "/" .. config.path .. config.log_name .. string.format("_%03d", log_index) .. ".log"
end

---@param config dh.plugins.config.overseer
local function overseer_dap(config)
    find_next_log_index(config)
    attach_log_task(config)
    register_user_commands(config)
end

---@param config dh.plugins.config.overseer
local function overseer(config)
    require("overseer").setup {
        dap = true,
        output = {
            use_terminal = true,
            preserve_output = true,
        },

        component_aliases = {
            default = {
                "on_exit_set_status",
                --"on_complete_notify",
                --{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
            },
        },

        -- Configure task list
        task_list = {
            direction = "bottom",
            max_height = 0.3,
            min_height = 0.1,
            keymaps = {
                [config.keybinds.actions.keybind] = "keymap.run_action",
                [config.keybinds.open_float.keybind] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
            },
        },

        -- Configure task floating output window
        task_win = {
            padding = 3,
        },
    }
end

---@param config dh.plugins.config
local function toggleterm(config)
    require("toggleterm").setup {
        size = 20,
    }
end

---@param config dh.plugins.config
function cmake_oversser.setup(config)
    toggleterm(config)
    overseer(config.overseer)
    overseer_dap(config.overseer)
    cmake_tools(config)
end

return cmake_oversser
