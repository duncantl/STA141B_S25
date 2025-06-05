## Day 20

### Tables for displaying data

+ [DT package](https://rstudio.github.io/DT/)
  + [dt.R](dt.R)
+ [reactable](https://glin.github.io/reactable/)
  + `reactable::reactable(mtcars)`

### Connecting 2 or more widgets

+ [crosstalk](https://rstudio.github.io/crosstalk/using.html)
+ [crosstalk::SharedData](https://rdrr.io/cran/crosstalk/man/SharedData.html)
+ [plotly::highlight()](https://www.rdocumentation.org/packages/plotly/versions/4.10.4/topics/highlight)
   + plotly_click, plotly_doubleclick events - on and off.
   
   
### Constructing/Assembling the HTML   
+ htmltools package and `tags$...()` for creating html content.
   + create HTML content
   + include widgets directly
   + `save_html()`

+ crosstalk::bscols()


+ flexdashboard and Rmarkdown
   + Create the HTML display document directly from an Rmd file. (Separate from your report.)
   + Example - [flex.Rmd](flex.Rmd) and the HTML page [flex.html](flex.html)

## Adding JavaScript Code to the HTML

+ [onRender()](https://www.rdocumentation.org/packages/htmlwidgets/versions/1.6.4/topics/onRender)
   + Add JavaScript code to be evaluated when a widget is rendered.


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



+ Possible Improvements - Appearance and Control s
   + colors
   + appearance of highlighted point
      + change size?
	  + color
	  + then reset.
   + reset the plot to show all and not the currently selected point
   + extra decorations, e.g., Brush, toolbar.
   + need for external files for JavaScript libraries.




