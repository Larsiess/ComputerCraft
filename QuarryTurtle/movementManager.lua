movementManager = {}

-- function movementManager.testCon()
--   print(movementManager.configMenu.forward_blocks)
-- end

function movementManager.dig_big_row(goal)
  if goal == nil then
    print("here")
    if telemetryManager.current_y == movementManager.configMenu.forward_blocks then
      goal = 1
    else
      goal = movementManager.configMenu.forward_blocks
    end
  end
  print("current_y " .. movementManager.configMenu.forward_blocks)
  print("goal " .. goal)

  local x = 0
  if(goal == 1) then
    x = 2
  else
    x = 0
  end
  if (telemetryManager.current_orientation == 1 and x == 0) or (telemetryManager.current_orientation == 3 and x == 2) then
    repeat
      turtle.turnRight()
      telemetryManager.update(0,0,1)
      turtle.dig()
    until telemetryManager.current_orientation == x
  end
  if (telemetryManager.current_orientation == 1 and x == 2) or (telemetryManager.current_orientation == 3 and x == 0)  then
    repeat
      turtle.turnLeft()
      telemetryManager.update(0,0,-1)
      turtle.dig()
    until telemetryManager.current_orientation == x
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

function movementManager.dig_small_row(goal)
  if goal == nil then
    if telemetryManager.current_y == movementManager.configMenu.forward_blocks then
      goal = 1
    else
      goal = movementManager.configMenu.forward_blocks
    end
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
    turtle.dig()
    telemetryManager.update(1,0,0)
    turtle.forward()
    turtle.dig()
    telemetryManager.update(1,0,0)
    turtle.forward()
    turtle.dig()
    telemetryManager.update(1,0,0)
  elseif next_small > 0 then
    local x = 1
    local succes, reason = turtle.forward()
    if succes == true then
      x = x + 1
    end
    turtle.dig()
    turtle.forward()
    telemetryManager.update(x,0,0)
  end

  if telemetryManager.current_y == movementManager.configMenu.forward_blocks then
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