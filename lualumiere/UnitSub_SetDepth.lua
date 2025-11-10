--[[
ScenEdit_RunScript ("lualumiere/UnitSub_SetDepth.lua")
SetDepth({name='B-112', guid='cc554ab2-c046-488f-b993-b63e86841e84'})
--50ft = 15.24m
--131ft = 40m
]]

function SetDepth(UnitTable)
  local unit = ScenEdit_GetUnit(UnitTable)

  if unit.fuel[4001].current/unit.fuel[4001].max < 0.3 then --diesel sub low on battery
    ScenEdit_SetUnit({guid = unit.guid, manualAltitude = -20})
    return
  end

  local location = World_GetLocation ({latitude=unit.latitude, longitude=unit.longitude})
  local ceiling = location.layer.ceiling
  local floor = location.layer.floor
  local layer = ceiling+( (floor-ceiling)/2 )

  --print("Layer ceiling = " ..ceiling)
  --print("Layer depth = " ..layer)
  --print("Layer floor = " ..floor)
  --print("Location depth = " ..location.altitude)

  local depth = {-21, -40, -50, math.floor(layer + (floor + layer)/2 + 0.5), location.altitude}

  if (ceiling-21)/2 < -21 then
    table.insert(depth, math.floor( (ceiling-21)/2 + 0.5) )
    table.insert(depth, math.floor( layer + 0.5) )
  end
  print(depth)

  local d100 = math.random(1, 100)
  if d100 <= 50 then --stay
    ScenEdit_SetUnit({guid = unit.guid, manualAltitude = unit.altitude})
    print("Steady at current depth")
    return
  end

  local d100 = math.random(1, 100)
  if unit.altitude > -30 and d100 <= 30 then --upscope
    ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")
    ScenEdit_SetUnit({guid = unit.guid, manualspeed = 2, manualAltitude = -30})
    ScenEdit_SetDoctrine({guid=unit.guid}, {dive_on_threat = 3})
    local Delay = 15
    local ScriptText = 'ScenEdit_SetUnit({guid ="' ..unit.guid.. '", manualspeed = nil, manualaltitude =' ..unit.altitude.. '})'
    DelayedEvent(Delay, ScriptText)
    print("Up Scope")
    return
  end

  for i = 1, #depth do
  	local k = math.random(#depth)
  	depth[i], depth[k] = depth[k], depth[i]
  end
  --print(depth)
  
  local makemydepth = depth[math.random(1,#depth)]
  ScenEdit_SetUnit({guid = unit.guid, manualAltitude = makemydepth})
  print("Make my depth " ..math.floor(makemydepth*3.28 + 0.5).. " feet, aye.")
end