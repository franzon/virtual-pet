local class = require "libs/middleclass"
local PetState = require "models/pet-state"
local PetAction = require "models/pet-action"

local Pet = class("Pet")

function Pet:initialize(name)
    self.name = name
    self.birthday = os.time()
    self.state = PetState.NORMAL
    self.action = PetState.NORMAL
    self.happiness = 80
    self.hunger = 80
    self.health = 80
    self.sleep_timer = os.time()
    self.play_timer = os.time()
    self.dirty_timer = os.time()

    -- self.minigames = {}
end

return Pet
