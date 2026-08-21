---@class dh.plugins.tasks.cmake_cmd
local cmake_cmd = {
	cmds = {},
}
local g_task_view = {}

local cmake = require("cmake-tools")
local overseer = require("overseer")
---@param config dh.plugins.config.tasks
local function camke_tools_usercmd(config) end

---@param config dh.plugins.config.tasks
local function cmake_tools_setup(config)
	if config.overseer.timeouts.destroy_on_exit then
		vim.api.nvim_create_autocmd("ExitPre", {
			group = "dh.plugins.tasks.cmake",
			callback = function()
				for _, task in ipairs(g_task_view) do
					if not task:is_disposed() then
						task:dispose(true)
					end
				end
			end,
		})
	end
	---@param task overseer.Task
	local function on_cmake_task(task)
		local cmd = task.cmd
		if type(cmd) == "table" then
			cmd = table.concat(cmd, " ")
		end
		if config.overseer.timeouts.build_events and (cmd:match("--build") or cmd:match("-B")) then
			task:add_component({
				"on_complete_dispose",
				timeout = config.overseer.timeouts.build_events,
				statuses = { "SUCCESS", "CANCELED" },
			})
		end
		table.insert(g_task_view, task)
		require("overseer").open({
			enter = false,
		})
	end

	local build_opts = {}
	local generate_opts = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }
	local system_threads = tonumber(vim.fn.system({ "nproc" }))

	-- Multithread cmake
	if system_threads ~= 0 then
		vim.list_extend(build_opts, { string.format("-j%d", system_threads - 1) })
	end

	-- Prefer ninja over make
	if vim.fn.executable("ninja") == 1 then
		vim.list_extend(generate_opts, { "-G Ninja" })
	end

	-- Use Clang if available
	if vim.fn.executable("clang") == 1 and vim.fn.executable("clang++") == 1 then
		vim.fn.setenv("CC", "/usr/bin/clang")
		vim.fn.setenv("CXX", "/usr/bin/clang++")
	end

	-- Use ccache if available
	if vim.fn.executable("ccache") == 1 then
		vim.fn.setenv("CMAKE_C_COMPILER_LAUNCHER", "ccache")
		vim.fn.setenv("CMAKE_CXX_COMPILER_LAUNCHER", "ccache")
	end

	local osys = require("cmake-tools.osys")
	require("cmake-tools").setup({
		cmake_regenerate_on_save = false,
		cmake_build_options = build_opts,
		cmake_generate_options = generate_opts,
		cmake_command = "cmake",
		ctest_command = "ctest",

		cmake_build_directory = function()
			if osys.iswin32 then
				return "build\\${variant:buildType}"
			end
			return "build/${variant:buildType}"
		end,

		cmake_dap_configuration = {
			name = "dap debug c/cpp",
			type = "gdb",
			request = "launch",
			stopOnEntry = false,
			runInTerminal = false,
		},

		cmake_executor = {
			name = "overseer",
			opts = {
				on_new_task = on_cmake_task,
			},
		},
		cmake_runner = {
			name = "overseer",
			opts = {
				on_new_task = on_cmake_task,
			},
		},
		cmake_notifications = {
			runner = { enabled = false },
			executor = { enabled = false },
			spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
			refresh_rate = 60,
		},
		cmake_virtual_text_support = true,
		cmake_use_scratch_buffer = true,
	})
end

---@param config dh.plugins.config.tasks
function cmake_cmd.register(config)
	vim.api.nvim_create_augroup("dh.plugins.tasks.cmake", {})
	cmake_tools_setup(config)
	camke_tools_usercmd(config)

	cmake_cmd.cmds = {
		"CMakePerf",
		"CMakeValgrind",
		"CMakeHelgrind",
	}
end

return cmake_cmd
