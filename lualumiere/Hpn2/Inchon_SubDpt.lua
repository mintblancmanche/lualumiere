--ScenEdit_RunScript ("lualumiere/Hpn2/Inchon_SubDpt.lua")

ScenEdit_RunScript ("lualumiere/UnitSub_SetDepth.lua")

local side = "North Korea"
local mission = "PatSub"
local mission = ScenEdit_GetMission (side, mission)
print(mission.unitlist)

math.randomseed (os.time() )
for k, v in pairs(mission.unitlist) do
  SetDepth({guid = v})
end