function Position(lat, lon)
    if lat > 0 then
        ns = "N"
    else
        ns = "S"
        lat = -lat
    end

    if lon > 0 then
        ew = "E"
    else
        ew = "W"
        lon = -lon
    end

    local latdeg = math.floor(lat)
    local latmin = math.floor( (lat-latdeg)*60 )
    local latsec = math.floor( ((lat-latdeg)*60-latmin)*60 )

    local londeg = math.floor(lon)
    local lonmin = math.floor( (lon-londeg)*60 )
    local lonsec = math.floor( ((lon-londeg)*60-lonmin)*60 )

    local pos = ns .. latdeg .. "." .. latmin .. "." .. latsec .. ", "
    .. ew .. londeg .. "." .. lonmin .. "." .. lonsec

    return pos
end

--ScenEdit_RunScript ("lualumiere/position.lua")