---@class dh.modules.auto_fold
local folding = {}

---@param config dh.modules.config
local function auto_open_fold(config)
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = "dh.modules.auto_fold",
		callback = function()
			local line = vim.fn.line(".")
			local fold = vim.fn.foldclosed(line)
			if not fold or fold == -1 then
				return
			end

			vim.cmd("normal! zM")
			vim.cmd("normal! zO")
		end,
	})
end

---@param config dh.modules.config
function folding.setup(config)
	if not config.folding.enabled then
		return
	end
	vim.api.nvim_create_augroup("dh.modules.auto_fold", {})
	vim.o.foldmethod = "expr"
	vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
	vim.opt.foldminlines = config.folding.min_foldsize
	auto_open_fold(config)
end
return folding
