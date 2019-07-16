
local rates = require "rates"
local PetState = require "./models/pet-state"
local Pet = require "./models/pet"

-- local user1 = db.users:findOne {username = "jorge"}
-- print(user1)
-- user1 = db.users:findOne {username = "jorgesad"}

local ui
local pet


function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("VirtualPet")

    cureIcon = love.graphics.newImage "assets/actions/cure.png"
    feedIcon = love.graphics.newImage "assets/actions/feed.png"
    lightsIcon = love.graphics.newImage "assets/actions/lights.png"
    playIcon = love.graphics.newImage "assets/actions/play.png"
    poopIcon = love.graphics.newImage "assets/actions/poop.png"
    washIcon = love.graphics.newImage "assets/actions/wash.png"

    happyIcon = love.graphics.newImage "assets/indicators/happy.png"
    foodIcon = love.graphics.newImage "assets/indicators/food.png"
    heartIcon = love.graphics.newImage "assets/indicators/heart.png"


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
    love.graphics.rectangle("line", x, y, 150, 1)

    if percent < 25 then
        love.graphics.setColor(255 / 255, 0, 0)
    elseif percent < 50 then
        love.graphics.setColor(127 / 255, 127 / 255, 0)
    elseif percent < 75 then
        love.graphics.setColor(0, 127 / 255, 0)
    else
        love.graphics.setColor(0, 255 / 255, 0)
    end

    love.graphics.rectangle("line", x, y, (percent / 100) * 150, 1)
    love.graphics.setColor(255, 255, 255)
end

function love.draw()
    -- love.graphics.draw(background, 0, 160)
    -- love.graphics.draw(header, 0, 0)
    -- love.graphics.draw(header, 0, 660)
    love.graphics.setColor(5/255, 6 / 255, 8/255)
    love.graphics.rectangle("fill", 0, 0, 800, 100)



    love.graphics.setColor(255, 255, 255)

    draw_bar(20, 20, pet.happiness)
    draw_bar(20, 50, pet.hunger)
    draw_bar(20, 80, pet.health)

    love.graphics.draw(foodIcon, 190, 10, 0, 0.65, 0.65)
    love.graphics.draw(happyIcon, 190, 40, 0, 0.65, 0.65)
    love.graphics.draw(heartIcon, 190, 70, 0, 0.65, 0.65)

    local lifetime = math.floor((os.time() - pet.birthday) / 60)

    love.graphics.print(pet.name, 280, 20, 0, 2, 2, 0, 0)
    love.graphics.print(lifetime .. " minutos de vida", 280, 55, 0, 1.2, 1.2, 0, 0)

    love.graphics.draw(cureIcon, 480, 35, 0, 0.5, 0.5)
    love.graphics.draw(feedIcon, 530, 35, 0, 0.5, 0.5)
    love.graphics.draw(lightsIcon, 580, 35, 0, 0.5, 0.5)
    love.graphics.draw(playIcon, 630, 35, 0, 0.5, 0.5)
    love.graphics.draw(poopIcon, 680, 35, 0, 0.5, 0.5)
    love.graphics.draw(washIcon, 730, 35, 0, 0.5, 0.5)


    love.graphics.setBackgroundColor(43 / 255, 33 / 255, 33 / 255, 0)
end
