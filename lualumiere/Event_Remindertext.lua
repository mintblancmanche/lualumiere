--[[
ScenEdit_RunScript ("lualumiere/Event_Remindertext.lua")
]]

ScenEdit_RunScript ("lualumiere/Event_DelayedEvent.lua")

local Eventname = "Remindertext Event"
ScenEdit_SetEvent(Eventname, {mode = "add", IsShown = true, IsRepeatable = true})

local action = "Lua - Remindertext Event"
local ScriptText = 'local side = ScenEdit_PlayerSide() \r\n' ..
  'local text = [[<P><EM>Message for every 3 hour scenario time.</EM></P>]]\r\n' ..
  'ScenEdit_SpecialMessage(side, text)\r\n' ..
  'ScenEdit_PlaySound("misc/Bugle - alert.wav")'
ScenEdit_SetAction({mode = "add", name = action, type = "LuaScript", ScriptText = ScriptText})
ScenEdit_SetEventAction (Eventname, {mode="add", name = action})

DelayedEventTriggerOnly(Eventname, 10800)
DelayedEventTriggerOnly(Eventname, 21600)
DelayedEventTriggerOnly(Eventname, 32400)
DelayedEventTriggerOnly(Eventname, 43200)
DelayedEventTriggerOnly(Eventname, 54000)
DelayedEventTriggerOnly(Eventname, 64800)
DelayedEventTriggerOnly(Eventname, 75600)
DelayedEventTriggerOnly(Eventname, 86400)