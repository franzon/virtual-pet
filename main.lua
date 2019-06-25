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

function love.load()
    love.window.setMode(1000, 820)
    love.window.setTitle("VirtualPet 3000")

    background = love.graphics.newImage "assets/bg.jpg"
    header = love.graphics.newImage "assets/header.jpg"

    pet = Pet:new("Jorge")
    print(pet.state)
end

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

    if pet.health <= 0 then
        pet.state = PetState.DEAD
    end

    if pet.happiness <= 0 then
        pet.state = PetState.SAD
    end

    if pet.hunger <= 0 then
        pet.state = PetState.SICK
    end
end

function love.update(dt)
    game_logic(dt)
end

function draw_bar(x, y, percent)
    love.graphics.setColor(127 / 255, 127 / 255, 127 / 255)
    love.graphics.rectangle("line", x, y, 120, 1)

    if percent < 25 then
        love.graphics.setColor(255 / 255, 0, 0)
    elseif percent < 50 then
        love.graphics.setColor(127 / 255, 127 / 255, 0)
    elseif percent < 75 then
        love.graphics.setColor(0, 127 / 255, 0)
    else
        love.graphics.setColor(0, 255 / 255, 0)
    end

    love.graphics.rectangle("line", x, y, (percent / 100) * 120, 1)
    love.graphics.setColor(255, 255, 255)
end

function love.draw()
    love.graphics.draw(background, 0, 160)
    love.graphics.draw(header, 0, 0)
    love.graphics.draw(header, 0, 660)

    draw_bar(260, 60, pet.happiness)
    draw_bar(260, 75, pet.hunger)
    draw_bar(260, 90, pet.health)

    local lifetime = math.floor((os.time() - pet.birthday) / 60)

    love.graphics.print(pet.name, 500, 63, 0, 1.25, 1.25, 0, 0)
    love.graphics.print(lifetime .. " minutos de vida", 470, 85, 0, 1, 1, 0, 0)

    love.graphics.draw(feedIcon, 260, 700, 0, 0.5, 0.5) -- 0 is for rotation, see the wiki
end

-- function love.update(dt)
--     -- ui:frameBegin()
--     -- if ui:windowBegin("VirtualPet 3000", 0, 0, 300, 500) then
--     --     ui:layoutRow("static", 25, {70, 150, 50})
--     --     ui:label(pet.name, "left", nuklear.colorRGBA(0, 0, 255))
--     --     local lifetime = os.time() - pet.birthday
--     --     ui:label("Age: " .. math.floor(lifetime / 60) .. " minute(s)")
--     --     ui:button("Exit")
--     --     ui:layoutRow("dynamic", 5, 1)
--     --     ui:spacing(1)
--     --     ui:layoutRow("static", 15, {70, 150, 5, 20})
--     --     ui:label("Health")
--     --     ui:progress(pet.health, 100)
--     --     ui:spacing(1)
--     --     ui:image(healthIcon)
--     --     ui:layoutRow("static", 15, {70, 150, 5, 20})
--     --     ui:label("Happiness")
--     --     ui:progress(pet.happiness, 100)
--     --     ui:spacing(1)
--     --     ui:image(healthIcon)
--     --     ui:layoutRow("static", 15, {70, 150, 5, 20})
--     --     ui:label("Hunger")
--     --     ui:progress(pet.hunger, 100)
--     --     ui:spacing(1)
--     --     ui:image(healthIcon)
--     --     ui:layoutRow("dynamic", 20, 1)
--     --     ui:spacing(1)
--     --     ui:layoutRow("static", 100, {50, 200, 50})
--     --     ui:spacing(1)
--     --     ui:image(normalPicture)
--     --     ui:spacing(1)
--     --     ui:layoutRow("dynamic", 30, 5)
--     --     ui:image(feedIcon)
--     --     ui:image(feedIcon)
--     --     ui:image(feedIcon)
--     --     ui:image(feedIcon)
--     --     ui:image(feedIcon)
--     --     game_logic(dt)
--     -- end
--     -- ui:windowEnd()
--     -- ui:frameEnd()
-- end
