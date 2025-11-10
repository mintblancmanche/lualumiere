--[[
ScenEdit_RunScript ("lualumiere/Misc_UnixToDate.lua")

local type = "UnitEntersArea"
local trigger = "EnterArea - Wpn"
local TargetFilter = {
  TargetSide = "Soviet Union",
  TargetType = "Weapon",
  TargetSubType = nil,
  SpecificUnitClass = nil,
  SpecificUnitID = nil
}

local Area = {"RP-2326", "RP-2327", "RP-2328", "RP-2329"}
local ETOA = UnixToDate(ScenEdit_CurrentTime()-31536000)
local LTOA = UnixToDate(ScenEdit_CurrentTime()+31536000)
local NOT = nil
local ExitArea = nil

ScenEdit_SetTrigger({mode = "add", name = trigger, type = type, TargetFilter = TargetFilter, Area = Area,
ETOA = ETOA, LTOA = LTOA, NOT = NOT, ExitArea = ExitArea})

local action = "Lua - TorpDpt"
local ScriptText = 'ScenEdit_RunScript ("lualumiere/UnitSub_TorpDpt.lua")'
ScenEdit_SetAction({mode= "add", name=action, type="LuaScript", ScriptText=ScriptText})

local eventname = "TorpDpt"
ScenEdit_SetEvent(eventname, {mode = "add", IsActive = True, IsRepeatable = true, IsShown = true, Probability = 100})
ScenEdit_SetEventTrigger (eventname, {mode = "add", name = trigger})
ScenEdit_SetEventAction (eventname, {mode = "add", name = action})
]]

local guid = UnitX().guid
local unit = ScenEdit_GetUnit({guid = guid})

if unit.subtype ~= "4001" then --NOT Torpedo
  return
end

local target, location, ceiling, floor, layer, depth
if unit.weapon.contact.type == "Activation Point" then --BOL launch
  target = World_GetLocation ({latitude = unit.course[1].latitude, longitude = unit.course[1].longitude})
  location = target
  ceiling = location.layer.ceiling
  floor = location.layer.floor
  layer = ceiling+( (floor-ceiling)/2 )
  depth = layer
else  --Surface or Submarine
  target = VP_GetContact({guid=unit.weapon.contact.guid})
  location = World_GetLocation ({latitude=target.latitude, longitude=target.longitude})
  ceiling = location.layer.ceiling
  floor = location.layer.floor
  layer = ceiling+( (floor-ceiling)/2 )

  if target.altitude == nil then
    depth = layer
  elseif target.altitude < floor then
    depth = ceiling+30
  else
    depth = layer
  end
end

function Fanshot()
  math.randomseed (os.time() )
    local zig = tonumber(ScenEdit_GetKeyValue("Torpedozig") )
    if zig == nil then
      ScenEdit_SetKeyValue("Torpedozig", math.random(0, 1) )
    elseif zig == 0 then
      ScenEdit_SetKeyValue("Torpedozig", 1)
    elseif zig == 1 then
      ScenEdit_SetKeyValue("Torpedozig", 0)
    end
    local zig = tonumber(ScenEdit_GetKeyValue("Torpedozig") )

  local range = Tool_Range(guid, {latitude = unit.course[1].latitude, longitude = unit.course[1].longitude})
  local bearing = Tool_Bearing(guid, {latitude = unit.course[1].latitude, longitude = unit.course[1].longitude})
  local gyroangle = bearing + 10 * (1-2*zig)

  if gyroangle <0 then
    gyroangle = gyroangle + 360
  elseif gyroangle >360 then
    gyroangle = gyroangle %360
  end
  local newpoint = World_GetPointFromBearing({latitude=unit.latitude, longitude=unit.longitude, bearing=gyroangle, distance=range})
  local course = { [1] = {latitude=newpoint.latitude, longitude= newpoint.longitude} }
  ScenEdit_SetUnit ({guid = guid, course = course})
end

local throttle = "Full"
if unit.speed > 35 then
  local throttle = "Cruise"
end

local range = Tool_Range(guid, target.guid)

if range > 5 then
  --if #unit.components == 3 then -- torpedo will zig (wire guided torpedo has three components)
  if ScenEdit_QueryDB("weapon", unit.dbid).guidance == 8 then -- torpedo will zig (wire guided torpedo has guidance code 8)
    math.randomseed (os.time() )
    local zig = tonumber(ScenEdit_GetKeyValue("Torpedozig") )
    if zig == nil then
      ScenEdit_SetKeyValue("Torpedozig", math.random(0, 1) )
    elseif zig == 0 then
      ScenEdit_SetKeyValue("Torpedozig", 1)
    elseif zig == 1 then
      ScenEdit_SetKeyValue("Torpedozig", 0)
    end
    local zig = tonumber(ScenEdit_GetKeyValue("Torpedozig") )

    local bearing = unit.heading+30*(1-2*zig)
    local distance = (range*3/4)/math.cos(30*math.pi/180)

    if bearing <0 then
      bearing = bearing+360
    elseif bearing >360 then
      bearing = bearing %360
    end

    local leg = World_GetPointFromBearing({latitude=unit.latitude, longitude=unit.longitude, bearing=bearing, distance=distance})
    local course = { [1] = {latitude=leg.latitude, longitude= leg.longitude} }
    ScenEdit_SetUnit ({guid = guid, course = course})
  else --no wire, fanshot
    Fanshot()
  end
elseif #unit.components ~= 3 then --no wire, fanshot
    Fanshot()
end

ScenEdit_SetUnit ({guid = guid, throttle = throttle, manualAltitude = depth})