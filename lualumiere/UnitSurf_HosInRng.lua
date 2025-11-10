--[[
ScenEdit_RunScript ("lualumiere/UnitSurf_HosInRng.lua")
ScenEdit_RunScript ("lualumiere/Unit_WpnCheck.lua")

local UnitTable = {name='Group 34', guid='359126d6-36bf-42a2-af9c-0ec9e5f2e7bb'}
local unit = ScenEdit_GetUnit(UnitTable)
local MaxRange = 20
local WpnDBID = 1364
local weaponavailable = WpnCheck(UnitTable, WpnDBID)

if HosInRng(UnitTable, MaxRange) and (weaponavailable) > 0) then
  local salvo = math.ceil(weaponavailable/#HosInRng(UnitTable, MaxRange) )

    ScenEdit_SetDoctrineWRA({side = unit.side, mission = unit.mission.guid, weapon_dbid = WpnDBID, target_type= 2999},
      {salvo, 'MAX', "MAX", "inherit"}) 
    ScenEdit_SetDoctrineWRA({side = unit.side, mission = unit.mission.guid, weapon_dbid = WpnDBID, target_type= 3000},
      {salvo, 'MAX', "MAX", "inherit"})
elseif weaponavailable < 1 then
  unit.mission = 'None'

  local newmission = "Support-2 (Osa runaway)"
  ScenEdit_AssignUnitToMission (unit.guid, newmission)
end
]]

ScenEdit_RunScript ("lualumiere/Unit_WpnCheck.lua")

function AllowAutofire1(UnitTable, MaxRange, WpnDBID)
  local unit = ScenEdit_GetUnit(UnitTable)

  if HosInRng(UnitTable, MaxRange) and (WpnCheck(UnitTable, WeaponDBID) > 0) then
    local salvo = math.ceil((WpnCheck(UnitTable, WeaponDBID)/#HosInRng(UnitTable, MaxRange) ) )

    ScenEdit_SetDoctrineWRA({side = unit.side, guid = unit.guid, weapon_dbid = WpnDBID, target_type= 2999},
      {salvo, 'MAX', "MAX", "inherit"})
    ScenEdit_SetDoctrineWRA({side = unit.side, guid = unit.guid, weapon_dbid = WpnDBID, target_type= 3000},
      {salvo, 'MAX', "MAX", "inherit"})
  end
end

function HosInRng(UnitTable, MaxRange)
  local unit = ScenEdit_GetUnit(UnitTable)
  local contacts = VP_GetSide ({side = unit.side}):contactsBy("2") --ships

  if not contacts then
    print("No contacts")
    return nil
  end

  --pick up hostle contact as "hostle" table
  local hostile = {}
  for k, v in pairs(contacts) do
    local contact = VP_GetContact({guid=v.guid})
    if contact.posture == "H" then
      table.insert(hostile, v.guid)
    end
    print(hostile)
  end

  if next(hostile) then
    local hosinrng = {}
    for k, v in pairs(hostile) do
      local range = Tool_Range(unit.guid, v)

      if range < MaxRange then
        table.insert(hosinrng, {guid = v, range = range}) 
      end
    end
    
    if next(hosinrng) then
      return hosinrng
    else
      print("No hostile contact in range")
      return nil
    end
  else
    print("No hostile contact")
    return nil
  end
end
