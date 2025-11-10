--ScenEdit_RunScript("lualumiere/PatrolOECM.lua")
--PatrolOECM("SideNameOrID", "MissionNameOrID", Radius)
--PatrolOECM2("SideNameOrID", "MissionNameOrID")

function PatrolOECM(SideNameOrID, MissionNameOrID, Radius)
	local aircontact = VP_GetSide ({side=SideNameOrID}):contactsBy("Aircraft")
	local unitlist = ScenEdit_GetMission(SideNameOrID, MissionNameOrID).unitlist

	for k, v in ipairs(unitlist) do
		local unit = ScenEdit_GetUnit({guid=v})
		ScenEdit_SetEMCON('Unit', '' .. v .. '', 'OECM=Passive')
		if unit.unitstate == 'EngagedOffensive' then
			for k1, v1 in ipairs(aircontact) do
				if Tool_Range(v, v1.guid) <= Radius then
					ScenEdit_SetEMCON('Unit', '' .. v .. '', 'OECM=Active')
					break
				end
			end
		end
	end
end

function PatrolOECM2(SideNameOrID, MissionNameOrID)
	local unitlist = ScenEdit_GetMission(SideNameOrID, MissionNameOrID).unitlist
	for i = 1, #unitlist do
		local unit = ScenEdit_GetUnit({guid=unitlist[i]})
		if unit.unitstate== 'EngagedOffensive' then
			ScenEdit_SetEMCON('Unit', '' .. unit.guid .. '', 'OECM=Active')
		else
			ScenEdit_SetEMCON('Unit', '' .. unit.guid .. '', 'OECM=Passive')
		end
	end
end