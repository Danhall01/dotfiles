---@class dh.lsp.server_attach
local server_attach = {}

---@param config dh.lsp.config
local function setup_lsp(config)
	for server, opts in pairs(config.lsps) do
		-- Ensure optional config table exists
		if opts.config == nil then
			opts.config = {}
		end

		-- Update capabilities for blink.cmp
		opts.config.capabilities = require("blink.cmp").get_lsp_capabilities(opts.config.capabilities)

		-- config and enable the lsp
		vim.lsp.config(server, opts.config)
		vim.lsp.enable(server)
	end
end

---@param config dh.lsp.config
function server_attach.setup(config)
	setup_lsp(config)
end

return server_attach
