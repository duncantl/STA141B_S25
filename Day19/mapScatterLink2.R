library(plotly)
library(leaflet)
library(crosstalk)

eqs = SharedData$new(quakes)
#eqs <- highlight_key(quakes)

p <- plot_ly(eqs, x = ~depth, y = ~mag) %>% 
  add_markers(alpha = 0.5) %>% 
  highlight("plotly_selected")

map <- leaflet(eqs) %>% 
  addTiles() %>% 
  addCircles()

map = highlight(map)

bscols(
  widths = c(6, 6), 
  p, map
)
