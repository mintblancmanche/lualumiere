local unit1 = tostring(ScenEdit_GetKeyValue("unit1") )
local unit2 = tostring(ScenEdit_GetKeyValue("unit2") )

local unit1 = ScenEdit_GetUnit({guid=unit1})
local unit2 = ScenEdit_GetUnit({guid=unit2})

local floor1 = World_GetLocation ({latitude=unit1.latitude, longitude=unit1.longitude}).altitude
local floor2 = World_GetLocation ({latitude=unit2.latitude, longitude=unit2.longitude}).altitude

local distance = math.floor(Tool_Range(unit1.guid, unit2.guid)*10+0.5)/10
local side = ScenEdit_PlayerSide()
local text = '<P>Current range is ' .. distance .. 'nm.</P>\r\n' ..
"<P>" ..unit1.name.. " depth = " ..math.floor(0.5+unit1.altitude*3.28084).. "/" ..math.floor(0.5+floor1*3.28084).. "/" ..math.floor(0.5+math.abs(floor1-unit1.altitude)*3.28084)..  "ft to floor</P>\r\n" ..
"<P>" ..unit2.name.. " depth = " ..math.floor(0.5+unit2.altitude*3.28084).. "/" ..math.floor(0.5+floor2*3.28084).. "/" ..math.floor(0.5+math.abs(floor2-unit2.altitude)*3.28084)..  "ft to floor</P>"

ScenEdit_SpecialMessage(side, text)