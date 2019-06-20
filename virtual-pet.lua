local mongo = require "mongo"
local client = mongo.Client("mongodb://127.0.0.1")

local Users = client:getCollection("virtual-pet", "users")

Users:insert {username = "jorge", password = "1234", pets = {__array = true, "a", "b"}}
