--[[ScenEdit_RunScript("lualumiere/Unit_TargetList.lua")

print(TargetList({name='Charlie K-479', guid='413275db-36a4-4416-9af7-9f9dadbdc4a1'}) )
]]

function TargetList(UnitTable)
  local unit = ScenEdit_GetUnit(UnitTable)
  local contacts = VP_GetSide ({side = unit.side}).contacts
  local targets = {}

  for k, v in pairs(contacts) do
    local contact = VP_GetContact({guid=v.guid})
    if contact.targetedBy ~= nil then
      for k1, v1 in pairs(contact.targetedBy) do
        if v1 == unit.guid then
          table.insert(targets, v.guid)
          break
        end
      end
    end
  end

  return targets
end
