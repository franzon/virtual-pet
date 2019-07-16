local class = require "libs/middleclass"

local UserManagement = class("userManagement")

function UserManagement:initialize()
end

function UserManagement:newUser(name, password)
    local file, err = io.open ('users.txt',"w")
    
    if file==nil then
        print("Couldn't open file: "..err)
    else
        file:write(name .. ";" .. password .. "\n")
        file:close()
    end
end

return UserManagement