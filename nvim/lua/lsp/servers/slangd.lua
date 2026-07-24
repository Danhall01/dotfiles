---@class dh.lsp.servers.slangd
local config = {
    settings = {
        slang = {
            predefinedMacros = nil,             --{ "MY_VALUE_MACRO=1" }
            inlayHints = {
                deducedTypes = true,
                parameterNames = true,
            }
        },
    }
}

return config
