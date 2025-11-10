--ScenEdit_RunScript ("lualumiere/GenerateSurface.lua")

--local side = "Neutral"
--local mission = "Support #Lane1-1"
--local surfacetype = "merchant"
--local qty = 5
--GenerateSurface1(side, mission, surfacetype, qty)

--local side ="Neutral"
--local baseRP = {"RP-118", "RP-119", "RP-120", "RP-121"}
--local surfacetype = "merchant"
--local qty = 5
--GenerateSurface2(side, baseRP, surfacetype, qty)

---
function RandomPointFromRP(side, name, mindistance, maxdistance)
	local rp = ScenEdit_GetReferencePoint ({side=side, name=name})
	return World_GetPointFromBearing ({latitude=rp.latitude, longitude=rp.longitude,
		bearing=math.random(0, 359), distance=math.random(mindistance, maxdistance) }) 
end

ScenEdit_RunScript ("lualumiere/randomtable.lua")

---for mission

function GenerateSurface1(side, mission, surfacetype, qty)
	math.randomseed(os.time() )

	unitids={}

	local zone
	if ScenEdit_GetMission (side, mission).supportmission ~= nil then
		zone= ScenEdit_GetMission (side, mission).supportmission.Zone
	elseif ScenEdit_GetMission (side, mission).patrolmission ~= nil then
		zone= ScenEdit_GetMission (side, mission).patrolmission.Zone
	end

	area = {}
	for k, v in ipairs(zone) do
		table.insert(area, v.name)
	end

	---use db3k/cwdb? (315532800=1980 UNIX time)
	if ScenEdit_CurrentTime() > 315532800 then
		--db3k
		dbidtabl={
		merchant = {1599, 2034, 774, 2026, 775, 2027, 1374, 773, 2023, 222, 144, 145, 1006, 1002, 1317, 2033, 2035},
		ferry = {2025, 2025, 2025, 3291, 2024, 384, 384, 384},
		coastal = {2696, 1474, 1475, 2398, 1378, 1379, 1789, 2033, 2035},
		fishing = {2357, 2358, 2359, 16, 328},
		dhow = {1787, 1788},
		junk = {2355, 2353}
		}
	else
		--cwdb
		dbidtabl={
		merchant = {660, 252, 1870, 1871, 1868, 1867, 650, 663, 273, 256, 651, 259, 580, 655, 287, 1318,1873, 1875},
		ferry = {509, 509, 509, 509, 285},
		coastal = {603, 579, 664, 665, 1318, 1873, 1875},
		fishing ={508, 1865, 2219, 2218, 2117},
		dhow = {20, 357},
		junk = {1324, 1322}
		}
	end

	--generate
	for k, v in pairs(dbidtabl) do
		if surfacetype == k then
			surfacetype = v
		end
	end

	for i = 1, math.random(1, qty) do
		local name = "Merchant Shipping #" ..math.random(1000, 9999)
		local dbid = Randomtable(surfacetype)[ math.random(1, #surfacetype) ]
		local lat = "N0.00.00"
		local lon = "E0.00.00"
		local unit = ScenEdit_AddUnit({side=side, name=name, type="Ship", dbid=dbid,latitude=lat,longitude=lon})
		ScenEdit_AssignUnitToMission(unit.guid, mission)
		table.insert(unitids, unit.guid)
	end

	--set sub teleport event
	local eventname = "Randomteleport - " ..mission.. " #" ..math.floor(os.clock()*1000 )
	ScenEdit_SetTrigger({mode="add", name=eventname.. " (trigger)", type="RegularTime", Interval=0})
	ScenEdit_SetAction({mode="add", name=eventname.. " (action)", type="TeleportInArea", UnitIDs=unitids, Area=area})

	ScenEdit_SetEvent(eventname, {mode="add"})
	ScenEdit_SetEventTrigger (eventname, {mode="add", name=eventname.. " (trigger)"})
	ScenEdit_SetEventAction (eventname, {mode="add", name=eventname.. " (action)"})
	--ScenEdit_ExecuteEventAction("Teleport - " ..mission)
end

----for waypoint

function GenerateSurface2(side, surfacetype, qty, baseRP)
	math.randomseed(os.time() )

	if ScenEdit_CurrentTime() > 315532800 then
		--db3k
		dbidtabl={
		merchant = {1599, 2034, 774, 2026, 775, 2027, 1374, 773, 2023, 222, 144, 145, 1006, 1002, 1317, 2033, 2035},
		ferry = {2025, 2025, 2025, 3291, 2024, 384, 384, 384},
		coastal = {2696, 1474, 1475, 2398, 1378, 1379, 1789, 2033, 2035},
		fishing = {2357, 2358, 2359, 16, 328},
		dhow = {1787, 1788},
		junk = {2355, 2353}
		}
	else
		--cwdb
		dbidtabl={
		merchant = {660, 252, 1870, 1871, 1868, 1867, 650, 663, 273, 256, 651, 259, 580, 655, 287, 1318,1873, 1875},
		ferry = {509, 509, 509, 509, 285},
		coastal = {603, 579, 664, 665, 1318, 1873, 1875},
		fishing ={508, 1865, 2219, 2218, 2117},
		dhow = {20, 357},
		junk = {1324, 1322}
		}
	end

	for k, v in pairs(dbidtabl) do
		if surfacetype == k then
			surfacetype = v
		end
	end

	for i = 1, math.random(1, qty) do
		local d1000 = math.random(1000, 9999)
		local name = "Shipping #" ..d1000
		local dbid = Randomtable(surfacetype)[ math.random(1, #surfacetype) ]

		local course = {}
		local d2 = math.random(1,2) -- go or return
		if d2 == 1 then
			local startRPkey = math.random(1, #baseRP-1)
			startposition = RandomPointFromRP(side, baseRP[startRPkey], 1, 20)
			
			for i = startRPkey+1, #baseRP do
				local waypoint = RandomPointFromRP(side, baseRP[i], 1, 20)
				--waypoint must be on water?			
				table.insert(course, waypoint)
			end
		else
			local startRPkey = math.random(2, #baseRP)
			startposition = RandomPointFromRP(side, baseRP[startRPkey], 1, 20)

			for i = startRPkey-1, 1, -1 do
				local waypoint = RandomPointFromRP(side, baseRP[i], 1, 20)
				--waypoint must be on water?			
				table.insert(course, waypoint)
			end
		end

		local lat = startposition.latitude
		local lon = startposition.longitude
		local unit = ScenEdit_AddUnit({side=side, name=name, type="Ship", dbid=dbid,
		latitude=lat,longitude=lon, course=course})
	end
end
 