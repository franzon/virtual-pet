local db = require "database-setup"
local nuklear = require "nuklear"
local rates = require "rates"
local PetState = require "./models/pet-state"
local Pet = require "./models/pet"

-- local user1 = db.users:findOne {username = "jorge"}
-- print(user1)
-- user1 = db.users:findOne {username = "jorgesad"}

local ui
local pet

local healthIcon = love.graphics.newImage "assets/heart.png"
local feedIcon = love.graphics.newImage "assets/feed.png"

local normalPicture = love.graphics.newImage "assets/normal.png"

local colors = {
    ["text"] = "#000000",
    ["window"] = "#f2f6fc",
    ["header"] = "#282828",
    ["border"] = "#414141",
    ["button"] = "#81858c",
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
    ["tab header"] = "#282828",
    ["progress"] = "#ff0000"
}

function love.load()
    love.window.setMode(300, 400)
    love.window.setTitle("VirtualPet 3000")

    ui = nuklear.newUI()
    ui:styleLoadColors(colors)

    pet = Pet:new("Jorge")
    print(pet.state)
end

local combo = {value = 1, items = {"A", "B", "C"}}

function game_logic(dt)
    if pet.state.value == PetState.NORMAL.value then
        -- pet.health = pet.health - (rates.HAPPINESS_RATE * dt)
        -- pet.hunger = pet.hunger - (1 * dt)
        pet.happiness = pet.happiness - (rates.HAPPINESS_RATE * dt)
    elseif pet.state.value == PetState.SICK.value then
    elseif pet.state.value == PetState.TIRED.value then
    elseif pet.state.value == PetState.SAD.value then
    elseif pet.state.value == PetState.SLEEPING.value then
    elseif pet.state.value == PetState.DEAD.value then
    end

    if pet.health == 0 then
        pet.state = PetState.DEAD
    end
end

function love.update(dt)
    ui:frameBegin()
    if ui:windowBegin("VirtualPet 3000", 0, 0, 300, 500) then
        ui:layoutRow("static", 25, {70, 150, 50})
        ui:label(pet.name, "left", nuklear.colorRGBA(0, 0, 255))

        local lifetime = os.time() - pet.birthday
        ui:label("Age: " .. math.floor(lifetime / 60) .. " minute(s)")
        ui:button("Exit")

        ui:layoutRow("dynamic", 5, 1)
        ui:spacing(1)

        ui:layoutRow("static", 15, {70, 150, 5, 20})
        ui:label("Health")
        ui:progress(pet.health, 100)
        ui:spacing(1)
        ui:image(healthIcon)

        ui:layoutRow("static", 15, {70, 150, 5, 20})
        ui:label("Happiness")
        ui:progress(pet.happiness, 100)
        ui:spacing(1)
        ui:image(healthIcon)

        ui:layoutRow("static", 15, {70, 150, 5, 20})
        ui:label("Hunger")
        ui:progress(pet.hunger, 100)
        ui:spacing(1)
        ui:image(healthIcon)

        ui:layoutRow("dynamic", 20, 1)
        ui:spacing(1)

        ui:layoutRow("static", 100, {50, 200, 50})
        ui:spacing(1)
        ui:image(normalPicture)
        ui:spacing(1)

        ui:layoutRow("dynamic", 30, 5)
        ui:image(feedIcon)
        ui:image(feedIcon)
        ui:image(feedIcon)
        ui:image(feedIcon)
        ui:image(feedIcon)

        game_logic(dt)
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
