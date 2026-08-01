---@class dh.lsp.diagnostics
local diagnostics = {}

---@param config dh.lsp.config.diagnostic
---@param severity vim.diagnostic.Severity
---@return string The diagnostic message
local function append_analytics(config, severity)
	local severity_count = #vim.diagnostic.get(nil, { severity = { severity } })
	if
		(config.max or vim.diagnostic.severity.HINT) <= severity
		and (config.min or vim.diagnostic.severity.ERROR) >= severity
		and severity_count > 0
	then
		return tostring(severity_count) .. " " .. config.text[severity] .. "(s)"
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
				},
			})
			local message_count = #messages
			if message_count == 0 then
				return
			end

			-- Analysis info which shows amount of warnings and errors
			local analytics_msg = ""
			local analytics_severity = config.max or vim.diagnostic.severity.HINT

			for i = config.max or vim.diagnostic.severity.HINT, config.min or vim.diagnostic.severity.ERROR, -1 do
				if string.len(analytics_msg) > 0 then
					analytics_msg = analytics_msg .. "\n"
				end
				local msg = append_analytics(config, i)
				analytics_msg = analytics_msg .. msg
				if string.len(msg) > 0 then
					analytics_severity = i
				end
			end

			vim.notify(analytics_msg, analytics_severity, { title = "Code Analysis" })
		end,
	})
end

---@param config dh.lsp.config
local function diagnostic_config(config)
	vim.diagnostic.config({
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
					return i == 3 + 1 and string.format("[%d]", total) or ""
				end
				return "■"
			end,
			format = function(diagnostic)
				return string.format(
					"[%s] %s: %s (%s)",
					config.diagnostic.icons[diagnostic.severity],
					diagnostic.code,
					diagnostic.message,
					diagnostic.source
				)
			end,
		},
		underline = true,
		float = {
			show_header = true,
			format = function(diagnostic)
				return string.format("%s (%s)", diagnostic.message, diagnostic.source)
			end,
			prefix = function(diagnostic)
				return string.format("[%s]\t", config.diagnostic.icons[diagnostic.severity] or ""),
					"DiagnosticVirtualText" .. (config.diagnostic.text[diagnostic.severity] or "")
			end,
			border = "rounded",
			style = "",
			focusable = false,
			source = "if_many",
		},
	})
end

---@param config dh.lsp.config
function diagnostics.setup(config)
	diagnostic_config(config)
	notify_on_errors(config.diagnostic)
end

return diagnostics
