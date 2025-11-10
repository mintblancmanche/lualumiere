--ScenEdit_RunScript("lualumiere/Air_StrOecm.lua")
--Air_StrOecm(SideNameOrID, MissionNameOrID, range)

function StrOecm(SideNameOrID, MissionNameOrID, range)
	local mission = ScenEdit_GetMission (SideNameOrID, MissionNameOrID)
	local unitlist = mission.unitlist
	local targetlist = mission.targetlist

	for i = 1, #unitlist do
		local unit = ScenEdit_GetUnit({guid=unitlist[i]})
		ScenEdit_SetEMCON('Unit', '' .. unitlist[i] .. '', 'OECM=Passive')
		for n = 1, #targetlist do
			local range = Tool_Range(unitlist[i], targetlist[n])
			if range <= radius then
				ScenEdit_SetEMCON('Unit', '' .. unitlist[i] .. '', 'OECM=Active')
				break
			end
		end
	end
end
