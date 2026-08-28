---@class dh.plugins.dependencies
local dependencies = {}

---@param config dh.plugins.config
function dependencies.setup(config)
	require("nvim-web-devicons").setup({})
end

return dependencies
