---@class dh.lsp.formatting
local formatting = {}

---@param config dh.lsp.config
local function conform_setup(config)
	require("conform").setup({
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters = {
			cmake_format = {
				command = "cmake-format",
				args = { "$FILENAME" },
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },

			-- Shader languages
			hlsl = { "clang-format" },
			hlsli = { "clang-format" },
			slang = { "clang-format" },

			-- C/C++
			c = { "clang-format" },
			cpp = { "clang-format" },

			-- CMake (Custom)
			cmake = { "cmake_format" },

			-- Use the "*" filetype to run formatters on all filetypes.
			["*"] = { "codespell" },
			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			["_"] = { "trim_whitespace" },
		},
		format_on_save = {
			timeout_ms = 1000,
		},
	})
end

---@param config dh.lsp.config
function formatting.setup(config)
	conform_setup(config)
end

return formatting
