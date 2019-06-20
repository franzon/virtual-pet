local enum = require "../libs/enum"
local PetState = enum.new("PetState", {"NORMAL", "SICK", "TIRED", "SAD", "SLEEPING", "DEAD"})

return PetState
