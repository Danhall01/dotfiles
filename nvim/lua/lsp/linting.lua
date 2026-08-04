---@class dh.lsp.linting
local linting = {}
local lint = require("lint")

---@param config dh.lsp.config
local function setup_linters(config)
	lint.linters_by_ft = {
		cmake = { "cmake_lint" },
	}
end

---@param config dh.lsp.config
local function auto_lint(config)
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = "dh.lsp",
		callback = function()
			lint.try_lint()
		end,
	})
end

---@param config dh.lsp.config
function linting.setup(config)
	setup_linters(config)

	auto_lint(config)
end

return linting
