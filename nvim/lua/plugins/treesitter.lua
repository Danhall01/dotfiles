---@class dh.plugins.treesitter
local treesitter = {}

local function autostart()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
		group = "dh.plugins.treesitter",
		callback = function()
			vim.treesitter.start()
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.bo.indentexpr = "v:vim.require'nvim-treesitter'.indentexpr()"
		end,
	})
end

---@param config dh.plugins.config
function treesitter.setup(config)
	require("nvim-treesitter").setup({})
	vim.api.nvim_create_augroup("dh.plugins.treesitter", { clear = true })
	autostart()
end

return treesitter
