vessels =
function(cookie, z = 2, x = 0, y = 1,
         userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:138.0) Gecko/20100101 Firefox/138.0",
         ...)
{
    url = mkURL(z, x, y)
    jj = getURLContent(url, useragent = userAgent, cookie = cookie, ...)
    mkData(fromJSON(jj))
}

gvessels =
function(cookie, z = 2, x = c(0, 1), y = c(0, 1))
{
    g = expand.grid(x, y)
    tmp = mapply(\(x, y) vessels(cookie, z = z, x = x, y = y),
                 g[,1], g[,2],
                SIMPLIFY = FALSE)
    ans = do.call(rbind, tmp)
    ans$z = z
    ans$x = rep(g[,1], sapply(tmp, nrow))
    ans$y = rep(g[,2], sapply(tmp, nrow))

    #
    # There may be duplicates for SHIP_ID
    #
    ans
}

# 1020 ships duplicated.


mkURL =
function(z = 2, x = 0, y = 1,
          fmt ="https://www.marinetraffic.com/getData/get_data_json_4/z:%s/X:%s/Y:%s/station:0")    
{
    sprintf(fmt, z, x, y)
}


InAll = c("COURSE", "ELAPSED", "HEADING", "LAT", "LON", "SHIP_ID", "SHIPNAME", "SHIPTYPE", "SPEED")
InSome = c("FLAG", "LENGTH", "WIDTH", "DESTINATION", "L_FORE", "W_LEFT", "GT_SHIPTYPE", "DWT", "ROT", "STATUS_NAME", "TYPE_IMG", "TYPE_NAME")

mkData =
function(js, r = js$data$rows)
{
    tmp = lapply(InAll, function(var) sapply(r, \(x) orNA( x[[var]])))
    tmp2 = lapply(InSome, function(var) sapply(r, \(x) if(var %in% names(x)) orNA( x[[var]]) else NA))
    ans = as.data.frame(tmp)
    ans = cbind(ans, as.data.frame(tmp2))
    names(ans) = c(InAll, InSome)
    fix(ans)
}

fix =
    #
    # SHIPTYPE is an integer from 0 to 9 with no 5.
    # Don't know what these correspond to. But TYPE_NAME also has 9 unique elements
    # tt = table(z2$TYPE_NAME, z2$SHIPTYPE, useNA = "always")
    # apply(tt[-nrow(tt), ], 2, function(x) sum(x != 0)) == 1
    #
function(df)    
{
    num = c("LAT", "LON")
    ints = c("COURSE", "ELAPSED", "HEADING", "SHIPTYPE", "SPEED", "LENGTH", "WIDTH", "L_FORE", "W_LEFT", "GT_SHIPTYPE", "DWT", "TYPE_IMG", "ROT")
    df[ints] = lapply(df[ints], as.integer)
    df[num] = lapply(df[num], as.numeric)

    # Should we 'fix' the TYPE_NAME when it is NA and we have the SHIPTYPE that is not NA
    w = is.na(df$TYPE_NAME)
    if(any(w))
        df$TYPE_NAME[w] = ShipTypeMap[ as.character(df$SHIPTYPE[w]) ]
    df
}

ShipTypeMap = 
c(`7` = "Cargo Vessel", `2` = "Fishing", `4` = "High Speed Craft", 
`1` = "Navigation Aids", `6` = "Passenger Vessel", `9` = "Pleasure Craft", 
`8` = "Tanker", `3` = "Tugs & Special Craft", `0` = "Unspecified Ship"
)



orNA =
function(x, val = NA)
{
    if(length(x) == 0)
        val
    else
        x
}
