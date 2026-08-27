-- Lualine theme companion to colors/mint_skyline.lua.

local colors = {
	bg1 = "#23272f", -- dark gray, close to the editor canvas -- deliberately unintrusive
	bg2 = "#1c1f25",
	fg = "#7D8590", -- muted text on that background
	normal = "#309189",
	insert = "#86B3DF",
	visual = "#2F81F7",
	replace = "#F85149",
	command = "#7153AC",
}

---@param accent string mode accent color, e.g. c.command
local function mode_hl(accent)
	return {
		a = { fg = colors.bg1, bg = accent, gui = "bold" }, -- vivid accent block
		b = { fg = accent, bg = colors.bg2 }, -- accent as text, neutral bg -- a fading echo of `a`
		c = { fg = colors.fg, bg = colors.bg1 }, -- fully neutral: the "invisible" middle section
	}
end

local theme = {
	normal = mode_hl(colors.normal),
	insert = mode_hl(colors.insert),
	visual = mode_hl(colors.visual),
	replace = mode_hl(colors.replace),
	command = mode_hl(colors.command),
	inactive = {
		a = { fg = colors.fg, bg = colors.bg1 },
		b = { fg = colors.fg, bg = colors.bg2 },
		c = { fg = colors.fg, bg = colors.bg1 },
	},
}

return theme
