もっとかんたんなほうほうがあるのでゎ？

--ScenEdit_RunScript ("lualumiere/PickupTargetContact.lua")
--    1 = Aircraft
--    2 = Ship
--    3 = Submarine
--    4 = Facility
--    5 = Aimpoint
--    6 = Weapon
--    7 = Satellite
--    8 = Ground unit

function PickUpHostleContact(Side)
	local contacts = VP_GetSide ({side=Side}).contacts
	local hostle = {}
--pick up hostle contact as "hostle" table
	for k, v in ipairs(contacts) do
		local contact = VP_GetContact({guid=v.guid})
		if contact.posture == "H" then
			table.insert(hostle, v.guid)
		end
	end
	return hostle
end


function PickUpTargetContact(UnitGuid)
	local unit = ScenEdit_GetUnit({guid=UnitGuid})
	local contacts = VP_GetSide ({side=unit.side}).contacts
	local hostle = {}
--pick up hostle contact as "hostle" table
	for k, v in ipairs(contacts) do
		local contact = VP_GetContact({guid=v.guid})
		if contact.posture == "H" then
			table.insert(hostle, v.guid)
		end
	end
print(hostle)

--check contact has Unitguid as targettedBy table
local result = nil
	for k, v in ipairs(hostle) do
		local contact = VP_GetContact({guid=v})
		if contact.targetedBy ~= nil then
			for k1, v1 in pairs(contact.targetedBy) do
				if v1 == UnitX().guid then
					result = v
					--break
				end
			end
		end
	end
    return result
end