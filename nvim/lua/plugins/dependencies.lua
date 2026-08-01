---@class dh.plugins.dependencies
local dependencies = {}

local function treesitter()
	require("nvim-treesitter").setup({})
end

local function devicons()
	require("nvim-web-devicons").setup({})
end

---@param config dh.plugins.config
function dependencies.setup(config)
	treesitter()
	devicons()
end

return dependencies
