--[[
ScenEdit_RunScript ("lualumiere/Event_SetNewRandomTimeTrigger.lua")
ScenEdit_RunScript ("lualumiere/Misc_UnixToDate.lua")

SetNewRandomTimeTrigger(EventName, UnixToDate(ScenEdit_CurrentTime() ), UnixToDate(ScenEdit_CurrentTime()+(15*60) ))
]]

function SetNewRandomTimeTrigger(EventName, EarliestTime, LatestTime)
  local event = ScenEdit_GetEvent(EventName)
  local oldtriggername = event.details.triggers[1].RandomTime.Description
  ScenEdit_SetEventTrigger (EventName, {mode = "remove", name = oldtriggername})
  ScenEdit_SetTrigger({mode="remove", name = oldtriggername})

  local triggername = "RandomT - " ..EarliestTime.. " - " ..LatestTime
  ScenEdit_SetTrigger({mode = "add", name = triggername, type = "RandomTime", EarliestTime=earliesttime, LatestTime=latesttime})
  ScenEdit_SetEventTrigger(EventName, {mode="add", name = triggername})
end

