---@class dh.plugins.c_cpp.overseer_cmake
local overseer_cmake = {}

---@param config dh.plugins.config
local function cmake_tools_setup(config)
	---@param task overseer.Task
	local function on_cmake_task(task)
		local cmd = task.cmd
		if type(cmd) == "table" then
			cmd = table.concat(cmd, " ")
		end
		if cmd:match("--build") or cmd:match("-B") then
			task:add_component({
				"on_complete_dispose",
				timeout = config.overseer.cmake_build_timeout,
				statuses = { "SUCCESS", "CANCELED" },
			})
		end
		require("overseer").open({
			enter = false,
		})
	end

	local osys = require("cmake-tools.osys")
	require("cmake-tools").setup({
		cmake_regenerate_on_save = false,
		cmake_generate_options = {
			"-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
			"-DCMAKE_C_COMPILER=clang",
		},
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
end

return overseer_cmake
