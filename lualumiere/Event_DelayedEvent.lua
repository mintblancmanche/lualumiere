--[[
ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")
DelayedEvent(Delay, ScriptText)

local Delay = 30
0  -1sec
1  -5sec
2  -15sec
3  -30sec
4  -1min
5  -5min
6  -15min
7  -30min
8  -1hour
9  -6hour
10 -12hour
11 -24hour
]]

function DelayedEvent(Delay, ScriptText)
  ScenEdit_RunScript ("lualumiere/Misc_UnixToDate.lua")
  local keyname = "DelayedEvent" .. ScenEdit_CurrentTime() + Delay
  local time = UnixToDate(ScenEdit_CurrentTime()+Delay) 
  local event_name = "DelayedEvent @" ..time
  local remove_event_name = event_name.. " - Remove Event"

  local eventactions = tonumber(ScenEdit_GetKeyValue(keyname) )
  if eventactions == nil then --delayed event does not exist, generate
    ScenEdit_SetKeyValue(keyname, 1)

    local action_name = event_name.. " - Action #1"
    local RemoveScript = 'ScenEdit_SetEvent("' .. event_name .. '", {mode = "remove"}) \r\n' ..
      'ScenEdit_SetTrigger({mode = "remove", name = "' ..event_name.. '"}) \r\n' ..
      'ScenEdit_SetAction({mode = "remove", name = "' ..action_name.. '"}) \r\n' ..
      'ScenEdit_SetAction({mode = "remove", name = "' ..remove_event_name.. '"}) \r\n' ..
      'ScenEdit_ClearKeyValue("' ..keyname.. '")'
    ScenEdit_SetTrigger({mode = "add", name = event_name, type = "Time", Time = time})
    ScenEdit_SetAction({mode = "add", name = action_name, type = "LuaScript", ScriptText = ScriptText})
    ScenEdit_SetAction({mode = "add", name = remove_event_name, type = "LuaScript", ScriptText = RemoveScript})
    ScenEdit_SetEvent(event_name, {mode="add", IsShown=false})
    ScenEdit_SetEventTrigger (event_name, {mode = "add", name = event_name})
    ScenEdit_SetEventAction (event_name, {mode = "add", name = action_name})
    ScenEdit_SetEventAction (event_name, {mode = "add", name = remove_event_name})
  else --delayed event exists, add action
    local eventactions = eventactions + 1
    ScenEdit_SetKeyValue(keyname, eventactions)

    local action_name = event_name.. " - Action #" ..eventactions
    local remove_name = action_name.. " - Remove"
    local RemoveScript = 'ScenEdit_SetAction({mode = "remove", name = "' ..action_name.. '"}) \r\n' ..
      'ScenEdit_SetAction({mode = "remove", name = "' ..remove_name.. '"})'
    ScenEdit_SetAction({mode = "add", name = action_name, type = "LuaScript", ScriptText = ScriptText})
    ScenEdit_SetAction({mode = "add", name = remove_name, type = "LuaScript", ScriptText = RemoveScript})
    ScenEdit_SetEventAction (event_name, {mode="remove", name = remove_event_name})
    ScenEdit_SetEventAction (event_name, {mode="add", name = action_name})
    ScenEdit_SetEventAction (event_name, {mode="add", name = remove_name})
    ScenEdit_SetEventAction (event_name, {mode="add", name = remove_event_name})
  end
end

function DelayedEventTriggerOnly(event_name, Delay)
  local triggername = "Time_" ..time

  ScenEdit_SetTrigger({mode="add", name=triggername, type="Time", Time=UnixToDate(ScenEdit_CurrentTime()+Delay) })
  ScenEdit_SetEventTrigger (event_name, {mode="add", name=triggername})
end