local rates = require "rates"
local PetState = require "./models/pet-state"
local PetAction = require "./models/pet-action"
local Pet = require "./models/pet"

local ui
local pet

function love.conf(t)
    t.console = true
end

function love.load()
    animation = newAnimation(love.graphics.newImage("/assets/sprites/normal.png"), 32, 32, 1)
    love.window.setMode(800, 600)
    love.window.setTitle("VirtualPet")

    cureIcon = {img = love.graphics.newImage("assets/actions/cure.png"), x = 480, y = 35}
    feedIcon = {img = love.graphics.newImage("assets/actions/feed.png"), x = 530, y = 35}
    lightsIcon = {img = love.graphics.newImage("assets/actions/lights.png"), x = 580, y = 35}
    playIcon = {img = love.graphics.newImage("assets/actions/play.png"), x = 630, y = 35}
    poopIcon = {img = love.graphics.newImage("assets/actions/poop.png"), x = 680, y = 35}
    washIcon = {img = love.graphics.newImage("assets/actions/wash.png"), x = 730, y = 35}

    happyIcon = love.graphics.newImage "assets/indicators/happy.png"
    foodIcon = love.graphics.newImage "assets/indicators/food.png"
    heartIcon = love.graphics.newImage "assets/indicators/heart.png"

    pet = Pet:new("Jorge")
    print(pet.state)
end

function game_logic(dt)
    if pet.state.value == PetState.NORMAL.value then
        pet.happiness = pet.happiness - (rates.HAPPINESS_RATE * dt)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt)
        pet.health = pet.health - (rates.HEALTH_RATE * dt)
    elseif pet.state.value == PetState.SICK.value then
        pet.happiness = pet.happiness - (rates.HAPPINESS_RATE * dt * 2)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt * 0.8)
        pet.health = pet.health - (rates.HEALTH_RATE * dt * 1.5)
    elseif pet.state.value == PetState.TIRED.value then
        pet.happiness = pet.happiness - (rates.HAPPINESS_RATE * dt * 2)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt * 1.5)
        pet.health = pet.health - (rates.HEALTH_RATE * dt)
    elseif pet.state.value == PetState.DIRTY.value then
        pet.happiness = pet.happiness - (rates.HAPPINESS_RATE * dt * 1.5)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt)
        pet.health = pet.health - (rates.HEALTH_RATE * dt * 2)
    elseif pet.state.value == PetState.SAD.value then
        pet.happiness = pet.happiness - (rates.HAPPINESS_RATE * dt * 2)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt * 1.5)
        pet.health = pet.health - (rates.HEALTH_RATE * dt * 1.5)
    elseif pet.state.value == PetState.SLEEPING.value then
        pet.happiness = pet.happiness + (rates.HAPPINESS_RATE * dt * 2)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt * 0.5)
        pet.health = pet.health + (rates.HEALTH_RATE * dt * 2)

        if os.time() - pet.sleep_timer > rates.SLEEP_DURATION then
            pet.state = PetState.NORMAL
            print "acorda bro"
        end
    elseif pet.state.value == PetState.PLAYING.value then
        pet.happiness = pet.happiness + (rates.HAPPINESS_RATE * dt * 4)
        pet.hunger = pet.hunger - (rates.HUNGER_RATE * dt * 1.5)
        pet.health = pet.health + (rates.HEALTH_RATE * dt)

        if os.time() - pet.play_timer > rates.PLAY_DURATION then
            pet.state = PetState.NORMAL
            print "acabou a brincadeira bro"
        end
    elseif pet.state.value == PetState.DEAD.value then
        print "morreu playboy"
    end

    -- health = 0 morre
    if pet.health <= 0 then
        pet.state = PetState.DEAD
    end

    -- happiness = 0 fica sadboy
    if pet.happiness <= 0 then
        pet.state = PetState.SAD
    end

    -- hunher = 0 ou  hunger > 90 ou health = 0 fica doente
    if pet.hunger <= 0 or pet.health < 20 or pet.hunger > 90 then
        pet.state = PetState.SICK
    end

    -- fica sujo a cada intervalo de tempo
    if pet.state ~= PetState.DIRTY then
        if os.time() - pet.dirty_timer > rates.DIRTY_INTERVAL then
            pet.state = PetState.DIRTY
        end
    end

    if pet.health > 100 then
        pet.health = 100
    end

    if pet.happiness > 100 then
        pet.happiness = 100
    end

    if pet.hunger > 100 then
        pet.hunger = 100
    end

    print(pet.state)
end

function love.update(dt)
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
    game_logic(dt)
end

function draw_bar(x, y, percent)
    love.graphics.setColor(127 / 255, 127 / 255, 127 / 255)
    love.graphics.rectangle("line", x, y, 150, 1)

    if percent < 0 then
        percent = 0
    elseif percent < 25 then
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
    love.graphics.setColor(5 / 255, 6 / 255, 8 / 255)
    love.graphics.rectangle("fill", 0, 0, 800, 100)

    love.graphics.setColor(255, 255, 255)

    draw_bar(20, 20, pet.happiness)
    draw_bar(20, 50, pet.hunger)
    draw_bar(20, 80, pet.health)

    love.graphics.draw(happyIcon, 190, 10, 0, 0.65, 0.65)
    love.graphics.draw(foodIcon, 190, 40, 0, 0.65, 0.65)
    love.graphics.draw(heartIcon, 190, 70, 0, 0.65, 0.65)

    local lifetime = math.floor((os.time() - pet.birthday) / 60)

    love.graphics.print(pet.name, 280, 20, 0, 2, 2, 0, 0)
    love.graphics.print(lifetime .. " minutos de vida", 280, 55, 0, 1.2, 1.2, 0, 0)

    love.graphics.draw(cureIcon.img, cureIcon.x, cureIcon.y, 0, 1, 1)
    love.graphics.draw(feedIcon.img, feedIcon.x, feedIcon.y, 0, 1, 1)
    love.graphics.draw(lightsIcon.img, lightsIcon.x, lightsIcon.y, 0, 1, 1)
    love.graphics.draw(playIcon.img, playIcon.x, playIcon.y, 0, 1, 1)
    love.graphics.draw(poopIcon.img, poopIcon.x, poopIcon.y, 0, 1, 1)
    love.graphics.draw(washIcon.img, washIcon.x, washIcon.y, 0, 1, 1)

    love.graphics.setBackgroundColor(43 / 255, 33 / 255, 33 / 255, 0)
    love.graphics.translate(350, 320)
    if pet.state == PetState.NORMAL then
        local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
        love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], 0, 0, 0, 4)

    end
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end


function action(type)
    if type == "cure" then
        if pet.health > 85 then
            pet.health = 20
            pet.state = PetState.SICK
        else
            pet.health = pet.health + 20
        end
    elseif type == "feed" then
        pet.hunger = pet.hunger + 20
    elseif type == "lights" then
        pet.state = PetState.SLEEPING
        pet.sleep_timer = os.time()
    elseif type == "play" then
        -- implementar minigame
        pet.state = PetState.PLAYING
        pet.play_timer = os.time()
    elseif type == "poop" then
        pet.state = PetState.DIRTY
    elseif type == "wash" then
        pet.health = pet.health + 10
        pet.state = PetState.NORMAL
        pet.dirty_timer = os.time()
    end
end

function checkIconPressed(mx, my, icon)
    return mx >= icon.x and mx < icon.x + icon.img:getWidth() and my >= icon.y and my < icon.y + icon.img:getHeight()
end

function love.mousepressed(mx, my, button)
    if button == 1 then
        if checkIconPressed(mx, my, cureIcon) then
            action("cure")
        elseif checkIconPressed(mx, my, feedIcon) then
            action("feed")
        elseif checkIconPressed(mx, my, lightsIcon) then
            action("lights")
        elseif checkIconPressed(mx, my, playIcon) then
            action("play")
        elseif checkIconPressed(mx, my, poopIcon) then
            action("poop")
        elseif checkIconPressed(mx, my, washIcon) then
            action("wash")
        end
    end
end
