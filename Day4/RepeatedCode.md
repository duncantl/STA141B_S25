
```
#given file path, get 5 dataframes for each location.
filepath_yosemite <- "C:/Users/xxx/Desktop/computer/2025spring/sta141b/hw1/clm/USA_CA_Mammoth.Yosemite.AP.723894_TMYx.2009-2023.clm"
filepath_shasta<- "C:/Users/xxx/Desktop/computer/2025spring/sta141b/hw1/clm/USA_CA_Mount.Shasta.725957_TMYx.2009-2023.clm"
filepath_arguello<-"C:/Users/xxx/Desktop/computer/2025spring/sta141b/hw1/clm/USA_CA_Point.Arguello.994210_TMYx.2009-2023.clm"
filepath_sandiego<-"C:/Users/xxx/Desktop/computer/2025spring/sta141b/hw1/clm/USA_CA_San.Diego-MCAS.Miramar.722930_TMYx.2009-2023.clm"
filepath_ucdavis<-"C:/Users/xxx/Desktop/computer/2025spring/sta141b/hw1/clm/USA_CA_UC-Davis-University.AP.720576_TMYx.2009-2023.clm"

yosemite_df <- readthecleandata(filepath_yosemite)
shasta_df <- readthecleandata(filepath_shasta)
arguello_df <- readthecleandata(filepath_arguello)
sandiego_df <- readthecleandata(filepath_sandiego)
ucdavis_df <- readthecleandata(filepath_ucdavis)
```


dir  = "C:/Users/xxx/Desktop/computer/2025spring/sta141b/hw1/"
clm.files = list.files(dir, pattern = ".clm", full.names = TRUE)
dfs = lapply(clm.files, readTheCleanData)
