--ScenEdit_RunScript ("lualumiere/RP_DrawSubBox.lua")

local side = ScenEdit_PlayerSide()
local selected = ScenEdit_SelectedUnits()
if selected == nil then
  ScenEdit_MsgBox("Aborted: Please select unit or contact!", 0)
  return
end

local dir = tonumber( ScenEdit_InputBox("Please enter direction of box.") )
if dir == nil then
  print("Cancelled.")
  return
end

unit = ScenEdit_GetUnit({guid = selected.units[1].guid})

ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=315+dir, distance=17.68, highlighted=true, locked=false})
ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=45+dir, distance=17.68, highlighted=true, locked=false})
ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=135+dir, distance=17.68, highlighted=true, locked=false})
ScenEdit_AddReferencePoint({side=side, relativeto=unit.guid, bearing=225+dir, distance=17.68, highlighted=true, locked=false})

print("RP generated!")