---@class dh.lsp.activation
local activation = {}


---@param config dh.lsp.config
function activation.setup(config)
    for server, opts in pairs(config.lsps) do
        -- Ensure optional config table exists
        if (opts.config == nil) then opts.config = {} end

        -- Update capabilities for blink.cmp
        opts.config.capabilities = require "blink.cmp".get_lsp_capabilities(opts.config.capabilities)

        -- config and enable the lsp
        vim.lsp.config(server, opts.config)
        vim.lsp.enable(server)
    end
end

return activation
