# https://linking.plotly-r.com/client-side-linking
library(plotly)
library(leaflet)
library(crosstalk)

eqs <- highlight_key(quakes)
stations <- filter_slider("station", "Number of Stations", eqs, ~stations)

p <- plot_ly(eqs, x = ~depth, y = ~mag) %>% 
  add_markers(alpha = 0.5) %>% 
  highlight("plotly_selected")

map <- leaflet(eqs) %>% 
  addTiles() %>% 
  addCircles()

bscols(
  widths = c(6, 6, 3), 
  p, map, stations
)
