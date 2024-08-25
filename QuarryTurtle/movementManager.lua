movementManager = {}

function movementManager.lol()
  print("penis")
  print(configMenu.forward_blocks)
end

function movementManager.dig_big_row()
  local goal
  if telemetryManager.current_y == configMenu.forward_blocks then
    goal = 1
  else
    goal = configMenu.forward_blocks
  end

  while telemetryManager.current_y ~= goal do
    local succes, block = turtle.inspectDown()
    if succes and block.name == "minecraft:bedrock" then
      telemetryManager.foundBedrock = true
    end
    turtle.dig()
    turtle.forward()
    telemetryManager.update(1,0,0)
    turtle.turnLeft()
    telemetryManager.update(0,0,-1)
    turtle.dig()
    turtle.turnRight()
    telemetryManager.update(0,0,1)
    turtle.turnRight()
    telemetryManager.update(0,0,1)
    turtle.dig()
    turtle.turnLeft()
    telemetryManager.update(0,0,-1)
  end
end

function movementManager.dig_small_row()
  local goal
  if telemetryManager.current_y == configMenu.forward_blocks then
    goal = 1
  else
    goal = configMenu.forward_blocks
  end

  while telemetryManager.current_y ~= goal do
    turtle.dig()
    turtle.forward()
    telemetryManager.update(1,0,0)
  end
end

function movementManager.turn(next_big, next_small) 
  repeat 
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  until telemetryManager.current_orientation == 1

  if next_big > 0 then
    turtle.forward()
    telemetryManager.update(1,0,0)
    turtle.dig()
    turtle.forward()
    telemetryManager.update(1,0,0)
    turtle.dig()
    turtle.forward()
    telemetryManager.update(1,0,0)
    turtle.dig()
    telemetryManager.update(1,0,0)
  elseif next_small > 0 then
    local succes, reason = turtle.forward()
    if succes == true then
      telemetryManager.update(1,0,0)
    end
    turtle.dig()
    turtle.forward()
    telemetryManager.update(1,0,0)
  end

  if telemetryManager.current_y == configMenu.forward_blocks then
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  else
    turtle.turnLeft()
    telemetryManager.update(0,0,-1)
  end
end

function movementManager.returnToStart()
  repeat 
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  until telemetryManager.current_orientation == 2

  while telemetryManager.current_y ~= 1 do
    turtle.forward()
    telemetryManager.update(1,0,0)
  end

  repeat 
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  until telemetryManager.current_orientation == 3

  while telemetryManager.current_x ~= 2 do
    turtle.forward()
    telemetryManager.update(1,0,0)
  end

  repeat 
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  until telemetryManager.current_orientation == 2

  turtle.dig()
  turtle.forward()
  telemetryManager.update(1,0,0)
  turtle.digDown()
  turtle.down()
  telemetryManager.update(0,1,0)

  repeat 
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  until telemetryManager.current_orientation == 0
end