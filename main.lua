local db = require "database-setup"
local nuklear = require "nuklear"
local Pet = require "./models/pet"

-- local user1 = db.users:findOne {username = "jorge"}
-- print(user1)
-- user1 = db.users:findOne {username = "jorgesad"}

local ui
local pet

local colors = {
    ["text"] = "#afafaf",
    ["window"] = "#f2f6fc",
    ["header"] = "#282828",
    ["border"] = "#414141",
    ["button"] = "#323232",
    ["button hover"] = "#282828",
    ["button active"] = "#232323",
    ["toggle"] = "#646464",
    ["toggle hover"] = "#787878",
    ["toggle cursor"] = "#2d2d2d",
    ["select"] = "#2d2d2d",
    ["select active"] = "#232323",
    ["slider"] = "#262626",
    ["slider cursor"] = "#646464",
    ["slider cursor hover"] = "#787878",
    ["slider cursor active"] = "#969696",
    ["property"] = "#262626",
    ["edit"] = "#262626",
    ["edit cursor"] = "#afafaf",
    ["combo"] = "#2d2d2d",
    ["chart"] = "#787878",
    ["chart color"] = "#2d2d2d",
    ["chart color highlight"] = "#ff0000",
    ["scrollbar"] = "#282828",
    ["scrollbar cursor"] = "#646464",
    ["scrollbar cursor hover"] = "#787878",
    ["scrollbar cursor active"] = "#969696",
    ["tab header"] = "#282828"
}

function love.load()
    love.window.setMode(250, 400)
    love.window.setTitle("VirtualPet 3000")

    ui = nuklear.newUI()
    ui:styleLoadColors(colors)

    pet = Pet:new("Jorge")

    print(pet.state)
end

local combo = {value = 1, items = {"A", "B", "C"}}

function love.update(dt)
    ui:frameBegin()
    if ui:windowBegin("VirtualPet 3000", 0, 0, 250, 400) then
        ui:layoutRow("dynamic", 30, 1)
        ui:label("Hello, world!")
    -- ui:layoutRow("dynamic", 30, 2)
    -- ui:label("Combo box:")
    -- if ui:combobox(combo, combo.items) then
    --     print("Combo!", combo.items[combo.value])
    -- end
    -- ui:layoutRow("dynamic", 30, 3)
    -- ui:label("Buttons:")
    -- if ui:button("Sample") then
    --     print("Sample!")
    -- end
    -- if ui:button("Button") then
    --     print("Button!")
    -- end
    end
    ui:windowEnd()
    ui:frameEnd()
end

function love.draw()
    ui:draw()
end

function love.keypressed(key, scancode, isrepeat)
    ui:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    ui:keyreleased(key, scancode)
end

function love.mousepressed(x, y, button, istouch, presses)
    ui:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
    ui:mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
    ui:mousemoved(x, y, dx, dy, istouch)
end

function love.textinput(text)
    ui:textinput(text)
end

function love.wheelmoved(x, y)
    ui:wheelmoved(x, y)
end
