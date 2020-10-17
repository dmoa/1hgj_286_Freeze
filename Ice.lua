local Ice = {
    x = -50,
    y = -50,
    xv = 0,
    yv = 0,
    image = lg.newImage("ice.jpg"),
    dest_x = -1,
    dest_y = -1,
    max_v = 100
}

function Ice:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Ice:Init()
    self.x = player.x
    self.y = player.y
    self.dest_x = love.mouse.getX()
    self.dest_y = love.mouse.getY()

    self.xv = self.dest_x - self.x
    self.yv = self.dest_y - self.y

    local off = math.sqrt(self.xv*self.xv + self.yv*self.yv) / self.max_v

    self.xv = self.xv / off
    self.yv = self.yv / off

end

function Ice:Draw()
    lg.draw(self.image, self.x, self.y)
end

function Ice:Update(dt)
    self.x = self.x + self.xv * dt
    self.y = self.y + self.yv * dt

    for k, v in ipairs(enemies.enemies) do
        if AABB(self.x, self.y, self.image:getWidth(), self.image:getHeight(), v.x, v.y, 50, 50) then
            if not v.frozen then
                score = score + 1
                v.frozen = true
            end
        end
    end
end

function Ice:Out()
    return self.x + self.image:getWidth() < 0 or self.x > game_width or self.y + self.image:getHeight() < 0 or self.y > game_height
end

return Ice