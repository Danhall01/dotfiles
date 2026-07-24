local plugin = {}
plugin.setup = function(config)
    -- See https://wiki.hypr.land/Configuring/Basics/Monitors/
    hl.monitor({
        output   = "",
        mode     = "preferred",
        position = "auto",
        scale    = "auto",
    })

    -- Ultrawide
    hl.monitor({
        output   = "DP-3",
        mode     = "preferred",
        position = "auto",
        scale    = "auto",
    })
end
plugin.init = function(opts) end


return plugin
