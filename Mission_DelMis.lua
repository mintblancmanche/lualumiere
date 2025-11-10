--local RPs = {"RP-1", "RP-2"}
--DelMis(RPs)

function DelMis(RPs)
  local text =
    'Will you keep/delete pre-generated mission/mission RP? \n\n' ..
    '"YES" - Keep mission/mission RP \n' ..
    '"NO" - Delete mission/mission RP'
  local yesno = ScenEdit_MsgBox(text, 4)

  if yesno == true then
    --keep mission and rp (do nothing)
  else
    local side = ScenEdit_PlayerSide()
    local missions = ScenEdit_GetMissions(side)

    for k, v in pairs(missions) do
      ScenEdit_DeleteMission(side, v.guid)
    end

    for k, v in pairs(RPs) do
      ScenEdit_DeleteReferencePoint ({side = side, name = v})
    end

    local text = "Deletion Completed. "
    ScenEdit_MsgBox(text, 0)
  end
end
