--local UnitTable = {"Unit1guid", "Unit2guid", "Unit3guid"}
--local RPside = "Neutral"
--local RPTable = {"RP-1", "RP-2", "RP-3", "RP-4"}
--TeleUnitToRP (UnitTable, RPside, RPTable)

function TeleUnitToRP (UnitTable, RPside, RPTable)
  math.randomseed(os.time() )
  ScenEdit_RunScript ("lualumiere/Misc_TableRandom.lua")

  for k, v in pairs (UnitTable) do
    local rpname = TableRandom(RPTable)[math.random(#RPTable) ]
    local rp = ScenEdit_GetReferencePoint({side = RPside, name = rpname })

    ScenEdit_SetUnit({guid=v, latitude=rp.latitude, longitude=rp.longitude})
    table.remove(RPtabl, rpname)
  end
end




