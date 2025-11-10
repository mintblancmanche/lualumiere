--[[
ScenEdit_RunScript ("lualumiere/UnitSub_SubShaking.lua")
SubShaking({guid = v})

local side = "North Korea"
local mission = "PatSub"
local mission = ScenEdit_GetMission (side, mission)
print(mission.unitlist)

math.randomseed (os.time() )
for k, v in pairs(mission.unitlist) do
  SubShaking({guid = v})
end
]]

function SubShaking(UnitTable)
  local unit = ScenEdit_GetUnit (UnitTable)
  if unit.unitstate ~= "EngagedOffensive" then
--    print("Unit not engaged")
    return
  end

  ScenEdit_RunScript("lualumiere/Unit_TargetList.lua")
  local targets = TargetList(UnitTable)

  local compareme = 180
  local priority = nil
  for k, v in pairs(targets) do
    local contact = VP_GetContact({guid=v})
    if contact.heading ~= nil then
      local tgtangle = math.abs(contact.heading-Tool_Bearing(v, unit.guid) )

      if tgtangle > 180 then
        tgtangle = 180-tgtangle%180
      end
--      print("Target angle for " ..contact.name.. " = " ..tgtangle)
    local range = Tool_Range(v, unit.guid)
--    print("Range for " ..contact.name.. " = " ..range)
      if compareme > tgtangle and range < 20 then
        compareme = tgtangle
        priority = contact
      end
    end

  end

--  print(compareme)
--  print(priority)

  if priority == nil then
    return
  end

  local course = {}
  table.insert(course, {latitude = priority.latitude, longitude = priority.longitude})
  unit.course = course
  ScenEdit_SetDoctrine({guid=unit.guid}, {ignore_plotted_course=false})

ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")
  local Delay = 50
  local ScriptText = 'local unit = ScenEdit_GetUnit ({guid = "' ..unit.guid.. '"}) \r\n' ..
  'ScenEdit_SetUnit({guid=unit.guid, course= {} }) \r\n' ..
  'ScenEdit_SetDoctrine({guid=unit.guid}, {ignore_plotted_course=true})'
  DelayedEvent(Delay, ScriptText)
end