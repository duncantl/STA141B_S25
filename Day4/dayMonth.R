day_month_hour = function(files, clm_data = readLines(files)){
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


# The whole object approach and not
#
# Checkout outer implementations in Day4/
#

day_month_hour = function(files, clm_data = readLines(files)){
    dayLines = grep("* day ", clm_data, value = TRUE)

    string = strsplit(dayLines, " ")

    string = lapply(string, function(x) x[ x != "" ] )

    # Bank these as working but repeating code
    #    day = sapply(string, `[`, 3)
    #    month = sapply(string, `[`, 5)

    # Get both together
    #    tmp = sapply(string, `[`, c(3, 5))
    # Should have converted these to integer but this doesn't work
    # as it destroys the matrix 2 rows and 365 colums
    #        tmp = as.integer(sapply(string, `[`, c(3, 5)))
    tmp = sapply(string, function(x) as.integer(x[c(3, 5)]))

    # Make certain to transpose first.
    ans = as.data.frame(t(tmp))

    # If we hadn't converted to integer above, we could  convert the columns now,
    # What's the difference between the next two lines of code.
    #    ans[] = lapply(ans, as.integer)
    #    ans = lapply(ans, as.integer)
    
    names(ans) = c("Day", "Month")
    ans
browser()
#    data.frame(Day = day, Month = month)
}
