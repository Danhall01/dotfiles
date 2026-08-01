---@class dh.autocmd.templates
local templates = {}

local function ccpp_header_guards()
	local function create_header_guard(path, extention)
		local fpath = vim.fn.fnamemodify(path, ":p:.:r") .. extention
		fpath = string.gsub(fpath, "[^%w_]", "_")
		fpath = string.upper(fpath)
		return string.format(
			[[
#ifndef _%s_
#define _%s_



#endif /* _%s_ */]],
			fpath,
			fpath,
			fpath
		)
	end

	vim.api.nvim_create_autocmd("BufNewFile", {
		desc = "Automatically creates a header guard for .h and .hpp files.",
		group = "autocmd_templates",
		pattern = { "*.h", "*.hpp" },
		callback = function()
			local fpath = vim.fn.expand("<afile>")
			local dir = vim.fn.fnamemodify(fpath, ":p")
			local f = io.open(dir, "w+")
			if not f then
				return
			end
			f:write(create_header_guard(dir, "." .. vim.fn.fnamemodify(fpath, ":e")))
			f:close()
		end,
	})
end

local function ccpp_auto_include()
	vim.api.nvim_create_autocmd("BufNewFile", {
		desc = "Automatically includes the related .h file.",
		group = "autocmd_templates",
		pattern = { "*.c" },
		callback = function()
			local fpath = vim.fn.expand("<afile>")
			local dir = vim.fn.fnamemodify(fpath, ":p")

			local f = io.open(dir, "w+")
			local includePath = vim.fn.fnamemodify(fpath, ":t:r") .. ".h"
			if not f then
				return
			end
			f:write('#include "' .. includePath .. '"\n')
			f:close()
		end,
	})
	vim.api.nvim_create_autocmd("BufNewFile", {
		desc = "Automatically includes the related .hpp file.",
		group = "autocmd_templates",
		pattern = { "*.cpp" },
		callback = function()
			local fpath = vim.fn.expand("<afile>")
			local dir = vim.fn.fnamemodify(fpath, ":p")

			local f = io.open(dir, "w+")
			local includePath = vim.fn.fnamemodify(fpath, ":t:r") .. ".hpp"
			if not f then
				return
			end
			f:write('#include "' .. includePath .. '"\n')
			f:close()
		end,
	})
end

---@param config dh.autocmd.config
function templates.setup(config)
	vim.api.nvim_create_augroup("autocmd_templates", { clear = true })
	ccpp_header_guards()
	ccpp_auto_include()
end

return templates
