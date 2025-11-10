--ScenEdit_RunScript ("lualumiere/Sound_Comm.lua")

math.randomseed(os.time() )
local d9 = math.random(1, 9) 

if d9 == 1 then
    ScenEdit_PlaySound("misc/WITPAE_Morse.sfx")
elseif d9 == 2 then
    ScenEdit_PlaySound("misc/WITPAE_Morse2.sfx")
elseif d9 == 3 then
    ScenEdit_PlaySound("misc/FATK_printer.wav")
elseif d9 == 4 then
    ScenEdit_PlaySound("misc/WITPAE_Morse3.sfx")
elseif d9 == 5 then
    ScenEdit_PlaySound("voices/RadioMsg.wav")
elseif d9 == 6 then
    ScenEdit_PlaySound("misc/WITPAE_Morse4.sfx")
elseif d9 == 7 then
    ScenEdit_PlaySound("misc/WITPAE_Telex1.SFX")
elseif d9 == 8 then
    ScenEdit_PlaySound("misc/WITPAE_Morse5.sfx")
else
    ScenEdit_PlaySound("misc/WITPAE_Morse6.sfx")
end