local class = require "middleclass"
local mongo = require "mongo"

local Database = class("Database")

function Database:initialize()
    local client = mongo.Client("mongodb://127.0.0.1")
    local dbName = "virtual-pet"
    self.users = client:getCollection(dbName, "users")
    self.pets = client:getCollection(dbName, "pets")
    self.minigames = client:getCollection(dbName, "minigames")
end

db = Database:new()
