day_month_hour0 = function(files, clm_data = readLines(files)){
  dm_lines = grep("* day ", clm_data)
  dayvec = c()
  monthvec = c()

  browser()
  
  for (i in dm_lines) {
    string = strsplit(clm_data[i], " ")[[1]]
    if (string[3] == "") {
      day = as.numeric(string[4])
      dayvec = append(dayvec, day)
    } else {
      day = as.numeric(string[3])
      dayvec = append(dayvec, day)
    }
    month = as.numeric(string[length(string)])
    monthvec = append(monthvec, month)
  }
  if (all(diff(dm_lines) == 25)) {
    hourvec = rep(1:24, 365)
    dayvec = rep(dayvec, each = 24)
    monthvec = rep(monthvec, each = 24)
  }
  all_dmh = list("Day" = dayvec, "Month" = monthvec, "Hour" = hourvec)
  data.frame(do.call(cbind, all_dmh))
}

day_month_hour = function(files, clm_data = readLines(files)){
    dayLines = grep("* day ", clm_data, value = TRUE)

    string = strsplit(dayLines, " ")

    string = lapply(string, function(x) x[ x != "" ] )

#    day = sapply(string, `[`, 3)
#    month = sapply(string, `[`, 5)

    #    tmp = sapply(string, `[`, c(3, 5))
    #        tmp = as.integer(sapply(string, `[`, c(3, 5)))
            tmp = sapply(string, function(x) as.integer(x[c(3, 5)]))
    ans = as.data.frame(t(tmp))

    ans[] = lapply(ans, as.integer)
#    ans = lapply(ans, as.integer)
    
    names(ans) = c("Day", "Month")
    ans
browser()
#    data.frame(Day = day, Month = month)
}
