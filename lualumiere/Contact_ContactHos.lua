local side = "NATO"
local contacts = VP_GetSide ({side = side}):contactsBy("1") --Air

if next(contacts) == nil then
  print("No Contacts")
else
  print(contacts)
  local unknown = {}

  for k, v in pairs(contacts) do
    local contact = VP_GetContact({guid=v.guid})
    if contact.posture == "X" then
      table.insert(unknown, v.guid)
    end
  end
    print(unknown)

  if next(unknown) == nil then
    print("No Unknown")
  else
    for k, v in pairs(unknown) do
      local unit = VP_GetUnit ({guid = v})
        if unit.group == nil then
          print("unit is independent")
        else
          VP_GetContact({guid = v}).posture = "H"
        end
    end
  end
end




    1 = Aircraft
    2 = Ship
    3 = Submarine
    4 = Facility