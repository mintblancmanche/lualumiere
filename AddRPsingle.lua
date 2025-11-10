--ScenEdit_RunScript ("lualumiere/AddRPsingle.lua")

local selected = ScenEdit_SelectedUnits()
local side = ScenEdit_PlayerSide()

local bearing = tonumber( ScenEdit_InputBox("RP Bearing?") )
assert(bearing ~= nil, "canceled")
local radius = tonumber( ScenEdit_InputBox("RP radius?") )
assert(radius ~= nil, "canceled")

if selected.units ~= nil then
    ScenEdit_AddReferencePoint({side=side, relativeto=selected.units[1].name, bearing=bearing, distance=radius, highlighted=true, locked=false})
else
    local unit = VP_GetContact({guid=selected.contacts[1].guid})
    local rp = World_GetPointFromBearing({latitude=unit.latitude, longitude=unit.longitude, bearing=bearing, distance=radius})
    ScenEdit_AddReferencePoint({side=side, latitude=rp.latitude, longitude=rp.longitude, highlighted=true, locked=false})
end