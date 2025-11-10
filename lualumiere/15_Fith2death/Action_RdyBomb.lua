--[[
ScenEdit_RunScript ("lualumiere/15_Fith2death/Action_RdyBomb.lua")
Ferry mission has no unitlist (= all unit reached destination)
]]

Tool_EmulateNoConsole() --required to avoid error window when testing

local rforbackfire = { [1] = '31d5ec84-4a31-483a-ba30-ad667824b887', [2] = '2f1d4e09-7f62-4e53-8306-f91336be49d1', [3] = 'ecad9e09-5847-47f9-b86c-270ea146dd35', [4] = '0d779755-0347-4352-bd86-d329f091f734' }
local rforbadger = { [1] = '07a1fc91-0ef0-4b6c-9553-95711427c2af', [2] = '2d743580-e6ab-42be-874b-e1dafcd67b08', [3] = '63024bf3-1c52-4e3a-8453-f9219a57c46c', [4] = 'd350b2f6-e37f-4d3a-bfa2-d8095c005923' }

local mission1 = "StrNav-1"
local mission2 = "StrNav-2"

for k, v in pairs(rforbackfire) do
  ScenEdit_AssignUnitToMission (v, mission1)
end

for k, v in pairs(rforbadger do
  ScenEdit_AssignUnitToMission (v, mission2)
end