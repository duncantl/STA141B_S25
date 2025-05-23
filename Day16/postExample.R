library(RCurl)
library(RJSONIO)

u = "https://httpbin.org/post"

bodyData = list(x = 1, y = 2:4, string = "this is a string")
body = toJSON(bodyData)

headers = c('Content-Type' = 'application/json',
            'Content-Length' = nchar(body)
            )

ans = httpPOST(u, httpheader = headers,
               postFields = body,
               verbose = TRUE)

res = fromJSON(ans)


######################
#
# Get both the header and the body of the response

ans = getURLContent(u, httpheader = headers,
                    postFields = body,
                    customrequest = "POST",
                    verbose = TRUE,
                    header = TRUE)

ans$header

ans$body$body
