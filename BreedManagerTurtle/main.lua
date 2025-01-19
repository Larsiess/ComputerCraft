function init()
  redstone.setOutput("back", false)

  breeder = peripheral.wrap("front")
  if breeder == nil then error("No breeder found.") end

  chicks = {}
  chicks[1] = breeder.getItemMeta(1)
  chicks[2] = breeder.getItemMeta(2)
  if chicks[1] == nil or chicks[2] == nil then error("Missing chicken") end
  main(breeder, chicks)
end

function main(breeder, chicks)
  lowest = 1
  if chickStatCount(chicks[1]) > chickStatCount(chicks[2]) then lowest = 2 end
  for i=4, 6 do
    if breeder.getItemMeta(i) ~= nil then
      breeder.drop(lowest)
      breeder.pushItems(peripheral.getName(breeder), i, 16, lowest)
      chicks[lowest] = breeder.getItemMeta(lowest)
    end
  end
  sleep(10)
  if chickStatCount(chicks[1]) == 30 and chickStatCount(chicks[2]) == 30 then
    finalBreeding(breeder, chicks, 0)
  else
    main(breeder, chicks)
  end

end

function finalBreeding(breeder, chicks, slotCounter)
  for i=4, 6 do
    if breeder.getItemMeta(i) ~= nil then
      breeder.pushItems(peripheral.getName(breeder), i, 16, (slotCounter % 2) + 1)
      chicks[(slotCounter % 2) + 1] = breeder.getItemMeta((slotCounter % 2) + 1)
      slotCounter = slotCounter + 1
    end
  end
  sleep(5)
  if chicks[1].count >= 8 and chicks[2].count >= 8 then
    redstone.setOutput("back", true)
  else
    finalBreeding(breeder, chicks, slotCounter)
  end
end
  

function chickStatCount(chick)
  return chick.roost.gain + chick.roost.growth + chick.roost.strength
end

init()