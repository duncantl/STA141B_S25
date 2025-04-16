read.clm2 =
function(file, ll = readLines(file))
{
    # Arrange lines by * day month
    g = groupByDay(ll)

    # Convert each day's lines into a data.frame with the 6 columns, day, month, hour
    days = lapply(g, mkDayDF)

    # Combine all the individual data.frames into one large data.frame
    d = do.call(rbind, days)
    rownames(d) = NULL
    names(d)[1:6] = c("Diffuse solar", "Temperature", "Solar intensity", "Wind speed", "Wind direction", "Relative humidity")

    d
}

groupByDay =
    # Group the lines by * day month lines
function(ll)    
{
    w = substring(ll, 1, 5) == "* day"
    g = split(ll, cumsum(w))[-1]
}


mkDayDF =
    # Create the data.frame by reading the lines for a single day.
function(txt)
{
    d = read.csv(textConnection(txt[-1]), header = FALSE)
    dm = getDayMonth(ll)
    d$day = dm[1]
    d$month = dm[2]
    d$hour = 0:(nrow(d) - 1L)
    d
}

getDayMonth =
    # For a single * day month string
function(x)
{
    els = strsplit(x, " ")[[1]]
    els = els[ els != ""]
    as.integer(els[c(3, 5) ])
}
