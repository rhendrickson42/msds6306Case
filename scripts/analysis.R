# Analysis - Questions Script
#
# This is an external R script to call dataSetup and perform some analysis to answer some questions
# 

if(!require("here")) cat("please install here package # devtools::install_github(\"krlmlr/here\")")
library(here)

dataSetup_file <- here("scripts", "dataSetup.R")
source(dataSetup_file)

## @knitr script_Analysis_getData

## Questions

## @knitr script_Analysis_Question1
# Q1
# 1. How many breweries are present in each state?

library(data.table)
library(dplyr)
library(ggplot2)

number_breweries_byState <- setDT(script_breweries)[, .(count = uniqueN(Brewery_id)), by = State]
setorder(number_breweries_byState, State)

# verify using dplyr
number_breweries_byState_dplyr <- script_breweries
number_breweries_byState_dplyr %>% group_by(State) %>% summarize(count=n()) %>% print(n = 100)

## @knitr script_Analysis_Question2

# 2. Merge beer data with the brewery data.
# Q2
# merge beer data and brewery data. Print first and last 6 observations to check the merged file.

script_beer_world <- merge(script_beers, script_breweries, by = "Brewery_id")
names(script_beer_world)[names(script_beer_world) == "Name.x"] <- "Beer_Name"
names(script_beer_world)[names(script_beer_world) == "Name.y"] <- "Brewery_Name"

## @knitr script_Analysis_Question3
# Q3
# Report the number of NS's in each column

num_NAs <- sapply(script_beer_world, function(x) sum(is.na(x)))

## @knitr script_Analysis_Question4
# Q4
# compute the median alcohol content and IBU for each state Plot a bar chart to compare

script_state_ABV <- aggregate(script_beer_world["ABV"], by=script_beer_world[c("State")], FUN=median, na.rm=TRUE)
barplot(script_state_ABV$ABV, main="Beer ABV by State", names.arg = script_state_ABV$State)

script_state_IBU <- aggregate(script_beer_world["IBU"], by=script_beer_world[c("State")], FUN=median, na.rm=TRUE)
barplot(script_state_IBU$IBU, main="Beer IBU by State", names.arg = script_state_IBU$State)

## @knitr script_Analysis_Question5
# Q5
# Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?

# max ABV
script_state_max_ABV <- script_state_ABV[which.max(script_state_ABV$ABV),]

# max IBU
script_state_max_IBU <- script_state_IBU[which.max(script_state_IBU$IBU),]


## @knitr script_Analysis_Question6
# Q6
# Summary statistics for the ABV variable.
summary(script_state_ABV)

## @knitr script_Analysis_Question7
# Q7
# Is there an apparent relationship between the bitterness of the beer and its alcoholic content? Draw a scatter plot.

ggplot(script_beer_world, aes(x = IBU, y = ABV)) + 
  geom_point(colour = 'red', size = 1, na.rm=TRUE) + 
  labs(title = "Relationship between Bitterness and Alcohol content", subtitle = "Is bitter better?") + 
  labs(caption = "(based on data from ...?? where's the data from ??)") +
  geom_smooth(method=lm, se=FALSE, size = 1, na.rm=TRUE)


# TODO

# cat(paste("This is the state to analyze:", params$state))

#```{r child = './markdown/analysis.Rmd'}
#```

#```{r child = './markdown/customer.Rmd'}
#```

