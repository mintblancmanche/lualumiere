--[[
ScenEdit_RunScript ("lualumiere/15_Fith2death/Cond_Less10Bomb.lua")
]]

local side = "Russia"
local mission1 = "StrNav-1"
local mission2 = "StrNav-2"
local mission1 = ScenEdit_GetMission (side, mission1)
local mission2 = ScenEdit_GetMission (side, mission2)

if (#mission1.unitlist + #mission2.unitlist) <= 10 then
  ScenEdit_EventX().isActive = false
  return true
else
  return false
end