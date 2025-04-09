mkHeader =
    #
    #
function(tt, widths)
{
    # Could also do this with
    #   h = read.fwf(textConnection(tt[1:2]), widths)
    # 
    h = sapply(tt[1:2], function(x) read.fwf(textConnection(x), widths ))
    w = is.na(h[,1])
    h[w,1] = ""
    paste(trimws(h[,1]), trimws(h[,2]))
}



