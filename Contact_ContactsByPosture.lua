--[[ScenEdit_RunScript("lualumiere/Contact_ContactsByPosture.lua")
print(ContactsByPosture("North Korea") )
]]

function ContactsByPosture(Sidename)
  local contacts = VP_GetSide ({side = Sidename}).contacts

  if next(contacts) == nil then
--    print("No Contacts")
    return
  end

  local list = {unknown = {}, hostile = {}, neutral = {}, unfriendly = {}, friendly = {} }

  for k, v in pairs(contacts) do
    local contact = VP_GetContact({guid=v.guid})
    if contact.posture == "X" then
      table.insert(list.unknown, v.guid)
    elseif contact.posture == "H" then
      table.insert(list.hostile, v.guid)
    elseif contact.posture == "N" then
      table.insert(list.neutral, v.guid)
    elseif contact.posture == "U" then
      table.insert(list.unfriendly, v.guid)
    else
      table.insert(list.friendly, v.guid)
    end
  end

  return list
end