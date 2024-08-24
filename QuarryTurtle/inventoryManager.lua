inventoryManager = {}

function inventoryManager.basicCheck()
  inventorySlotsFilled = 0
  for i=1, 16 do
    turtle.select(i)
    if turtle.getItemCount() > 0 then
      inventorySlotsFilled = inventorySlotsFilled + 1
    end
  end
  if inventorySlotsFilled == 16 then
    print("Inventory is full, empty and press enter to continue.")
    read()
  end
end

function inventoryManager.advancedCheck()
  inventorySlotsFilled = 0
  for i=1, 16 do
    turtle.select(i)
    if turtle.getItemCount() > 0 then
      inventorySlotsFilled = inventorySlotsFilled + 1
    end
  end
  if inventorySlotsFilled == 16 then
    turtle.select(1)
    turtle.placeUp()
    local eChest = peripheral.wrap("top")
    for i=1, 16 do
      turtle.select(i)
      turtle.dropUp()
    end
    turtle.select(1)
    turtle.digUp()
  end
  return 0
end