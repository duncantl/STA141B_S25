library(patchwork)
library(ggiraph)
library(htmlwidgets)

p1 <- ggplot(mtcars, aes(x=wt, 
                      y=mpg, 
                      tooltip = rownames(mtcars),
                      data_id = rownames(mtcars))) +
  geom_point_interactive(size=3, alpha =.6) 

p2 <- ggplot(mtcars, aes(x=drat, 
                         y=qsec, 
                         tooltip = rownames(mtcars),
                         data_id = rownames(mtcars))) +
  geom_point_interactive(size = 3, alpha = .6) 

p3 <- ggplot(mtcars, aes(x=cyl,
                         data_id = rownames(mtcars))) +
  geom_bar_interactive() 

p3 <- (p1 | p2)/p3
girafe(code = print (p3))
saveWidget(girafe(code = print (p3)), "linked.html") 
