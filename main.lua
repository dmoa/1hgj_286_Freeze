la = love.audio
ld = love.data
le = love.event
lfile = love.filesystem
lf = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmouse = love.mouse
lp = love.physics
lsound = love.sound
lsys = love.system
lth = love.thread
lt = love.timer
ltouch = love.touch
lv = love.video
lw = love.window

lg.setDefaultFilter("nearest", "nearest", 1)
lg.setLineStyle('rough')

splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 3, {}, function()

ROOT2 = 1.41421356237

input = require "libs/input"
require "libs/AABB"

push = require "libs/push"
game_width, game_height = 512, 512
window_width, window_height = 512, 512
lw.setMode(window_width, window_height, {borderless = false})
push:setupScreen(game_width, game_height, window_width, window_height, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())


player = require "Player"
enemies = require "Enemies"
enemies:Init()


font = love.graphics.newFont(30)

highscore = 0
score = 0
timer = 30

font2 = lg.newFont(18)

playing = false
starting_img = lg.newImage("starting.jpg")

function love.draw()
    screen:apply()
    push:start()

    if not playing then
        lg.draw(starting_img)

        lg.print("Tired of leaders imploding your bountiful harvest?\nThis is the game for you!\nWASD/Arrow Keys to move\nClick to send an ice cube towards a foreign leader!\nMore frozen leaders means you can increase GDP!\nSpace to Start\n\nHighscore: "..highscore, font2, 5, 200)
    else

        player:Draw()
        enemies:Draw()

        lg.print("GDP: $"..score, font, 15, 55)
        lg.print("timer: "..math.floor(timer), font, 15, 15)

    end

    push:finish()
end

function love.update(dt)
    if score > highscore then highscore = score end
    screen:update(dt)

    if playing then

        player:Update(dt)
        enemies:Update(dt)

        local all = true
        for k, v in ipairs(enemies.enemies) do
            if not v.frozen then
                all = false
                break
            end
        end
        if all then
            enemies:Init()
            player.ices = {}
        end

        timer = timer - dt
        if timer < 0 then
            timer = 0
            playing = false
        end
    end

end

function start()
    score = 0
    player.ices = {}
    enemies:Init()
    playing = true
    timer = 30
end


function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
    if key == "space" then start() end
end

function love.resize(w, h)
  push:resize(w, h)
  lg.clear()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        player:NewIce()
    end
end


end)
