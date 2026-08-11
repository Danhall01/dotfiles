---@class dh.keymap.debug
local debug = {}

---@param config dh.keymap.config.debug
local function debug_adapter_protocol(config)
	if not config.toggle_breakpoint.disabled then
		vim.keymap.set("n", config.toggle_breakpoint.keybind, function()
			require("dap").toggle_breakpoint()
		end, { desc = "dap: Set breakpoint" })
	end

	if not config.toggle_breakpoint_cond.disabled then
		vim.keymap.set("n", config.toggle_breakpoint_cond.keybind, function()
			require("dap").toggle_breakpoint()
		end, { desc = "dap: Set conditional breakpoint" })
	end

	if not config.continue.disabled then
		vim.keymap.set("n", config.continue.keybind, function()
			require("dap").continue()
		end, { desc = "dap: Continue execution" })
	end

	if not config.restart.disabled then
		vim.keymap.set("n", config.restart.keybind, function()
			require("dap").restart()
		end, { desc = "dap: Restart execution" })
	end

	if not config.step_over.disabled then
		vim.keymap.set("n", config.step_over.keybind, function()
			require("dap").step_over()
		end, { desc = "dap: Step over" })
	end

	if not config.step_into.disabled then
		vim.keymap.set("n", config.step_into.keybind, function()
			require("dap").step_into()
		end, { desc = "dap: Step into" })
	end

	if not config.step_out.disabled then
		vim.keymap.set("n", config.step_out.keybind, function()
			require("dap").step_out()
		end, { desc = "dap: Step out" })
	end

	if not config.inspect.disabled then
		vim.keymap.set("n", config.inspect.keybind, function()
			require("dap.ui.widgets").hover()
		end, { desc = "dap: Inspect" })
	end
end

---@param config dh.keymap.config
function debug.setup(config)
	debug_adapter_protocol(config.debug)
end

return debug
