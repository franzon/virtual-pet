local enum = require "../libs/enum"
local PetAction = enum.new("PetAction", {"NORMAL", "CURING", "FEEDING", "SLEEPING", "PLAYING", "POOPING", "WASHING"})

return PetAction
