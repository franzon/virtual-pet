local class = require "libs/middleclass"
local PetState = require "models/pet-state"

local Pet = class("Pet")

function Pet:initialize(name)
    self.name = name
    self.birthday = os.time()
    self.state = PetState.NORMAL
    self.happiness = 80
    self.hunger = 0
    self.health = 100
    -- self.minigames = {}
end

return Pet
