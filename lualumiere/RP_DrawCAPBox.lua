--ScenEdit_RunScript ("lualumiere/RP_DrawCAPBox.lua")

local side = ScenEdit_PlayerSide()
local selected = ScenEdit_SelectedUnits()
if selected == nil then
  ScenEdit_MsgBox("Aborted: Please select unit or contact!", 0)
  return
end

local bea  = tonumber( ScenEdit_InputBox("Step1: Please enter box bearing from selected unit/contact.") )
if bea == nil then
  print("Cancelled.")
  return
end

local dis  = tonumber( ScenEdit_InputBox("Step2: Please enter box distance (nm) from selected unit/contact.") )
if dis == nil then
  print("Cancelled.")
  return
end

local dir  = tonumber( ScenEdit_InputBox("Step3: Please enter direction of box itself.") )
if dir == nil then
  print("Cancelled.")
  return
end


--print(dir)
local unit
if selected.units ~= nil then --unit
  unit = ScenEdit_GetUnit({guid = selected.units[1].guid})
else --contact
  unit = VP_GetContact({guid= selected.contacts[1].guid})
end

local point1 = World_GetPointFromBearing ({latitude = unit.latitude, longitude = unit.longitude, bearing = bea, distance = dis})
local point2 = World_GetPointFromBearing ({latitude = point1.latitude, longitude = point1.longitude, bearing = dir, distance = 20})
local point3 = World_GetPointFromBearing ({latitude = point1.latitude, longitude = point1.longitude, bearing = dir+180, distance = 20})

local rp1 = World_GetPointFromBearing ({latitude = point2.latitude, longitude = point2.longitude, bearing = 270+dir, distance = 20})
local rp2 = World_GetPointFromBearing ({latitude = point2.latitude, longitude = point2.longitude, bearing = 90+dir, distance = 20})
local rp3 = World_GetPointFromBearing ({latitude = point3.latitude, longitude = point3.longitude, bearing = 90+dir, distance = 20})
local rp4 = World_GetPointFromBearing ({latitude = point3.latitude, longitude = point3.longitude, bearing = 270+dir, distance = 20})

local rp1brg = Tool_Bearing(unit.guid, {latitude = rp1.latitude, longitude = rp1.longitude})
local rp2brg = Tool_Bearing(unit.guid, {latitude = rp2.latitude, longitude = rp2.longitude})
local rp3brg = Tool_Bearing(unit.guid, {latitude = rp3.latitude, longitude = rp3.longitude})
local rp4brg = Tool_Bearing(unit.guid, {latitude = rp4.latitude, longitude = rp4.longitude})
local rp1dis = Tool_Range(unit.guid, {latitude = rp1.latitude, longitude = rp1.longitude})
local rp2dis = Tool_Range(unit.guid, {latitude = rp2.latitude, longitude = rp2.longitude})
local rp3dis = Tool_Range(unit.guid, {latitude = rp3.latitude, longitude = rp3.longitude})
local rp4dis = Tool_Range(unit.guid, {latitude = rp4.latitude, longitude = rp4.longitude})

if selected.units ~= nil then --unit
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp1brg, distance=rp1dis, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp2brg, distance=rp2dis, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp3brg, distance=rp3dis, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=rp4brg, distance=rp4dis, highlighted=true, locked=false})
else --contact
  ScenEdit_AddReferencePoint({side=side, latitude=rp1.latitude, longitude=rp1.longitude, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, latitude=rp2.latitude, longitude=rp2.longitude, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, latitude=rp3.latitude, longitude=rp3.longitude, highlighted=true, locked=false})
  ScenEdit_AddReferencePoint({side=side, latitude=rp4.latitude, longitude=rp4.longitude, highlighted=true, locked=false})
end

