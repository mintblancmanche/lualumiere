local time = ScenEdit_CurrentTime()
local time = string.upper( os.date("!%d%H%MZ %b %y", time) )
print(time)

--print(string.upper(os.date("%Y %b %d %H%M Z", time)))

--ScenEdit_RunScript ("eclairlua/Displaytime.lua")

1970年より前
https://www.matrixgames.com/forums/viewtopic.php?f=10236&t=392735&p=5075974#p5075974

local currenttime = ScenEdit_CurrentTime()

local time
if currenttime <0 then
    time = os.date("!*t", currenttime+4070908800)
    time = (time.year-129).. "-" ..string.format("%02d", time.month).. "-" ..string.format("%02d", time.day).. " "
    	..EpochToUTC_Time(currenttime)
else
    time = os.date("!%Y-%m-%d %X", currenttime)
end

print(time)


yyyy-mm-dd hh:mm:ss
yyyy/mm/dd hh:mm:ss形式

ーーー

local earliesttime = "1955-12-05 13:00:00"
local latesttime = "1955-12-05 14:00:00"

ScenEdit_SetTrigger({mode="update", name="Randomtime", EarliestTime=earliesttime, LatestTime=latesttime})


----
local Delay = 15*60

local time
if ScenEdit_CurrentTime() <0 then
	time = os.date("!*t", ScenEdit_CurrentTime()+3155760000+Delay)
	time = (time.year-100).. "-" ..string.format("%02d", time.month).. "-" ..string.format("%02d", time.day).. " "
			..string.format("%02d", time.hour).. ":" ..string.format("%02d", time.min).. ":" ..string.format("%02d", time.sec)
else
	time = os.date("!%Y-%m-%d %X", ScenEdit_CurrentTime()+Delay)
end

local triggername = "Time_" ..time
local eventname = "006_MBoat flee"

ScenEdit_SetTrigger({mode="add", name=triggername, type="Time", Time=time})
ScenEdit_SetEventTrigger (eventname, {mode="add", name=triggername})
-----







http://noriko3.blog42.fc2.com/blog-entry-128.html
%a	abbreviated weekday name (e.g., Wed)
%A	full weekday name (e.g., Wednesday)
%b	abbreviated month name (e.g., Sep)
%B	full month name (e.g., September)
%c	date and time (e.g., 09/16/98 23:48:10)
%d	day of the month (16) [01-31]
%H	hour, using a 24-hour clock (23) [00-23]
%I	hour, using a 12-hour clock (11) [01-12]
%M	minute (48) [00-59]
%m	month (09) [01-12]
%p	either "am" or "pm" (pm)
%S	second (10) [00-61]
%w	weekday (3) [0-6 = Sunday-Saturday]
%x	date (e.g., 09/16/98)
%X	time (e.g., 23:48:10)
%Y	full year (1998)
%y	two-digit year (98) [00-99]
%%	the character `%´


時刻フィールド
%H 時 (00..23)
%I 時 (01..12)
%k 時 (0..23)
%l 時 (1..12)
%M 分 (00..59)
%p AM あるいは PM のロケール
%r 時刻、12 時間 (hh:mm:ss [AP]M)
%s 1970-01-01 00:00:00 UTC からの秒数 (標準外の拡張)
%S 秒 (00..60)
%T 時刻、24 時間 (hh:mm:ss)
%X ロケールによる時刻の表現 (%H:%M:%S)
%Z タイムゾーン (例 EDT)、あるいはタイムゾーンが決定できないならば無し

日付フィールド
%a ロケールの省略形の曜日名 (Sun..Sat)
%A ロケールの完全表記の曜日名、可変長 (Sunday..Saturday)
%b ロケールの省略形の月名 (Jan..Dec)
%B ロケールの完全表記の月名、可変長 (January..December)
%c ロケールの日付と時刻 (Sat Nov 04 12:02:33 EST 1989)
%d 月内通算日数 (01..31)
%D 日付 (mm/dd/yy)
%h %b と同じ
%j 年内通算日数 (001..366)
%m 月 (01..12)
%U 日曜日を週の最初の日とした年内通算週 (00..53)
%w 週のうちの曜日 (0..6) (0 が日曜日)
%W 月曜日を週の最初の日とした年内通算週 (00..53)
%x ロケールの日付表現 (mm/dd/yy)
%y 年の最後の 2 つの数字 (00..99)
%Y 年 (1970...)

"!%Y-%m-%d %X"

文字フィールド
%% 文字 %
%n 改行
%t 水平タブ