# MSDS 6306 Case Study 01
#
# data setup and log environment()
#
# This is an external R script to setup data
# 

## @knitr variablesGitHubFiles

library(RCurl)

# use here package to help with project structure
# devtools::install_github("krlmlr/here")
library(here)
# option to replace below from using github
local_file1 <- here("data", "Breweries.csv")
local_file2 <- here("data", "Beers.csv")

breweries <- read.csv(paste(local_file1), header = TRUE, sep = ",")
beers <- read.csv(paste(local_file2), header = TRUE, sep = ",")

github_file_1 <- "https://raw.githubusercontent.com/rhendrickson42/msds6306Case/master/data/Breweries.csv"
github_file_2 <- "https://raw.githubusercontent.com/rhendrickson42/msds6306Case/master/data/Beers.csv"

## @knitr variables beersBreweries

#breweries <- read.csv(text = getURL(github_file_1), header = TRUE, sep = ",")
#beers <- read.csv(text = getURL(github_file_2), header = TRUE, sep = ",")

# tidy the data
# 
# TODO - remove strange characters seen in dataframe, whitespace, view data, verify #001 Golden Amber Lager beer name
# from str(beer_world), also " AL", " AR", etc.

colnames(breweries)[1] <- "Brewery_id"
breweries$Name <- trimws(breweries$Name)
breweries$State <- trimws(breweries$State)

# note - to run from cmd line
# "c:\Program Files\R\R-3.4.1\bin\Rscript.exe" -e "library(knitr); knit('Case_Study_01_Beers.Rmd')


# log bibliography info
#
# TODO note- testing where to put bibliographies and citations (some ideas)
# probably at end of Rmarkdown as described in Bibliography placement
# http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#bibliography_placement

# https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faq-how-do-i-cite-web-pages-and-programs-from-the-ucla-statistical-consulting-group/
# https://stats.idre.ucla.edu/r/faq/how-can-i-explore-different-smooths-in-ggplot2/

# http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html

# info on how to separate documents
# https://yihui.name/knitr/demo/externalization/
# https://github.com/yihui/knitr-examples

# a package for working directory (to help with project structure)
# https://github.com/jennybc/here_here#readme

# updated 2016 top craft/breweries 
# topbreweries2016.csv, topcraft2016.csv
# https://www.brewersassociation.org/press-releases/brewers-association-releases-top-50-breweries-of-2016/


# log environment
sessionInfo()

