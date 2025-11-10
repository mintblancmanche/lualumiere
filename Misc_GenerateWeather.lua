ScenEdit_SetKeyValue ("weathervalue", 1)
math.randomseed(os.time() )

local weather = ScenEdit_GetWeather ()

print(weather.temperature)
print(weather.rainfall)
print(weather.undercloud)
print(weather.seastate)
----


https://www.data.jma.go.jp/cpd/monitor/climfig/?tm=normal&el=tn

--night = average-10
--dawn/dusk = average
--day = average+10

https://www.matrixgames.com/forums/viewtopic.php?f=10230&t=392955&p=5092303&hilit=temperature#p5092303


-----
local averagetemp = 10


math.randomseed(os.time() )
if ScenEdit_GetKeyValue ("weathervalue") == "" then
	ScenEdit_SetKeyValue ("weathervalue", math.random(1,3) )
end
local weathervalue = tonumber(ScenEdit_GetKeyValue ("weathervalue") )




local foggy = 5
local worse  = 20
local better = 40
local nochange = 40

local d100 = math.random(1,100)
if (weathervalue == 2 or weathervalue == 7) and (d100 <= foggy) then
	weathervalue = 7
elseif weathervalue == 7 and d100 >= foggy then
    weathervalue = 2
elseif d100 <= worse then
	weathervalue = weathervalue+1
elseif d100 <= worse+better then
	weathervalue = weathervalue-1	
end

if weathervalue == 0 then
	weathervalue = 1
elseif weathervalue == 6 then
	weathervalue = 5
end

ScenEdit_SetKeyValue ("weathervalue", weathervalue)
print(weathervalue)
local newweather ={
	[1] = {newrainfall = 0, newundercloud = math.random(0, 3)/10, newseastate = math.random(0, 2)},
	[2] = {newrainfall = 0,	newundercloud = math.random(4, 8)/10, newseastate = math.random(3, 5)},
	[3] = {newrainfall = math.random(1, 19),  newundercloud = math.random(4, 8)/10,  newseastate = math.random(3, 5)},
	[4] = {newrainfall = math.random(20, 29), newundercloud = math.random(4, 8)/10,  newseastate = math.random(6, 7)},
	[5] = {newrainfall = math.random(30, 50), newundercloud = math.random(9, 10)/10, newseastate = math.random(8, 9)},
	[6] = {},
	[7] = {newrainfall = 0, newundercloud = math.random(9, 10)/10, newseastate = math.random(0, 5)},
}

ScenEdit_SetWeather (math.random(averagetemp-7, averagetemp+7), newweather[weathervalue].newrainfall,
 newweather[weathervalue].newundercloud,  newweather[weathervalue].newseastate)


Calm 0
Light air 1
Light breeze 2
Gentle breeze 3
Moderate breeze 4
Fresh breeze 5
Strong breeze 6
7 Moderate gale
8 gale
9 Strong gale
10 Storm