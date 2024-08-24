dofile("configMenu.lua")
dofile("telemetryManager.lua")
dofile("movementManager.lua")
dofile("inventoryManager.lua")
dofile("saveManager.lua")

local modem = peripheral.find("modem")
local port = 0

Modules = {
  ["inventoryCheck"] = function() inventoryManager.basicCheck() end,
  ["dataReporting"] = function(x,y) end
}


function mainLoop(am_big_rows, am_small_rows, big_rows_done, small_rows_done, goal)
  repeat
    for i = big_rows_done, am_big_rows do
      -- local fuely = fuelCheck()
      Modules["inventoryCheck"]()
      movementManager.dig_big_row(goal)
      movementManager.turn(am_big_rows - i, am_small_rows)
      goal = nil
    end

    for i = small_rows_done, am_small_rows do
      -- local fuely = fuelCheck()
      Modules["inventoryCheck"]()
      movementManager.dig_small_row(goal)
      movementManager.turn(0, am_small_rows - i)
      goal = nil
    end
  big_rows_done = 1
  small_rows_done = 1
  movementManager.returnToStart()
  until telemetryManager.foundBedrock == true
end

function init(saveData)
  local small_rows_done = 0
  local big_rows_done = 0
  local goal = nil

  if saveData ~= nil then
    local configData = textutils.unserializeJSON(saveData.readAll())
    saveData.close()

    configMenu = configData.config
    print(configMenu.forward_blocks)
    small_rows_done = configData.progress.small_rows_done
    big_rows_done = configData.progress.big_rows_done
    goal = configData.progress.current_row_goal

    telemetryManager.current_orientation = configData.telemetry.current_orientation
    telemetryManager.current_x = configData.telemetry.current_x
    telemetryManager.current_y = configData.telemetry.current_y
    telemetryManager.current_z = configData.telemetry.current_z
  else
    configMenu.gatherParameters()
  end
  movementManager.telemetryManager = telemetryManager
  movementManager.configMenu = configMenu

  local am_big_rows = math.floor(configMenu.right_blocks / 3)
  local am_small_rows = configMenu.right_blocks % 3

  if configMenu.inventory_management == 1 then
    Modules["inventoryCheck"] = function() inventoryManager.advancedCheck() end
  end

  if configMenu.data_reporting == 1 then
    port = configMenu.data_reporting_port
    Modules["dataReporting"] = function() modem.transmit(port, 0, telemetryManager.current_orientation .." ".. telemetryManager.current_x .. " ".. telemetryManager.current_y .. " " .. telemetryManager.current_z .." " ..turtle.getFuelLevel()); end
  end
  telemetryManager.dataReporting = Modules

  if(saveData == nil) then
    turtle.digDown()
    turtle.down()
    telemetryManager.update(0,1,0)
  end
  mainLoop(am_big_rows,am_small_rows, small_rows_done, big_rows_done, goal)
end


local file = fs.open("saveData.json", "r")
if file == nil then
  init(nil)
else
  init(file) --CHANGE THIS
end