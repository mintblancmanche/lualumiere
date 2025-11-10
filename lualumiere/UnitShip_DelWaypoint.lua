--[[
ScenEdit_RunScript ("lualumiere/UnitShip_DelWaypoint.lua")

local Side = ""
DelWaypoint(Side)
]]

function DelWaypoint(Side)
  local side = VP_GetSide({side = Side})

  local ships = side:unitsBy("2")
  local subs  = side:unitsBy("3")


  for k, v in pairs (ships) do
    ScenEdit_SetUnit({guid=v.guid, course= {} })
  end

  for k, v in pairs (subs) do
    ScenEdit_SetUnit({guid=v.guid, course= {} })
  end
end