--[[
local type = "UnitDetected"
local trigger = "Detected - Wpn"
local TargetFilter = {
  TargetSide = "Hostile",
  TargetType = "Weapon",
  TargetSubType = nil,
  SpecificUnitClass = nil,
  SpecificUnitID = nil
}
local Area = nil
local DetectorSideID = "Detector"
local MCL = 2

ScenEdit_SetTrigger({mode = "add", name = trigger, type = type, TargetFilter = TargetFilter, Area = Area, DetectorSideID = DetectorSideID, MCL = MCL})

local action = "Lua - Snapshot"
local ScriptText = 'ScenEdit_RunScript ("lualumiere/UnitSub_Snapshot.lua")'
ScenEdit_SetAction({mode= "add", name=action, type="LuaScript", ScriptText=ScriptText})

local eventname = "Snapshot"
ScenEdit_SetEvent(eventname, {mode = "add", IsActive = True, IsRepeatable = true, IsShown = false, Probability = 100})
ScenEdit_SetEventTrigger (eventname, {mode = "add", name = trigger})
ScenEdit_SetEventAction (eventname, {mode = "add", name = action})
]]

----------assert if torpedo is low on fuel (<25%)
local contact = ScenEdit_UnitC().guid
local actualunit = VP_GetContact({guid=contact}).actualunitid
local fuel = ScenEdit_GetUnit({guid=actualunit}).fuel[5002]

if fuel.current/fuel.max*100 < 25 then return end

ScenEdit_EventX().isActive = false

----------load other lua files
math.randomseed(os.time() )
ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")

----------
local unity = ScenEdit_UnitY().unit
if unity.type == "Weapon" then
	unity =  ScenEdit_GetUnit({guid=unity.weapon.shooter.guid})
end

local sidedoc = ScenEdit_GetDoctrine({side = unity.side})
local misdoc = ScenEdit_GetDoctrine({side = unity.side, mission = unity.mission.guid})

local docambi
if misdoc.engaging_ambiguous_targets ~= nil then
  docambi = misdoc.engaging_ambiguous_targets
else
  docambi = sidedoc.engaging_ambiguous_targets
end

local dockine
if misdoc.kinematic_range_for_torpedoes ~= nil then
  dockine = misdoc.kinematic_range_for_torpedoes
else
  dockine = sidedoc.kinematic_range_for_torpedoes
end

local mission = ScenEdit_GetMission(unity.side, unity.mission.guid)

ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {engaging_ambiguous_targets=0})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {kinematic_range_for_torpedoes=0})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {ignore_plotted_course=false})
ScenEdit_SetDoctrine({guid=unity.guid}, {ignore_plotted_course='inherit'})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {automatic_evasion=false})

----------active sonar
local sonar = 'Sonar=Active'
ScenEdit_SetEMCON('mission', mission.guid, sonar)
for k, v in ipairs (mission.unitlist) do
	ScenEdit_SetEMCON('unit', v, "Inherit")
end

----------beaming maneuver
local contact = ScenEdit_UnitC().guid			
local manualThrottle = 4 --flank
local manualAltitude = -1000

local random = math.random(0,1)
local course = {}
local waypoint1 = World_GetPointFromBearing({lat=unity.latitude, lon=unity.longitude, distance=4, bearing= Tool_Bearing(unity.guid, contact)+150*(1-2*random) })
table.insert(course, waypoint1)

local random2 = math.random(0,2)
local bearing 
if random2 == 0 then
	bearing = Tool_Bearing(waypoint1, unity.guid)-165*(1-2*random) --go inside
else
	bearing = Tool_Bearing(unity.guid, contact)+90*(1-2*random) --go outside
end
local waypoint2 = World_GetPointFromBearing({lat=waypoint1.latitude, lon=waypoint1.longitude, distance=4, bearing=bearing})
table.insert(course, waypoint2)

ScenEdit_SetUnit({guid=unity.guid, course=course, manualThrottle=manualThrottle, manualAltitude=manualAltitude})

---------auto hostile
local delay = 1
local scripttext =
  'local unityguid = "' ..unity.guid.. '" \r\n' ..
  'local contact = "' ..contact.. '" \r\n' ..
  ' \r\n' ..
  'local subtabl = VP_GetSide ({side="' ..unity.side.. '"}):contactsBy("3") \r\n' ..
  ' \r\n' ..
  'for k,v in pairs (subtabl) do \r\n' ..
  '  subcon = VP_GetContact({guid=v.guid}) \r\n' ..
  '  if math.abs (Tool_Bearing(unityguid, v.guid) - Tool_Bearing(unityguid, contact) ) < 45 then \r\n' ..
  '    subcon.posture = "H" \r\n' ..
  '  end \r\n' ..
  'end'

DelayedEvent(delay, scripttext)

----------deactivate active sonar
local delay = 1*60
local scripttext =
  'local side = "' .. unity.side .. '" \r\n' ..
  'local mission = "' .. mission.guid ..  '" \r\n' ..
  ' \r\n' ..
  'local mission = ScenEdit_GetMission(side, mission) \r\n' ..
  'local sonar = "Sonar=Passive" \r\n' ..
  'ScenEdit_SetEMCON("mission", mission.guid, sonar) \r\n' ..
  'for k, v in ipairs (mission.unitlist) do \r\n' ..
  '  ScenEdit_SetEMCON("unit", v, "Inherit") \r\n' ..
  'end'

DelayedEvent(delay, scripttext)

----------reduce speed
local delay = 5*60
local scripttext =
  'local guid = "' ..unity.guid.. '" \r\n' ..
  'local maketurnsfor = 5 \r\n' ..
  'ScenEdit_SetUnit({guid=guid, manualSpeed=maketurnsfor}) \r\n' ..
  ' \r\n' ..
  'ScenEdit_RunScript ("lualumiere/UnitSub_DelAmbiSub.lua") \r\n' ..
  'DelAmbiSub ("' ..unity.side.. '", 5)'

DelayedEvent(delay, scripttext)

----regain speed
local delay = 6*60
local scripttext =
  'local guid = "' ..unity.guid.. '" \r\n' ..
  'local manualThrottle = 4 \r\n' ..
  'local manualAltitude = -1000 \r\n' ..
  'ScenEdit_SetUnit({guid=guid, manualThrottle=manualThrottle, manualAltitude=manualAltitude})'

DelayedEvent(delay, scripttext)

--------reactivate Snapshot event
local delay = 30*60
local scripttext =
  'local side = "' .. unity.side .. '" \r\n' ..
  'local mission = "' .. mission.guid ..  '" \r\n' ..
  ' \r\n' ..
  'for k, v in ipairs (ScenEdit_GetMission(side, mission).unitlist) do \r\n' ..
  '  ScenEdit_SetUnit({guid=v, manualSpeed="OFF", manualAltitude="OFF", course= {} }) \r\n' ..
  'end \r\n' ..
  ' \r\n' ..
  'ScenEdit_SetDoctrine({side=side, mission=mission}, {engaging_ambiguous_targets=' ..docambi.. '}) \r\n' ..
  'ScenEdit_SetDoctrine({side=side, mission=mission}, {kinematic_range_for_torpedoes=' ..dockine.. '}) \r\n' ..
  ' \r\n' ..
  'ScenEdit_SetDoctrine({side=side, mission=mission}, {ignore_plotted_course=true}) \r\n' ..
  'ScenEdit_SetDoctrine({side=side, mission=mission}, {automatic_evasion=true}) \r\n' ..
  ' \r\n' ..
  'local event = "' ..ScenEdit_EventX().details.guid.. '" \r\n' ..
  'ScenEdit_SetEvent(event, {isactive=true}) \r\n' ..
  ' \r\n' ..
  'ScenEdit_RunScript ("lualumiere/UnitSub_DelAmbiSub.lua") \r\n' ..
  'DelAmbiSub ("' ..unity.side.. '", 5)'

DelayedEvent(delay, scripttext)