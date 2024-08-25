dofile("telemetryManager.lua")
dofile("inventoryManager.lua")

function waiting()
  local buckets = inventoryManager.withdraw()
  if turtle.getItemCount() ~= 16 then
    waiting()
  else
    mainLoop()
  end
end

function mainLoop()
  turtle.select(1)
  local currentInventorySlot = 1

  repeat
    local succes, reason = turtle.forward()
    if succes == false then
      break
    else
      telemetryManager.update(1,0,0)
    end

    turtle.placeUp()
    if turtle.getItemDetail() ~= nil and turtle.getItemDetail().name == "minecraft:lava_bucket" then
      break
    end

    turtle.turnRight()
    telemetryManager.update(0,0,1)
    turtle.place()
    if turtle.getItemDetail() ~= nil and turtle.getItemDetail().name == "minecraft:lava_bucket" then
      break
    end

    turtle.turnLeft()
    telemetryManager.update(0,0,-1)
    turtle.turnLeft()
    telemetryManager.update(0,0,-1)
    turtle.place()
    if turtle.getItemDetail() ~= nil and turtle.getItemDetail().name == "minecraft:lava_bucket" then
      break
    end
    turtle.turnRight()
    telemetryManager.update(0,0,1)
    
  until x ~= nil

  repeat 
    turtle.turnRight()
    telemetryManager.update(0,0,1)
  until telemetryManager.current_orientation == 2
  repeat
    local succes, reason = turtle.forward()
    if succes == false then
      break
    else
      telemetryManager.update(1,0,0)
    end
  until x ~= nil
  turtle.turnRight()
  telemetryManager.update(0,0,1)
  turtle.turnRight()
  telemetryManager.update(0,0,1)
  inventoryManager.deposit()

  waiting()
end

function init()
  inventoryManager.telemetryManager = telemetryManager
  waiting()
end

init()
