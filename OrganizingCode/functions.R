getSnortId =
function(alerts)
{
    l1 =  sapply(alerts, `[`, 1)
    gsub("^\\[([^ ]+) .*", "\\1", l1)
}

getTitle =
function(alerts, l1 = sapply(alerts, `[`, 1))
{

}

