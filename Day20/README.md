## Day 20

### Examples

+ [example 1](eg1.html)
   + created in R.
   + inserted JavaScript code to control run/view-time display rendering and event handlers
+ [example 2](eg2.html), [example 3](eg3.html)
   + high-level 
   + Rmarkdown to create HTML - flexdashboard
   + plotly and DT
   + [SharedData](https://rdrr.io/cran/crosstalk/man/SharedData.html) 
      and [highlight()](https://www.rdocumentation.org/packages/plotly/versions/4.10.4/topics/highlight)
+ [example 4](eg4.html)



+ Improvements - Control 
   + colors
   + extra decorations, e.g., Brush, toolbar.
   + need for external files for JavaScript libraries.


### flexdashboard

+ [flexdashboard example output](flex.html)
  + [Rmd file](flex.Rmd)


### Additional Useful Approaches

+ [crosstalk::SharedData](https://rdrr.io/cran/crosstalk/man/SharedData.html)
+ [plotly::highlight()](https://www.rdocumentation.org/packages/plotly/versions/4.10.4/topics/highlight)

+ htmltools package and `tags$...()` for creating html content.
   + create HTML content
   + include widgets directly


+ [onRender()](https://www.rdocumentation.org/packages/htmlwidgets/versions/1.6.4/topics/onRender)


+ 
