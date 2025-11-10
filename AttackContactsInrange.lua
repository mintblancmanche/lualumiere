--攻撃されていないコンタクトを探す



function AttackContactInRange(AttackerGUID, AttackRange)

--serch non attacked hostle contact (=which is not targeted by any weapons)
local weapons = VP_GetSide({Side ="RED"}):unitsBy("6")
print(weapons)

local contacts = VP_GetSide ({side="RED"}).contacts
local hostle = {}

for k, v in ipairs(contacts) do
	local contact = VP_GetContact({guid=v.guid})
	if contact.posture == "H" then
		table.insert(hostle, v.guid)
	end
end
print(hostle)

if next(weapons) ~= nil and next(hostle) ~= nil then
	for k, v in ipairs(hostle) do
		local contact = VP_GetContact({guid=v})
		if contact.targetedBy ~= nil then
			for k1, v1 in pairs(contact.targetedBy) do
				for k2, v2 in ipairs(weapons) do
					if v1 == v2.guid then
						table.remove (hostle, k)
						break
					end
				end
			end
		end
	end
	print(hostle)

	if next(hostle) ~= nil
		for k, v in ipairs(hostle) do
			local range = Tool_Range(AttackerGUID, v)
			if range <= AttackRange then
				ScenEdit_AttackContact (AttackerGUID, v, {mode=0})
			end
		end
	else
		print("all targets are engaged.")
	end		
else
	print("no weapon or hostle contact is found.")
end


local sj = '13a966e0-f257-4de5-9cc2-84d8ba94962b' --San Juan
local target = '1accce69-78f9-4e4f-84ae-99077dea5ebe'
local options = {mode=2, qty=2}

return ScenEdit_AttackContact (sj, target, options)

