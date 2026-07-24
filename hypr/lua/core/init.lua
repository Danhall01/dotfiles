local init = {}
init.setup = function(config)
    require"lua.core.monitors".setup(config)
    require"lua.core.autostart".setup(config)
    require"lua.core.environment-variables".setup(config)
    require"lua.core.permissions".setup(config)
    require"lua.core.look-and-feel".setup(config)
    require"lua.core.misc".setup(config)
    require"lua.core.input".setup(config)
    require"lua.core.keybinds".setup(config)
    require"lua.core.window-rules".setup(config)
end
return init
