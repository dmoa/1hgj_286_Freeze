local Player = {
    x = 50,
    y = 50,
    v = 400,
    xv = 0,
    yv = 0,
    image = lg.newImage("player.jpg"),
    ice = require "Ice",
    ices = {}
}

function Player:Draw()
    lg.draw(self.image, self.x, self.y)

    for _, v in ipairs(self.ices) do
        v:Draw()
    end
end

function Player:NewIce()
    local ice = self.ice:New()
    ice:Init()

    table.insert(self.ices, ice)
end

function Player:Update(dt)
    self.xv = 0
    self.yv = 0

    if not (input.right() and input.left()) and (input.left() or input.right()) then
        if input.right() then
            self.xv = self.v
        else
            self.xv = - self.v
        end
    end
    if not (input.down() and input.up()) and (input.up() or input.down()) then
        if input.down() then
            self.yv = self.v
        else
            self.yv = - self.v
        end
    end

    if self.x < 0 then self.x = 0 end
    if self.y < 0 then self.y = 0 end
    if self.x + self.image:getWidth() > game_width then self.x = game_width - self.image:getWidth() end
    if self.y + self.image:getHeight() > game_height then self.y = game_height - self.image:getHeight() end


    self.x = self.x + self.xv * dt
    self.y = self.y + self.yv * dt


    for i, v in ipairs(self.ices) do
        v:Update(dt)
        if v:Out() then
            table.remove(self.ices, i)
        end
    end
end



return Player