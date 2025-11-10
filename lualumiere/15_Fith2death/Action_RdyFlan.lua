--[[
ScenEdit_RunScript ("lualumiere/15_Fith2death/Action_RdyFlan.lua")
Ferry mission has no unitlist (= all unit reached destination)
]]

Tool_EmulateNoConsole() --required to avoid error window when testing

local rforflanker = { [1] = '75b512ab-12aa-4ebd-87dd-4db61efb6a32', [2] = '277061ae-94b3-444a-8b4d-a56b44e925c5', [3] = 'c6c0dcd1-4dc8-44c0-bf12-ceff4b6cd20d', [4] = '9d6b3180-4c47-45ec-8c25-2c8145b11af5', [5] = '16a22acd-ceb5-42b1-9631-61fc08bff960', [6] = '38145478-9c70-429e-944d-a74b104a37ae' }
local mission = "PatCAP"
local loadoutid = 2937 --Flanker Standard AAW
local timetoready_minutes = nil
local ignoremagazines = false

for k, v in pairs(rforflanker) do
  ScenEdit_AssignUnitToMission (v, mission)
  ScenEdit_SetLoadout({unitname = v,loadoutid = loadoutid, timetoready_minutes = timetoready_minute, ignoremagazines = ignoremagazines})
end