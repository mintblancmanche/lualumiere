local target = '69702e1f-1bab-4cc0-b415-8727e4185ab7'

local guid = ScenEdit_UnitX().guid
ScenEdit_DeleteUnit({guid=guid})

local newside = "PLAYER"
ScenEdit_SetUnitSide({guid=target, newside=newside})

local zone = {}
local rp1 = ScenEdit_AddReferencePoint({side = newside, relativeto = target, bearing=0, distance=0.5})
local rp2 = ScenEdit_AddReferencePoint({side = newside, relativeto = target, bearing=120, distance=0.5})
local rp3 = ScenEdit_AddReferencePoint({side = newside, relativeto = target, bearing=240, distance=0.5})
table.insert(zone, rp1.name)
table.insert(zone, rp2.name)
table.insert(zone, rp3.name)

ScenEdit_AddMission (newside, target, 'Mining', {zone=zone})
ScenEdit_SetMission (newside, target, {Armingdelay = "45"})
      
ScenEdit_AssignUnitToMission (target, target)

ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")


local ScriptText = 
  'local side = "' ..newside.. '" \r\n' ..
  'local target = "' ..target.. '" \r\n' ..
  ' \r\n' ..
  'ScenEdit_DeleteUnit({guid="' ..target.. '"}) \r\n' ..
  'ScenEdit_DeleteReferencePoint ({side = side, name = "' ..rp1.name.. '"}) \r\n' ..
  'ScenEdit_DeleteReferencePoint ({side = side, name = "' ..rp2.name.. '"}) \r\n' ..
  'ScenEdit_DeleteReferencePoint ({side = side, name = "' ..rp3.name.. '"}) \r\n' ..
  'ScenEdit_DeleteMission (side, target) '

DelayedEvent(target, 30, ScriptText)


--予備
if unit.dbid == 710 then --Mk37
  ScenEdit_EventX().isActive = false

  local unitname = "Mine Target #1"
  local side = "PLAYER"

  ScenEdit_SetUnitSide({unitname=unitname, newside=side})

  local misname = "Mine-1"
  local mistype = "Mining"
  local zone = {'RP-32','RP-33','RP-34'}

  local mission = ScenEdit_AddMission (side, misname, mistype, {zone = zone})
  print(mission)

  local armingdelay = "0:0:0:30"
  ScenEdit_SetMission(side, misname, {Armingdelay = armingdelay})

  ScenEdit_AssignUnitToMission(unitname, misname)
end