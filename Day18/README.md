## Day 18

+ Recap on 
   + dynamic HTML documents/content, 
   + selenium and RSelenium
   + section titles for task 2
   + the text and word for task 2

+ [Using try and why](try.md)


+ [quick, no-frills functions to talk with geckodriver directly](direct.R)
   + When RSelenium, selenium aren't working on a machine,
     one can try to run the geckodriver directly (in a shell)
	 and then use the code in direct.R from within R to 
	   + connect to the geckodriver via mkSession()
	   + navigate to a URL
	   + get the current page's HTML
   + See the example at the top of the file within the `if(FALSE) {... }`

### Interactive Data Visualization


+ [gapminder](https://www.gapminder.org/tools/#$chart-type=bubbles&url=v2)
  + 223 years
  + over 270 countries
  + 4 geographical regions
  + 3 variables
     + GDP per capita
     + Life expectancy
     + Country Population

  + ~ 240,000 data items in a single display.



+ [COVID animation](https://www.stat.ucdavis.edu/~duncan/VizEg/AnimatedCOVIDMap/animatedMap.html)


# plotly

+ [features](https://rkabacoff.github.io/datavis/Interactive.html#plotly)


+ 1st plot - tooltip shows the same information as on the plot - x, y, legend value.
   + Not particularly helpful.
   + legend allows us to toggle visibility entire sets of points.

+ 2nd plot shows the values of other variables in the tooltip.
   + so value added.

+ 3rd plot shows general possibilities
   + but actually could be done with less verbose text.


+ can create regular plots similar to R's
   + but in HTML & JavaScript

+ also works with ggplot() objects.

+ print the plot and it appears in RStudio viewer or Web browser.
   + save to a file via htmlwidgets::saveWidget


## Time-series

+ [time-series highlighting](https://www.ardata.fr/ggiraph-book/customize.html#sec-hover-opt)
   + Would be better if could click on label in legend to highlight


## Linked Plots

+ [Figure 13.6: Linked interactive graphs](https://rkabacoff.github.io/datavis/Interactive.html#fig:ggiraph3)
  + hover over a point in either scatterplot
     + highlight corresponding entries in other plots

+ Connect 2 or more plots

+ Visualizing in multiple dimensions - not just 2 or 3, but p.

+ also can insert JavaScript code for actions
   + https://www.ardata.fr/ggiraph-book/starting.html - section 1.5



## Maps

+ [ggplot + ggiraph](https://bhaskarvk.github.io/user2017.geodataviz/notebooks/03-Interactive-Maps.nb.html#using-ggiraph)
+ [ggplot + plotly](https://bhaskarvk.github.io/user2017.geodataviz/notebooks/03-Interactive-Maps.nb.html#using-plotly)
   + [gallery](https://plotly.com/r/maps/)
+ [leaflet](https://bhaskarvk.github.io/user2017.geodataviz/notebooks/03-Interactive-Maps.nb.html#using-leaflet)


+ Overall https://bhaskarvk.github.io/user2017.geodataviz/notebooks/03-Interactive-Maps.nb.html



## Interactive Tables

+ [DT](https://rstudio.github.io/DT/)
+ [gt](https://gt.rstudio.com/)
+ [reactable](https://r-graph-gallery.com/package/reactable.html)

## Challenge

How to combine scatterplots, maps, tables.




## Anatomy of a  display.

+ [Anatomy of ggiraph display](anatomy.md)


+ An important concept to keep in mind is that we are creating these
  plots in R by generating HTML, JavaScript, CSS etc. 
  which will be evaluated at a later time in a Web browser entirely separate from R and our current
  R session.
  + So there are two stages
    + create
	+ view/render
  

+ During the create stage, we need to insert any data and any code that will be needed  in the view stage.

+ We have to arrange for any data or code we insert to be used by the JavaScript code.
  + Have to find how to add event handlers to specific elements created in view stage. 
     + Mostly have to do this during the create stage 
	 + and can be different for each R package/type of plot, e.g., leaflet, plotly, ...
