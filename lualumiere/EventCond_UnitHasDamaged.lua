--ScenEdit_RunScript ("lualumiere/EventCond_UnitHasDamaged.lua")

ScenEdit_RunScript ("lualumiere/Misc_UnixToDate.lua")

local time = UnixToDate(ScenEdit_CurrentTime())
local ConditionName = "EventCond_UnitHasDamaged - " ..ScenEdit_UnitX().name.. " #" ..time

local ScriptText = 'local damagedguid ="' ..ScenEdit_UnitX().guid..  '" \r\n' ..
  'if ScenEdit_UnitX().guid == damagedguid then \r\n' ..
  '  return false \r\n' ..
  'else \r\n' ..
  '  return true \r\n' ..
  'end'

ScenEdit_SetCondition ({mode = "add", name = ConditionName, type = "LuaScript", ScriptText = ScriptText})
ScenEdit_SetEventCondition (ScenEdit_EventX().details.description, {mode = "add", name = ConditionName})