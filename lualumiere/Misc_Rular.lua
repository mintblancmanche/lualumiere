--ScenEdit_RunScript("lualumiere/rular.lua")

local selected = ScenEdit_SelectedUnits()

if selected.contacts == nil then
    unit1 = selected.units[1].guid
    unit2 = selected.units[2].guid
elseif selected.units == nil then
    unit1 = selected.contacts[1].guid
    unit2 = selected.contacts[2].guid
else
    unit1 = selected.contacts[1].guid
    unit2 = selected.units[1].guid
end

local range = math.floor(Tool_Range(unit1, unit2)*10+0.5)/10
local bearing1 = math.floor(Tool_Bearing(unit1, unit2)*10+0.5)/10
local bearing2 = math.floor(Tool_Bearing(unit2, unit1)*10+0.5)/10

print("Range = " .. range .. " nm")
print("Bearing 1 (unit1-unit2) = " .. bearing1 .. " deg")
print("Bearing 2 (unit2-unit1) = " .. bearing2 .. " deg")
