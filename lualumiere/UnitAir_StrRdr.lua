--ScenEdit_RunScript ("lualumiereStrikeRadar.lua")
--StrikeRadar("SideNameOrID", "MissionNameOrID", "Radius")

function StrikeRadar(SideNameOrID, MissionNameOrID, Radius)
	local mission = ScenEdit_GetMission (SideNameOrID, MissionNameOrID)
	local unitlist = mission.unitlist

	local escortlist = {}
	for i = 1, #unitlist do
		local unit = ScenEdit_GetUnit({guid=unitlist[i]})
		if unit.isEscort == true then
			table.insert(escortlist, unitlist[i])
		end
	end

	local contactlist = ScenEdit_GetContacts (SideNameOrID)
	local targetlist = {}
	for i = 1, #contactlist do
		if contactlist[i].type == "Air" then
			table.insert(targetlist, contactlist[i].guid
		end
	end

	for e = 1, #escortlist do
		local unit = ScenEdit_GetUnit({guid=escortlist[e]})
		ScenEdit_SetEMCON('Unit', escortlist[e], 'Radar=Passive')
		if unit.unitstate == 'EngagedOffensive' then
			for n = 1, #targets do
				local range = Tool_Range(escortlist[e], targetlist[n])
				if range <= Radius then
					ScenEdit_SetEMCON('Unit', '' .. escortlist[e] .. '', 'Radar=Active')
					break
				end
			end
		end
	end
end