local UnitTable = {name='Flight Nail32', guid='d9ae8397-f67e-448b-b295-d4c457963cd7'}
  local unit = ScenEdit_GetUnit(UnitTable)
  local contacts = VP_GetSide ({side = unit.side}):contactsBy("4") --ships

  if contacts == nil then
    print("No contacts")
    return nil
  end

local unittable = {name='SAM Sec (Stinger MANPADS x 5)', guid='71d01b9a-b92b-4ce6-b48c-9564fe66f03e'}
local unit = ScenEdit_GetUnit (unittable)
print(unit)
if string.find(unit.classname, "SAM") ~= nil then
  print("SAM")
end

local x, y, z = pairs(contacts)
print(x)
print(y)
print(z)