--[[
ScenEdit_RunScript ("lualumiere/Unit_CompDamage.lua")

local UnitTable = {name='PLA Victor III', guid='0593c70e-954d-4f1a-b557-262d61f2ad1b'}
CompDamage(UnitTable)
RestoreCompDamage(UnitTable)
AllCompDamage()
CompDamageEvent(Side)
]]

function CompDamage(UnitTable)
  local unit = ScenEdit_GetUnit(UnitTable)
  local damage = math.floor(((unit.damage.startdp-unit.damage.dp)/unit.damage.startdp)*100+0.5)

  math.randomseed(os.time() )
  for k, v in pairs (unit.sensors) do --sensor
    if v.sensor_status == 'Operational' then
      local d100 = math.random(100)
      if d100 < damage-20 then
        ScenEdit_SetUnitDamage({guid=unit.guid, components={ {v.sensor_guid, math.random(0,2)} } })
      end
    end
  end

  for k, v in pairs (unit.mounts) do --mount
    if v.mount_status == 'Operational' then
      local d100 = math.random(100)
      if d100 < damage-20 then
        ScenEdit_SetUnitDamage({guid=unit.guid, components={ {v.mount_guid, math.random(0,2)} } })
      end
    end
  end

  for k, v in pairs (unit.components) do --comm
    if (v.comp_type == 'CommDevice') and (v.comp_status == 'Operational') then
      local d100 = math.random(100)
      if d100 < damage-20 then
        ScenEdit_SetUnitDamage({guid=unit.guid, components={ {v.comp_guid, math.random(0,2)} } })
      end
    end
  end
end

function RestoreCompDamage(UnitTable)
  local unit = ScenEdit_GetUnit(UnitTable)
  for k, v in pairs (unit.components) do
    ScenEdit_SetUnitDamage({guid=unit.guid, components={ {v.comp_guid, "None"} } })
  end
end

function AllCompDamage(UnitTable)
  local unit = ScenEdit_GetUnit(UnitTable)
  for k, v in pairs (unit.components) do
    ScenEdit_SetUnitDamage({guid=unit.guid, components={ {v.comp_guid, 0} } })
  end
end


--local sides = VP_GetSides ()
--print(sides)
function CompDamageEvent(Side)
  local event = "CompDamage Event"
  ScenEdit_SetEvent(event, {mode="add", IsRepeatable=true})

  local damages = {25, 50, 75}

  for k, v in pairs (damages) do
    local mode = "add"
    local trigger = event.. " - " ..Side.. " - Ship - " ..v.. "%" 
    local type = "UnitDamaged"
    local TargetFilter={
      TargetSide= Side,
      TargetType= 2,
      TargetSubType= nil,
      SpecificUnitClass= nil,
      SpecificUnitID= nil
    }
    local DamagePercent = v
    ScenEdit_SetTrigger({mode = mode, name = trigger, type = type, TargetFilter = TargetFilter, DamagePercent = DamagePercent})
    ScenEdit_SetEventTrigger (event, {mode = "add", name = trigger})
  end

  local action = "Lua_CompDamage Event"
  local ScriptText = 
    'ScenEdit_RunScript ("lualumiere/Unit_CompDamage.lua") \r\n' ..
    'CompDamage({guid = ScenEdit_UnitX().guid})'
  ScenEdit_SetAction({mode = "add", name= action, type = "LuaScript", ScriptText = ScriptText})

  ScenEdit_SetEventAction (event, {mode="add", name = action})
end

--[[
local SideTable = {side = "Soviet Union"}
local sideops = ScenEdit_GetSideOptions (SideTable)
local side = VP_GetSide (SideTable) 

local chance, number
if     sideops.proficiency == 'Novice'  then chance = 60 number = 10
elseif sideops.proficiency == 'Cadet'   then chance = 40 number = 8
elseif sideops.proficiency == 'Regular' then chance = 20 number = 6 
elseif sideops.proficiency == 'Veteran' then chance = 10 number = 4
                                        else chance = 5  number = 2
end

local comptype = {"Sensor", "Mount", "CommDevice"}

math.randomseed(os.time() )

for k, v in pairs (side:unitsBy("2") ) do
  for i = 1, number do
    local d100 = math.random(100)
    if d100 < chance then
      local damage = ScenEdit_SetUnitDamage({guid=v.guid, components={ {'type', type = comptype[math.random(3)], 0} } })
      print(damage)
    end
  end
end
]]


--[[
math.randomseed(os.time() )
local UnitTable = {name='PLA Victor III', guid='0593c70e-954d-4f1a-b557-262d61f2ad1b'}
local unit = ScenEdit_GetUnit(UnitTable)



		{stringName = 'Novice', numberValue = 0},
		{stringName = 'Cadet', numberValue = 1},
		{stringName = 'Regular', numberValue = 2},
		{stringName = 'Veteran', numberValue = 3},
		{stringName = 'Ace', numberValue = 4},




local comptype = {"Sensor", "Mount", "CommDevice"}
ScenEdit_SetUnitDamage({guid=unit.guid, components={ {'type', type = comptype[math.random(3)], 0} } })
]]