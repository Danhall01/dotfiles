---@class dh.lsp.config.treesitter
---@field install? table<string>

---@class dh.lsp.config.mason.install_entry
---@field install string The tool you want to install
---@field version? string Pin to particular version
---@field auto_update? boolean Toggle auto update per tool
---@field target? string You can set a specific arch, helpful if you have a win_arm64 processor
---@field condition? function Conditional install
---@field enabled? boolean If lsp should attach or not when prompted
---@field config? table For lspconfig when configuring the language server, might not exist

---@class dh.lsp.config.diagnostic
---@field min? vim.diagnostic.Severity The minimum diagnostic to be shown
---@field max? vim.diagnostic.Severity The maximum diagnostic to be shown
---@field icons table<vim.diagnostic.Severity, string> The symbols to show in diagnostics
---@field text table<vim.diagnostic.Severity, string> The text to be shown in diagnostic notifications

---@class dh.lsp.config
---@field lsps table<string, dh.lsp.config.mason.install_entry> All active lsps to be installed and loaded when required
---@field formatters table<string, dh.lsp.config.mason.install_entry> All active formatters to be installed and loaded when required
---@field dap table<string, dh.lsp.config.mason.install_entry> All active formatters to be installed and loaded when required
---@field diagnostic dh.lsp.config.diagnostic The diagnostic settings
---@field treesitter dh.lsp.config.treesitter Install config for treesitter
---@field treesitter_install boolean Flag to enable/disable all treesitter auto installs
---@field mason_install boolean Flag to enable/disable all mason auto installs
