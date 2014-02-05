local Main = Game:addState('Main')
Game.static.WIDTH = 16
Game.static.HEIGHT = 16

function Main:enteredState()
  love.physics.setMeter(Game.HEIGHT)
  World = love.physics.newWorld(0, 10 * Game.HEIGHT, true)
  World:setCallbacks(
    function(a, b, c) self:begin_contact(a, b, c) end,
    function(a, b, c) self:end_contact(a, b, c) end
  )

  self.default_font = g.newFont(12)
  g.setFont(self.default_font)

  self.width, self.height = Game.WIDTH, Game.HEIGHT
  self.tile_width, self.tile_height = 16, 16
  self.pixel_width, self.pixel_height = self.width * self.tile_width, self.height * self.tile_height

  self.generator = Generator:new()
  self:new_map(3, 3)

  love.window.setMode(self.pixel_width * 3, self.pixel_height * 3)
end

function Main:update(dt)
  World:update(dt)

  if self.circle then
    local cx, cy = self.circle.body:getWorldCenter()
    cx, cy = cx - g.getWidth() / 2, cy - g.getHeight() / 2
    self.camera:setPosition(cx, cy)
  end
end

function Main:render()
  self.camera:set()

  self.map:render()

  if self.circle then
    self.circle:render()
  end

  self.camera:unset()
end

function Main:new_map(w, h)
  self.map = Map:new({
    width = Game.WIDTH,
    height = Game.HEIGHT
  })
  for x=1,w do
    for y=1,h do
      local section = self.generator:generate(self.width, self.height)
      self.map:add_section(x, y, section)
    end
  end
  -- self.camera:setPosition(self.pixel_width, self.pixel_height)
end

function Main:mousepressed(x, y, button)
  x, y = self.camera:mousePosition(x, y)
  if self.circle then self.circle:destroy() end
  self.circle = Ball:new(x, y, 8)
end

function Main:mousereleased(x, y, button)
end

function Main:keypressed(key, unicode)
  if key == "r" then
    self.circle = nil
    for _,body in ipairs(World:getBodyList()) do
      body:destroy()
    end
    self:new_map(3, 3)
  end
end

function Main:keyreleased(key, unicode)
end

function Main:joystickpressed(joystick, button)
end

function Main:joystickreleased(joystick, button)
end

function Main:focus(has_focus)
end

function Main:begin_contact(fixture_a, fixture_b, contact)
  local object_one, object_two = fixture_a:getUserData(), fixture_b:getUserData()

  if object_one and is_func(object_one.begin_contact) then
    object_one:begin_contact(object_two, contact)
  end

  if object_two and is_func(object_two.begin_contact) then
    object_two:begin_contact(object_one, contact)
  end
end

function Main:end_contact(fixture_a, fixture_b, contact)
  local object_one, object_two = fixture_a:getUserData(), fixture_b:getUserData()

  if object_one and is_func(object_one.end_contact) then
    object_one:end_contact(object_two, contact)
  end

  if object_two and is_func(object_two.end_contact) then
    object_two:end_contact(object_one, contact)
  end
end

function Main:exitedState()
  Collider:clear()
  Collider = nil
end

return Main
