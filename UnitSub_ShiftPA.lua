--[[
ScenEdit_RunScript ("lualumiere/UnitSub_ShiftPA.lua")

local UnitTable = {name='S 601 Rubis', guid='cf1df443-5905-43f1-bff4-8f208dd15775'}
DoShiftPA(UnitTable)
]]
function DoShiftPA(UnitTable)
  local unit = ScenEdit_GetUnit (UnitTable)

  ScenEdit_RunScript("lualumiere/Unit_TargetList.lua")
  local targets = TargetList(UnitTable)

  local compareme = 135
  local priority = nil
  for k, v in pairs(targets) do
    local contact = VP_GetContact({guid=v})
    if contact.heading ~= nil then
      local tgtangle = math.abs(contact.heading-Tool_Bearing(v, unit.guid) )
      if tgtangle > 180 then
        tgtangle = 180-tgtangle%180
      end
      print("Target angle for " ..contact.name.. " = " ..tgtangle)
      local range = Tool_Range(v, unit.guid)
      print("Range for " ..contact.name.. " = " ..range)
      if compareme > tgtangle and tgtangle > 15 and range > 15 then
        compareme = tgtangle
        priority = contact
      end
    end

    print(compareme)
    print(priority)
  end

  if priority == nil then
    return
  end

  ShiftPA(UnitTable, priority)
end

function ShiftPA(UnitTable, ContactTable)
  local unit = ScenEdit_GetUnit (UnitTable)
  if unit.unitstate == "EngagedOffensive" then
    print("Unit engaged")
    return
  end

  local mission = ScenEdit_GetMission(unit.side, unit.mission.name).patrolmission
  local area = mission.PatrolZone
  local contact = VP_GetContact({guid = ContactTable.guid})
  local course = contact.heading
  local speed = contact.speed
  if speed < 10 then
    speed = 10
  end

  local hour4 = World_GetPointFromBearing ({latitude = contact.latitude, longitude = contact.longitude, bearing = course, distance = speed*4})
  local hour8 = World_GetPointFromBearing ({latitude = contact.latitude, longitude = contact.longitude, bearing = course, distance = speed*8})
  local hour12 = World_GetPointFromBearing ({latitude = contact.latitude, longitude = contact.longitude, bearing = course, distance = speed*12})

  local range4 = Tool_Range(unit.guid, hour4)
  local range8 = Tool_Range(unit.guid, hour8)
  local range12 = Tool_Range(unit.guid, hour12)
  print(range4)
  print(range8)
  print(range12)

  local pointa = nil
  if range12 < 110 then
    pointa = hour12
  end

  if range8 < 70 then
    pointa = hour8
  end

  if range4 < 30 then
    pointa = hour4
  end

  print(pointa)

  if pointa == nil then
  print("No reachable point")
    return
  end

  local rpoint1 = World_GetPointFromBearing ({latitude = pointa.latitude, longitude = pointa.longitude, bearing=315, distance=17.68})
  local rpoint2 = World_GetPointFromBearing ({latitude = pointa.latitude, longitude = pointa.longitude, bearing=45, distance=17.68})
  local rpoint3 = World_GetPointFromBearing ({latitude = pointa.latitude, longitude = pointa.longitude, bearing=135, distance=17.68})
  local rpoint4 = World_GetPointFromBearing ({latitude = pointa.latitude, longitude = pointa.longitude, bearing=225, distance=17.68})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[1].name, latitude = rpoint1.latitude, longitude = rpoint1.longitude})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[2].name, latitude = rpoint2.latitude, longitude = rpoint2.longitude})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[3].name, latitude = rpoint3.latitude, longitude = rpoint3.longitude})
  ScenEdit_SetReferencePoint ({side = unit.side, name = area[4].name, latitude = rpoint4.latitude, longitude = rpoint4.longitude})
  ScenEdit_SetUnit({guid = unit.guid, course= {} })
end


