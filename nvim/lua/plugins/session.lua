---@class dh.plugins.session
local session = {}

---@param config dh.plugins.config.session
local function resession_setup(config)
	local resession = require("resession")
	resession.setup({
		autosave = {
			enabled = config.auto_save.enabled,
			interval = config.auto_save.interval,
			notify = config.auto_save.notify,
		},
		extensions = {
			overseer = {},
		},
	})

	local function get_session_name()
		local name = vim.fn.getcwd()
		local branch = vim.trim(vim.fn.system("git branch --show-current"))
		if vim.v.shell_error == 0 then
			return string.format("%s::%s", name, branch)
		else
			return name
		end
	end

	if config.save_on_exit then
		vim.api.nvim_create_autocmd("VimLeavePre", {
			group = "dh.plugins.session",
			callback = function()
				resession.save(get_session_name(), { dir = "dirsession", notify = false })
			end,
		})
	end
	if config.load_on_enter then
		vim.api.nvim_create_autocmd("VimEnter", {
			group = "dh.plugins.session",
			callback = function()
				if vim.fn.argc(-1) == 0 then
					vim.schedule(function()
						vim.notify(string.format("Loading session: %s", get_session_name()), vim.log.levels.TRACE)
					end)
					resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
				end
			end,
		})
	end
end

---@param config dh.plugins.config
function session.setup(config)
	vim.api.nvim_create_augroup("dh.plugins.session", {})
	resession_setup(config.session)
end

return session
