## Day 16

+ [example to illustrate a POST request with JSON](postExample.R)
   + uses httpbin.org which is a convenient Web site that allows us to make
     HTTP requests and returns the information it received about those requests.
	 This helps debug HTTP requests.

+ [R session](Rsession)

+ [XPath slides](XPath.html)

+ [R selenium example](selenium.R)
   + This shows a relatively simple and comprehensive approach
     to dealing with dynamic HTML documents that are constructed
	 by JavaScript code. Accordingly, there is no complete HTML document
     we can request from the Web server. Instead, there is a single top-level
	 HTML document that contains JavaScript code (directly or by reference)
	 which will construct the page's contents.

+ [Download selenium server](https://selenium-release.storage.googleapis.com/index.html)

+ [Download the geckodriver](https://github.com/mozilla/geckodriver/releases)
    + For simplicity, put the geckodriver executable in the same directory as the selenium-server-standalone jar file.

# Run

In a shell, start the selenium server in the directory where you have the .jar file and the geckodriver:
```
java -jar selenium-server-standalone-3.9.1.jar 
```


+ [Example R session] (example.session)
   + marine traffic
   + postExample.R
   

