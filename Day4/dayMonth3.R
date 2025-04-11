day_month_hour3 =
function(files, clm_data = readLines(files))
{
                                        # ||||||||||
    dm_lines = grep("* day ", clm_data, value = TRUE, fixed = TRUE)

    els = strsplit(dm_lines, " ")
    vals = sapply(els, function(x) as.integer(x[x != ""] [c(3, 5)]))
    dm = as.data.frame(t(vals))
    names(dm) = c("day", "month")
    dm
}

