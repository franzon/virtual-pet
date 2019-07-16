local enum = require "../libs/enum"
local PetState = enum.new("PetState", {"NORMAL", "SICK", "TIRED", "DIRTY", "SAD", "SLEEPING", "DEAD", "PLAYING"})

return PetState
