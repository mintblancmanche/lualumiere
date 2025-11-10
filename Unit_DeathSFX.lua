--[[
ScenEdit_RunScript ("lualumiere/Unit_DeathSFX.lua")

local unit = ScenEdit_GetUnit({guid=ScenEdit_SelectedUnits().units[1].guid})

for k, v in pairs (ScenEdit_SelectedUnits().units) do
  ScenEdit_KillUnit({guid=v.guid})
end
]]

UnitDamaged 	DamagePercent 	
	TargetFilter 	See below
UnitDestroyed 	TargetFilter 	See below



local unit = ScenEdit_UnitX()

if not unit.side == ScenEdit_PlayerSide() then
	return
end



local file
if unit.type == "Aircraft" then
	file = 'Explosion_air_medium.mp3'
elseif unit.type == "Submarine" then
	file = 'Explosion_underwater_large.mp3'
else --2 Ship,4 Facility
	file = 'Impact_directhit_large.mp3'
end

ScenEdit_PlaySound(file)