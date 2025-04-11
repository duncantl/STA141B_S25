day_month_hour = function(files, clm_data = readLines(files)){
  dm_lines = grep("* day ", clm_data)
  dayvec = c()
  monthvec = c()
  
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
