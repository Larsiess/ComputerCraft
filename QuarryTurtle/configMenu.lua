configMenu = {}

function configMenu.gatherParameters()
  print("How many blocks forward?")
  configMenu.forward_blocks = tonumber(read())
  print("How many blocks right?")
  configMenu.right_blocks = tonumber(read())
  print("Manage inventory? (0/1)")
  configMenu.inventory_management = tonumber(read())
  print("Manage fuel? (0/1)")
  configMenu.fuel_management = tonumber(read())
  print("Report data? (0/1)")
  configMenu.data_reporting = tonumber(read())
  if configMenu.data_reporting == 1 then
    print("Which port to report to?")
    configMenu.data_reporting_port = tonumber(read())
  end
end