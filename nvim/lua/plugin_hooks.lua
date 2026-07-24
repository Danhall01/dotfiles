---@class dh.plugin_hooks
local hooks = {}

local function treesitter_hook()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(event)
            local name, kind = event.data.spec.name, event.data.kind
            if name == "nvim-treesitter" and kind == "update" then
                if not event.data.active then vim.cmd.packadd("nvim-treesitter") end
                vim.cmd("TSUpdate")
            end
        end
    })
end

local function telescope_build()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(event)
            local name, kind = event.data.spec.name, event.data.kind
            if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
                vim.system({ "make" }, { cwd = event.data.path }):wait()
            end
        end
    })
end

local function blink_build()
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(event)
            local name, kind = event.data.spec.name, event.data.kind
            if name == "blink.cmp" and (kind == "install" or kind == "update") then
                require('blink.cmp').build()
            end
        end
    })
end

function hooks.setup()
    treesitter_hook()
    telescope_build()
    blink_build()
end

return hooks
