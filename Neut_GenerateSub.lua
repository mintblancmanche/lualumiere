--[[
ScenEdit_RunScript ("lualumiere/Neut_GenerateSub.lua")
GenerateSub("Neutral", "PatASW")
]]

function GenerateSub(side, mission)
  ScenEdit_RunScript ("lualumiere/Misc_TableRandom.lua")
  math.randomseed(os.time() )

	unitids={}
	area = {}
	for k, v in pairs(ScenEdit_GetMission (side, mission).patrolmission.PatrolZone) do
			table.insert(area, v.name)
	end

	---use db3k/cwdb? (315532800=1980 UNIX time) {686, 687, 688} , {653, 654}

	if ScenEdit_CurrentTime() > 315532800 then
		--db3k
		bio = {354, 92, 355}
		fls = {93, 94, 95}
	else
		--cwdb
		bio = {220, 221, 92}
		fls = {93, 94, 95}
	end

	local qty = 10
	local flsqty = math.floor(qty/2)
	local bioqty = qty-flsqty

	--generate false contact
	for i = 1, flsqty do
		local name = "False Contact #" ..i
		local dbid = TableRandom(fls)[ math.random(1, #fls) ]
		local lat = "N0.00.00"
		local lon = "E0.00.00"
		local unit = ScenEdit_AddUnit({side=side, name=name, type="Submarine", dbid=dbid,latitude=lat,longitude=lon})
		ScenEdit_AssignUnitToMission(unit.guid, mission)
		table.insert(unitids, unit.guid)
	end

	--generate biologic contact
	for i = 1, bioqty do
		local number = flsqty + i
		local name = "Biologics #" ..number
		local dbid = TableRandom(bio)[ math.random(1, #bio) ]
		local lat = "N0.00.00"
		local lon = "E0.00.00"
		local unit = ScenEdit_AddUnit({side=side, name=name, type="Submarine", dbid=dbid,latitude=lat,longitude=lon})
		ScenEdit_AssignUnitToMission(unit.guid, mission)
		table.insert(unitids, unit.guid)
	end

	--set sub teleport event
	ScenEdit_SetTrigger({mode="add", name="RTime - 1hr (for GenerateSub)", type="RegularTime", Interval=8})
	ScenEdit_SetAction({mode="add", name="Teleport - " ..mission, type="TeleportInArea", UnitIDs=unitids, Area=area})

	ScenEdit_SetEvent("Teleport - " ..mission, {mode="add", isRepeatable = true})
	ScenEdit_SetEventTrigger ("Teleport - " ..mission, {mode = "add", name = "RTime - 1hr (for GenerateSub)"})
	ScenEdit_SetEventAction ("Teleport - " ..mission, {mode = "add", name="Teleport - " ..mission})
end