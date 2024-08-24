telemetryManager = {}

telemetryManager.current_orientation = 0
telemetryManager.current_x = 2 --1 is start pos!
telemetryManager.current_y = 0
telemetryManager.current_z = 0
telemetryManager.foundBedrock = false

function telemetryManager.update(amount_forward, amount_down, direction_modifier)
  directions = {
    [0] = function() telemetryManager.current_y = telemetryManager.current_y + amount_forward end,
    [1] = function() telemetryManager.current_x = telemetryManager.current_x + amount_forward end,
    [2] = function() telemetryManager.current_y = telemetryManager.current_y - amount_forward end,
    [3] = function() telemetryManager.current_x = telemetryManager.current_x - amount_forward end,
  }

  telemetryManager.current_orientation = telemetryManager.current_orientation + direction_modifier
  telemetryManager.current_z = telemetryManager.current_z + amount_down
  
  if directions[telemetryManager.current_orientation] then
    directions[telemetryManager.current_orientation]()
  else
    if telemetryManager.current_orientation < 0 then
      telemetryManager.current_orientation = 3
    else
      telemetryManager.current_orientation = 0
    end
  end

  telemetryManager.dataReporting["dataReporting"]()
  telemetryManager.save()
end

function telemetryManager.save()
local info = {
  config = {
    forward_blocks= configMenu.forward_blocks,
    right_blocks= configMenu.right_blocks,
    inventory_management= configMenu.inventory_management,
    fuel_management= configMenu.fuel_management,
    data_reporting= configMenu.data_reporting,
    data_reporting_port= configMenu.data_reporting_port
},
telemetry= {
    current_orientation= telemetryManager.current_orientation,
    current_x= telemetryManager.current_x,
    current_y= telemetryManager.current_y,
    current_z= telemetryManager.current_z
}}

local file = fs.open("saveData.json", "w")
file.write(textutils.serializeJSON(info))
file.close()
end