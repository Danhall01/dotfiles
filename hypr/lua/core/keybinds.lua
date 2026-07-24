local plugin = {}
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local secondMod = mainMod .. " + SHIFT"

local function launch_program(programs)
    if type(programs) == "string" then
        return (function()
            hl.dispatch(hl.dsp.exec_cmd(programs))
        end)
    end
    if type(programs) == "table" then
        return function()
            for _, app in pairs(programs) do
                hl.dispatch(hl.dsp.exec_cmd(app))
            end
        end
    end
    return function()
        hl.notification.create({ text = "Invalid type for " .. tostring(programs), timeout = 2000 })
    end
end


plugin.setup = function(config)
    -- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
    hl.bind(mainMod .. " + T", launch_program(config.programs.terminal))
    hl.bind(mainMod .. " + F", launch_program(config.programs.file_manager))
    hl.bind(mainMod .. " + B", launch_program(config.programs.browser))
    hl.bind(mainMod .. " + M", launch_program(config.programs.music_player))
    hl.bind(mainMod .. " + G", launch_program(config.programs.game_launcher))
    hl.bind(mainMod .. " + C", launch_program(config.programs.social_chat))
    hl.bind(mainMod .. " + N", launch_program(config.programs.note_taker))

    hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(config.programs.launcher))
    hl.bind(secondMod .. " + S", hl.dsp.exec_cmd(config.programs.runner))

    hl.bind(mainMod .. " + Q", hl.dsp.window.close())

    -- closeWindowBind:set_enabled(false)
    hl.bind(secondMod .. " + Q",
        hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
    hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
    -- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

    -- Move focus with mainMod + arrow keys
    hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

    hl.bind(secondMod .. " + h", hl.dsp.window.move({ direction = "left" }))
    hl.bind(secondMod .. " + l", hl.dsp.window.move({ direction = "right" }))
    hl.bind(secondMod .. " + k", hl.dsp.window.move({ direction = "up" }))
    hl.bind(secondMod .. " + j", hl.dsp.window.move({ direction = "down" }))

    hl.bind(secondMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(secondMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))


    hl.bind("Print", hl.dsp.exec_cmd("grimblast copysave area"))
    hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grimblast copy screen"))
    hl.bind(secondMod .. " + Print", hl.dsp.exec_cmd("grimblast copy active"))


    -- Switch workspaces with mainMod + [0-9]
    -- Move active window to a workspace with mainMod + SHIFT + [0-9]
    for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind(secondMod .. " + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
    end

    -- Example special workspace (scratchpad)
    hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("gaming"))
    hl.bind(secondMod .. " + X", hl.dsp.window.move({ workspace = "special:gaming", follow = false }))

    -- Scroll through existing workspaces with mainMod + scroll
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Laptop multimedia keys for volume and LCD brightness
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
        { locked = true, repeating = true })

    -- Requires playerctl
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
end
plugin.init = function(opts) end


return plugin
