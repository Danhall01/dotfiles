local plugin = {}
plugin.setup = function(config)
    hl.config({
        misc = {
            force_default_wallpaper    = 2,     -- Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo      = false, -- If true disables the random hyprland logo / anime girl background. :(
            disable_splash_rendering   = true,

            mouse_move_focuses_monitor = false,

            on_focus_under_fullscreen  = 0, -- 0: stay behind fullscreen, 1: take over, 2: unfullscreen and focus
            initial_workspace_tracking = 2, -- 0: disabled, 1: single-shot, 2: persistent (all children too)
        },
        binds = {
            movefocus_cycles_fullscreen = true,
        },
    })
end
plugin.init = function(opts) end


return plugin
