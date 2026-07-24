local config = {}
config.programs = require "lua.config.programs"
require "lua.core.init".setup(config)
require "lua.modules.init".setup(config)
