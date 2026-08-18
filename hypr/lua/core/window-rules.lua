local plugin = {}

local function defaultrules()
	local suppressMaximizeRule = hl.window_rule({
		-- Ignore maximize requests from all apps. You'll probably like this.
		name = "suppress-maximize-events",
		match = { class = ".*" },

		suppress_event = "maximize",
	})
	suppressMaximizeRule:set_enabled(false)

	hl.window_rule({
		-- Fix some dragging issues with XWayland
		name = "fix-xwayland-drags",
		match = {
			class = "^$",
			title = "^$",
			xwayland = true,
			float = true,
			fullscreen = false,
			pin = false,
		},

		no_focus = true,
	})

	-- Hyprland-run windowrule
	hl.window_rule({
		name = "move-hyprland-run",
		match = { class = "hyprland-run" },

		move = "20 monitor_h-120",
		float = true,
	})
end

local function gamerules()
	hl.window_rule({
		name = "games-title",
		match = {
			class = "gamescope",
		},
		workspace = "special:gaming silent",
		fullscreen = true,
		float = true,
		rounding = 0,
		border_size = 0,
		no_blur = true,
		no_shadow = true,
		no_anim = true,
	})
end

local function locationrules()
	-- Social workspace
	hl.window_rule({
		match = {
			class = "^(discord|Spotify)$",
		},
		workspace = "2 silent",
	})

	-- Launcher workspace
	hl.window_rule({
		match = {
			--class = "steam_app_default",
			title = "^(Battle.net|Battle.net Login)$",
		},
		workspace = "3 silent",
	})
	hl.window_rule({
		match = {
			class = "^(net.lutris.Lutris|steam)$",
		},
		workspace = "3 silent",
	})

	-- Error and useless workspace
	hl.window_rule({
		match = {
			class = "steam_app_default",
			title = "",
		},
		workspace = "5 silent",
	})
end

plugin.setup = function(config)
	-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
	-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

	defaultrules()
	gamerules()
	locationrules()
end

return plugin
