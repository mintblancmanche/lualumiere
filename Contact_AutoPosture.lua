--[[
ScenEdit_RunScript ("lualumiere/Contact_AutoPosture.lua")
AutoPosture(Side, 60)
]]

function AutoPosture(Side, Percent)
  local contacts = VP_GetSide({side = Side}).contacts

  for k, v in pairs (contacts) do
    local contact = VP_GetContact({guid = v.guid})

    math.randomseed(os.time() )
    local d100 = math.random(1, 100)
    if (contact.posture == "U") and (d100 <= Percent) then
      local actualunit = VP_GetUnit({guid = v.guid})
      local posture = ScenEdit_GetSidePosture(Side, actualunit.side)
      contact.posture = posture
    end
  end
end
