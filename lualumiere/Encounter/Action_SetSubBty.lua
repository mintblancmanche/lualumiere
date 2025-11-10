--[[
ScenEdit_RunScript ("lualumiere/Encounter/Action_SetSubBty.lua")
]]

math.randomseed(os.time() )

local oberon = {name='S16 HMS Oracle', guid='4ef6ee1f-efe1-4416-8346-84f4cb0535db'}
local guid = oberon.guid
local unit = ScenEdit_GetUnit({guid = guid})
local fuel = { {4001, math.floor(0.5+unit.fuel[4001].max*(math.random(55, 90)/100 ) )} } 
ScenEdit_SetUnit({guid = guid, fuel = fuel})

local foxtrot = {name='B-112', guid='cc554ab2-c046-488f-b993-b63e86841e84'}
local guid = foxtrot.guid
local unit = ScenEdit_GetUnit({guid = guid})
local fuel = { {4001, math.floor(0.5+unit.fuel[4001].max*(math.random(55, 90)/100 ) )} } 
ScenEdit_SetUnit({guid = guid, fuel = fuel})

local tango = {name='B-546', guid='f8b527b4-359e-4d21-a90b-ea0e161ac59c'}
local guid = tango.guid
local unit = ScenEdit_GetUnit({guid = guid})
local fuel = { {4001, math.floor(0.5+unit.fuel[4001].max*(math.random(55, 90)/100 ) )} } 
ScenEdit_SetUnit({guid = guid, fuel = fuel})