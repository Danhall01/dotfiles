---@class dh.plugins.workflow_c_cpp
local workflow_c_cpp = {}

---@param config dh.plugins.config
local function cmake_tools(config)
    require("cmake-tools").setup {
        cmake_generate_options = {
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
            "-DCMAKE_C_COMPILER=clang",
        },

        cmake_build_directory = function()
            local osys = require("cmake-tools.osys");
            if osys.iswin32 then
                return "build\\${variant:buildType}"
            end
            return "build/${variant:buildType}"
        end,

        cmake_dap_configuration = { -- debug settings for cmake
            name = "c/c++ debug",
            type = "gdb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal",
        },

        cmake_executor = {
            name = "overseer",
            default_opts = {
                overseer = {
                    new_task_opts = {
                        strategy = {
                            "toggleterm",
                            direction = "horizontal",
                            auto_scroll = true,
                            quit_on_exit = "success"
                        }
                    }, -- options to pass into the `overseer.new_task` command
                    on_new_task = function(task)
                        require("overseer").open(
                            { enter = false, direction = "right" }
                        )
                    end, -- a function that gets overseer.Task when it is created, before calling `task:start`
                },
                toggleterm = {
                    direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
                    close_on_exit = false, -- whether close the terminal when exit
                    auto_scroll = true,    -- whether auto scroll to the bottom
                    singleton = true,      -- single instance, autocloses the opened one, if present
                },
            },
        },

        cmake_runner = {
            name = "overseer",
            default_opts = {
                overseer = {
                    new_task_opts = {
                        strategy = {
                            "toggleterm",
                            direction = "horizontal",
                            auto_scroll = true,
                            quit_on_exit = "success"
                        }
                    }, -- options to pass into the `overseer.new_task` command
                    on_new_task = function(task)
                    end
                },
                toggleterm = {
                    direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
                    close_on_exit = true,     -- whether close the terminal when exit
                    auto_scroll = true,       -- whether auto scroll to the bottom
                    singleton = true,         -- single instance, autocloses the opened one, if present
                },
            },
        },

        cmake_notifications = {
            runner = { enabled = false },
            executor = { enabled = false },
            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
            refresh_rate_ms = 100, -- how often to iterate icons
        },
    }
end

---@param config dh.plugins.config
local function overseer(config)
    require("overseer").setup {
        strategy = "toggleterm",
        task_list = {
            bindings = {
                ["<CR>"] = "OpenFloat",
            },
        },
    }
end

---@param config dh.plugins.config
local function toggleterm(config)
    require("toggleterm").setup {}
end

---@param config dh.plugins.config
function workflow_c_cpp.setup(config)
    toggleterm(config)
    overseer(config)
    cmake_tools(config)
end

return workflow_c_cpp
