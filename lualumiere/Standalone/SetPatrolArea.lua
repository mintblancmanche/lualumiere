--[[
ScenEdit_RunScript ("lualumiere/Standalone/SetPatrolArea.lua")
]]

function ShiftPatArea(UnitTable, Location)
  local unit = ScenEdit_GetUnit({guid = UnitTable.guid})
  local mission = ScenEdit_GetMission(unit.side, unit.mission.name).patrolmission
  local area = mission.PatrolZone

  local rpoint1 = World_GetPointFromBearing ({latitude = Location.latitude, longitude = Location.longitude, bearing=315, distance=17.68})
  local rpoint2 = World_GetPointFromBearing ({latitude = Location.latitude, longitude = Location.longitude, bearing=45, distance=17.68})
  local rpoint3 = World_GetPointFromBearing ({latitude = Location.latitude, longitude = Location.longitude, bearing=135, distance=17.68})
  local rpoint4 = World_GetPointFromBearing ({latitude = Location.latitude, longitude = Location.longitude, bearing=225, distance=17.68})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[1].name, latitude = rpoint1.latitude, longitude = rpoint1.longitude})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[2].name, latitude = rpoint2.latitude, longitude = rpoint2.longitude})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[3].name, latitude = rpoint3.latitude, longitude = rpoint3.longitude})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[4].name, latitude = rpoint4.latitude, longitude = rpoint4.longitude})
end

local UnitTable = {name='Foxtrot B-341', guid='bdc9aa22-6b2e-440f-aa80-872a16635a8b'}
local unit = ScenEdit_GetUnit({guid = UnitTable.guid})
local Location = {latitude = unit.latitude, longitude = unit.longitude}
ShiftPatArea(UnitTable, Location)

local UnitTable = {name='Foxtrot B-342', guid='84824b4c-43a3-4ca7-b20e-e8499b436218'}
local unit = ScenEdit_GetUnit({guid = UnitTable.guid})
local Location = {latitude = unit.latitude, longitude = unit.longitude}
ShiftPatArea(UnitTable, Location)

local UnitTable = {name='Foxtrot B-343', guid='0fb77c0e-8705-44b3-8963-a430358088dc'}
local unit = ScenEdit_GetUnit({guid = UnitTable.guid})
local Location = {latitude = unit.latitude, longitude = unit.longitude}
ShiftPatArea(UnitTable, Location)

local UnitTable = {name='Foxtrot B-344', guid='b9ab2106-e4d0-48d3-b9a7-e240c1468d35'}
local unit = ScenEdit_GetUnit({guid = UnitTable.guid})
local Location = {latitude = unit.latitude, longitude = unit.longitude}
ShiftPatArea(UnitTable, Location)
