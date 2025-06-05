https://www.gapminder.org/tools/#$chart-type=bubbles&url=v2


+ 223 years
+ over 270 countries
+ 4 geographical regions
+ 3 variables
   + GDP per capita
   + Life expectancy
   + Country Population

+ ~ 240,000 data items in a single display.


# plotly

https://rkabacoff.github.io/datavis/Interactive.html#plotly

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
   



# ggiraph package

+ have to add _interactive to the ggeom_* commands, e.g., ggeom_points_interactive

+ default point size different from ggplotly()


## Linked Plots

+ 2 or more plots

+ highlight point in one - show corresponding point in the other  plots.

+ Visualizing in multiple dimensions - not just 2 or 3, but p.

+ also can insert JavaScript code for actions
   + https://www.ardata.fr/ggiraph-book/starting.html - section 1.5




# D3

https://observablehq.com/@d3/gallery
https://observablehq.com/@mbostock/inequality-in-american-cities/2



Animated map and time series for COVID.
https://www.stat.ucdavis.edu/~duncan/VizEg/AnimatedCOVIDMap/animatedMap.html









--------

From JS4R

p = plot_ly(cars, x = ~speed, y = ~dist)
p2 = add_markers(p)
htmlwidgets::saveWidget(p2, "simplePlotly.html", selfcontained = FALSE, title = "My Plot")


Anatomy of a Web-based plot.



library(XML)
doc = htmlParse("simplePlotly.html")
els = getNodeSet(doc, "//*")
sapply(els, xmlName)


d = fromJSON(xmlValue(els[[17]]))
# the data + additional elements




- AnimatedMap in Day18 and

https://www.stat.ucdavis.edu/~duncan/VizEg/AnimatedCOVIDMap/animatedMap.html
http://127.0.0.1/~duncan/AnimatedMap.html/map.html

Note: Doesn't work when view as local file. Security permissions.


HTML we create manually.

Create 2 plots in R.

Create data we need in HTML/JavaScript
   + for each state, a vector of the colors for each day.
   + the labels for each of the days.
   + serialize as JSON




- Event driven programming



## Brushing

Use the mouse to identify a rectangular region on a plot.
Highlight the points in that rectangle.  And then highlight
the corresponding points in other related/linked plots.


