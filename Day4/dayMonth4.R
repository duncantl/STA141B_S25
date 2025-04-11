day_month_hour4 =
function(files, clm_data = readLines(files))
{
                                        # ||||||||||
    dm_lines = grep("* day ", clm_data, value = TRUE, fixed = TRUE)

    els = strsplit(dm_lines, " ")
    els = lapply(els, function(x) x[x != ""])
    dm = data.frame(day = sapply(els, `[`, 3),
                    month = sapply(els, `[`, 5))
    dm[] = lapply(dm, as.integer)
    dm
}


day_month_hour5 =
function(files, clm_data = readLines(files))
{
                                        # ||||||||||
    dm_lines = grep("* day ", clm_data, value = TRUE, fixed = TRUE)

    els = strsplit(dm_lines, " ")
    els = lapply(els, function(x) x[x != ""])
    cols = lapply(c(day = 3, month = 5), function(i) sapply(els, `[`, i))
    as.data.frame(cols)
}

