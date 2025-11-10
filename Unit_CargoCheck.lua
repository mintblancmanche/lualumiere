--ScenEdit_RunScript ("lualumiere/Unit_CargoCheck.lua")
--return CargoCheck("Blue Airfield1", 9, 50)

function CargoCheck(UnitGUID, CargoDBID, Quota)
  local cargo = ScenEdit_GetUnit({guid = UnitGUID}).cargo
  print(cargo)

  if next(cargo) ~= nil then --unit has some cargo
    local qty = 0
    for k, v in pairs (cargo[1].cargo) do
        if v.dbid == CargoDBID then
          qty = qty + 1
        end
    end
    print(qty)
    if qty >= Quota then
      return true --enough cargo
    else
      return false --less cargo
    end
  else
    print("No cargo")
      return false --unit has no cargo
  end
end