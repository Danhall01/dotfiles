local plugin = {}
plugin.setup = function(config)
    hl.config {
        input = {
            kb_layout          = "se",
            kb_variant         = "",
            kb_model           = "",
            kb_options         = "",
            kb_rules           = "",

            repeat_rate        = 25,
            repeat_delay       = 250,

            numlock_by_default = false,

            follow_mouse       = 1,

            sensitivity        = 0, -- -1.0 - 1.0, 0 means no modification.
            accel_profile      = "flat",

            touchpad           = {
                natural_scroll = false,
                -- scroll_factor = 0.2,
            },
        },
    }

    -- Example per-device config
    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
    hl.device {
        name          = "corsair-corsair-darkstar-rgb-wireless-gaming-mouse-3",
        sensitivity   = 0,
        accel_profile = "flat",
    }
    hl.device {
        name = "corsair-corsair-slipstream-wireless-usb-receiver",
        sensitivity = 0,
        accel_profile = "flat",
    }
end
plugin.init = function(opts) end


return plugin
