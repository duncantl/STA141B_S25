library(leaflet)
library(crosstalk)
library(ggplot2)
library(plotly) 

shared_quakes <- SharedData$new(quakes[sample(nrow(quakes), 100),])



  p <- ggplot(shared_quakes, aes(x = depth, 
                     y = mag)) +
  geom_point(size = 3) +
  labs(x = "Engine displacement",
       y = "Highway Mileage",
       color = "Car Class") +
  theme_bw()




a = bscols(
  leaflet(shared_quakes, width = "100%", height = 300) %>%
    addTiles() %>%
  addMarkers(),
  ggplotly(p, tooltip = c("label1", "label2", "label3"))
#  d3scatter(shared_quakes, ~depth, ~mag, width = "100%", height = 300)
)

