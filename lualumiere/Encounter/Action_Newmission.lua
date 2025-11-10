--[[
ScenEdit_RunScript ("lualumiere/Encounter/Action_Newmission.lua")
]]

local guid = ScenEdit_UnitX().guid
local mission = "Mining"
ScenEdit_AssignUnitToMission (guid, "None") 
ScenEdit_AssignUnitToMission (guid, mission) 