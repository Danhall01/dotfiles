---@class dh.lsp.autocmd
local autocmd = {}

local function format_on_save()
    vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Automatically format upon save (Uses local format file if found)",
        group = "lsp",
        pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.hlsl", "*.hlsli", "*.lua", "CMakeLists.txt", "*.cmake", "*.sh" },
        callback = function(_)
            vim.lsp.buf.format({ async = false });
        end
    });
end

---@param config dh.lsp.config.diagnostic
---@param severity vim.diagnostic.Severity
---@return string The diagnostic message
local function append_analytics(config, severity)
    local severity_count = #vim.diagnostic.get(nil, { severity = { severity } });
    if (config.max or vim.diagnostic.severity.HINT) <= severity
        and (config.min or vim.diagnostic.severity.ERROR) >= severity
        and severity_count > 0 then
        return tostring(severity_count) .. ' ' .. config.text[severity] .. "(s)"
    end
    return ""
end
---@param config dh.lsp.config.diagnostic
local function notify_on_errors(config)
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        desc = "Sends notifications of all warnings and errors upon writing to buffer",
        group = "lsp",
        pattern = { "*" },
        callback = function(_)
            local messages = vim.diagnostic.get(nil, {
                severity = {
                    min = config.min,
                    max = config.max,
                }
            });
            local message_count = #messages
            if message_count == 0 then return end

            -- Analysis info which shows amount of warnings and errors
            local analytics_msg = "";
            local analytics_severity = config.max or vim.diagnostic.severity.HINT;

            for i = config.max or vim.diagnostic.severity.HINT, config.min or vim.diagnostic.severity.ERROR, -1 do
                if string.len(analytics_msg) > 0 then
                    analytics_msg = analytics_msg .. '\n'
                end
                local msg = append_analytics(config, i)
                analytics_msg = analytics_msg .. msg
                if (string.len(msg) > 0) then
                    analytics_severity = i
                end
            end

            vim.notify(analytics_msg, analytics_severity, { title = "Code Analysis" });
        end,
    });
end

---@param config dh.lsp.config
function autocmd.setup(config)
    format_on_save()
    notify_on_errors(config.diagnostic)
end

return autocmd
