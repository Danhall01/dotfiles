---@class dh.lsp.debug
local debug = {}

local function setup_adapters()
    local dap = require "dap"

    -- See: https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb
    -- C / C++
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    -- Rust
    dap.adapters["rust-gdb"] = {
        type = "executable",
        command = "rust-gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    -- Lua
    dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
end

local function setup_config()
    local dap = require "dap"

    -- C / C++
    dap.configurations.c = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            args = {}, -- provide arguments if needed
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
        {
            name = "Select and attach to process",
            type = "gdb",
            request = "attach",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
            end,
            cwd = '${workspaceFolder}'
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}'
        }
    }
    dap.configurations.cpp = dap.configurations.c;

    -- Lua
    dap.configurations.lua = {
        {
            type = 'nlua',
            request = 'attach',
            name = "Attach to running Neovim instance",
        }
    }

    -- Rust
    dap.configurations.rust = {
        {
            name = "Launch",
            type = "rust-gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            args = {}, -- provide arguments if needed
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
        {
            name = "Select and attach to process",
            type = "rust-gdb",
            request = "attach",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
            end,
            cwd = "${workspaceFolder}"
        },
        {
            name = "Attach to gdbserver :1234",
            type = "rust-gdb",
            request = "attach",
            target = "localhost:1234",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}'
        }
    }
end

local function debug_virtual_text()
    require "nvim-dap-virtual-text".setup {
        only_first_definition = false,
        all_references = true,

        comment = true,
        highlight_changed_variables = true,

        virt_text_win_col = 75,
        virt_text_pos = "eol",
    }
end

local function debug_gui()
    local dap = require "dap"
    local dapui = require "dapui"
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end

---@param config dh.lsp.config
function debug.setup(config)
    setup_adapters()
    setup_config()

    debug_virtual_text()
    debug_gui()
end

return debug
