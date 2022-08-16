data = {}

---@param args
---@return boolean
lib.addCommand("group.admin", "toggle:hospital", function(args)
   GlobalState.hospitalState = not GlobalState.hospitalState

   local hospitalState = GlobalState.hospitalState and "open" or "closed"

   TriggerClientEvent("chat:addMessage", -1, {
      template = '<div class="chat-message text-system"><span class="text-white">[SYSTEM]: Local Medical Center is now {0}.</span></div>',
      args = { hospitalState },
   })
end)

local entity = nil

local function hospitalNPC()
   if not entity then
      local ped = CreatePed(4, config.npc.model, config.npc.x, config.npc.y, config.npc.z, config.npc.h, true, false)
      entity = NetworkGetNetworkIdFromEntity(ped)
      FreezeEntityPosition(ped, true)
   end
end

AddEventHandler("onResourceStart", function(resourceName)
   if GetCurrentResourceName() ~= resourceName then return end
   hospitalNPC()
end)

AddEventHandler("onResourceStop", function(resourceName)
   if entity then
      if GetCurrentResourceName() ~= resourceName then return end

      local entity = NetworkGetEntityFromNetworkId()
      DeleteEntity(entity)
      entity = nil
   end
end)

CreateThread(function()
   if GetConvar('onesync') == "on" then
      print("^2Resource started successfully")
   else
      print("^8This resource requires OneSync")
   end
end)

---@param entityId any
---@param stateBag usedState
---@return unknown
function getState(entityId, stateBag)
   local player = Player(entityId)
   return player.state[stateBag]
end

---@param entityId any
---@param stateBag usedState
function setState(entityId, stateBag, bool, replicated)
   local player = Player(entityId)

   if replicated == nil then
      replicated = false
   end

   player.state:set(stateBag, bool, replicated)
end

data.usedStates = {
   'isBleeding',
}

---@param key usedState
---@param value boolean
---@param source any
for i = 1, #data.usedStates do
   local state = data.usedStates[i]
   AddStateBagChangeHandler(state, false, function(bagName, key, value, source, replicated)
      local playerNet = tonumber(bagName:gsub('player:', ''), 10)
      print("bagName: ["..key.."] value: ["..tostring(value).."] replicated: ["..tostring(replicated).."]")
   end)
end
