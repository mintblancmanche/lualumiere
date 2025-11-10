--[[
ScenEdit_RunScript ("lualumiere/15_Fith2death/Cond_NoKuzunit.lua")
Ferry mission has no unitlist (= all unit reached destination)
]]

local side = "Russia"
local mission = "Fer-Kuz"
local mission = ScenEdit_GetMission (side, mission)
print(mission.unitlist)

if next(mission.unitlist) == nil then
  ScenEdit_EventX().isActive = false
  return true
else
  return false
end