---@class dh.plugins.navigation
local navigation = {}

---@param config dh.plugins.config
local function telescope(config)
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	})
end

---@param config dh.plugins.config
local function telescope_fzf(config)
	require("telescope").load_extension("fzf")
end

---@param config dh.plugins.config
function navigation.setup(config)
	telescope(config)
	telescope_fzf(config)
end

return navigation
