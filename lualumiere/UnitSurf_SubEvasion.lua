--ScenEdit_RunScript ("lualumiere/UnitSurf_SubEvasion.lua")

ScenEdit_EventX().isActive = false

-----load other lua files
math.randomseed(os.time() )
ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")

-----
local unity = ScenEdit_UnitY().unit
if unity.group ~= nil then
  unity = ScenEdit_GetUnit({guid=unity.group.guid})
end

local mission = ScenEdit_GetMission(unity.side, unity.mission.guid)

ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {engaging_ambiguous_targets=0})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {kinematic_range_for_torpedoes=0})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {engage_opportunity_targets=true})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {ignore_plotted_course=false})
ScenEdit_SetDoctrine({side=unity.side, mission=mission.guid}, {automatic_evasion=false})

local contact = ScenEdit_UnitC().guid
local manualThrottle = 4 --flank

local random = math.random(0,1)
local course = {}
local waypoint1 = World_GetPointFromBearing({lat=unity.latitude, lon=unity.longitude, distance=25, bearing= Tool_Bearing(unity.guid, contact)+135*(1-2*random) })
table.insert(course, waypoint1)

ScenEdit_SetUnit({guid=unity.guid, course=course, manualThrottle=manualThrottle})

-----
local eventname = "Surface_SubEvasion_DelayedEvent-1 (auto hostile) #" .. mission.name
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

DelayedEvent(eventname, delay, scripttext)

-----
local eventname = "Surface_SubEvasion_DelayedEvent-2 (speed full) #" .. mission.name
local delay = 10*60
local scripttext =
	'local guid = "' ..unity.guid.. '" \r\n' ..
	'local manualThrottle = 3 \r\n' ..
	'ScenEdit_SetUnit({guid=guid, manualThrottle=manualThrottle})'

DelayedEvent(eventname, delay, scripttext)

-----
local eventname = "Surface_SubEvasion_DelayedEvent-3 (reactivate SubEvasion event) #" .. mission.name
local delay = 60*60
local scripttext =
	'local side = "' .. unity.side .. '" \r\n' ..
	'local mission = "' .. mission.guid ..  '" \r\n' ..

	'for k, v in ipairs (ScenEdit_GetMission(side, mission).unitlist) do \r\n' ..
	'	ScenEdit_SetUnit({guid=v, manualSpeed="OFF", course= {} }) \r\n' ..
	'end \r\n' ..
	' \r\n' ..
	'ScenEdit_SetDoctrine({side=side, mission=mission}, {engaging_ambiguous_targets=1}) \r\n' ..
	'ScenEdit_SetDoctrine({side=side, mission=mission}, {kinematic_range_for_torpedoes=2}) \r\n' ..
	'ScenEdit_SetDoctrine({side=side, mission=mission}, {engage_opportunity_targets=false}) \r\n' ..
	' \r\n' ..
	'ScenEdit_SetDoctrine({side=side, mission=mission}, {ignore_plotted_course=true}) \r\n' ..
	'ScenEdit_SetDoctrine({side=side, mission=mission}, {automatic_evasion=true}) \r\n' ..
	' \r\n' ..
	'local event = "' ..ScenEdit_EventX().details.description.. '" \r\n' ..
	'ScenEdit_SetEvent(event, {isactive=true}) \r\n' ..
	' \r\n' ..
	'ScenEdit_RunScript ("lualumiere/UnitSub_DelAmbiSub.lua") \r\n' ..
	'DelAmbiSub ("' ..unity.side.. '", 10)'

DelayedEvent(eventname, delay, scripttext)