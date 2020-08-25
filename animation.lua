local Object = require('classic')
local vector = require('hump.vector')
Animation = Object.extend(Object)
local lg = love.graphics

Animation.directionMap = { 3, 5, 1, 4, 0, 6, 2, 7 }

function Animation:new(image, diag, frame_width, frame_height, duration)
  file_w, file_h = image:getDimensions()

  self.cardinal_image = image
  self.diag_image = diag
  self.quads ={}
  self.size = {w = frame_width, h = frame_height}
  self.offset = vector(frame_width/2, frame_height/2)
  self.currentTime = 0
  self.duration = duration
  self.direction = 0
  self.mode = 0

  for y=0, (file_h / self.size.h)*2 - 1 do
    print('y', y)
    self.quads[y] = {}
    for x=0, file_w / self.size.w -1 do
      table.insert(self.quads[y], lg.newQuad(x*self.size.w, (y%4)*self.size.h, self.size.w, self.size.h, file_w, file_h))
    end
  end
end

function Animation:update(dt)
  self.currentTime = self.currentTime + dt
  if self.currentTime >= self.duration then
    self.currentTime = self.currentTime - self.duration
  end
end

function Animation:draw(direction)
  local image
  if direction % 2 == 0 then
    image = self.cardinal_image
  else
    image = self.diag_image
  end

  self.mode = self.directionMap[direction + 1]
  local n = math.floor(self.currentTime / self.duration * #self.quads[self.mode]) + 1
  lg.draw(image, self.quads[self.mode][n])
end

return Animation
