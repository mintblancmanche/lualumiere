by blu3 -  https://discord.com/channels/557667391438454800/557676287137939456/1207336966711025737

local side_name = 'RED' ------- NAME OF THE AI SIDE

function SetDoctrineUnit(unit,dbid,range)
  
  for k,i in ipairs({1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100}) do
    ScenEdit_SetDoctrineWRA({side=side_name, target_type=i, weapon_dbid=dbid}, {'1','inherit','inherit','inherit'})
  end

end
function AssignWRA(unit,dbid,max_range)
  local range
  if max_range > 80 then
    range = math.ceil(math.random(60,80)/100*max_range)
    SetDoctrineUnit(unit,dbid,range)
  elseif max_range > 40 then 
    range = math.ceil(math.random(30,50)/100*max_range)
    SetDoctrineUnit(unit,dbid,range)
  elseif max_range > 20 then
    range = math.ceil(math.random(20,30)/100*max_range)
    SetDoctrineUnit(unit,dbid,range)
  else
    SetDoctrineUnit(unit,dbid,'NEZ')
  end
end
local side = VP_GetSide({side=side_name})
local weapons_t = {}


for k2,unit in ipairs(side.units) do
  
  local u = SE_GetUnit({guid=unit.guid})
  local weapons
  if u.type == 'Aircraft' then
    --print(unit)
    weapons = ScenEdit_GetLoadout({unitname = u.guid})
    if weapons.weapons then
      for k3,w in ipairs(weapons.weapons) do
        if w.wpn_type == 2001 then
            local data = ScenEdit_QueryDB( 'weapon', w.wpn_dbid )
            AssignWRA(u, w.wpn_dbid, data.ranges.air.max)
        end
      end
    end
  elseif u.type == 'Facility' or u.type=='Ship' then
    --print(unit)
    local mounts = u.mounts
    if mounts ~= nil and #mounts > 0 then
      for i,m in ipairs(mounts) do
      local mount_weapons = m.mount_weapons
        if mount_weapons ~= nil then
            for _,w in ipairs(mount_weapons) do
              if w.wpn_type == 2001 then
                  local data = ScenEdit_QueryDB( 'weapon', w.wpn_dbid )
                  AssignWRA(u, w.wpn_dbid, data.ranges.air.max)
              end
            end
        end
      end
    end
  end
end