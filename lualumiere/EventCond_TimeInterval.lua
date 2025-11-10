--[[
ScenEdit_RunScript ("lualumiere/EventCond_TimeInterval.lua")
TimeInterval(3)
]]

function TimeInterval(Interval)
  local time = ScenEdit_CurrentTime()
  if time < 0 then
    time = time+3155760000
  end

  local timetable = os.date("!*t", time)
  print(timetable)

  if timetable.hour %tonumber(Interval) == 0 then --3, 6, 9, 12, 15, 18, 21, 24

    return true
  else
    return false
  end
end