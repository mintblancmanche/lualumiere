--[[
ScenEdit_RunScript ("lualumiere/Doctrine_SetWRA.lua")
local Table = {name='D89 HMS Exeter', guid='0f1b30f4-0982-4120-bec0-9a93be06b904'}
local IsEscort = false
local NoHelo = true
local WeaponDBID = 1641
local Salvo = 1
local Range = 25
SetWRA_Air(Table, IsEscort, NoHelo, WeaponDBID, Salvo, Range)

ScenEdit_RunScript ("lualumiere/Doctrine_SetWRA.lua")
local Table = {side = ScenEdit_PlayerSide(), mission="PatMix"}
local IsEscort = false
local NoHard = true
local NoTank = false
local WeaponDBID = 314
local Salvo = 3
local Range = "5nm"
SetWRA_Land(Table, IsEscort, NoHard, WeaponDBID, Salvo, Range)

local NoTiny = true
local Range = "5nm"
SetWRA_Surf(Table, IsEscort, NoTiny, WeaponDBID, Salvo, Range)
]]

function SetWRA_Air(Table, IsEscort, NoHelo, WeaponDBID, Salvo, Range)
  local fixwng = {
    1999, --Air_Contact_Unknown_Type
    2000, --Aircraft_Unspecified
  }
  for k, v in pairs (fixwng) do
    ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
      target_type=v, weapon_dbid=WeaponDBID}, {Salvo, 'MAX', Range, 'inherit'}) 
  end

  if NoHelo == true then
    Salvohelo = "None"
  else
    Salvohelo = Salvo
  end
  ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
    target_type=2100, weapon_dbid=WeaponDBID}, {Salvohelo, 'MAX', Range, 'inherit'}) --Helicopter_Unspecified

--  ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
--    target_type=2200, weapon_dbid=dbid}, {salvo, 'MAX', range, 'inherit'}) --Guided_Weapon_Unspecified
end

function SetWRA_Surf(Table, IsEscort, NoTiny, WeaponDBID, Salvo, Range)
  local surf = {
    2999, --Surface_Contact_Unknown_Type 
    3000, --Ship_Unspecified 
    3501, --Submarine_Surfaced 
  }
  for k, v in pairs (surf) do
    ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
    target_type=v, weapon_dbid=WeaponDBID}, {Salvo, 'MAX', Range, 'inherit'}) 
  end

  if NoTiny == true then
    Salvotiny = "None"
  else
    Salvotiny = Salvo
  end

  local tiny = {
    3101, --Ship_Surface_Combatant_0_500_tons
    3201, --Ship_Amphibious_0_500_tons
    3301, --Ship_Auxiliary_0_500_tons
    3401, --Ship_Merchant_Civilian_0_500_tons 
  }
  for k, v in pairs (tiny) do
    ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
    target_type=v, weapon_dbid=WeaponDBID}, {Salvotiny, 'MAX', Range, 'inherit'}) 
  end
end

function SetWRA_Land(Table, IsEscort, NoHard, WeaponDBID, Salvo, Range)
  local soft = {
    4999, --Land_Contact_Unknown_Type
    5000, --Land_Structure_Soft_Unspecified
    5300, --Radar_Unspecified
    5400  --Mobile_Target_Soft_Unspecified
    }
  for k, v in pairs (soft) do
    ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
    target_type=v, weapon_dbid=WeaponDBID}, {Salvo, 'MAX', Range, 'inherit'}) 
  end

  if NoHard == true then
    Salvohard = "None"
  else
    Salvohard = Salvo
  end

  local hard = {
    5100, --Land_Structure_Hardened_Unspecified
    5200 --Runway_Facility_Unspecified
    }
  for k, v in pairs (hard) do
    ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
    target_type=v, weapon_dbid=WeaponDBID}, {Salvohard, 'MAX', Range, 'inherit'}) 
  end

  if NoTank = true then
    Salvotank = "None"
  else
    Salvotank = Salvo
  end

    ScenEdit_SetDoctrineWRA({side=Table.side, unitname=Table.name, guid=Table.guid, mission=Table.mission, escort=IsEscort,
    target_type=5500, weapon_dbid=WeaponDBID}, {Salvotank, 'MAX', Range, 'inherit'}) --Mobile_Target_Hardened_Unspecified 
end