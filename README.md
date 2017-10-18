BrewData - README.md

Jim Park and Randall Hendrickson

# Project Summary

The number of breweries in the United States has more than tripled in the last decade according to www.brewersassociation.org. Along with this explosive growth the industry is becoming much more competitive. For startup breweries it is important to understand the level of competition within the state and the preferences of the consumer in order to be successful. This project utilizes two provided data sets, combines them, then explores several statistics and relationships of interest.

# Company Profile

BrewData Inc., a data science company specializing in brewery and beer data has created new algorithms and data analysis tools to help understand your target market.

# Directory Structure

### **Master_JP_RH.Rmd** <---- master document
### **README.md** <----- this file
### **codebook.Rmd**
### **Bibliography_adn_notes.Rmd**

```
|--Project_Root
    |--data
    |--markdown
    |--scripts
    |--Bibliography_and_notes.Rmd
    |--Makefile
    |--Master_JP_RH.Rmd
    |--Master_JP_RH.html
    |--Master_JP_RH.md
    |--README.md
    |--codebook.Rmd
```

* data directory
    + Beers.csv - data for beers across the United States
    + Breweries.csv - data for breweries across the United States
    + topBreweries2016.csv - updated data for new trends
    + topcraft2016.csv - updated data for craft beer trends

* markdown directory
    + analysis.Rmd - analysis for breweries and beers
    + customer.Rmd - analysis specific to a particular state where the customer is located
    + Case_Study_01_Beers.Rmd

* scripts directory
    + dataSetup.R - R script to get data
    + createDataSets.R - R script to process data
    + analysis.R - R script to analyze data
    
* Project Root
    + Bibliography_and_notes.Rmd
    + **codebook.Rmd**
    + Makefile
    + **Master_JP_RH.Rmd**
    + msds6306Case.Rproj
    + Proj1.Rproj
    + **README.md**
    
    

To access data and code for this codebook, please fork us at:
https://github.com/rhendrickson42/msds6306Case
