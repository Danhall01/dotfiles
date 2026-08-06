---@class dh.plugins.c_cpp.overseer_cmake
local overseer_cmake = {}

---@param config dh.plugins.config
local function camke_tools_usercmd(config)
	local cmake = require("cmake-tools")
	local overseer = require("overseer")

	vim.api.nvim_create_user_command("CMakePerf", function()
		local path = vim.fs.dirname(cmake.get_launch_target_path())
		local args = unpack(cmake.get_launch_args())
		args = args or ""

		overseer
			.new_task({
				name = "Perf " .. cmake.get_launch_target(),
				cmd = "perf record --call-graph dwarf " .. cmake.get_launch_target_path() .. args,
				cwd = path,
			})
			:start()
	end, {})

	vim.api.nvim_create_user_command("CMakeValgrind", function()
		local path = vim.fs.dirname(cmake.get_launch_target_path())
		local args = unpack(cmake.get_launch_args())
		args = args or ""

		overseer
			.new_task({
				name = "Valgrind " .. cmake.get_launch_target(),
				cmd = "valgrind --tool=memcheck --leak-check=full --xml=yes --xml-file=memcheck.xml "
					.. cmake.get_launch_target_path()
					.. args,
				cwd = path,
			})
			:start()
	end, {})
	vim.api.nvim_create_user_command("CMakeHelgrind", function()
		local path = vim.fs.dirname(cmake.get_launch_target_path())
		local args = unpack(cmake.get_launch_args())
		args = args or ""

		overseer
			.new_task({
				name = "Helgrind " .. cmake.get_launch_target(),
				cmd = "valgrind --tool=helgrind --xml=yes --xml-file=helgrid.xml "
					.. cmake.get_launch_target_path()
					.. args,
				cwd = path,
			})
			:start()
	end, {})
end

---@param config dh.plugins.config
local function cmake_tools_setup(config)
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

---@param config dh.plugins.config.overseer
local function overseer_setup(config)
	local overseer = require("overseer")
	overseer.setup({
		dap = true,
		output = {
			use_terminal = true,
			preserve_output = true,
		},

		component_aliases = {
			default = {
				"on_exit_set_status",
				--"on_complete_notify",
				--{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},

		-- Configure task list
		task_list = {
			direction = "bottom",
			max_height = 0.3,
			min_height = 0.1,
			keymaps = {
				[config.keybinds.actions.keybind] = "keymap.run_action",
				[config.keybinds.open_float.keybind] = {
					"keymap.open",
					opts = { dir = "float" },
					desc = "Open task output in float",
				},
			},
		},

		-- Configure task floating output window
		task_win = {
			padding = 3,
		},
	})
end

---@param config dh.plugins.config
local function toggleterm_setup(config)
	require("toggleterm").setup({
		size = 20,
	})
end

---@param config dh.plugins.config
function overseer_cmake.setup(config)
	toggleterm_setup(config)
	overseer_setup(config.overseer)
	cmake_tools_setup(config)
	camke_tools_usercmd(config)
end

return overseer_cmake
