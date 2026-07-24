local system_threads = tonumber(vim.fn.system({ "nproc" }))
local thread_flag = ""
if system_threads ~= 0 then
    thread_flag = "--j=" .. tostring(system_threads - 1)
end


---@class dh.lsp.servers.clangd
local config = {
    cmd = {
        "clangd",
        "--background-index",
        thread_flag,
        "--completion-style=detailed",
        "--function-arg-placeholders",

        "--header-insertion=iwyu",
        "--clang-tidy",

        "--fallback-style=gnu",
    },
    init_options = {
        fallbackFlags = { "-Wall", "-Wextra", "-Wpedantic", },
    },
}

return config
