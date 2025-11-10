--7000ft = 2135m and loadout = 9579 (TARPS)

if (ScenEdit_UnitX().loadoutID == 9579) and (ScenEdit_UnitX().altitude <= 2135) then
  return true
else
  return false
end