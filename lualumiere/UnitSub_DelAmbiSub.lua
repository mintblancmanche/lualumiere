--ScenEdit_RunScript ("lualumiere/Sub_DelAmbiSub.lua")
--DelAmbiSub (side, AOUradius)

function DelAmbiSub (side, AOUradius)
  local side = VP_GetSide ({side=side})
  local subtabl = side:contactsBy("3")  -- submarine

  for k,v in pairs (subtabl) do
    local contact = VP_GetContact({guid=v.guid})

    if next(contact.areaofuncertainty) ~=nil then
      local aou = Tool_Range({latitude=contact.latitude, longitude=contact.longitude}, {latitude=contact.areaofuncertainty[1].latitude, longitude=contact.areaofuncertainty[1].longitude})
      if (aou > AOUradius) and (contact.age > 60)then
        contact:DropContact()
      end
    else
      --No AOU
    end
  end
end