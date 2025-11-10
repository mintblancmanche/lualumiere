--ScenEdit_RunScript ("lualumiere/AddRPcircle.lua")

local side = ScenEdit_PlayerSide()

local selected = ScenEdit_SelectedUnits()
if selected == nil then
  ScenEdit_MsgBox("Aborted: Please select unit or contact!", 0)
  return
end

local radius = tonumber(ScenEdit_InputBox("Please enter desired RP raidus (nm).") )
assert(radius ~= nil, "canceled")

local numpoints = tonumber(ScenEdit_InputBox("Please enter how many RP will be generated.\n\n" ..
"3  = 120deg  interval\n" ..
"6  = 60deg   interval\n" ..
"8  = 45deg   interval\n" ..
"12 = 30deg   interval\n" ..
"16 = 22.5deg interval\n" ..
"24 = 15deg   interval") )
assert(numpoints ~= nil, "canceled")

if selected.units ~= nil then -- unit
	for k, v in ipairs(selected.units) do
    		for i = 0, 359, 360/numpoints do
			ScenEdit_AddReferencePoint({side=side, relativeto=v.name, bearing=i, distance=radius, highlighted=true, locked=false})
    		end
	end
else -- contact
	for k, v in ipairs(selected.contacts) do
		local unit = VP_GetContact({guid=v.guid})
		local circle = World_GetCircleFromPoint({latitude=unit.latitude, longitude=unit.longitude, numpoints=numpoints,radius=radius})
		for k, v in ipairs(circle) do
    			ScenEdit_AddReferencePoint({side=side, latitude=v.latitude, longitude=v.longitude, highlighted=true, locked=false})
		end
    	end
end