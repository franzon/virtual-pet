return function()
    mainSound = love.audio.newSource("/assets/sounds/main_sound.mp3", "stream")
    love.audio.play(mainSound)
end