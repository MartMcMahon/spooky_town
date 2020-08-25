assets = require('cargo').init('assets')
Animation = require('animation') vector = require('hump.vector') Camera =
require('hump.camera')

local lg = love.graphics local pi = 3.14

player = {pos = vector(0, 0), direction = 0}

function love.load(args)

  camera = Camera(player.pos.x, player.pos.y)

  window = { w = lg.getWidth(), h = lg.getHeight() }

  -- image refs
  grass_tile = assets.spooky.TileGrass
  floor_tile = assets.PVGames_Infernus_Free.Infernus_Tiles.Building_Infernus_1.Floor_Lower_1
  dude_image = assets.Medieval_Warfare_Templar.Warfare.Medieval_Warfare_Humans.Medieval_Warfare_PremadeCharacters.Medieval_Warfare_Premade_Male_1.Medieval_Warfare_Premade_Male_1_walking
  dude_diag = assets.Medieval_Warfare_Templar.Warfare.Medieval_Warfare_Humans.Medieval_Warfare_PremadeCharacters.Medieval_Warfare_Premade_Male_1.Medieval_Warfare_Premade_Male_1_walking_diag

  dude_anim = Animation(dude_image, dude_diag, 128, 128, 1)
  -- PlayerAnimation = require('playerAnimation')
  -- t = PlayerAnimation(dude_image, 128, 128, 1)
  -- t:setup(dude_image, dude_diag)
end

function player:update(dt)
  -- player.pos = player.pos + (player.destination - player.pos):normalized()
  -- x = player.destination - player.pos
  -- print(x)
  -- print(x:normalized())
end
function player:set_direction(vec, isCameraCoords)
  local v = vec
  if isCameraCoords then
    v = vector(camera:worldCoords(vec)) - (player.pos + dude_anim.offset)
  end
  player.direction = (math.floor(v:toPolar().x / (pi/4) + pi/8) + 4) % 8
  print(player.direction)
end

function player:moveTo(x, y)

end

function love.update(dt)
  local dx, dy = player.pos.x - camera.x, player.pos.y - camera.y
  camera:move(dx/2, dy/2)

  player.update(dt)
  -- dude_anim.mode = player.direction
  dude_anim:update(dt)

  -- print('mode', dude_anim.mode)
  -- x, y = love.mouse.getPosition()
  -- local v = vector(camera:worldCoords(x,y)) - (player.pos + dude_anim.offset)
  -- v = math.floor(v:toPolar().x / (pi/4) + pi/8)
  -- print('direction', v)

end

function love.mousepressed(x, y)
  local v = vector(camera:worldCoords(x,y)) - (player.pos + dude_anim.offset)
  print(v)
  player:set_direction(v)
end

function love.draw()
  camera:attach()

  dude_anim:draw(player.direction)

  camera:detach()
end

function love.keypressed(key)
  print(key)
end
