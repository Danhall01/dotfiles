local config = {}

config.terminal = "kitty"
config.file_manager = "nemo"
config.browser = "firefox"
config.music_player = "spotify"
config.game_launcher = { "lutris", "steam" }
config.social_chat = "discord"
config.note_taker = "obsidian"

config.launcher = "rofi -show drun -show-icons"
config.runner = "rofi -show run"

config.autostart_apps = {
    --["kitty"] = {workspace = 6},
}

return config
