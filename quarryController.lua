dofile("configMenu.lua")
dofile("telemetryManager.lua")
dofile("movementManager.lua")
dofile("inventoryManager.lua")

local modem = peripheral.find("modem")
local port = 0

Modules = {
  ["inventoryCheck"] = function() inventoryManager.basicCheck() end,
  ["dataReporting"] = function(x,y) end

}


function mainLoop()
  local am_big_rows = math.floor(configMenu.right_blocks / 3)
  local am_small_rows = configMenu.right_blocks % 3
  repeat
    for i = 1, am_big_rows do
      -- local fuely = fuelCheck()
      Modules["inventoryCheck"]()
      movementManager.dig_big_row()
      movementManager.turn(am_big_rows - i, am_small_rows)
    end

    for i = 1, am_small_rows do
      -- local fuely = fuelCheck()
      Modules["inventoryCheck"]()
      movementManager.dig_small_row()
      movementManager.turn(0, am_small_rows - i)
    end
  movementManager.returnToStart()
  until telemetryManager.foundBedrock == true
end

function init(saveData)
  movementManager.config = configMenu
  movementManager.telemetryManager = telemetryManager
  telemetryManager.configMenu = configMenu

  if saveData ~= nil then
    saveData = textutils.unserializeJSON(saveData.readAll())
    configMenu = saveData.config

    telemetryManager.current_orientation = saveData.telemetry.current_orientation
    telemetryManager.current_x = saveData.telemetry.current_x
    telemetryManager.current_y = saveData.telemetry.current_y
    telemetryManager.current_z = saveData.telemetry.current_z
  else
    configMenu.gatherParameters()
  end
  

  if configMenu.inventory_management == 1 then
    Modules["inventoryCheck"] = function() inventoryManager.advancedCheck() end
  end

  if configMenu.data_reporting == 1 then
    port = configMenu.data_reporting_port
    Modules["dataReporting"] = function() modem.transmit(port, 0, telemetryManager.current_orientation .." ".. telemetryManager.current_x .. " ".. telemetryManager.current_y .. " " .. telemetryManager.current_z .." " ..turtle.getFuelLevel()); end
  end
  telemetryManager.dataReporting = Modules

  if saveData ~= nil then
    turtle.up()
    telemetryManager.update(0,-1,0)
    movementManager.returnToStart()
  else
    turtle.digDown()
    turtle.down()
    telemetryManager.update(0,1,0)
  end
  mainLoop()
end

local file = fs.open("saveData.json", "r")
init(file)