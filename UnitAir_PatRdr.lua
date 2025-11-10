--ScenEdit_RunScript ("lualumiere/PatrolRadar.lua")

function PatrolRadar(SideNameOrID, MissionNameOrID, Radius)
	local aircontact = VP_GetSide ({side=SideNameOrID}):contactsBy("Aircraft")
	local unitlist = ScenEdit_GetMission(SideNameOrID, MissionNameOrID).unitlist

	for k, v in ipairs(unitlist) do
		local unit = ScenEdit_GetUnit({guid=v})
		ScenEdit_SetEMCON('Unit', v, 'Radar=Passive')

		if unit.unitstate == 'EngagedOffensive' then
			for k1, v1 in ipairs(aircontact) do
				if Tool_Range(v, v1.guid) <= Radius then
					ScenEdit_SetEMCON('Unit', v, 'Radar=Active')	
					break
				end
			end
		end
	end
end