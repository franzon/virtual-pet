local class = require "libs/middleclass"

local User = class("User")

function User:initialize(name, password, pets)
    self.name = name
    self.password = password
    self.pets = { pets }
end

return User