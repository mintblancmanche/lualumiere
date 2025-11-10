--ScenEdit_RunScript ("lualumiere/RP_DrawASWBoxPIM.lua")

local side = ScenEdit_PlayerSide()
local selected = ScenEdit_SelectedUnits()
if selected == nil then
  ScenEdit_MsgBox("Aborted: Please select unit or contact!", 0)
  return
end

local unit
if selected.units ~= nil then --unit
  unit = ScenEdit_GetUnit({guid = selected.units[1].guid})
else --contact
  unit = VP_GetContact({guid= selected.contacts[1].guid})
end

local bea = tonumber( ScenEdit_InputBox("Please enter box bearing from selected unit/contact.") )
if bea == nil then
  print("Cancelled.")
  return
end

local point1 = World_GetPointFromBearing ({latitude = unit.latitude, longitude = unit.longitude, bearing = bea, distance = 50})

local rp1 = World_GetPointFromBearing ({latitude = point1.latitude, longitude = point1.longitude, bearing = 270+bea, distance = 20})
local rp2 = World_GetPointFromBearing ({latitude = point1.latitude, longitude = point1.longitude, bearing = 90+bea, distance = 20})
local rp3 = World_GetPointFromBearing ({latitude = rp2.latitude, longitude = rp2.longitude, bearing = 180+bea, distance = 40})
local rp4 = World_GetPointFromBearing ({latitude = rp1.latitude, longitude = rp1.longitude, bearing = 180+bea, distance = 40})

local rp1brg = Tool_Bearing(unit.guid, {latitude = rp1.latitude, longitude = rp1.longitude})
local rp2brg = Tool_Bearing(unit.guid, {latitude = rp2.latitude, longitude = rp2.longitude})
local rp3brg = Tool_Bearing(unit.guid, {latitude = rp3.latitude, longitude = rp3.longitude})
local rp4brg = Tool_Bearing(unit.guid, {latitude = rp4.latitude, longitude = rp4.longitude})
local rp1dis = Tool_Range(unit.guid, {latitude = rp1.latitude, longitude = rp1.longitude})
local rp2dis = Tool_Range(unit.guid, {latitude = rp2.latitude, longitude = rp2.longitude})
local rp3dis = Tool_Range(unit.guid, {latitude = rp3.latitude, longitude = rp3.longitude})
local rp4dis = Tool_Range(unit.guid, {latitude = rp4.latitude, longitude = rp4.longitude})

if selected.units ~= nil then --unit
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp1brg, distance=rp1dis, bearingtype=0, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp2brg, distance=rp2dis, bearingtype=0, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp3brg, distance=rp3dis, bearingtype=0, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp4brg, distance=rp4dis, bearingtype=0, highlighted=true, locked=false})
else --contact
  ScenEdit_AddReferencePoint({side=side, latitude=rp1.latitude, longitude=rp1.longitude, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, latitude=rp2.latitude, longitude=rp2.longitude, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, latitude=rp3.latitude, longitude=rp3.longitude, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, latitude=rp4.latitude, longitude=rp4.longitude, highlighted=true, locked=false})
end

print("RP generated!")
