--[[
ScenEdit_RunScript ("lualumiere/Camp_TSS/08_Gchange_1956/ChooseSub.lua")
]]

local msg = "You can choose one of two options for your unit.\n\n"..
"Yes - USS Nautilus, nuclear submarine (SSN)\n"..
"No - Wolfpack of three diesel submarine (SS)"

::redo::
local input1 = ScenEdit_MsgBox(msg, 4)

local msg2 = "Is is okay for your selection?\n"..
" (Cancel to previous dialog)"
local input2 = ScenEdit_MsgBox(msg2, 1)

if input2 == "Cancel" then
  goto redo
end

if input1 == "Yes" then
  ScenEdit_DeleteUnit({guid='141c01f2-571c-44d3-b984-f57f42be5c73'}) --Razorback
else
  ScenEdit_DeleteUnit({guid='1ae9a2ee-f3ee-4061-909a-91102412ceb9'}) --Nautilus
end