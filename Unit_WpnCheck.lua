--[[
ScenEdit_RunScript ("lualumiere/Unit_WpnCheck.lua")

local UnitTable = {name='TG November', guid='b00afbfa-cafc-4866-a61e-2e5114c84b00'}
local WpnDBID = 1131
local qty = 2
WpnCheck(UnitTable, WpnDBID)


local unit = ScenEdit_GetUnit(UnitTable)
if WpnCheck(UnitTable, WpnDBID) < qty then
  unit.mission = 'None'

  local newmission = "Support-2 (Osa runaway)"
  ScenEdit_AssignUnitToMission (unit.guid, newmission)
end
]]

function WpnCheck(UnitTable, WpnDBID)
  local unit = ScenEdit_GetUnit(UnitTable)
  local qty = 0
  print(unit.type)

  if unit.type == "Group" then
    for k, v in pairs (unit.group.unitlist) do
      local UnitTable = {guid = v}
      qty = qty + WpnCheckSubfnc(UnitTable, WpnDBID)
    end
  else
    qty = WpnCheckSubfnc(UnitTable, WpnDBID)
  end

  return qty
end

function WpnCheckSubfnc(UnitTable, WpnDBID)
  local unit = ScenEdit_GetUnit(UnitTable)
  local subqty = 0
  for k, v in pairs(unit.magazines) do
    for k1, v1 in pairs (v.mag_weapons) do
      if v1.wpn_dbid == WpnDBID then
        subqty = subqty + v1.wpn_current
      end
    end
  end

  for k, v in pairs(unit.mounts) do
    for k1, v1 in pairs (v.mount_weapons) do
      if v1.wpn_dbid == WpnDBID then
        subqty = subqty + v1.wpn_current
      end
    end
  end

  return subqty
end
