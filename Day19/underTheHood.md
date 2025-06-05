The basic approach to creating interactive Web-based plots in R is that 
we write  R code that creates descriptions of plots in R for a given data set and then,
via `saveWidget()`, we output these to an HTML document along with supporting
+ JavaScript
+ HTML layout
+ possibly data
+ possibly the actual plots themselves.

Then the general-purpose JavaScript libraries/frameworks that are added to the HTML document
arrange to create the actual display at viewing time, i.e., when the Web is loaded and rendered.
Exactly what happens depends on which type(s) of widgets we are including in the display.

We explored the structure and content of the HTML document [linked.html](..Day18/linked.html)
which we generated via the R code in [linked.R](..Day18/linked.R) in Day18.
Please read the exploration in [anatomy.md](../Day18/anatomy.md).

This collection of 3 plots was created with the `ggiraph` package.
So there is only one widget. That widget contains the three plots as a single unit.
The linking there is simpler than if we had 2 or more widgets of different types, 
e.g., a ggiraph plot and a leaflet map and a DT table.



## What happens under the hood 

As we saw in the anatomy.md, for the ggiraph widget, the body of the HTML contains

```
<div id="htmlwidget_container">
<div id="htmlwidget-2a317b4f45f0b2de1503" class="girafe html-widget" style="width:960px;height:500px;">

</div>
</div> 
```

The outer-most `div` with `id = htmlwidget_container` is generic and what the htmlWidgets package
creates.
This is a placeholder where the plots will be located and built  when the Web browser renders the
page.

There is a single widget. It has an `id` attribute
`htmlwidget-2a317b4f45f0b2de1503`.
The htmlWidgets package created this "unique" name.

We also saw that the two script nodes in the body have attributes
```
xmlAttrs(b[[4]])
                             type                          data-for 
               "application/json" "htmlwidget-2a317b4f45f0b2de1503" 
xmlAttrs(b[[5]])
                             type                          data-for 
  "application/htmlwidget-sizing" "htmlwidget-2a317b4f45f0b2de1503" 
```
Note that they both have a `data-for` attribute with a value that matches the `id` of
the inner `div` above. 
This provides the clear association that these two `script` nodes are associated with tha widget.

If we had two widgets, we would presumably have additional `script` nodes with 
`data-for` attributes with values corresponding to the second widget.


We also saw that JSON content in the 4th node contained an SVG (scalable vector graphics)
plot, generated in R. Within that one SVG document, we had the three plots.


To understand what interactivity it has by itself, we can save this to a separate .svg file
and load it into the browser:
```r
s = xmlParse(j$x$html)
s = xmlRoot(s)
saveXML(s, "standaloneLinked.svg")
browseURL("standaloneLinked.svg")
```
(You may have to explicitly open it in the browser depending on how your machine is configured
to open files with an .svg extension.)

Important,  if we mouse over a point, we don't see the tooltip appear.
Also, there is  no linking. So R and ggiraph and htmlWidgets have not built the interactivity and
linking into the SVG plot. They have just created the appearance.


Importantly, we saw the circle and rect nodes in the three plots had a `data-id` attribute.
Let's find those.
```r
did = getNodeSet(s, "//*[@data-id]")
length(did)
```
We have 96. This corresponds to 3 x 32 and there are 32 rows in the mtcars dataset which we used to
create the plot.
So this looks good.

What are the names of these SVG nodes?
```r
table(sapply(did, xmlName))
```
```
circle   rect 
    64     32 
```
This is what "we" expected.


How many unique values are there for the `data-id` attributes and how often does each occur:
```
table(sapply(did, xmlGetAttr, "data-id"))
```
```
        AMC Javelin  Cadillac Fleetwood          Camaro Z28   Chrysler Imperial          Datsun 710 
                  3                   3                   3                   3                   3 
   Dodge Challenger          Duster 360        Ferrari Dino            Fiat 128           Fiat X1-9 
                  3                   3                   3                   3                   3 
     Ford Pantera L         Honda Civic      Hornet 4 Drive   Hornet Sportabout Lincoln Continental 
                  3                   3                   3                   3                   3 
       Lotus Europa       Maserati Bora           Mazda RX4       Mazda RX4 Wag            Merc 230 
                  3                   3                   3                   3                   3 
          Merc 240D            Merc 280           Merc 280C          Merc 450SE          Merc 450SL 
                  3                   3                   3                   3                   3 
        Merc 450SLC    Pontiac Firebird       Porsche 914-2      Toyota Corolla       Toyota Corona 
                  3                   3                   3                   3                   3 
            Valiant          Volvo 142E 
                  3                   3 
```
So this is very likely to be one in each plot.
And these correspond to the row names of mtcars:
```r
rownames(mtcars)
```
```
 [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"          "Hornet 4 Drive"     
 [5] "Hornet Sportabout"   "Valiant"             "Duster 360"          "Merc 240D"          
 [9] "Merc 230"            "Merc 280"            "Merc 280C"           "Merc 450SE"         
[13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood"  "Lincoln Continental"
[17] "Chrysler Imperial"   "Fiat 128"            "Honda Civic"         "Toyota Corolla"     
[21] "Toyota Corona"       "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
[25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"       "Lotus Europa"       
[29] "Ford Pantera L"      "Ferrari Dino"        "Maserati Bora"       "Volvo 142E"         
```




## Interactivity

So how does the plot become interactive?

The final `script` node in the `head` of the HTML document is
```
<script>HTMLWidgets.widget({
  name: 'girafe',
  type: 'output',
  factory: ggiraphjs.factory(HTMLWidgets.shinyMode)
});
</script>
```
This calls the JavaScript function `HTMLWidgets.widget()`.
The `factory` presumably indicates how the JavaScript code should build/assemble the widget.

The function `HTMLWidgets.widget()` is defined at line 415 of linked.html in the first `script` node. 

Where is the `ggiraphjs.factory()` function? <!-- fix?? -->


The HTMLWidgets javascript code is the first  `script` node.
(It is easier to read than the other 'minified' libraries.)
The HTMLWidgets javascript code defines the function `window.HTMLWidgets.staticRender()`.

It finds the `div` with the `id = "htmlwidgets_container"`.
Then it finds each of the child `div` elements and gets their `id`, e.g.,
`htmlwidget-2a317b4f45f0b2de1503` we saw in the body of the HTML for linked.html.

Then it searches for the corresponding `script` node with a `data-for` attribute with the
corresponding id (and is of type application/json.)
This is line 650 of linked.html:
```
document.querySelector("script[data-for='" + el.id + "'][type='application/json']");
```
Then it parses the script as JSON (as we did in R when exploring)
```
  var data = JSON.parse(scriptData.textContent || scriptData.text);
  // Resolve strings marked as javascript literals to objects
  if (!(data.evals instanceof Array)) data.evals = [data.evals];
  for (var k = 0; data.evals && k < data.evals.length; k++) {
    window.HTMLWidgets.evaluateStringMember(data.x, data.evals[k]);
  }
  binding.renderValue(el, data.x, initResult);
  evalAndRun(data.jsHooks.render, initResult, [el, data.x]);
```
We saw that this JSON has elements named x, evals and jsHooks.
The element x contained elements html, js, uid, ration and settings.
The html element was the SVG. 

For our plot, evals and jsHooks were empty. So nothing will happen for these.
But the important command
```
  binding.renderValue(el, data.x, initResult);
```
appears to render our widget.
`el` is the inner `div` (with the id of the specific widget).
`data.x` contains the HTML or in our case the SVG.

My guess is that, for a ggiraph widget, `renderValue()` adds the `html`
content as a child of the current `div` node.
That would cause the SVG to be displayed.

<!-- Fix not needed here but return and explain what evals and jsHooks do.
So we see that this JavaScript code above 
+ calls evaluateStringMember(data.x, data.evals[k]) for each element
+ 
-->

<!-- 
HTMLWidgets defines .widgets as an array which we can access.

window.HTMLWidgets.staticRender defines a function to 
-->


### But where does the interactivity get added.

For a ggiraph widget, it can find all nodes in the SVG
that have a `data-id` attribute. These are the 96 circle and rect nodes.
It can use XPath or CSS selectors to find these within the widget's own HTML content (in this case SVG.)

It can then add an event handler for the `mouseover` events
for each of these nodes.

The event handler can display the tooltip.
As part of the information about the event, the handler
knows which SVG circle or rectangle it is in.
So it knows the `data-id` and `title` attributes. Importantly,
I hope it uses the `title` and allows us in R to compose the tooltip when describing the plot.

The event handler can also highlight the elements in each of the (3) linked  ggiraph plots.
It can can use XPath/CSS selectors to find all the elements with a `data-id` attribute with the
current nodes `data-id` value.   It will find 3, in our case. It can then change the fill color 
of each.

There will also be a mouseout event handler which will do the opposite, i.e., remove the
tooltip and reset the color to its original value.
Importantly, it shouldn't reset it to, e.g., black. It needs to reset it to the original color for
that element. This is to ensure if we set the colors for each plot, they should revert to those
colors.


How do we specify the
+ tooltips
+ colors for this linked plot.

+ Can we control the tooltip appearance, i.e., smaller? How?
+ Can we change the linking to just change the color of the border? How?



<!--  -->
----

```r
library(XML)
doc = htmlParse("linked.html")
```

The names of all the regular nodes are
```
xpathSApply(doc, "//*", xmlName)
```

Like 
we have a `head` and `body` node.

The head node contains
```r
r = xmlRoot(doc)
names(r)
```
```
  head   body 
"head" "body" 
```

## The `head` node

```r
h = r[["head"]]
names(h)
```
```
    meta    title   script   script   script   script   script    style   script   script 
  "meta"  "title" "script" "script" "script" "script" "script"  "style" "script" "script" 
```

The meta and title nodes are 
```
<meta charset="utf-8"/> 
<title>girafe</title> 
```

Rather than print the entire contents of all script nodes, let's see the attributes of each
and also how large they are
```{r}
sapply(h[ names(h) == "script"], function(x) nchar(xmlValue(x)))
```
```
script script script script script script script 
 33196  62446   8618   8636   6357 131413    113 
```

```
sapply(h[ names(h) == "script"], xmlAttrs)
```
We get NULL for all of them. So they are regular JavaScript.

We can explore these but we'll come back to them later.


## The `body` node.

What are the top-level nodes in the body?

```r
b = r[["body"]]
names(b)
```
```
    text      div     text   script   script 
  "text"    "div"   "text" "script" "script" 
```

The two `text` nodes are just blank space.

The `div` nodes is
```
<div id="htmlwidget_container">
<div id="htmlwidget-2a317b4f45f0b2de1503" class="girafe html-widget" style="width:960px;height:500px;">

</div>
</div> 
```
This is very similar to what we saw in the antomy.md for the other 
