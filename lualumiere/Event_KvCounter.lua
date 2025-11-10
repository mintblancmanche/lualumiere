--[[
ScenEdit_RunScript ("lualumiere/Event_KvCounter.lua")
KvCounter(KvName)

--ScenEdit_ClearKeyValue(name)
]]

function KvCounter(KvName)
  local number = tonumber(ScenEdit_GetKeyValue(KvName) )

  if number == nil then
    ScenEdit_SetKeyValue(KvName, 1)
  else
    number = ScenEdit_SetKeyValue(KvName, number + 1)
  end

  return tonumber(ScenEdit_GetKeyValue(KvName) )
end