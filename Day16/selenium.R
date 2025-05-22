library(RSelenium)

dr = remoteDriver$new()
dr$open()

u = "https://fa-euyk-dev2-saasfaprod1.fa.ocs.oraclecloud.com/hcmUI/CandidateExperience/en/sites/PenskeCareers/job/2502487"

dr$navigate(u)
# Wait a second or two for the browser to dynamically build the page's contents
p = dr$getPageSource()

doc = htmlParse(p[[1]])


# if we had a list of URLs
html = lapply(urls,
              function(u) {
                  dr$navigate(u)
                  # Wait a second or two for the browser to dynamically build the page's contents
                  Sys.sleep(2)
                  p = dr$getPageSource()[[1]]
              })



