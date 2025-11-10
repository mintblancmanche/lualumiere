--[[
ScenEdit_RunScript ("lualumiere/15_Fith2death/Cond_Less5Flan.lua")
]]

local side = "Russia"
local mission = "6d3fe630-a83e-4513-a152-dd365f2c36e8"
local mission = ScenEdit_GetMission (side, mission)
print(mission.unitlist)

if #mission.unitlist <= 5 then
  ScenEdit_EventX().isActive = false
  return true
else
  return false
end