# Case Study 01 - Beers
Randall Hendrickson and Jim Park  
October 6, 2017  

#INTRODUCTION

The number of breweries in the United States has more than tripled in the last decade according to www.brewersassociation.org.  Along with this explosive growth the industry is becoming much more competitive.   For startup breweries it is important to understand the level of competition within the state and the preferences of the consumer in order to be successful.  BrewData Inc., a data science company specializing in brewery and beer data, is pleased to provide our client, Great-Beer Distributors Inc. (GBDI), with an easy to use R program which reports out specific beer and brewery data of interested by the state as well as national trends.  As requested BrewData Inc. will conduct this work utilizing the data provided by GBDI.  Finally, GBDI has also asked BrewDAta Inc. to simplify the data provided by consolidating in to one merged data file and to identify missing data.

CAPABILITIES AND DEMONSTRATION OF PROGRAM
To illustrate the program capabilites BrewData Inc. has provided sample program output using the state of Texas. To get additional reports for different states, change the state in *line 6* of the *Master_JP_RH.Rmd* document to another state, and run the *make* command at the project root directory, or use RStudio's *Build All* button. The program will provide a report specific to the state entered.  A sample report for the state of Texas, entered as 'TX', is provided below.

Here are specific responses as requested by our contract signed earlier. Please note, for the purpose of this report,  Washington D.C is modeled as a separate state.

1. As requested by GBDI, we have the following data for the number of breweries in each state. This will provide data whether their new brewery has local competition and by how many breweries.


```r
StateSelected <- params$state
# devtools::install_github("krlmlr/here")
library(here)
```

```
## here() starts at C:/Users/Jim/Google Drive/School/DoingDataScience/BranchProject/msds6306Case
```

```r
local_file1 <- here("data", "Breweries.csv")
local_file2 <- here("data", "Beers.csv")
Breweries <- read.csv(paste(local_file1),sep=",", header = TRUE)
library('plyr') # to call the count command
```

```
## 
## Attaching package: 'plyr'
```

```
## The following object is masked from 'package:here':
## 
##     here
```

```r
States <- (Breweries$State) #assigns variable to States
names(States)[names(States) == "x"] <- "State"
names(States)[names(States) == "freq"] <- "frequency"
count(States) #Generates frequency table.  Number of Observations(breweries)/State
```

```
##      x freq
## 1   AK    7
## 2   AL    3
## 3   AR    2
## 4   AZ   11
## 5   CA   39
## 6   CO   47
## 7   CT    8
## 8   DC    1
## 9   DE    2
## 10  FL   15
## 11  GA    7
## 12  HI    4
## 13  IA    5
## 14  ID    5
## 15  IL   18
## 16  IN   22
## 17  KS    3
## 18  KY    4
## 19  LA    5
## 20  MA   23
## 21  MD    7
## 22  ME    9
## 23  MI   32
## 24  MN   12
## 25  MO    9
## 26  MS    2
## 27  MT    9
## 28  NC   19
## 29  ND    1
## 30  NE    5
## 31  NH    3
## 32  NJ    3
## 33  NM    4
## 34  NV    2
## 35  NY   16
## 36  OH   15
## 37  OK    6
## 38  OR   29
## 39  PA   25
## 40  RI    5
## 41  SC    4
## 42  SD    1
## 43  TN    3
## 44  TX   28
## 45  UT    4
## 46  VA   16
## 47  VT   10
## 48  WA   23
## 49  WI   20
## 50  WV    1
## 51  WY    4
```

2. Additional information requested by GBDI was related to the beers that these respective brewers produce. We have consolidated this data by merging the data for the beers produced by each brewer. As requested, here are the first and last six observations for this data. A printing of the first 6 observations and the last 6 observations are provided here as a sample of the output.


```r
Beers <- read.csv(paste(local_file2),sep=",", header = TRUE)
mergedData <- merge(Breweries, Beers, by.x=c('Brew_ID'), by.y=c('Brewery_id'))
names(mergedData)[names(mergedData) == "Name.x"] <- "Brewery_Name"
names(mergedData)[names(mergedData) == "Name.y"] <- "Beer_Name"
mergedData$State <- gsub(" ", "", mergedData$State, fixed = TRUE) #Removes extra spaces that area not needed.
head(mergedData,n=6)
```

```
##   Brew_ID       Brewery_Name        City State     Beer_Name Beer_ID   ABV
## 1       1 NorthGate Brewing  Minneapolis    MN       Pumpion    2689 0.060
## 2       1 NorthGate Brewing  Minneapolis    MN    Stronghold    2688 0.060
## 3       1 NorthGate Brewing  Minneapolis    MN   Parapet ESB    2687 0.056
## 4       1 NorthGate Brewing  Minneapolis    MN  Get Together    2692 0.045
## 5       1 NorthGate Brewing  Minneapolis    MN Maggie's Leap    2691 0.049
## 6       1 NorthGate Brewing  Minneapolis    MN    Wall's End    2690 0.048
##   IBU                               Style Ounces
## 1  38                         Pumpkin Ale     16
## 2  25                     American Porter     16
## 3  47 Extra Special / Strong Bitter (ESB)     16
## 4  50                        American IPA     16
## 5  26                  Milk / Sweet Stout     16
## 6  19                   English Brown Ale     16
```

```r
tail(mergedData, n=6)
```

```
##      Brew_ID                  Brewery_Name          City State
## 2405     556         Ukiah Brewing Company         Ukiah    CA
## 2406     557       Butternuts Beer and Ale Garrattsville    NY
## 2407     557       Butternuts Beer and Ale Garrattsville    NY
## 2408     557       Butternuts Beer and Ale Garrattsville    NY
## 2409     557       Butternuts Beer and Ale Garrattsville    NY
## 2410     558 Sleeping Lady Brewing Company     Anchorage    AK
##                      Beer_Name Beer_ID   ABV IBU                   Style
## 2405             Pilsner Ukiah      98 0.055  NA         German Pilsener
## 2406         Porkslap Pale Ale      49 0.043  NA American Pale Ale (APA)
## 2407           Snapperhead IPA      51 0.068  NA            American IPA
## 2408         Moo Thunder Stout      50 0.049  NA      Milk / Sweet Stout
## 2409  Heinnieweisse Weissebier      52 0.049  NA              Hefeweizen
## 2410 Urban Wilderness Pale Ale      30 0.049  NA        English Pale Ale
##      Ounces
## 2405     12
## 2406     12
## 2407     12
## 2408     12
## 2409     12
## 2410     12
```

3. As requested by GBDI, we are pleased to perform robustness tests on the produced data. We have identified some missing data as detailed below. This is represented by an "NA" term and the counts are detailed below. The chart below shows there are 62 NAs in Alcohol by Volume (ABV) and there are 1005 NAs in International Bitterness Unit data. Both were from data sets provided by GBDI. It should be noted that South Dakota did not have any reported IBU data. (For an additional fee, we can provide testing for all missing NA data or provide state of the art bootstrapping techniques.)


```r
# report number of NAs
num_NAs <- sapply(mergedData, function(x) sum(is.na(x)))
num_NAs
```

```
##      Brew_ID Brewery_Name         City        State    Beer_Name 
##            0            0            0            0            0 
##      Beer_ID          ABV          IBU        Style       Ounces 
##            0           62         1005            0            0
```

4. After speaking with GBDI's *Brewmaster Mr. Potterhead*, we are well aware of the need to understand the ABV and IBU medians from the provided data. We are pleased to provide *Mr. Potterhead* with the following results and he should note that the report is customized to highlight The State of Texas in *Blue* as defined in our contract.


```r
state_ABV <- aggregate(mergedData["ABV"], by=mergedData[c("State")], FUN=median, na.rm=TRUE)
State_IBU <- aggregate(mergedData["IBU"], by=mergedData[c("State")], FUN=median, na.rm=TRUE)
library('plyr')
ListOfStates <- sort(unique(mergedData$State)) # Creates a list of the states in alphabetical order assuming it may be needed by the application user.
StateQty <- data.frame(matrix(ncol = 2, nrow = 51)) #Initiates data frame for loop
ColorOfPlot <- 0 #Initiates vector for loop to be used to color code bar chart.
library(data.table)
setnames(StateQty, old = c('X1','X2'), new = c('State','Number')) #Changes the names of columns.

#  Loop below builds a data frame with state, number of beers in each state, and color scheme for bar chart
for(i in 1:51){
StateQty$State[i] <- as.character(ListOfStates[i]) #Adds each state to the vector
StateBeers <- mergedData[grep(ListOfStates[i], mergedData$State),]
StateQty$Number[i] <- nrow(StateBeers)
ColorOfPlot[i] <- 'Red' #Initializes all to the color red.
}

StateQty <- StateQty[order(-StateQty$Number),]#Orders from high to low based on number in brewery
#StateQty
ColorOfPlot[which(grepl(StateSelected, StateQty$State))] <- 'blue' #Changes the color of the state of interest to stand out in plotting.  Feeds into fill command in plot that follows.
# Plots a histogram in decreasing order of beers per state with the state of interest highlighted
library(ggplot2)
ggplot(data=StateQty, aes(x=reorder(State, -Number), y=Number)) + geom_bar(stat = "identity", fill=ColorOfPlot) +  theme(axis.text.x=element_text(angle=90,vjust=0.5)) + xlab("State") + ylab("Number of Beers") + ggtitle("Number of Different Beers by State")
```

![](Master_JP_RH_files/figure-html/ABVIBUCharts-1.png)<!-- -->

```r
# Loop to construct the color scheme for fill option in plotting median IBU by state
ColorOfPlotIBU <- 0
for(i in 1:51){
ColorOfPlotIBU[i] <- 'Red'
}
State_IBU <- State_IBU[order(-State_IBU$IBU),]#Orders from high to low based on IBU
State_IBU[is.na(State_IBU)] <- 0
ColorOfPlotIBU[which(grepl(StateSelected, State_IBU$State))] <- 'blue' 
ggplot(data=State_IBU, aes(x=reorder(State, -IBU), y=IBU)) + geom_bar(stat = "identity", fill=ColorOfPlotIBU) +  theme(axis.text.x=element_text(angle=90,vjust=0.5)) + xlab("State") + ylab("IBU") + ggtitle("IBU Median by State") + labs(caption = "(*SD did not have any reported IBU values)")
```

![](Master_JP_RH_files/figure-html/ABVIBUCharts-2.png)<!-- -->

Additionally, after deep analysis, we are able to provide which state has the maximum alcoholic (ABV) beer and which state has the most bitter (IBU) beer. Please find the following data for your reference.

The state with the highest (max) median ABV is District of Columbia (DC).
The state with the highest (max) median IBU is Maine (ME).


```r
# max ABV
state_ABV[which.max(state_ABV$ABV),]
```

```
##   State    ABV
## 8    DC 0.0625
```

```r
# max IBU
State_IBU[which.max(State_IBU$IBU),]
```

```
##    State IBU
## 22    ME  61
```

6. Following the last sections of our contract, we are providing a summary of the ABV data, this summary includes the data from the output below.


```r
summary(state_ABV)
```

```
##     State                ABV         
##  Length:51          Min.   :0.04000  
##  Class :character   1st Qu.:0.05500  
##  Mode  :character   Median :0.05600  
##                     Mean   :0.05585  
##                     3rd Qu.:0.05800  
##                     Max.   :0.06250
```

7. Finally, GBDi requested us to understand the relationship between the bitterness of the beer and its alcoholic content? Please see the below scatter plot. You will see there is a somewhat linear trend whereas IBU increases, so does ABV. Please note, that this is an observational study so causation cannot be inferred.


```r
ggplot(mergedData, aes(x = IBU, y = ABV)) + 
  geom_point(colour = 'red', size = 1, na.rm=TRUE) + 
  labs(title = "Relationship between Bitterness and Alcohol content", subtitle = "Is bitter better?") + 
  labs(caption = "(based on data from GBDI") +
  geom_smooth(method=lm, se=FALSE, size = 1, na.rm=TRUE)
```

![](Master_JP_RH_files/figure-html/beer_plot-1.png)<!-- -->

In addition to the information requested under contract BrewData Inc. strives to exceed our customers expectations.  We hope you find the following information useful in understanding beer adn brewery trends in the selected state and in the nation in general.  The queries the data provided and lists all of the beers in a particular state (in this case Texas) along with a custom statement.  This data may be useful in understanding the level of competition in your state as well as an indication of which states are "Brew Friendly."


```r
StateBeers <- mergedData[grep(StateSelected, mergedData$State),]
BeersInStateOutput <- paste('There are', length(ListOfStates), ' Unique states in this data set and', nrow(StateBeers), 'unique beers in the state of', StateSelected)
BeersInStateOutput
```

```
## [1] "There are 51  Unique states in this data set and 130 unique beers in the state of TX"
```

```r
StateBeers
```

```
##      Brew_ID                        Brewery_Name             City State
## 226       30                 Cedar Creek Brewery     Seven Points    TX
## 227       30                 Cedar Creek Brewery     Seven Points    TX
## 228       30                 Cedar Creek Brewery     Seven Points    TX
## 229       30                 Cedar Creek Brewery     Seven Points    TX
## 230       30                 Cedar Creek Brewery     Seven Points    TX
## 231       30                 Cedar Creek Brewery     Seven Points    TX
## 283       39           Twisted X Brewing Company Dripping Springs    TX
## 284       39           Twisted X Brewing Company Dripping Springs    TX
## 285       39           Twisted X Brewing Company Dripping Springs    TX
## 455       67            Freetail Brewing Company      San Antonio    TX
## 456       67            Freetail Brewing Company      San Antonio    TX
## 457       67            Freetail Brewing Company      San Antonio    TX
## 458       67            Freetail Brewing Company      San Antonio    TX
## 459       67            Freetail Brewing Company      San Antonio    TX
## 460       67            Freetail Brewing Company      San Antonio    TX
## 461       67            Freetail Brewing Company      San Antonio    TX
## 462       67            Freetail Brewing Company      San Antonio    TX
## 508       78                    Blue Owl Brewing           Austin    TX
## 509       78                    Blue Owl Brewing           Austin    TX
## 510       78                    Blue Owl Brewing           Austin    TX
## 511       78                    Blue Owl Brewing           Austin    TX
## 695      119       Southern Star Brewing Company           Conroe    TX
## 696      119       Southern Star Brewing Company           Conroe    TX
## 697      119       Southern Star Brewing Company           Conroe    TX
## 698      119       Southern Star Brewing Company           Conroe    TX
## 699      119       Southern Star Brewing Company           Conroe    TX
## 700      119       Southern Star Brewing Company           Conroe    TX
## 701      119       Southern Star Brewing Company           Conroe    TX
## 702      119       Southern Star Brewing Company           Conroe    TX
## 703      119       Southern Star Brewing Company           Conroe    TX
## 704      119       Southern Star Brewing Company           Conroe    TX
## 705      119       Southern Star Brewing Company           Conroe    TX
## 706      119       Southern Star Brewing Company           Conroe    TX
## 707      119       Southern Star Brewing Company           Conroe    TX
## 708      119       Southern Star Brewing Company           Conroe    TX
## 733      126             Karbach Brewing Company          Houston    TX
## 734      126             Karbach Brewing Company          Houston    TX
## 735      126             Karbach Brewing Company          Houston    TX
## 736      126             Karbach Brewing Company          Houston    TX
## 737      126             Karbach Brewing Company          Houston    TX
## 738      126             Karbach Brewing Company          Houston    TX
## 739      126             Karbach Brewing Company          Houston    TX
## 740      126             Karbach Brewing Company          Houston    TX
## 741      126             Karbach Brewing Company          Houston    TX
## 742      126             Karbach Brewing Company          Houston    TX
## 743      127 Uncle Billy's Brewery and Smokeh...           Austin    TX
## 744      127 Uncle Billy's Brewery and Smokeh...           Austin    TX
## 745      128          Deep Ellum Brewing Company           Dallas    TX
## 746      128          Deep Ellum Brewing Company           Dallas    TX
## 747      128          Deep Ellum Brewing Company           Dallas    TX
## 748      128          Deep Ellum Brewing Company           Dallas    TX
## 749      128          Deep Ellum Brewing Company           Dallas    TX
## 750      128          Deep Ellum Brewing Company           Dallas    TX
## 751      128          Deep Ellum Brewing Company           Dallas    TX
## 752      128          Deep Ellum Brewing Company           Dallas    TX
## 753      128          Deep Ellum Brewing Company           Dallas    TX
## 754      129            Real Ale Brewing Company           Blanco    TX
## 755      129            Real Ale Brewing Company           Blanco    TX
## 756      129            Real Ale Brewing Company           Blanco    TX
## 757      129            Real Ale Brewing Company           Blanco    TX
## 758      129            Real Ale Brewing Company           Blanco    TX
## 759      129            Real Ale Brewing Company           Blanco    TX
## 760      129            Real Ale Brewing Company           Blanco    TX
## 761      129            Real Ale Brewing Company           Blanco    TX
## 825      137       Hops & Grains Brewing Company           Austin    TX
## 832      141        Independence Brewing Company           Austin    TX
## 833      141        Independence Brewing Company           Austin    TX
## 834      141        Independence Brewing Company           Austin    TX
## 952      162        Martin House Brewing Company       Fort Worth    TX
## 953      162        Martin House Brewing Company       Fort Worth    TX
## 954      162        Martin House Brewing Company       Fort Worth    TX
## 955      162        Martin House Brewing Company       Fort Worth    TX
## 956      162        Martin House Brewing Company       Fort Worth    TX
## 957      162        Martin House Brewing Company       Fort Worth    TX
## 958      162        Martin House Brewing Company       Fort Worth    TX
## 959      162        Martin House Brewing Company       Fort Worth    TX
## 1077     177         Rahr & Sons Brewing Company       Fort Worth    TX
## 1078     177         Rahr & Sons Brewing Company       Fort Worth    TX
## 1114     185         Oasis Texas Brewing Company           Austin    TX
## 1115     185         Oasis Texas Brewing Company           Austin    TX
## 1116     185         Oasis Texas Brewing Company           Austin    TX
## 1117     185         Oasis Texas Brewing Company           Austin    TX
## 1124     188          Pedernales Brewing Company   Fredericksburg    TX
## 1125     188          Pedernales Brewing Company   Fredericksburg    TX
## 1219     208          Branchline Brewing Company      San Antonio    TX
## 1244     214             Grapevine Craft Brewery   Farmers Branch    TX
## 1245     214             Grapevine Craft Brewery   Farmers Branch    TX
## 1246     214             Grapevine Craft Brewery   Farmers Branch    TX
## 1247     215       Buffalo Bayou Brewing Company          Houston    TX
## 1248     215       Buffalo Bayou Brewing Company          Houston    TX
## 1249     215       Buffalo Bayou Brewing Company          Houston    TX
## 1250     216                  Texian Brewing Co.         Richmond    TX
## 1251     216                  Texian Brewing Co.         Richmond    TX
## 1252     216                  Texian Brewing Co.         Richmond    TX
## 1253     216                  Texian Brewing Co.         Richmond    TX
## 1357     242        New Republic Brewing Company  College Station    TX
## 1358     242        New Republic Brewing Company  College Station    TX
## 1359     242        New Republic Brewing Company  College Station    TX
## 1360     243            Infamous Brewing Company           Austin    TX
## 1361     243            Infamous Brewing Company           Austin    TX
## 1402     258                South Austin Brewery     South Austin    TX
## 1403     258                South Austin Brewery     South Austin    TX
## 1404     258                South Austin Brewery     South Austin    TX
## 1405     258                South Austin Brewery     South Austin    TX
## 1494     288        Four Corners Brewing Company           Dallas    TX
## 1495     288        Four Corners Brewing Company           Dallas    TX
## 1496     288        Four Corners Brewing Company           Dallas    TX
## 1962     396                Hops & Grain Brewery           Austin    TX
## 1963     396                Hops & Grain Brewery           Austin    TX
## 1964     396                Hops & Grain Brewery           Austin    TX
## 1965     396                Hops & Grain Brewery           Austin    TX
## 2014     414                    Austin Beerworks           Austin    TX
## 2015     414                    Austin Beerworks           Austin    TX
## 2016     414                    Austin Beerworks           Austin    TX
## 2017     414                    Austin Beerworks           Austin    TX
## 2018     414                    Austin Beerworks           Austin    TX
## 2051     427                 Armadillo Ale Works           Denton    TX
## 2052     427                 Armadillo Ale Works           Denton    TX
## 2168     464            Big Bend Brewing Company           Alpine    TX
## 2169     464            Big Bend Brewing Company           Alpine    TX
## 2170     464            Big Bend Brewing Company           Alpine    TX
## 2171     464            Big Bend Brewing Company           Alpine    TX
## 2172     464            Big Bend Brewing Company           Alpine    TX
## 2181     471              Pete's Brewing Company      San Antonio    TX
## 2182     471              Pete's Brewing Company      San Antonio    TX
## 2183     471              Pete's Brewing Company      San Antonio    TX
## 2184     471              Pete's Brewing Company      San Antonio    TX
## 2185     471              Pete's Brewing Company      San Antonio    TX
## 2186     471              Pete's Brewing Company      San Antonio    TX
## 2187     471              Pete's Brewing Company      San Antonio    TX
##                                      Beer_Name Beer_ID   ABV IBU
## 226                            The Lawn Ranger    1050 0.050  18
## 227             Elliott's Phoned Home Pale Ale    1182 0.051  36
## 228                       Scruffy's Smoked Alt    1584 0.051  35
## 229                            Special Release    2210    NA  NA
## 230                                Dankosaurus    2052 0.068  70
## 231                                 Gone A-Rye    2600 0.085  90
## 283                                  Twisted X    2212 0.051  19
## 284                                  Cow Creek    2588 0.054  26
## 285                                 Chupahopra    2458 0.075  63
## 455                                  Texicali     2526 0.065  33
## 456                           Bat Outta Helles    2524 0.042  20
## 457                             Pinata Protest    2525 0.060  NA
## 458                                    Rye Wit    2522 0.042  10
## 459                                   Original    2523 0.068  NA
## 460                                 Soul Doubt    2521 0.059  70
## 461                              OktoberFiesta    2527 0.053  27
## 462                         Yo Soy Un Berliner    2520 0.044   5
## 508                                Little Boss    2489    NA  NA
## 509                              Spirit Animal    2487    NA  NA
## 510                            Professor Black    2490    NA  NA
## 511                                 Van Dayum!    2488    NA  NA
## 695                       PRO-AM (2012) (2012)     853 0.099 100
## 696                    Red Cockaded Ale (2013)    1011 0.085 110
## 697                              Old Potentate    1010 0.072  40
## 698                        Valkyrie Double IPA    1497 0.092 100
## 699                      Le Mort Vivant (2011)     555 0.069  23
## 700                                    Walloon    2267 0.055  NA
## 701                           Red Cockaded Ale    1728 0.085 110
## 702                           Bombshell Blonde     856 0.050  20
## 703                         Pine Belt Pale Ale    2387 0.065  45
## 704                         Pine Belt Pale Ale      45 0.065  45
## 705                       Buried Hatchet Stout      46 0.083  50
## 706                             Walloon (2014)     691 0.055  NA
## 707                             Le Mort Vivant    1740 0.069  23
## 708                           Bombshell Blonde      44 0.050  20
## 733         Love Street Summer Seasonal (2014)    1235 0.047  20
## 734                   Hopadillo India Pale Ale     463 0.066  70
## 735                         Barn Burner Saison    1068 0.066  20
## 736                     Rodeo Clown Double IPA     666 0.095  85
## 737                               Weisse Versa     464 0.052  15
## 738                           Karbachtoberfest    1458 0.055  25
## 739                     Sympathy for the Lager     465 0.049  45
## 740                            Mother in Lager    1560 0.058  25
## 741                   Weekend Warrior Pale Ale    1557 0.055  40
## 742                        Weisse Versa (2012)    2374 0.052  16
## 743                           Humbucker Helles    2367 0.047  25
## 744                             The Green Room    2372 0.060  75
## 745                       Oak Cliff Coffee Ale    2251 0.075  33
## 746                         Double Brown Stout    1203 0.070  NA
## 747                              Farmhouse Wit    1202 0.048  25
## 748                     Rye Pils Session Lager    1161 0.046  NA
## 749                   Dream Crusher Double IPA    2166 0.085 100
## 750                        Deep Ellum Pale Ale    1827 0.060  NA
## 751                              Neato Bandito    2371 0.060  NA
## 752                             Deep Ellum IPA     943 0.070  70
## 753                              Dallas Blonde     946 0.052  23
## 754                      18th Anniversary Gose    2370 0.044   5
## 755                                     BLAKKR    1861 0.099  85
## 756                    The Sword Iron Swan Ale    1290 0.059  NA
## 757                               White (2015)    2211 0.046  25
## 758              Firemans #4 Blonde Ale (2015)     830 0.051  21
## 759                          Hans' Pils (2015)    1091 0.053  52
## 760              Firemans #4 Blonde Ale (2013)    1718 0.051  21
## 761                        Four Squared (2015)    1086 0.060  50
## 825                             Porter Culture    2357 0.065  NA
## 832                              Power & Light    2301 0.055  42
## 833                              White Rabbit     1904 0.059  27
## 834                              Oklahoma Suks    2350 0.048  32
## 952           Day Break 4-Grain Breakfast Beer    1233 0.050  NA
## 953                                River House    2308 0.050  20
## 954                         The Imperial Texan    2120 0.080  NA
## 955                         The Imperial Texan    1234 0.080  NA
## 956                        There Will Be Stout    1231 0.065  NA
## 957                              Pretzel Stout    2268 0.065  47
## 958                         River House Saison    1232 0.050  NA
## 959                             Rubberneck Red    2197 0.050  35
## 1077                   Pride of Texas Pale Ale    2229 0.058  60
## 1078                             Rahr's Blonde    2269 0.046  NA
## 1114                              Lake Monster    2247 0.082  25
## 1115                       London Homesick Ale    2071 0.049  27
## 1116                             Luchesa Lager    2070 0.048  35
## 1117                                 Slow Ride    2069 0.048  35
## 1124                                 Lobo Lito    2238 0.040  12
## 1125               Robert Earl Keen Honey Pils    2144 0.050  17
## 1219                                  Evil Owl    2167 0.052  40
## 1244           Sir William's English Brown Ale    2127 0.049  21
## 1245            Monarch Classic American Wheat    2129 0.043  21
## 1246                     Lakefire Rye Pale Ale    2126 0.055  35
## 1247                                      1836    2125 0.060  40
## 1248                              Summer's Wit    2124 0.060  20
## 1249                              More Cowbell    2123 0.090 118
## 1250                                    Brutus    2116 0.071  69
## 1251                               Battle LIne    2118 0.063  23
## 1252                               First Stand    2119 0.055  35
## 1253                             Broken Bridge    2117 0.056  12
## 1357                                  Skylight    2043 0.056  20
## 1358                                   Kadigan    2042 0.056  30
## 1359                               Dammit Jim!    2041 0.052  50
## 1360                                    Hijack    1774 0.055  20
## 1361                              Infamous IPA    2038 0.070  75
## 1402                                 Kol' Beer    1969 0.050  22
## 1403                                LuckenBock    1972 0.070  18
## 1404                           6 String Saison    1970 0.080  NA
## 1405                      Texas Pale Ale (TPA)    1971 0.055  40
## 1494                            El Chingon IPA    1874 0.076  73
## 1495                                Local Buzz    1872 0.052  20
## 1496                 Block Party Robust Porter    1873 0.057  40
## 1962                     The One They Call Zoe    1004 0.051  NA
## 1963                Green House India Pale Ale    1501 0.070  NA
## 1964                                  Pale Dog     501 0.060  50
## 1965                                Alteration     502 0.051  40
## 2014 Heavy Machinery IPA Series #1: Heavy Fist    1409 0.070  NA
## 2015                             Black Thunder     340 0.052  NA
## 2016                            Fire Eagle IPA     343 0.062  NA
## 2017                                Peacemaker     342 0.051  NA
## 2018                                Pearl-Snap     341 0.053  NA
## 2051                          Quakertown Stout    1333 0.092  50
## 2052                   Greenbelt Farmhouse Ale    1332 0.051  20
## 2168                            Terlingua Gold    1154 0.060  NA
## 2169                       Big Bend Hefeweizen    1155 0.056  NA
## 2170                   La Frontera Premium IPA    1158 0.078  NA
## 2171                               Tejas Lager    1157 0.047  NA
## 2172                          Number 22 Porter    1156 0.064  NA
## 2181             Pete's Wicked Pale Ale (1997)    1056    NA  NA
## 2182          Pete's Wicked Summer Brew (1996)    1053 0.047  NA
## 2183          Pete's Wicked Summer Brew (1997)    1054 0.047  NA
## 2184                   Pete's ESP Lager (1998)    1062 0.051  NA
## 2185     Pete's Wicked Bohemian Pilsner (1997)    1060 0.049  NA
## 2186          Pete's Wicked Summer Brew (1995)    1061 0.047  NA
## 2187          Pete's Wicked Summer Brew (2002)    1055 0.047  NA
##                                 Style Ounces
## 226                         Cream Ale     16
## 227           American Pale Ale (APA)     16
## 228                       Smoked Beer     16
## 229                                       16
## 230                      American IPA     16
## 231    American Double / Imperial IPA     16
## 283            American Adjunct Lager     12
## 284        American Amber / Red Lager     12
## 285                      American IPA     12
## 455                American Brown Ale     12
## 456               Munich Helles Lager     12
## 457                           Witbier     12
## 458                           Witbier     12
## 459          American Amber / Red Ale     12
## 460                      American IPA     12
## 461                                       12
## 462                Berliner Weissbier     12
## 508           American Pale Wheat Ale     12
## 509           American Pale Ale (APA)     12
## 510                    American Stout     12
## 511          American Amber / Red Ale     12
## 695    American Double / Imperial IPA     12
## 696    American Double / Imperial IPA     12
## 697                           Old Ale     12
## 698    American Double / Imperial IPA     12
## 699                   BiÃ¨re de Garde     12
## 700            Saison / Farmhouse Ale     12
## 701    American Double / Imperial IPA     12
## 702               American Blonde Ale     16
## 703           American Pale Ale (APA)     12
## 704           American Pale Ale (APA)     16
## 705            Foreign / Export Stout     12
## 706            Saison / Farmhouse Ale     12
## 707                   BiÃ¨re de Garde     12
## 708               American Blonde Ale     12
## 733                           KÃ¶lsch     12
## 734                      American IPA     12
## 735            Saison / Farmhouse Ale     12
## 736    American Double / Imperial IPA     12
## 737                        Hefeweizen     12
## 738             MÃ¤rzen / Oktoberfest     12
## 739        American Amber / Red Lager     12
## 740               Munich Dunkel Lager     12
## 741           American Pale Ale (APA)     12
## 742                        Hefeweizen     12
## 743             Maibock / Helles Bock     16
## 744                      American IPA     16
## 745                American Brown Ale     12
## 746                     Baltic Porter     12
## 747            Saison / Farmhouse Ale     16
## 748                   German Pilsener     12
## 749    American Double / Imperial IPA     12
## 750           American Pale Ale (APA)     12
## 751                   Euro Pale Lager     12
## 752                      American IPA     12
## 753               American Blonde Ale     12
## 754                              Gose     12
## 755                American Black Ale     12
## 756                  English Pale Ale     12
## 757                           Witbier     12
## 758               American Blonde Ale     12
## 759                   German Pilsener     12
## 760               American Blonde Ale     12
## 761               American Blonde Ale     12
## 825                   American Porter     12
## 832           American Pale Ale (APA)     12
## 833                           Witbier     12
## 834          American Amber / Red Ale     12
## 952                          Rye Beer     16
## 953            Saison / Farmhouse Ale     16
## 954    American Double / Imperial IPA     16
## 955    American Double / Imperial IPA     12
## 956                    American Stout     12
## 957                    American Stout     16
## 958            Saison / Farmhouse Ale     12
## 959          American Amber / Red Ale     16
## 1077          American Pale Ale (APA)     12
## 1078              Munich Helles Lager     12
## 1114                    Baltic Porter     16
## 1115                   English Bitter     12
## 1116       Keller Bier / Zwickel Bier     12
## 1117          American Pale Ale (APA)     12
## 1124                      Light Lager     12
## 1125                 American Pilsner     12
## 1219         American Amber / Red Ale     12
## 1244                English Brown Ale     12
## 1245          American Pale Wheat Ale     12
## 1246          American Pale Ale (APA)     12
## 1247              American Blonde Ale     12
## 1248                          Witbier     12
## 1249   American Double / Imperial IPA     16
## 1250     English India Pale Ale (IPA)     12
## 1251               American Brown Ale     12
## 1252           Saison / Farmhouse Ale     12
## 1253                     Dunkelweizen     12
## 1357                     Dunkelweizen     12
## 1358              American Blonde Ale     12
## 1359         American Amber / Red Ale     12
## 1360                        Cream Ale     12
## 1361                     American IPA     12
## 1402                          KÃ¶lsch     16
## 1403                             Bock     16
## 1404           Saison / Farmhouse Ale     16
## 1405                     American IPA     16
## 1494                     American IPA     12
## 1495              American Blonde Ale     12
## 1496                  American Porter     12
## 1962              American Pale Lager     12
## 1963                     American IPA     12
## 1964          American Pale Ale (APA)     12
## 1965                          Altbier     12
## 2014               American Black Ale     16
## 2015                      Schwarzbier     12
## 2016                     American IPA     12
## 2017          American Pale Ale (APA)     12
## 2018                  German Pilsener     12
## 2051 American Double / Imperial Stout     12
## 2052           Saison / Farmhouse Ale     12
## 2168              American Blonde Ale     12
## 2169                       Hefeweizen     12
## 2170                     American IPA     12
## 2171                   Czech Pilsener     12
## 2172                  American Porter     12
## 2181          American Pale Ale (APA)     12
## 2182          American Pale Wheat Ale     12
## 2183          American Pale Wheat Ale     12
## 2184              American Pale Lager     12
## 2185                   Czech Pilsener     12
## 2186          American Pale Wheat Ale     12
## 2187          American Pale Wheat Ale     12
```

Finally, BrewData Inc. has provided sample output for our patent pending regional ABV preference algorithm.   This tool assesses if there is a correlation between ABV and longitude and latitude as measured by the center of each state.   In both cases the correlation was relatively weak (less than 13%) with p values of 0.5737 (Longitude) and 0.3861 (Latitude).   Althought the correlations are week, With additional contract work we could explore similar trends that your prime competitor seems to be leveraging fairly well.

# A Look at possible correlation between longitude and ABV

```r
StateLatLong <- data.frame(matrix(ncol = 3, nrow = 50))
sa <- as.data.frame(state.abb)
names(sa)[names(sa) == "state.abb"] <- "State"
sc <- as.data.frame(state.center)
StateLatLong <- cbind(sa,sc)
names(StateLatLong)[names(StateLatLong) == "x"] <- "Longitude"
names(StateLatLong)[names(StateLatLong) == "y"] <- "Latitude"
StateLatLong$State <- as.character(as.factor(StateLatLong$State))

state_ABV$State <- as.character(as.factor(state_ABV$State))
StateLatLong <- rbind(StateLatLong, c("DC", -77.0369, 38.9072)) #Adds DC to the list
StateLatLong$Longitude <- as.numeric(as.character(StateLatLong$Longitude))
StateLatLong$Latitude <- as.numeric(as.character(StateLatLong$Latitude))
StateLatLong <- StateLatLong[order(StateLatLong$State),]

StateCenterABV <-data.frame(matrix(ncol = 4, nrow = 51))
#StateCenterABV <- data.frame(matrix(ncol=4, nrow=51)
StateCenterABV <- merge(StateLatLong, state_ABV, by=c('State'))
StateCenterABV
```

```
##    State Longitude Latitude    ABV
## 1     AK -127.2500  49.2500 0.0560
## 2     AL  -86.7509  32.5901 0.0600
## 3     AR  -92.2992  34.7336 0.0520
## 4     AZ -111.6250  34.2192 0.0550
## 5     CA -119.7730  36.5341 0.0580
## 6     CO -105.5130  38.6777 0.0605
## 7     CT  -72.3573  41.5928 0.0600
## 8     DC  -77.0369  38.9072 0.0625
## 9     DE  -74.9841  38.6777 0.0550
## 10    FL  -81.6850  27.8744 0.0570
## 11    GA  -83.3736  32.3329 0.0550
## 12    HI -126.2500  31.7500 0.0540
## 13    IA  -93.3714  41.9358 0.0555
## 14    ID -113.9300  43.5648 0.0565
## 15    IL  -89.3776  40.0495 0.0580
## 16    IN  -86.0808  40.0495 0.0580
## 17    KS  -98.1156  38.4204 0.0500
## 18    KY  -84.7674  37.3915 0.0625
## 19    LA  -92.2724  30.6181 0.0520
## 20    MA  -71.5800  42.3645 0.0540
## 21    MD  -76.6459  39.2778 0.0580
## 22    ME  -68.9801  45.6226 0.0510
## 23    MI  -84.6870  43.1361 0.0620
## 24    MN  -94.6043  46.3943 0.0560
## 25    MO  -92.5137  38.3347 0.0520
## 26    MS  -89.8065  32.6758 0.0580
## 27    MT -109.3200  46.8230 0.0550
## 28    NC  -78.4686  35.4195 0.0570
## 29    ND -100.0990  47.2517 0.0500
## 30    NE  -99.5898  41.3356 0.0560
## 31    NH  -71.3924  43.3934 0.0550
## 32    NJ  -74.2336  39.9637 0.0460
## 33    NM -105.9420  34.4764 0.0620
## 34    NV -116.8510  39.1063 0.0600
## 35    NY  -75.1449  43.1361 0.0550
## 36    OH  -82.5963  40.2210 0.0580
## 37    OK  -97.1239  35.5053 0.0600
## 38    OR -120.0680  43.9078 0.0560
## 39    PA  -77.4500  40.9069 0.0570
## 40    RI  -71.1244  41.5928 0.0550
## 41    SC  -80.5056  33.6190 0.0550
## 42    SD  -99.7238  44.3365 0.0600
## 43    TN  -86.4560  35.6767 0.0570
## 44    TX  -98.7857  31.3897 0.0550
## 45    UT -111.3300  39.1063 0.0400
## 46    VA  -78.2005  37.5630 0.0565
## 47    VT  -72.5450  44.2508 0.0550
## 48    WA -119.7460  47.4231 0.0555
## 49    WI  -89.9941  44.5937 0.0520
## 50    WV  -80.6665  38.4204 0.0620
## 51    WY -107.2560  43.0504 0.0500
```

```r
plot(StateCenterABV$Longitude, StateCenterABV$ABV)
abline(lm(StateCenterABV$ABV~StateCenterABV$Longitude),col="blue",lwd=2)
```

![](Master_JP_RH_files/figure-html/LatLong-1.png)<!-- -->

```r
cor.test(StateCenterABV$Longitude, StateCenterABV$ABV)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  StateCenterABV$Longitude and StateCenterABV$ABV
## t = 0.5664, df = 49, p-value = 0.5737
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1993641  0.3484888
## sample estimates:
##        cor 
## 0.08065061
```

# A Look at possible correlation between latitude and ABV

```r
StateLatLong <- data.frame(matrix(ncol = 3, nrow = 50))
sa <- as.data.frame(state.abb)
names(sa)[names(sa) == "state.abb"] <- "State"
sc <- as.data.frame(state.center)
StateLatLong <- cbind(sa,sc)
names(StateLatLong)[names(StateLatLong) == "x"] <- "Longitude"
names(StateLatLong)[names(StateLatLong) == "y"] <- "Latitude"
StateLatLong$State <- as.character(as.factor(StateLatLong$State))
state_ABV$State <- as.character(as.factor(state_ABV$State))
StateLatLong <- rbind(StateLatLong, c("DC", -77.0369, 38.9072)) #Adds DC to the list
StateLatLong$Longitude <- as.numeric(as.character(StateLatLong$Longitude))
StateLatLong$Latitude <- as.numeric(as.character(StateLatLong$Latitude))
StateLatLong <- StateLatLong[order(StateLatLong$State),]
StateCenterABV <-data.frame(matrix(ncol = 4, nrow = 51))
#StateCenterABV <- data.frame(matrix(ncol=4, nrow=51)
StateCenterABV <- merge(StateLatLong, state_ABV, by=c('State'))
StateCenterABV
```

```
##    State Longitude Latitude    ABV
## 1     AK -127.2500  49.2500 0.0560
## 2     AL  -86.7509  32.5901 0.0600
## 3     AR  -92.2992  34.7336 0.0520
## 4     AZ -111.6250  34.2192 0.0550
## 5     CA -119.7730  36.5341 0.0580
## 6     CO -105.5130  38.6777 0.0605
## 7     CT  -72.3573  41.5928 0.0600
## 8     DC  -77.0369  38.9072 0.0625
## 9     DE  -74.9841  38.6777 0.0550
## 10    FL  -81.6850  27.8744 0.0570
## 11    GA  -83.3736  32.3329 0.0550
## 12    HI -126.2500  31.7500 0.0540
## 13    IA  -93.3714  41.9358 0.0555
## 14    ID -113.9300  43.5648 0.0565
## 15    IL  -89.3776  40.0495 0.0580
## 16    IN  -86.0808  40.0495 0.0580
## 17    KS  -98.1156  38.4204 0.0500
## 18    KY  -84.7674  37.3915 0.0625
## 19    LA  -92.2724  30.6181 0.0520
## 20    MA  -71.5800  42.3645 0.0540
## 21    MD  -76.6459  39.2778 0.0580
## 22    ME  -68.9801  45.6226 0.0510
## 23    MI  -84.6870  43.1361 0.0620
## 24    MN  -94.6043  46.3943 0.0560
## 25    MO  -92.5137  38.3347 0.0520
## 26    MS  -89.8065  32.6758 0.0580
## 27    MT -109.3200  46.8230 0.0550
## 28    NC  -78.4686  35.4195 0.0570
## 29    ND -100.0990  47.2517 0.0500
## 30    NE  -99.5898  41.3356 0.0560
## 31    NH  -71.3924  43.3934 0.0550
## 32    NJ  -74.2336  39.9637 0.0460
## 33    NM -105.9420  34.4764 0.0620
## 34    NV -116.8510  39.1063 0.0600
## 35    NY  -75.1449  43.1361 0.0550
## 36    OH  -82.5963  40.2210 0.0580
## 37    OK  -97.1239  35.5053 0.0600
## 38    OR -120.0680  43.9078 0.0560
## 39    PA  -77.4500  40.9069 0.0570
## 40    RI  -71.1244  41.5928 0.0550
## 41    SC  -80.5056  33.6190 0.0550
## 42    SD  -99.7238  44.3365 0.0600
## 43    TN  -86.4560  35.6767 0.0570
## 44    TX  -98.7857  31.3897 0.0550
## 45    UT -111.3300  39.1063 0.0400
## 46    VA  -78.2005  37.5630 0.0565
## 47    VT  -72.5450  44.2508 0.0550
## 48    WA -119.7460  47.4231 0.0555
## 49    WI  -89.9941  44.5937 0.0520
## 50    WV  -80.6665  38.4204 0.0620
## 51    WY -107.2560  43.0504 0.0500
```

```r
cor.test(StateCenterABV$Latitude, StateCenterABV$ABV)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  StateCenterABV$Latitude and StateCenterABV$ABV
## t = -0.8746, df = 49, p-value = 0.3861
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3863625  0.1569671
## sample estimates:
##        cor 
## -0.1239796
```

```r
lm(StateCenterABV$ABV~StateCenterABV$Latitude) #in the form Y=X
```

```
## 
## Call:
## lm(formula = StateCenterABV$ABV ~ StateCenterABV$Latitude)
## 
## Coefficients:
##             (Intercept)  StateCenterABV$Latitude  
##               0.0600399               -0.0001063
```

```r
myfit=lm(StateCenterABV$ABV~StateCenterABV$Latitude) #in the form Y=X
myfit
```

```
## 
## Call:
## lm(formula = StateCenterABV$ABV ~ StateCenterABV$Latitude)
## 
## Coefficients:
##             (Intercept)  StateCenterABV$Latitude  
##               0.0600399               -0.0001063
```

```r
plot(StateCenterABV$Latitude, StateCenterABV$ABV)
abline(lm(StateCenterABV$ABV~StateCenterABV$Latitude),col="blue",lwd=2)
```

![](Master_JP_RH_files/figure-html/LatLong1-1.png)<!-- -->

# CONCLUSION
BrewData Inc. has concluded that the beer industry is in a high growth mode in both ABV and IBU.   We would be please to collect and leverage further data in defining a profitable niche for your next super beer.

** Cheers, R. Hendrickson (Chief Beer Officer) and J. Park (Chief Data Officer) **




