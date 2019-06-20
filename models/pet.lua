local class = require "libs/middleclass"
local PetState = require "models/pet-state"

local Pet = class("Pet")

function Pet:initialize(name)
    self.name = name
    self.birthday = os.time()
    self.state = PetState.NORMAL
    self.happiness = 100
    self.hunger = 100
    self.health = 100
    -- self.minigames = {}
end

return Pet
