local plugin = {}
plugin.setup = function(config)
    function autolaunch(apps)
        for app, field in pairs(apps) do
            hl.exec_cmd(app)
            hl.window_rule({
                name = "startup_apps",
                match = {
                    class = app,
                },
                workspace = field.workspace .. " silent",
            })
        end
    end


    hl.on("hyprland.start", function () 
        hl.exec_cmd("waybar")
        hl.exec_cmd("systemctl --user start hyprpolkitagent")
        hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 30")


        autolaunch(config.programs.autostart_apps)
    end)
end
plugin.init = function(opts) end


return plugin
