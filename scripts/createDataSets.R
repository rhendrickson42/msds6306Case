# data sets
# script testing

library(ggplot2)

# use here package to help with project structure
# devtools::install_github("krlmlr/here")
library(here)

dataSetup_script <- here("scripts", "dataSetup.R")

source(dataSetup_script)

# Create a data set for bitterness
script_bitter_beers <- subset(script_beers,!(is.na(script_beers$IBU))) 

# Aggregate instances, IBU, ABV by style
script_instances <- table(script_bitter_beers$Style)
script_instances <- as.data.frame(script_instances)
script_instances <- subset(script_instances, script_instances$Freq > 0)

means1 <- aggregate(IBU~Style, script_bitter_beers, mean)
means2 <- aggregate(ABV~Style, script_bitter_beers, mean)
means3 <- script_instances$Freq

means1$ABV <- means2$ABV
means1$instance <- means3
means1 <- means1[order(-means1$instance),]

# top 10 style of beer
head(means1, n = 10)

#reorder in order of instances
means1$Style <- factor(means1$Style, levels = means1$Style[order(-means1$instance)])

#bar plot of results
ggplot(data=means1, aes(x=Style, y=instance)) +
  geom_bar(stat="identity", fill="#ff0000") + xlab("Beer Style") + ylab("Number of Beers Produced") +
  ggtitle("Styles of Beer") + theme(axis.text.x = element_text(angle=90, vjust=.5, hjust = 1,size=5))

