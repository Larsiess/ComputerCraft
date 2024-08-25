local chest = peripheral.wrap("front")

repeat
  local isLavaBucket = false
  repeat
    isLavaBucket = (chest.list()[27].name == "minecraft:lava_bucket")
  until isLavaBucket == true
  isLavaBucket = false
  
  for i=1, 27 do
    turtle.suck()
    turtle.refuel()
    if turtle.getFuelLevel() >= 99000 then
      break
    end
    turtle.dropDown()
  end

until x ~= nil