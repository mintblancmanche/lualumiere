--ScenEdit_RunScript ("lualumiere/UnitAir_ReadyNow.lua")

--Ready aircraft now!!
--This magic special action sets all grounded aircraft ready.

--
local aircraft = VP_GetSide({side = ScenEdit_PlayerSide() }):unitsBy("1")
print(aircraft)

local unit
for k,v in pairs(aircraft) do
  unit = ScenEdit_GetUnit({guid=v.guid})
  if unit.airbornetime == "0" then
    ScenEdit_SetLoadout({unitname=unit.guid, LoadoutID = 0, TimeToReady_Minutes = 0})
  end
end