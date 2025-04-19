 z = c("* day  1 month 12", "* day 11 month  9")

 strsplit(z, " ")

 strsplit(z, " +")

 z = c("* day  1 month 12", "* day 11 month  9", "* day and no info")

 grepl("day ( |1|2|3)(1|2|3|4|5|6|7|8|9)", z)

 w = grepl("day ( |1|2|3)(1|2|3|4|5|6|7|8|9)", z)

 z[w]

 gsub("\\* day +([0-9]+) .*", "\\1", z)

 gsub("\\* day +([0-9]+) month ([0-9]+)", "\\1;\\2", z[w])

 gsub("\\* day +([0-9]+) month +([0-9]+)", "\\1;\\2", z[w])

 gregexpr("\\* day +([0-9]+) month +([0-9]+)", z[w], perl = TRUE)

 gregexpr("([0-9]+)", z[w], perl = TRUE)

