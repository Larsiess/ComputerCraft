inventoryManager = {}

function inventoryManager.deposit()
  turtle.turnLeft()
  telemetryManager.update(0,0,-1)
  for i=1, 16 do
    turtle.select(i)
    turtle.drop()
  end
  turtle.select(1)
  turtle.turnRight()
  telemetryManager.update(0,0,1)
end

function inventoryManager.withdraw()
  turtle.turnRight()
  telemetryManager.update(0,0,1)
  turtle.suck()
  turtle.turnLeft()
  telemetryManager.update(0,0,-1)
end

