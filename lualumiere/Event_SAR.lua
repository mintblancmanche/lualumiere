--[[
ScenEdit_RunScript("lualumiere/Event_SAR.lua")

local ResSide = "Side1"
local SuvSide = "Side2"
local FailChan = 30
local Point = 50
SAR(ResSide, SuvSide, FailChan, Point)
]]

function SAR(ResSide, SuvSide, FailChan, Point)
  local guid = ScenEdit_UnitX().guid
  local unit = ScenEdit_GetUnit({guid = guid})

----rp datum
  local time
  if ScenEdit_CurrentTime() <0 then
    time = os.date("!*t", ScenEdit_CurrentTime()+3155760000)
    time = (time.year-100).. "-" ..string.format("%02d", time.month).. "-" ..string.format("%02d", time.day).. " " ..string.format("%02d", time.hour).. ":" ..string.format("%02d", time.min).. ":" ..string.format("%02d", time.sec)
  else
    time = os.date("!%Y-%m-%d %X", ScenEdit_CurrentTime() )
  end

  local rpname = "Unit Lost - " ..unit.name.. " / " ..time
  ScenEdit_AddReferencePoint({side=ResSide, name = rpname, latitude=unit.latitude, longitude=unit.longitude, locked = true})

  math.randomseed(os.time() )
----generate survivor unit
  if math.random(1, 100) < FailChan then
    -- Unit failed to survivor check, do nothing
  else
    local suvnumber
    if unit.type == "Aircraft" then
      suvnumber = 1
    elseif unit.type == "Ship" then
      suvnumber = math.random(2, 10)
    end

    for i = 1, suvnumber do
      local point = World_GetPointFromBearing({latitude = unit.latitude, longitude = unit.longitude, bearing = math.random(0,359), distance = math.random(1, 5)})

      local name, unittype, dbid
      if World_GetLocation({latitude=point.latitude, longitude=point.longitude}).altitude > 0 then
        name = "Downed Personel - " ..unit.name.. " #" ..i
        unittype = "Facility"
        dbid = 3135 --personnel 5
      else
        name = "Life Raft - " ..unit.name.. " #" ..i
        unittype = "Ship"
        dbid = 2552 --raft 10m
      end

      local suvunit = ScenEdit_AddUnit({side = SuvSide, name= name, type = unittype, dbid = dbid, lat = point.latitude, lon = point.longitude, heading = 0})

--rp for mission/trigger
      local rparea = {}
      local rp1 = ScenEdit_AddReferencePoint({side = SuvSide, relativeto=suvunit.name, bearing=0, distance=1.5})
      local rp2 = ScenEdit_AddReferencePoint({side = SuvSide, relativeto=suvunit.name, bearing=90, distance=1.5})
      local rp3 = ScenEdit_AddReferencePoint({side = SuvSide, relativeto=suvunit.name, bearing=180, distance=1.5})
      local rp4 = ScenEdit_AddReferencePoint({side = SuvSide, relativeto=suvunit.name, bearing=270, distance=1.5})
      table.insert(rparea, rp1.name)
      table.insert(rparea, rp2.name)
      table.insert(rparea, rp3.name)
      table.insert(rparea, rp4.name)

      ScenEdit_AddMission(SuvSide, suvunit.name, 'Patrol', {type='AAW',zone=rparea})

      if suvunit.type == "Ship" then
        ScenEdit_AssignUnitToMission (suvunit.guid, suvunit.name)
      end
--event trigger
      local eventname = "999_SAR Event - " ..name
      ScenEdit_SetEvent(eventname, {mode="add", IsRepeatable=false, IsShown=true, Probability=100})

      local mode = "add"
      local type = "UnitRemainsInArea"
      local Area = rparea
      local TD = 120

      local trigger1 = eventname.. " (AirRemainArea)"
      local TargetFilter1={
        TargetSide = ResSide,
        TargetType = "Aircraft",
        TargetSubType = nil,
        SpecificUnitClass = nil,
        SpecificUnitID = nil
      }
      ScenEdit_SetTrigger({mode = mode, name = trigger1, type = type, TargetFilter = TargetFilter1, Area = Area, TD = TD})

      local trigger2 = eventname.. " (SurfRemainArea)"
      local TargetFilter2={
        TargetSide = ResSide,
        TargetType = "Ship",
        TargetSubType = nil,
        SpecificUnitClass = nil,
        SpecificUnitID = nil
      }
      ScenEdit_SetTrigger({mode = mode, name = trigger2, type = type, TargetFilter = TargetFilter2, Area = Area, TD = TD})

      local trigger3 = eventname.. " (SubRemainArea)"
      local TargetFilter3={
        TargetSide = ResSide,
        TargetType = "Submarine",
        TargetSubType = nil,
        SpecificUnitClass = nil,
        SpecificUnitID = nil
      }
      ScenEdit_SetTrigger({mode = mode, name = trigger3, type = type, TargetFilter = TargetFilter3, Area = Area, TD = TD})

      ScenEdit_SetEventTrigger (eventname, {mode = mode, name = trigger1})
      ScenEdit_SetEventTrigger (eventname, {mode = mode, name = trigger2})
      ScenEdit_SetEventTrigger (eventname, {mode = mode, name = trigger3})
--event action
      local action = eventname.. " (Action)"
      local ScriptText =
      'local ResSide = "' ..ResSide.. '" \r\n' ..
      'local SuvSide = "' ..SuvSide.. '" \r\n' ..

      'local suvunitname = "' ..suvunit.name.. '" \r\n' ..
      ' \r\n' ..
      'local text = [[ \r\n' ..
      '<P>Survivor unit "]] ..suvunitname.. [[" is rescued by friendly unit.</P> \r\n' ..
      '<P>(+' .. Point .. ' Point for successful SAR action)</P> \r\n' ..
      ']] \r\n' ..
      'ScenEdit_SpecialMessage(ResSide, text) \r\n' ..
      'ScenEdit_SetScore(ResSide, ScenEdit_GetScore(side)+ (' ..Point.. '), "SAR action successful") \r\n' ..
      ' \r\n' ..
      'ScenEdit_DeleteUnit({guid="' ..suvunit.guid.. '"}) \r\n' ..
      'ScenEdit_DeleteReferencePoint ({side = SuvSide, name = "' ..rp1.name.. '"}) \r\n' ..
      'ScenEdit_DeleteReferencePoint ({side = SuvSide, name = "' ..rp2.name.. '"}) \r\n' ..
      'ScenEdit_DeleteReferencePoint ({side = SuvSide, name = "' ..rp3.name.. '"}) \r\n' ..
      'ScenEdit_DeleteReferencePoint ({side = SuvSide, name = "' ..rp4.name.. '"}) \r\n' ..
      'ScenEdit_DeleteMission (ResSide, suvunitname) \r\n' ..
      ' \r\n' ..
      'ScenEdit_SetEvent("' .. eventname .. '", {mode ="remove"}) \r\n' ..
      'ScenEdit_SetTrigger({mode = "remove", name = "' ..trigger1.. '"}) \r\n' ..
      'ScenEdit_SetTrigger({mode = "remove", name = "' ..trigger2.. '"}) \r\n' ..
      'ScenEdit_SetTrigger({mode = "remove", name = "' ..trigger3.. '"}) \r\n' ..
      'ScenEdit_SetAction ({mode = "remove", name = "' ..action..   '"})'

      ScenEdit_SetAction({mode= mode, name=action, type="LuaScript", ScriptText=ScriptText})
      ScenEdit_SetEventAction (eventname, {mode = mode, name = action})
    end
  end
end