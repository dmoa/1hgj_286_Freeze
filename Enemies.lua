local Enemies = {
    enemies = {},
    images = {}
}

function Enemies:Init()
    self.enemies = {}
    for i = 1, 4 do
        table.insert(self.images, lg.newImage("enemy"..tostring(i)..".jpg"))
    end
    for i = 1, 10 do
        self:AddEnemy()
    end
end

function Enemies:AddEnemy()
    table.insert(self.enemies, {x = lm.random(game_width), y = lm.random(game_height), image = self.images[lm.random(1, 4)], frozen = false})
end

function Enemies:Draw()
    for _, v in ipairs(self.enemies) do
        if v.frozen then
            lg.setColor(65 / 255,105 / 255,225 / 255, 1)
        else
            lg.setColor(1, 1, 1, 1)
        end
        lg.draw(v.image, v.x, v.y, 0, 0.5, 0.5)
    end
    lg.setColor(1, 1, 1, 1)
end

function Enemies:Update()
end

return Enemies