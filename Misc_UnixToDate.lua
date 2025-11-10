--[[
ScenEdit_RunScript ("lualumiere/Misc_UnixToDate.lua")
print( UnixToDate(ScenEdit_CurrentTime()) )
]]


function UnixToDate(Unix)
  if Unix < 0 then
    date = os.date("!*t", Unix+3155760000)
    date = (date.year-100).. "-" ..string.format("%02d", date.month).. "-" ..string.format("%02d", date.day).. " "       ..string.format("%02d", date.hour).. ":" ..string.format("%02d", date.min).. ":" ..string.format("%02d", date.sec)
  else
    date = os.date("!%Y-%m-%d %X", Unix)
  end

  return date
end