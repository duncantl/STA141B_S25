getCaptures =
function(pat, x, matches = gregexpr(pat, x, perl = TRUE, ...), ..., SIMPLIFY = FALSE,
          asDataFrame = TRUE)
{
    if(length(matches) == 0)
        return(list())

    if(is.null(attr(matches[[1]], "capture.start")))
        stop("no capture group information. Does the regular expression contain capture groups?")
    
    ans = mapply(getCapture, x, matches,
                 MoreArgs =  list(asDataFrame = asDataFrame),
                 SIMPLIFY = SIMPLIFY)

    if(asDataFrame)
        do.call(rbind, ans)
    else
        ans
}

getCapture =
function(str, m, asDataFrame = FALSE)
{
    st = attr(m, "capture.start")

    w = st != -1
    ans = rep(NA, length(st))
    
    ans[w] =  substring(str, st[w], st[w] + attr(m, "capture.length")[w] - 1L)
       
    if(asDataFrame)
        structure(as.data.frame(as.list(ans), stringsAsFactors = FALSE, make.names = FALSE, row.names = NULL),
                  names = attr(m, "capture.names"))
    else
        ans
}
