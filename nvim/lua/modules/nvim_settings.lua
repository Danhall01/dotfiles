---@class dh.module.nvim_settings
local settings = {}

local function editor_style()
	vim.opt.background = "dark"
	vim.opt.termguicolors = true
	vim.o.winborder = "rounded"
end

local function behaviour()
	vim.opt.autoread = true
	vim.opt.autowriteall = true
	vim.opt.confirm = true
	vim.opt.mouse = "a"
	vim.opt.mousehide = true
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.scrolloff = 6
end

local function style()
	vim.opt.autoindent = true
	vim.opt.expandtab = true
	vim.opt.shiftwidth = 4
	vim.opt.softtabstop = 4
	vim.opt.tabstop = 4
end

local function cursorline()
	vim.opt.cursorline = true
end

local function shader_filetype_ext()
	vim.filetype.add({
		extension = {
			shader = "hlsl",
			hlsl = "hlsl",
			hlsli = "hlsl",
			shaderslang = "hlsl",
			glsl = "glsl",
			glsli = "glsl",
			vert = "glsl",
			tesc = "glsl",
			tese = "glsl",
			frag = "glsl",
			geom = "glsl",
			comp = "glsl",
		},
	})
end

---@param config dh.module.config
function settings.setup(config)
	editor_style()
	behaviour()
	style()
	cursorline()
	shader_filetype_ext()
end

return settings
