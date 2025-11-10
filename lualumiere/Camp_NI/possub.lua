--[[
ScenEdit_RunScript ("lualumiere/Camp_NI/possub.lua")
]]

math.randomseed(os.time() )

local side
if math.random(1, 3) <= 2 then
  side = "Soviet Union"
else
  side = "Biological"
end

local subs = VP_GetSide({side=side}):unitsBy("3")
print(subs)

local k = math.random(1, #subs)
local unit = ScenEdit_GetUnit({guid=subs[k].guid})
print(unit)

local latitude = unit.latitude
local longitude = unit.longitude
local distance = math.random(1, 100)
local bearing = math.random(0, 359)

local point = World_GetPointFromBearing ({latitude=latitude, longitude=longitude, distance=distance, bearing=bearing})
print(point)

ScenEdit_RunScript ("lualumiere/Misc_UnixToDate.lua")

local side = "NATO"
local name = "PROBSUB @" ..UnixToDate(ScenEdit_CurrentTime() ).. ""
local latitude = point.latitude
local longitude = point.longitude
local highlighted = true
local locked = true

ScenEdit_AddReferencePoint ({side=side, name=name, latitude=latitude, longitude=longitude, highlighted=highlighted, locked=locked})
