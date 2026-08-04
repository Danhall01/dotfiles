---@class dh.autocmd.templates
local templates = {}

local function ccpp_header_guards()
	local function create_header_guard(path, extension)
		local fpath = vim.fn.fnamemodify(path, ":p:.:r") .. extension
		fpath = string.gsub(fpath, "[^%w_]", "_")
		fpath = string.upper(fpath)
		return string.format("#ifndef _%s_\n#define _%s_\n\n\n#endif /* _%s_ */", fpath, fpath, fpath)
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		desc = "Automatically creates a header guard for .h and .hpp files.",
		group = "dh.autocmd.templates",
		pattern = { "*.h", "*.hpp" },
		callback = function(args)
			if vim.fn.line("$") ~= 1 or vim.fn.getline(1) ~= "" then
				return
			end
			local fpath = vim.fn.expand("<afile>")
			local path = vim.fn.fnamemodify(fpath, ":p")
			local ext = "." .. vim.fn.fnamemodify(fpath, ":e")
			vim.api.nvim_buf_set_lines(
				args.buf,
				0,
				0,
				false,
				vim.split(create_header_guard(path, ext), "\n", { plain = true })
			)
		end,
	})
end

local function ccpp_auto_include()
	local function find_header_clangd(bufnr)
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		for _, client in ipairs(clients) do
			if client.name == "clangd" then
				local params = vim.lsp.util.make_text_document_params(bufnr)
				local res = vim.lsp.buf_request_sync(bufnr, "textDocument/switchSourceHeader", params, 600)
				if res then
					for _, response in pairs(res) do
						if response.result then
							return vim.uri_to_fname(response.result)
						end
					end
				end
			end
		end
		vim.notify("Could not find lsp header location, using fallback", vim.log.levels.WARN)
	end
	local function find_header(path, stem)
		local dir = vim.fn.fnamemodify(path, ":h")
		local root = vim.fn.getcwd()

		local search_paths = {
			dir .. "/" .. stem,
			root .. "/include/" .. stem,
		}
		for _, query_path in ipairs(search_paths) do
			for _, ext in ipairs({ ".h", ".hpp" }) do
				if vim.uv.fs_stat(query_path .. ext) then
					return vim.fn.fnamemodify(query_path .. ext, ":t")
				end
			end
		end
		return nil
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		desc = "Automatically includes the related .h or .hpp file. Queries common directories",
		group = "dh.autocmd.templates",
		pattern = { "*.c", "*.cpp" },
		callback = function(args)
			if vim.fn.line("$") ~= 1 or vim.fn.getline(1) ~= "" then
				return
			end
			local path = vim.api.nvim_buf_get_name(args.buf)
			local ext = vim.fn.fnamemodify(path, ":e")
			local stem = vim.fn.fnamemodify(path, ":t:r")

			local header = nil
			if ext == "c" then
				header = stem .. ".h"
			else
				header = find_header_clangd(args.buf)
				if not header then
					header = find_header(path, stem)
				end
				if not header then
					header = stem .. ".hpp"
				end
			end

			vim.api.nvim_buf_set_lines(args.buf, 0, 0, false, {
				string.format('#include "%s"', header),
			})
		end,
	})
end

---@param config dh.autocmd.config
function templates.setup(config)
	vim.api.nvim_create_augroup("dh.autocmd.templates", { clear = true })
	ccpp_header_guards()
	ccpp_auto_include()
end

return templates
