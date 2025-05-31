#
# This provides a small set of functions similar to some in RSelenium
# to
#  create a driver
#  connect/open the driver to create a session and a remote-controlled Web browser
#  navigate the browser to a URL
#  get the browser's current page source, i.e., HTML
#
# The key difference between this and RSelenium is that we are connecting directly
# to a standalone geckodriver server.
# See https://firefox-source-docs.mozilla.org/testing/geckodriver/Usage.html#standalone
# and the curl commands to interface.
#
# https://w3c.github.io/webdriver/#protocol
#
#
# findElement()/findElements()
# √ getCurrentUrl()
# getAllCookies()
# √ getStatus()
# √ getTitle()
# getWindowSize()
# getWindowPosition()
# √ goBack()
# √ goForward()
#
#

if(FALSE) {

    # Start the geckodriver in the terminal/power-shell
    #  geckodriver

    
    dr = mkSession()

    navigate(dr, "https://www.nytimes.com")
    html = getPageSource(dr)
    
    # u is a vector URLs
    z = lapply(u[1:20],
               function(u) {
                   navigate(dr, u)
                   Sys.sleep(2)
                   getPageSource(dr)
               })
}



library(RJSONIO)
library(RCurl)

mkSession =
function(host = "localhost", port = 4444,
         opts = list(capabilities = list(alwaysMatch = list(acceptInsecureCerts = TRUE))),
         ...)
{
    ans = mkPostRequest(opts, host = host, port = port, ...)
    tmp = fromJSON(ans)
    id = tmp$value$sessionId

    structure(list(host = host, port = port, sessionId = id),
              class = "GeckoDriver")
}


navigate =
    # have the Web browser visit the specified URL
    #
function(dr, url)
{
    invisible(
        mkPostRequest(list(url = url),
                      "url",
                      dr$sessionId,
                      host = dr$host,
                      port = dr$port)
    )
}

getPageSource =
function(dr)
{
    url = mkURL(dr$sessionId,
                "source",
                host = dr$host,
                port = dr$port)

    getURLContent(url)
}


close =
function(dr)
{
    url = mkURL(dr$sessionId, "", host = dr$host, port = dr$port)
    getURLContent(url, customrequest = "DELETE")
}


getAllCookies =
function(dr)
{
    simpleGet(dr, "cookie")$value
}

getCurrentUrl = getCurrentURL =
function(dr, path = "url")
{
    simpleGet(dr, path)["value"]
}

getStatus =
function(dr)    
{
    u = sprintf("http://%s:%s/status", dr$host, dr$port)
    fromJSON(getURLContent(u))$value
}


getTitle =
function(dr)    
    getCurrentURL(dr, "title")

getWindow =
function(dr)    
  getCurrentURL(dr, "window")


back = goBack =
function(dr)
    forward(dr, "back")

refresh =
function(dr)
    forward(dr, "refresh")

forward = goForward =
function(dr, cmd = "forward", ...)
{
    url = mkURL(dr$sessionId, cmd, dr$host, dr$port)
    tmp = getURLContent(url,
                        customrequest = "POST",
                        postfields = "{}",
                        httpheader = c("Content-Type" = "application/json"),
                        ...)
    invisible(fromJSON(tmp)["value"])
}



findElement =
function(dr, value, using = "xpath", ..., action = "element")
{
    tmp = mkPostRequest(list(using = using, value = value),
                        action, dr$sessionId, dr$host, dr$port, ...)

    fromJSON(tmp)$value
}

findElements =
function(dr, value, using = "xpath", ..., action = "elements")
{
    findElement(dr, value, using, ..., action = action)
}


click =
function(dr, element, ...)
{
    #    url = mkURL0(dr, sprintf("element/%s/click", element))
    url = mkURL0(dr, "click")
    tmp = getURLContent(url,
                        customrequest = "POST",
                        postfields = toJSON(list(button = element)),
                        httpheader = c("Content-Type" = "application/json"),
                        ...)
    fromJSON(tmp)
}


####

getWindowSize =
function(dr, windowId = "current")    
{
    simpleGet(dr, sprintf("window/%s/size", windowId))
}


#################
# Helper functions


mkURL0 =
function(dr, path = "")    
{
    mkURL(dr$sessionId, path, dr$host, dr$port)
}

mkURL =
function(sessionId = "", path  = "", host = "localhost", port = 4500)
{
    if(sessionId != "")
        sessionId = paste0("/", sessionId)
    
    if(path != "")
        path = paste0("/", path)

    # Don't use https -    LibreSSL/3.3.6: error:1404B42E:SSL routines:ST_CONNECT:tlsv1 alert protocol version
    sprintf("http://%s:%s/session%s%s", host, port, sessionId, path)
}

mkPostRequest =
function(data, path = "", sessionId = "", host = "localhost", port = 4500, ...)
{
    url = mkURL(sessionId, path, host = host, port = port)
    body = toJSON(data)

    z = httpPOST(url,
                 postFields = body,
                 httpheader = c("Content-Type" = "application/json"),
                 followlocation = TRUE,
                 ssl.verifypeer = FALSE,
                 ...)
}


simpleGet =
function(dr, path)
{
    url = mkURL(dr$sessionId, path, host = dr$host, port = dr$port)
    j = getURLContent(url)
    fromJSON(j)
}
