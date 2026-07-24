---@class dh.lsp.diagnostics
local diagnostics = {}


---@param config dh.lsp.config
function diagnostics.setup(config)
    vim.diagnostic.config {
        signs = {
            text = config.diagnostic.icons,
            numhl = {
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            },
        },

        -- Format virtual text (float + inline)
        virtual_text = {
            -- If more than 3 errors, show number instead (after 3 signs)
            prefix = function(_, i, total)
                if total ~= nil and total > 3 and i > 3 then
                    return i == 3 + 1 and string.format("[%d]", total) or "";
                end
                return '■';
            end,
            format = function(diagnostic)
                return string.format("[%s] %s: %s (%s)", config.diagnostic.icons[diagnostic.severity], diagnostic.code,
                    diagnostic.message, diagnostic.source)
            end
        },
        underline = true,
        float = {
            show_header = true,
            format = function(diagnostic)
                return string.format("%s (%s)", diagnostic.message, diagnostic.source)
            end,
            prefix = function(diagnostic)
                return string.format("[%s]\t", config.diagnostic.icons[diagnostic.severity] or ""),
                    "DiagnosticVirtualText" .. (config.diagnostic.text[diagnostic.severity] or "");
            end,
            border = "rounded",
            style = "",
            focusable = false,
            source = "if_many",
        },
    }
end

return diagnostics
