---@class dh.plugins.code_analysis
local code_analysis = {}

---@param config dh.plugins.config
function code_analysis.setup(config)
	require("perfanno").setup()
	require("sanity").setup({
		thread_support = true,
	})
end

return code_analysis
