--ScenEdit_RunScript ("lualumiere/Misc_TableRandom.lua")

function TableRandom(Table)
  math.randomseed(os.time() )
  for i = 1, #Table do
    local k = math.random(#Table)
    Table[i], Table[k] = Table[k], Table[i]
  end
  return Table
end