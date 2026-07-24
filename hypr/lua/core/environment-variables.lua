local plugin = {}
plugin.setup = function(config)
    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

    hl.env("XCURSOR_SIZE", "30")
    hl.env("HYPRCURSOR_SIZE", "30")
    hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

    hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
    hl.env("XDG_SESSION_TYPE", "wayland")
    hl.env("XDG_SESSION_DESKTOP", "Hyprland")
end
plugin.init = function(opts) end


return plugin
