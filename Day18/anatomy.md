

We can use XPath to explore the structure of linked.html


```{r}
doc = htmlParse("linked.html")
xpathSApply(doc, "//*", xmlName)
```
```
 [1] "html"   "head"   "meta"   "title"  "script" "script" "script" "script" "script" "style" 
[11] "script" "script" "body"   "div"    "div"    "script" "script"
```

These appear in the order they occur in the document.

So we have 
+ the html root node
+ a head and a body.
+ The head contains some
   + meta data
   + title
   + 7 script nodes
   + 1 style node
```{r}
table(xpathSApply(doc, "//head/*", xmlName))
```
```
  meta script  style  title 
     1      7      1      1 
```
   + The script nodes are JavaScript libraries that are general, i.e., not specific to this plot.
   + We could (probably) have these script nodes (and style node) as separate files if we had use
     `selfcontained = FALSE` when exporting the HTML with `saveWidget()`.

+ The `<div>` node in the body 
```{r}
d1 = xmlRoot(doc)[["body"]][["div"]]
```
is 
```
<div id="htmlwidget_container">
<div id="htmlwidget-2a317b4f45f0b2de1503" class="girafe html-widget" style="width:960px;height:500px;">

</div>
</div> 
```
    + It is a general container with a child `<div>` node for a specific plot/display identified by
      the `id` attribute.
	
+ The `<script>` nodes in the body provide the information	 for rendering this specific display/plot.

```{r}
sc = getNodeSet(doc, "//body/script")
lapply(sc, xmlAttrs)
```
```
[[1]]
                             type                          data-for 
               "application/json" "htmlwidget-2a317b4f45f0b2de1503" 

[[2]]
                             type                          data-for 
  "application/htmlwidget-sizing" "htmlwidget-2a317b4f45f0b2de1503" 
```

   + The `data-for` attribute in each corresponds to the `id` of the nested `<div>` above which
     anchors the location for this display/plot.


+ The general htmlWidgets JavaScript code gets called when the page has been loaded.
   + It searches for the `<div id='...' class='... html-widget'>` node.
   + It uses the id to find the corresponding `script` nodes with `data-for` containing that `id`



