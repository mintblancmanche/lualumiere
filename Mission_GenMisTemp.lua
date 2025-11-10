--[[
ScenEdit_RunScript ("lualumiere/Mission_GenMisTemp.lua")
GenMis_PatCAP()
GenMis_PatNav()
GenMis_PatSub()
GenMis_PatGrd()
GenMis_PatMix()
GenMis_PatSEAD()
GenMis_PatASW()
GenMis_SupAEW()
GenMis_SupJAM()
GenMis_StrAir()
]]

function GenMis_PatCAP()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatCAP"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'AAW'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = true
    ,CheckWWR = false
    ,UseFlightSize = true
    ,FlightSize = 2
    ,FlightsToInvestigate = 1
    ,FlightsToEngage = 3
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "36000FT"
    ,StationThrottleAircraft = "Loiter"
    ,StationAltitudeAircraft = "36000FT"
    ,AttackThrottleAircraft = "Military"
    ,AttackAltitudeAircraft = "36000FT"
    ,AttackDistanceAircraft = "30"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {ignore_plotted_course=false})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {weapon_state_planned=4022})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {weapon_state_rtb = 1})
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Passive')
end

function GenMis_PatNav()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatNav"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'NAVAL'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = true
    ,CheckWWR = false
    ,UseFlightSize = true
    ,FlightSize = 2
    ,FlightsToInvestigate = 1
    ,FlightsToEngage = 2
    ,BoatsToInvestigate = nil --not working
    ,BoatsToEngage = nil --not working
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "36000FT"
    ,StationThrottleAircraft = "Loiter"
    ,StationAltitudeAircraft = "36000FT"
    ,AttackThrottleAircraft = "Full"
    ,AttackAltitudeAircraft = nil --not working
    ,AttackDistanceAircraft = "40"
    ,TransitThrottleShip = "Cruise"
    ,StationThrottleShip = "Cruise"
    ,AttackThrottleShip = "Cruise"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {kinematic_range_for_torpedoes=0})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {ignore_plotted_course=false})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {use_sams_in_anti_surface_mode = true})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {use_wp_missile_in_anti_surface_mod = true})
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Passive')
end

function GenMis_PatSub()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatSub"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'SEA'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = false
    ,CheckWWR = false
    ,BoatsToInvestigate = nil --not working
    ,BoatsToEngage = nil --not working
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleSubmarine = 1
    ,TransitDepthSubmarine = "-850FT"
    ,StationThrottleSubmarine = 1
    ,StationDepthSubmarine = "-200FT"
    ,AttackThrottleSubmarine = 1
    ,AttackDepthSubmarine = "-450FT"
    ,AttackDistanceSubmarine = 20
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {kinematic_range_for_torpedoes=1})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {ignore_plotted_course=false})
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Passive')
end

function GenMis_PatGrd()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatGrd"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'LAND'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = true
    ,CheckWWR = false
    ,UseFlightSize = true
    ,FlightSize = 2
    ,FlightsToInvestigate = 1
    ,FlightsToEngage = 2
    ,BoatsToInvestigate = nil --not working
    ,BoatsToEngage = nil --not working
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "36000FT"
    ,StationThrottleAircraft = "Cruise"
    ,StationAltitudeAircraft = "5000FT"
    ,AttackThrottleAircraft = "Full"
    ,AttackAltitudeAircraft = nil --not working
    ,AttackDistanceAircraft = "40"
    ,TransitThrottleShip = "Cruise"
    ,StationThrottleShip = "Cruise"
    ,AttackThrottleShip = "Cruise"
  }


  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {gun_strafing = 1}) --true
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Passive')
end

function GenMis_PatMix()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatMix"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'MIXED'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = true
    ,CheckWWR = false
    ,UseFlightSize = true
    ,FlightSize = 2
    ,FlightsToInvestigate = 1
    ,FlightsToEngage = 2
    ,BoatsToInvestigate = nil --not working
    ,BoatsToEngage = nil --not working
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "36000FT"
    ,StationThrottleAircraft = "Cruise"
    ,StationAltitudeAircraft = "10000FT"
    ,AttackThrottleAircraft = "Full"
    ,AttackAltitudeAircraft = nil --not working
    ,AttackDistanceAircraft = "40"
    ,TransitThrottleShip = "Cruise"
    ,StationThrottleShip = "Cruise"
    ,AttackThrottleShip = "Cruise"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {kinematic_range_for_torpedoes=0})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {ignore_plotted_course=false})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {use_sams_in_anti_surface_mode = true})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {use_wp_missile_in_anti_surface_mod = true})
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Passive')
end

function GenMis_PatSEAD()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatSEAD"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'SEAD'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = true
    ,CheckWWR = false
    ,UseFlightSize = true
    ,FlightSize = 2
    ,FlightsToInvestigate = 1
    ,FlightsToEngage = 2
    ,BoatsToInvestigate = nil --not working
    ,BoatsToEngage = nil --not working
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "36000FT"
    ,StationThrottleAircraft = "Cruise"
    ,StationAltitudeAircraft = "10000FT"
    ,AttackThrottleAircraft = "Full"
    ,AttackAltitudeAircraft = nil --not working
    ,AttackDistanceAircraft = "40"
    ,TransitThrottleShip = "Cruise"
    ,StationThrottleShip = "Cruise"
    ,AttackThrottleShip = "Cruise"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Passive')
end

function GenMis_PatASW()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "PatASW"
  local MissionType = "Patrol"
  local MissionOptions ={type = 'ASW'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,CheckOPA = false
    ,CheckWWR = false
    ,UseFlightSize = true
    ,FlightSize = 1
    ,FlightsToInvestigate = 2
    ,FlightsToEngage = 4
    ,BoatsToInvestigate = nil --not working
    ,BoatsToEngage = nil --not working
    ,PatrolZone = nil
    ,ProsecutionZone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "36000FT"
    ,StationThrottleAircraft = "Loiter"
    ,StationAltitudeAircraft = "1000FT"
    ,AttackThrottleAircraft = "Cruise"
    ,AttackAltitudeAircraft = nil --not working
    ,AttackDistanceAircraft = "40"
    ,TransitThrottleShip = "Cruise"
    ,StationThrottleShip = "Cruise"
    ,AttackThrottleShip = "Cruise"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {kinematic_range_for_torpedoes=1})
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {weapon_state_rtb = 2})
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Active;Sonar=Active')
end

function GenMis_SupAEW()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "SupAEW"
  local MissionType = "Support"
  local MissionOptions ={ zone = {} }


  ScenEdit_AddMission(SideNameOrId,mission, MissionType, MissionOptions)

  local MissionOptions = {
    OneThirdRule = false
    ,OnStation = 1
    ,FlightSize = 1
    ,UseFlightSize = false
    ,Zone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "108000FT"
    ,StationThrottleAircraft = "Loiter"
    ,StationAltitudeAircraft = "108000FT"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {use_refuel_unrep = 1})
  ScenEdit_SetEMCON("Mission", mission, 'Radar=Active')
end

function GenMis_SupJAM()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "SupJAM"
  local MissionType = "Support"
  local MissionOptions ={ zone = {} }


  ScenEdit_AddMission(SideNameOrId,mission, MissionType, MissionOptions)

  local MissionOptions = {
    OneThirdRule = true
    ,OnStation = 1
    ,FlightSize = 0
    ,UseFlightSize = false
    ,Zone = nil
    ,TransitThrottleAircraft = "Cruise"
    ,TransitAltitudeAircraft = "108000FT"
    ,StationThrottleAircraft = "Loiter"
    ,StationAltitudeAircraft = "108000FT"
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {use_refuel_unrep = 1})
  ScenEdit_SetEMCON("Mission", mission, 'OECM=Active')
end

function GenMis_StrAir()
  local SideNameOrId = ScenEdit_PlayerSide()
  local mission = "StrAir"
  local MissionType = "Strike"
  local MissionOptions ={type = 'AIR'}

  ScenEdit_AddMission(SideNameOrId,mission, MissionType,MissionOptions)

  local MissionOptions = {
    UseFlightSize = true
    ,FlightSize = 2
  }

  ScenEdit_SetMission (SideNameOrId, mission, MissionOptions) 

  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {weapon_state_planned = 3003}) --ShotgunBVR_WVR_Guns
  ScenEdit_SetDoctrine({side=SideNameOrId, mission=mission}, {weapon_state_rtb = 2}) --0 = No, 1 = YesLastUnit. 2 = YesFirstUnit. 3 = YesLeaveGroup

  ScenEdit_SetEMCON("Mission", mission, 'Radar=Active')
end