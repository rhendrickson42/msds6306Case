# MSDS 6306 Case Study 01
#
# data setup and log environment()
#
# This is an external R script to setup data
# 

if(!require("here")) cat("please install here package # devtools::install_github(\"krlmlr/here\")")
# note1 - here package
# use here package to help with project structure, install described below
# devtools::install_github("krlmlr/here")


## @knitr scriptDataSetup_files
library(RCurl)
library(here) # see note1 in script for explanation
# --- Raw data
local_file1 <- here("data", "Breweries.csv")
local_file2 <- here("data", "Beers.csv")

## @knitr scriptDataSetup_readFiles
script_breweries <- read.csv(paste(local_file1), header = TRUE, sep = ",")
script_beers <- read.csv(paste(local_file2), header = TRUE, sep = ",")

## @knitr scriptDataSetup_tidyBeersAndBreweries

# tidy the data
# 
# TODO - remove strange characters seen in dataframe, whitespace, view data, verify #001 Golden Amber Lager beer name
# from str(beer_world), also " AL", " AR", etc.

colnames(script_breweries)[1] <- "Brewery_id"
script_breweries$Name <- trimws(script_breweries$Name)
script_breweries$State <- trimws(script_breweries$State)


## @knitr scriptDataSetup_logsessionInfo

# log environment
sessionInfo()

