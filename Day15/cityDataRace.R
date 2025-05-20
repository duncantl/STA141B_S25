# See slides.html and cityData.R for getting the value of doc

# Quick sanity check to see that there is a section with this id
length(getNodeSet(doc, "//section[@id = 'races-graph']"))


# Get the single node that corresponds to the section with this id
r = getNodeSet(doc, "//section[@id = 'races-graph']")[[1]]

# Within this section subnode of the document, find all <li> nodes
li = getNodeSet(r, ".//li")

# Within the second of these <li> nodes, find the <ul> nodes and then its <li> children nodes
# Get their text values,
race = t(xpathSApply(li[[2]], ".//ul/li", function(x) xmlSApply(x, xmlValue)))

# We have a matrix, with 3 columns.
# Convert to a data.frame and reorder the columns
race = as.data.frame(race)[, c(3, 1, 2)]
names(race) = c("race", "number", "percent")


# Now convert from text to values, cleaning up the human-readable formatting.
race$number = as.integer(gsub(",", "", race$number))
race$percent = as.numeric(gsub("%$", "", race$percent))

race$percent2 = race$number/sum(race$number)*100
