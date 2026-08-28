-- Named after "Mint skyline" from @Nick and created by @Danhall01,
local colors_name = "mint_skyline"

if vim.g.colors_name then
	vim.cmd("hi clear")
end
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = colors_name

---------------------------------------------------------------------------
-- PALETTE
---------------------------------------------------------------------------

local p = {
	bg0 = "#161b22", -- popups / floats
	bg2 = "#252a31", -- lighter bg: pmenu, statusline fg well etc.
	bg3 = "#363c44", -- colorcolumn, folds, diff-change bg
	bg4 = "#484f58", -- conceal / whitespace fg

	fg0 = "#8b949e", -- dim fg (nontext, conceal)
	fg1 = "#e6edf3", -- default fg
	fg2 = "#7d8590", -- muted fg (statusline, hints)
	fg3 = "#6e7681", -- darker fg (line numbers, fold column)

	sel_visual = "#304d75", -- visual selection bg
	sel_pmenu = "#335582", -- popup selection bg
	sel_search = "#585951", -- search bg

	-- Your own explicit UI overrides
	normal_float_bg = "#232323",
	cursorline_bg = "#232632",

	-- Diagnostics / git / diff: GitHub's semantic red/yellow/green/blue.
	red = "#f85149",
	orange = "#db6d28",
	yellow = "#d29922",
	green = "#3fb950",
	blue_info = "#2f81f7",
	ok_green = "#90ee90",

	-----------------------------------------------------------------------
	-- SYNTAX / CODE PALETTE
	-----------------------------------------------------------------------
	-- Family 1: BLUE -- low-key, high-frequency tokens (identifiers,
	-- strings, operators, comments).
	comment = "#6F879F", -- H210 S20 L53  (was #647A91, contrast 4.27 -> 5.08)
	operator_sym = "#95A8BB", -- H210 S22 L66  (was #79C0FF @ S100 -- too vivid for something on every line)
	fg_default = "#E6EDF3", -- identifiers / brackets / punctuation: same as fg1, deliberately neutral
	variable = "#B1CBE2", -- H208 S46 L79  (was #A9CAE9, near-identical, kept)
	variable_member = "#8DADC9", -- H208 S36 L67  NEW: struct/table fields, was colliding with operator blue
	variable_builtin = "#98C2E7", -- H208 S62 L75  self/this/NULL-ish builtins, was colliding with operator blue
	string_fg = "#90B4D5", -- H209 S45 L70  (was #91B4D5, kept -- already well separated)

	-- Family 2: TEAL/CYAN -- structural + literal-data tokens.
	type_fg = "#309189", -- H175 S50 L38  types/structs/classes
	storageclass = "#38B296", -- H166 S52 L46  static/const/volatile/register/inline
	func_fg = "#4AACBF", -- H190 S48 L52  ALL function calls, user or library
	func_def = "#6CA9EF", -- H288 S78 L73  function DEFINITIONS/headers: void func_name(...) {
	type_builtin = "#38C2C2", -- H180 S55 L49  int/char/float/void/bool
	namespace_fg = "#5CBCB0", -- H172 S42 L55  namespaces / Lua's string./table./math. libraries
	constructor_fg = "#60C2CD", -- H186 S52 L59  table constructors etc.

	const_number = "#40E5E7", -- H181 S78 L58  numeric/string literals
	const_builtin = "#66D9DB", -- H181 S62 L63  true/false/nil/NULL
	macro_global_c = "#66EEF0", -- H181 S82 L67

	-- Family 3: PURPLE/INDIGO -- reserved words.
	keyword_fg = "#9869F7", -- H260 S90 L69  general keywords: return, break, goto, sizeof, local, function, end
	conditional = "#8181DF", -- H240 S60 L69  NEW LANE: if/else/for/while/do/switch/repeat/until (was #135048, 2.0:1 contrast -> now 5.2:1, and out of the crowded teal cluster)
	exception_fg = "#887CDA", -- H248 S56 L67  throw/try/catch (C++)
	preproc = "#A475CC", -- H272 S46 L63  #include/#define/#ifdef (was #6C58A6, 3.2:1 contrast -> now 5.4:1)

	-- Family 4: PINK accent
	-- for "special" literal content: regex, escape sequences, format specs.
	regex_special = "#E3C0C7", -- H347 S38 L82 (was #E2BEC6, kept essentially as-is)
}

---------------------------------------------------------------------------
-- HIGHLIGHT GROUPS
---------------------------------------------------------------------------

local groups = {}

-- ===== General editor UI (verbatim from github_dark) =====================
groups.Normal = { fg = p.fg1 } -- no bg: Kitty's background_opacity shows through
groups.NormalNC = { fg = p.fg1 } -- same for unfocused splits
groups.NormalFloat = { fg = p.fg1, bg = p.normal_float_bg }
groups.FloatBorder = { fg = "#161b22", bg = p.normal_float_bg }
groups.FloatTitle = { link = "Title" }
groups.Pmenu = { fg = p.fg1, bg = p.bg2 }
groups.PmenuSel = { bg = p.sel_pmenu }
groups.PmenuSbar = { link = "Pmenu" }
groups.PmenuThumb = { bg = p.sel_visual }
groups.PmenuKind = { link = "Pmenu" }
groups.PmenuKindSel = { link = "PmenuSel" }
groups.PmenuExtra = { link = "Pmenu" }
groups.PmenuExtraSel = { link = "PmenuSel" }
groups.WildMenu = { link = "Pmenu" }
groups.WinSeparator = { fg = "#161b22" }
groups.VertSplit = { fg = "#161b22" }
groups.StatusLine = { fg = "#7D8590", bg = "#23272f" }
groups.StatusLineNC = { fg = "#30363d", bg = "#30363d", sp = p.bg2, underline = true }
groups.TabLine = { fg = p.fg2, bg = p.bg3 }
groups.TabLineFill = { bg = p.bg2 }
groups.TabLineSel = { fg = "#30363d", bg = p.fg3 }
groups.Title = { fg = "#79c0ff", bold = true }
groups.Directory = { fg = p.func_fg }
groups.Cursor = { fg = "#30363d", bg = p.fg1 }
groups.CursorLine = { bg = p.cursorline_bg }
groups.CursorColumn = { link = "CursorLine" }
groups.CursorLineNr = { fg = p.fg1 }
groups.LineNr = { fg = p.fg3 }
groups.LineNrAbove = { link = "LineNr" }
groups.LineNrBelow = { link = "LineNr" }
groups.SignColumn = { fg = p.fg3 }
groups.ColorColumn = { bg = p.bg3 }
groups.Folded = { fg = p.fg3, bg = p.bg3 }
groups.FoldColumn = { fg = p.fg3 }
groups.Visual = { bg = p.sel_visual }
groups.VisualNOS = { link = "Visual" }
groups.Search = { bg = p.sel_search }
groups.IncSearch = { fg = "#161b22", bg = "#f0883e" }
groups.CurSearch = { link = "IncSearch" }
groups.Substitute = { fg = "#30363d", bg = p.red }
groups.MatchParen = { fg = p.fg1, bg = "#33588a", bold = true }
groups.NonText = { fg = p.fg0 }
groups.SpecialKey = { link = "NonText" }
groups.EndOfBuffer = { fg = "#30363d" }
groups.Whitespace = { fg = p.bg4 }
groups.Conceal = { fg = p.fg0 }
groups.ErrorMsg = { fg = p.red }
groups.WarningMsg = { fg = p.yellow }
groups.ModeMsg = { fg = p.yellow, bold = true }
groups.MoreMsg = { fg = p.blue_info, bold = true }
groups.Question = { link = "MoreMsg" }
groups.QuickFixLine = { link = "CursorLine" }
groups.SpellBad = { sp = p.red, undercurl = true }
groups.SpellCap = { sp = p.yellow, undercurl = true }
groups.SpellLocal = { sp = p.blue_info, undercurl = true }
groups.SpellRare = { sp = p.blue_info, undercurl = true }

-- ===== Diagnostics (GitHub semantic colors) ====================
groups.DiagnosticError = { fg = p.red }
groups.DiagnosticWarn = { fg = p.yellow }
groups.DiagnosticInfo = { fg = p.blue_info }
groups.DiagnosticHint = { fg = p.fg2 }
groups.DiagnosticOk = { fg = p.ok_green }
groups.DiagnosticFloatingError = { link = "DiagnosticError" }
groups.DiagnosticFloatingWarn = { link = "DiagnosticWarn" }
groups.DiagnosticFloatingInfo = { link = "DiagnosticInfo" }
groups.DiagnosticFloatingHint = { link = "DiagnosticHint" }
groups.DiagnosticFloatingOk = { link = "DiagnosticOk" }
groups.DiagnosticSignError = { link = "DiagnosticError" }
groups.DiagnosticSignWarn = { link = "DiagnosticWarn" }
groups.DiagnosticSignInfo = { link = "DiagnosticInfo" }
groups.DiagnosticSignHint = { link = "DiagnosticHint" }
groups.DiagnosticSignOk = { link = "DiagnosticOk" }
groups.DiagnosticUnderlineError = { sp = p.red, undercurl = true }
groups.DiagnosticUnderlineWarn = { sp = p.yellow, undercurl = true }
groups.DiagnosticUnderlineInfo = { sp = p.blue_info, undercurl = true }
groups.DiagnosticUnderlineHint = { sp = p.fg2, undercurl = true }
groups.DiagnosticUnderlineOk = { sp = p.ok_green, underline = true }
groups.DiagnosticVirtualTextError = { fg = p.red }
groups.DiagnosticVirtualTextWarn = { fg = p.yellow }
groups.DiagnosticVirtualTextInfo = { fg = p.blue_info }
groups.DiagnosticVirtualTextHint = { fg = p.fg2 }
groups.DiagnosticVirtualTextOk = { link = "DiagnosticOk" }
groups.DiagnosticDeprecated = { sp = "#ff0000", strikethrough = true }
groups.DiagnosticUnnecessary = { link = "Comment" }

-- ===== Diff & git =============================================
groups.Added = { fg = p.green, bg = "#2e423c" }
groups.Changed = { fg = p.yellow, bg = "#413e34" }
groups.Removed = { fg = p.red, bg = "#4a363c" }
groups.DiffAdd = { link = "Added" }
groups.DiffChange = { link = "Changed" }
groups.DiffDelete = { link = "Removed" }
groups.DiffText = { fg = p.fg1, bg = p.bg3 }
groups.diffAdded = { link = "Added" }
groups.diffChanged = { link = "Changed" }
groups.diffRemoved = { link = "Removed" }
groups.diffFile = { fg = p.blue_info }
groups.diffLine = { fg = "#79c0ff" }
groups.diffIndexLine = { fg = p.preproc }
groups.GitSignsAdd = { fg = p.green }
groups.GitSignsChange = { fg = p.yellow }
groups.GitSignsDelete = { fg = p.red }

-- ===== Legacy syntax groups (Vim regex-based highlighting) ================
-- These drive syntax/c.vim, syntax/cpp.vim and syntax/lua.vim when
-- Treesitter isn't attached, and are also what many Treesitter capture
-- groups fall back / link to.
groups.Comment = { fg = p.comment, italic = true }

groups.Constant = { fg = p.const_number }
groups.String = { fg = p.string_fg }
groups.Character = { link = "String" }
groups.Number = { fg = p.const_number }
groups.Boolean = { fg = p.const_number }
groups.Float = { link = "Number" }

groups.Identifier = { fg = p.fg_default }
groups.Function = { fg = p.func_fg, bold = true }

groups.Statement = { fg = p.keyword_fg }
groups.Conditional = { fg = p.conditional }
groups.Repeat = { link = "Conditional" }
groups.Label = { link = "Conditional" }
groups.Operator = { fg = p.operator_sym }
groups.Keyword = { fg = p.keyword_fg }
groups.Exception = { fg = p.exception_fg }

groups.PreProc = { fg = p.preproc }
groups.Include = { link = "PreProc" }
groups.Define = { link = "PreProc" }
groups.Macro = { link = "PreProc" }
groups.PreCondit = { link = "PreProc" }

groups.Type = { fg = p.type_fg }
groups.StorageClass = { fg = p.storageclass }
groups.Structure = { link = "Type" }
groups.Typedef = { link = "Type" }

groups.Special = { fg = p.fg_default } -- kept neutral; Delimiter/Debug/Tag ride on this
groups.SpecialChar = { fg = p.regex_special } -- escape sequences: \n \t \\ etc.
groups.SpecialComment = { link = "Special" }
groups.Debug = { link = "Special" }
groups.Delimiter = { fg = p.fg_default }
groups.Tag = { fg = p.fg_default }

groups.Underlined = { underline = true }
groups.Ignore = {}
groups.Error = { fg = p.red }
groups.Todo = { fg = "#30363d", bg = p.blue_info }

-- explicit C / C++ / Lua legacy-syntax escape & special groups
groups.cSpecial = { link = "SpecialChar" }
groups.cSpecialCharacter = { link = "SpecialChar" }
groups.cFormat = { link = "SpecialChar" } -- printf-style %d %s ...
groups.cStorageClass = { link = "StorageClass" }
groups.cppStorageClass = { link = "StorageClass" }
groups.cppAccess = { link = "Statement" } -- public/protected/private
groups.cppStructure = { link = "Type" } -- class/typename/template/namespace keyword
groups.luaSpecial = { link = "SpecialChar" }

-- ===== Treesitter: generic captures ========================================
groups["@comment"] = { link = "Comment" }
groups["@comment.todo"] = { fg = "#30363d", bg = p.fg2 }
groups["@comment.error"] = { fg = "#30363d", bg = p.red }
groups["@comment.warning"] = { fg = "#30363d", bg = p.yellow }
groups["@comment.hint"] = { fg = "#30363d", bg = p.fg2 }
groups["@comment.info"] = { fg = "#30363d", bg = p.blue_info }

groups["@variable"] = { fg = p.variable }
groups["@variable.builtin"] = { fg = p.variable_builtin } -- self, this, __func__
groups["@variable.parameter"] = { fg = p.fg_default }
groups["@variable.parameter.builtin"] = { fg = p.variable_builtin }
groups["@variable.member"] = { fg = p.variable_member } -- struct fields, table keys
groups["@property"] = { link = "@variable.member" }

groups["@constant"] = { fg = p.const_number }
groups["@constant.builtin"] = { fg = p.const_builtin } -- true/false/nil/NULL
groups["@constant.macro"] = { link = "Macro" }
groups["@string"] = { link = "String" }
groups["@string.escape"] = { fg = p.regex_special, bold = true }
groups["@string.regexp"] = { fg = p.regex_special }
groups["@string.special"] = { link = "SpecialChar" }
groups["@character"] = { link = "Character" }
groups["@character.special"] = { link = "SpecialChar" }
groups["@number"] = { link = "Number" }
groups["@boolean"] = { link = "Boolean" }
groups["@float"] = { link = "Number" }

groups["@function"] = { fg = p.func_def, bold = true } -- definition site: void func_name(...) {
groups["@function.builtin"] = { fg = p.func_fg, bold = true } -- same color as regular calls: free() looks like foo()
groups["@function.macro"] = { link = "Macro" }
groups["@function.call"] = { fg = p.func_fg, bold = true } -- call site: func_name(...)
groups["@constructor"] = { fg = p.constructor_fg }
groups["@constructor.lua"] = { fg = p.fg_default } -- table literal braces stay neutral

groups["@keyword"] = { fg = p.keyword_fg }
groups["@keyword.function"] = { fg = p.keyword_fg, bold = true } -- "function"/"local function"
groups["@keyword.operator"] = { fg = p.keyword_fg } -- and/or/not/sizeof/new/delete
groups["@keyword.return"] = { fg = p.keyword_fg }
groups["@keyword.exception"] = { fg = p.exception_fg } -- throw/try/catch
groups["@keyword.directive"] = { link = "PreProc" }
groups["@conditional"] = { fg = p.conditional }
groups["@repeat"] = { link = "@conditional" }
groups["@label"] = { link = "@conditional" } -- goto labels / switch case labels
groups["@exception"] = { fg = p.exception_fg }
groups["@operator"] = { fg = p.operator_sym }
groups["@operator.lua"] = { fg = p.operator_sym }

groups["@type"] = { fg = p.type_fg }
groups["@type.builtin"] = { fg = p.type_builtin } -- int/char/float/void/bool/size_t
groups["@type.qualifier"] = { fg = p.storageclass } -- const/volatile/restrict
groups["@type.definition"] = { link = "@type" }
groups["@storageclass"] = { fg = p.storageclass }
groups["@namespace"] = { fg = p.namespace_fg }
groups["@module"] = { fg = p.namespace_fg }
groups["@module.builtin"] = { fg = p.namespace_fg } -- Lua's string/table/math/os
groups["@attribute"] = { link = "@constant" } -- [[nodiscard]], __attribute__((...))
groups["@punctuation.bracket"] = { fg = p.fg_default }
groups["@punctuation.delimiter"] = { fg = p.fg_default }
groups["@punctuation.special"] = { link = "SpecialChar" }

groups["@markup.strong"] = { fg = p.fg1, bold = true }
groups["@markup.italic"] = { fg = p.fg1, italic = true }
groups["@markup.raw"] = { fg = p.fg1, italic = true }
groups["@markup.link.uri"] = { fg = p.const_number, italic = true, underline = true }
groups["@text.uri"] = { link = "Underlined" }

-- Lua-specific fine-tuning
groups["@function.builtin.lua"] = { fg = p.func_fg, bold = true }
groups["@module.builtin.lua"] = { fg = p.namespace_fg }
groups["@property.lua"] = { fg = p.fg_default }
groups["@operator.luadoc"] = { fg = p.fg_default }

-- ===== LSP semantic tokens =================================================
groups["@lsp.type.variable"] = { fg = p.variable }
groups["@lsp.type.variable.lua"] = {}
groups["@lsp.type.parameter"] = { link = "@variable.parameter" }
groups["@lsp.type.property"] = { fg = p.variable_member }
groups["@lsp.type.function"] = { link = "@function.call" }
groups["@lsp.type.method"] = { link = "@function.call" }
groups["@lsp.type.class"] = { link = "@type" }
groups["@lsp.type.struct"] = { link = "@type" }
groups["@lsp.type.interface"] = { link = "@type" }
groups["@lsp.type.enum"] = { link = "@type" }
groups["@lsp.type.enumMember"] = { link = "@constant" }
groups["@lsp.type.type"] = { link = "@type" }
groups["@lsp.type.typeParameter"] = { link = "@type" }
groups["@lsp.type.namespace"] = { link = "@namespace" }
groups["@lsp.type.keyword"] = { link = "@keyword" }
groups["@lsp.type.macro"] = { link = "Macro" }
groups["@lsp.type.decorator"] = { link = "@function.call" }
groups["@lsp.type.comment"] = { link = "Comment" }
groups["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" }
groups["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" }
groups["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" }
groups["@lsp.typemod.variable.injected"] = { link = "@variable" }
groups["@lsp.typemod.string.injected"] = { link = "@string" }
groups["@lsp.typemod.operator.injected"] = { link = "@operator" }

-- Function/method DEFINITION sites (the header, e.g. `void func_name(...) {`)
groups["@lsp.typemod.function.definition"] = { fg = p.func_def }
groups["@lsp.typemod.function.definition.c"] = { fg = p.func_def }
groups["@lsp.typemod.function.definition.cpp"] = { fg = p.func_def }
groups["@lsp.typemod.function.definition.lua"] = { fg = p.func_def }
groups["@lsp.typemod.method.definition.cpp"] = { fg = p.func_def } -- MyClass::method() { ... } definitions

-- C setup mirrored into C++
groups["@lsp.typemod.macro.globalscope.c"] = { fg = p.macro_global_c }
groups["@lsp.typemod.macro.globalscope.cpp"] = { fg = p.macro_global_c }
groups["@lsp.typemod.class.filescope.c"] = { fg = p.type_fg } -- struct/class tags -> Type family
groups["@lsp.typemod.class.filescope.cpp"] = { fg = p.type_fg }
groups["@lsp.typemod.property.classScope.c"] = { fg = p.variable_member }
groups["@lsp.typemod.property.classScope.cpp"] = { fg = p.variable_member }
groups["@lsp.typemod.parameter.functionScope.c"] = { fg = p.variable_builtin }
groups["@lsp.typemod.parameter.functionScope.cpp"] = { fg = p.variable_builtin }

-- ===== A few common plugin integrations (link to the base groups above, so
-- they automatically follow the same palette) ==============================
groups.TelescopeMatching = { link = "Search" }
groups.TelescopeSelection = { link = "CursorLine" }
groups.TelescopeSelectionCaret = { fg = p.blue_info }

groups.CmpItemAbbr = { fg = p.fg1 }
groups.CmpItemAbbrMatch = { fg = p.func_fg }
groups.CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" }
groups.CmpItemAbbrDeprecated = { fg = "#ffa198", strikethrough = true }
groups.CmpItemKindFunction = { link = "@function" }
groups.CmpItemKindMethod = { link = "@function" }
groups.CmpItemKindClass = { link = "@type" }
groups.CmpItemKindConstructor = { link = "@constructor" }
groups.CmpItemKindConstant = { link = "@constant" }
groups.CmpItemKindEnum = { link = "@constant" }
groups.CmpItemKindEnumMember = { link = "@constant" }
groups.CmpItemKindField = { link = "@variable.member" }
groups.CmpItemKindInterface = { link = "@type" }
groups.CmpItemKindKeyword = { link = "@keyword" }
groups.CmpItemKindModule = { link = "@namespace" }
groups.CmpItemKindOperator = { link = "@operator" }
groups.CmpItemKindDefault = { fg = p.fg2 }
groups.CmpDocumentation = { fg = p.fg1, bg = p.bg2 }
groups.CmpDocumentationBorder = { fg = p.sel_visual, bg = p.bg2 }

groups.WhichKey = { link = "Identifier" }
groups.WhichKeyDesc = { link = "@keyword" }
groups.WhichKeyGroup = { link = "@function" }
groups.WhichKeySeparator = { link = "Comment" }
groups.WhichKeyValue = { link = "Comment" }
groups.WhichKeyFloat = { bg = p.bg2 }

groups.IndentBlanklineChar = { fg = "#42484f" }
groups.IndentBlanklineContextChar = { fg = "#5e7781" }
groups.IblIndent = { link = "IndentBlanklineChar" }
groups.IblScope = { link = "IndentBlanklineContextChar" }

groups.NvimTreeNormal = { fg = p.fg1 } -- no bg, matches the transparent editor canvas
groups.NvimTreeFolderIcon = { fg = p.func_fg }
groups.NvimTreeFolderName = { fg = p.fg1 }
groups.NvimTreeOpenedFolderName = { fg = "#79c0ff" }
groups.NvimTreeRootFolder = { fg = p.preproc, bold = true }
groups.NvimTreeIndentMarker = { fg = p.fg0 }
groups.NeoTreeDirectoryName = { fg = p.fg1 }
groups.NeoTreeRootName = { fg = p.fg1, bold = true }
groups.NeoTreeIndentMarker = { fg = p.fg0 }

---------------------------------------------------------------------------
-- APPLY
---------------------------------------------------------------------------

for name, val in pairs(groups) do
	vim.api.nvim_set_hl(0, name, val)
end
