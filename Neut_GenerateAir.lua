local aircraft = {
	{dbid=2421, ferryRange=3800, loadoutid=14761}, --Boeing 737-700ER -- Commercial (Commercial), 2008
	{dbid=2424, ferryRange=4260, loadoutid=14762}, --Boeing 767-300 -- Commercial (Commercial), 1988
	{dbid=2425, ferryRange=5625, loadoutid=14765}, --Boeing 767-400ER -- Commercial (Commercial), 2002
	{dbid=2428, ferryRange=7250, loadoutid=9926}, --Airbus A.330-200 -- Commercial (Commercial), 1999
	{dbid=2429, ferryRange=5850, loadoutid=9928}, --Airbus A.330-300 -- Commercial (Commercial), 1995
	{dbid=2430, ferryRange=8000, loadoutid=14744}, --Airbus A.340-200 -- Commercial (Commercial), 1995
	{dbid=2431, ferryRange=6700, loadoutid=9930}, --Airbus A.340-300 -- Commercial (Commercial), 1995
	{dbid=2525, ferryRange=7260, loadoutid=9914}, --Boeing 747-400 -- Commercial (Commercial), 1990, 442x, Passenger
	{dbid=2526, ferryRange=6700, loadoutid=9912}, --Boeing 747-300M -- Commercial (Commercial), 1984, 21x, Combi, Passenger + Container
	{dbid=2531, ferryRange=6700, loadoutid=9912}, --Boeing 747-300 -- Commercial (Commercial), 1984, 56x, Passenger
	{dbid=2533, ferryRange=7360, loadoutid=9919}, --Boeing 747-400F -- Commercial (Commercial), 1994, 126x, Freighter
	{dbid=2534, ferryRange=7670, loadoutid=9917}, --Boeing 747-400ER -- Commercial (Commercial), 2003, 6x, ER Passenger
	{dbid=2536, ferryRange=7750, loadoutid=9918}, --Boeing 747-400ERF -- Commercial (Commercial), 2003, 40x, ER Freighter
	{dbid=2537, ferryRange=8000, loadoutid=9908}, --Boeing 747-8 -- Commercial (Commercial), 2012, Passenger
	{dbid=2538, ferryRange=7900, loadoutid=8288}, --Boeing 747-8F -- Commercial (Commercial), 2012, Freighter
	{dbid=2898, ferryRange=5800, loadoutid=15009}, --Gulfstream G550 -- Commercial (Commercial), 2004
	{dbid=2956, ferryRange=4220, loadoutid=15779}, --Gulfstream G-IV SP -- Commercial (Commercial), 1987
	{dbid=32, ferryRange=8650, loadoutid=9932}, --Airbus A.340-500 -- Commercial (Commercial), 2004
	{dbid=3704, ferryRange=3395, loadoutid=18354}, --Boeing 757-300 -- Commercial (Commercial), 1999
	{dbid=3974, ferryRange=8150, loadoutid=19912}, --Boeing 787-8 Dreamliner -- Commercial (Commercial), 2012
	{dbid=3975, ferryRange=8650, loadoutid=19915}, --Boeing 787-9 Dreamliner -- Commercial (Commercial), 2015
	{dbid=3976, ferryRange=7350, loadoutid=19919}, --Boeing 787-10 Dreamliner -- Commercial (Commercial), 2018
	{dbid=3977, ferryRange=5650, loadoutid=19921}, --Boeing 777-200 -- Commercial (Commercial), 1995
	{dbid=3978, ferryRange=8100, loadoutid=19923}, --Boeing 777-200ER -- Commercial (Commercial), 1997
	{dbid=3979, ferryRange=6400, loadoutid=19929}, --Boeing 777-300 -- Commercial (Commercial), 1998
	{dbid=3980, ferryRange=9800, loadoutid=19927}, --Boeing 777-200LR -- Commercial (Commercial), 1998
	{dbid=3981, ferryRange=8200, loadoutid=19933}, --Boeing 777-300ER -- Commercial (Commercial), 1998
	{dbid=3982, ferryRange=4900, loadoutid=19935}, --Boeing 777 Freighter -- Commercial (Commercial), 2009
	{dbid=3983, ferryRange=8650, loadoutid=19939}, --Airbus A.350-800 -- Commercial (Commercial), 2017
	{dbid=3984, ferryRange=8150, loadoutid=19942}, --Airbus A.350-900 -- Commercial (Commercial), 2015
	{dbid=3985, ferryRange=8400, loadoutid=19944}, --Airbus A.350-1000 -- Commercial (Commercial), 2019
	{dbid=3986, ferryRange=8900, loadoutid=19948}, --Airbus A.380-800 -- Commercial (Commercial), 2008
	{dbid=4012, ferryRange=2825, loadoutid=20017}, --Learjet 36A -- Civilian (Civilian), 1977
	{dbid=4044, ferryRange=3125, loadoutid=20138}, --MD-10-30F -- Commercial (Commercial), DC-10-30 Upgr
	{dbid=4045, ferryRange=6820, loadoutid=20140}, --MD-11 -- Commercial (Commercial), 1991, DC-10 Mod
	{dbid=4046, ferryRange=3950, loadoutid=20141}, --MD-11F -- Commercial (Commercial), 1991, DC-10 Mod
	{dbid=4461, ferryRange=3500, loadoutid=22574}, --Gulfstream III -- Commercial (Commercial), 1981
	--Private aircraft have database ferry range as their range
	{dbid=3244,ferryRange=1765, loadoutid=17394}, --King Air 350 -- Commercial (Commercial), 1991
	{dbid=2897,ferryRange=1400, loadoutid=15006}, --F406 Caravan II -- Civilian (Civilian), 1986
	{dbid=2558,ferryRange=2075, loadoutid=14738}, --Super King Air B200 -- Commercial (Commercial), 1975
	{dbid=3324,ferryRange=2240, loadoutid=17584}, --Pilatus PC-12 -- Commercial (Commercial), 1994
	{dbid=2557,ferryRange=465, loadoutid=9973}, --Piper PA-28 Cherokee -- Civilian (Civilian), 1962
	{dbid=1571,ferryRange=415, loadoutid=8396}, --Cessna 152 -- Civilian (Civilian), 1978
	{dbid=312,ferryRange=700, loadoutid=8398}, --Cessna 172 -- Civilian (Civilian), 1957
	{dbid=3943,ferryRange=970, loadoutid=19786}, --Cessna 208A Caravan -- Civilian (Civilian), 1985
	{dbid=3946,ferryRange=970, loadoutid=19790}, --Cessna 208A-675 Caravan -- Civilian (Civilian), 1998
	{dbid=3945,ferryRange=900, loadoutid=19787}, --Cessna 208B Grand Caravan -- Civilian (Civilian), 1991
	{dbid=3906,ferryRange=1150, loadoutid=19607}, --Cessna 337 Super Skymaster -- Civilian (Civilian), 1966
	{dbid=4254,ferryRange=1500, loadoutid=21851}, --Cessna 500 Citation I -- Civilian (Civilian), 1972
	{dbid=4255,ferryRange=2300, loadoutid=21854}, --Cessna 550 Citation II -- Civilian (Civilian), 1979
	{dbid=4257,ferryRange=2300, loadoutid=21858}, --Cessna 560 Citation Ultra -- Civilian (Civilian), 1995
	{dbid=4256,ferryRange=2300, loadoutid=21857}, --Cessna 560 Citation V -- Civilian (Civilian), 1988
}