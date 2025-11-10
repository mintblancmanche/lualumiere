--[[
ScenEdit_RunScript ("lualumiere/Misc_GetTgtAngle.lua")

GetTgtAngle(UnitGUID, ContactGUID)
]]

function GetTgtAngle(UnitGUID, ContactGUID)
  local unit = ScenEdit_GetUnit({guid = UnitGUID})
  local contact = VP_GetContact({guid = ContactGUID})

  local tgtangle = nil
  if contact.heading ~= nil then
    tgtangle = math.abs(contact.heading-Tool_Bearing(ContactGUID, UnitGUID) )
    if tgtangle > 180 then
      tgtangle = 180-tgtangle%180
    end
  end
  return tgtangle
end