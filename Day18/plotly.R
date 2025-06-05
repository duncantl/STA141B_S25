library(ggplot2)
library(plotly)

p <- ggplot(mpg, aes(x=displ, 
                     y=hwy, 
                     color=class,
                     label1 = manufacturer,
                     label2 = model,
                     label3 = year)) +
  geom_point(size = 3) +
  labs(x = "Engine displacement",
       y = "Highway Mileage",
       color = "Car Class") +
  theme_bw()

ggplotly(p, tooltip = c("label1", "label2", "label3"))
