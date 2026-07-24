---@class dh.keymap.cmake
local cmake = {}

---@param config dh.keymap.config.cmake
local function runner(config)
    if not config.run.disabled then
        vim.keymap.set('n', config.run.keybind, function() vim.cmd("CMakeRun") end,
            { desc = "CMake-tools: Build and run program" })
    end

    if not config.build.disabled then
        vim.keymap.set('n', config.build.keybind, function() vim.cmd("CMakeBuild") end,
            { desc = "Cmake-Tools: Build the program according to settings" })
    end
end

---@param config dh.keymap.config.cmake
local function options(config)
    if not config.set_build_type.disabled then
        vim.keymap.set('n', config.set_build_type.keybind, function() vim.cmd("CMakeSelectBuildType") end,
            { desc = "CMake-tools: Select target configuration for CMake" })
    end
end

---@param config dh.keymap.config
function cmake.setup(config)
    runner(config.cmake)
    options(config.cmake)
end

return cmake
