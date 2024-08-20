local modem = peripheral.find("modem")
--known addresses
local thisAddress = 1000
local fuelGatheringAddress = 8080
--dynamic addresses
local refuelReqAddress = 0

modem.open(thisAddress)

function refuel(replychannel, code)
  if code == "0" then
    refuelReqAddress = replychannel
    modem.transmit(fuelGatheringAddress, thisAddress, "gather")
    print("gathering tasked")
  elseif code == "2" then
    print("Please resolve the issue at the refueling station.")
  end
end

function fuelGathering(replychannel, code)
  if code == "1" then
    modem.transmit(refuelReqAddress, thisAddress, "ok")
    print("sent confirmation to refueler")
  elseif code == "2" then
    print("Please resolve the issue at the refueling station.")
  end
end

function messageCheck()
  local event, side, channel, replyChannel, message, distance
  repeat
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
  until channel == thisAddress
  
  local actions = {
    ["10"] = function() refuel(replyChannel, string.sub(message, 3,3)) end,
    ["11"] = function() fuelGathering(replyChannel, string.sub(message, 3,3)) end 
  }
  print(string.sub(message,5))
  
  if actions[string.sub(message, 1,2)] then
    actions[string.sub(message, 1,2)]()
  else
    print("?: Unknown request.")
  end
  messageCheck()
end

messageCheck()


