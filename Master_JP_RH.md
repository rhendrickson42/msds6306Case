INTRODUCTION
============

The number of breweries in the United States has more than tripled in
the last decade according to www.brewersassociation.org. Along with this
explosive growth the industry is becoming much more competitive. For
startup breweries it is important to understand the level of competition
within the state and the preferences of the consumer in order to be
successful. BrewData Inc., a data science company specializing in
brewery and beer data, is pleased to provide our client, Great-Beer
Distributors Inc. (GBDI), with an easy to use R program which reports
out specific beer and brewery data of interested by the state as well as
national trends. As requested BrewData Inc. will conduct this work
utilizing the data provided by GBDI. Finally, GBDI has also asked
BrewDAta Inc. to simplify the data provided by consolidating in to one
merged data file and to identify missing data.

CAPABILITIES AND DEMONSTRATION OF PROGRAM To illustrate the program
capabilites BrewData Inc. has provided the following sample program
output. All all that is needed is to enter the state in the indicated
location and the program will provide a report specific to the state
entered. A sample report for the state of Michigan, entered as 'MI', is
provided below.

Once the state is entered the program will output the following useful
information:

1.  Number of Breweries in each state. This provides national context.

<!-- -->

    # devtools::install_github("krlmlr/here")
    library(here)

    ## here() starts at C:/Users/Jim/Google Drive/School/DoingDataScience/BranchProject/msds6306Case

    #setwd("C:/Users/Jim/Google Drive/School/DoingDataScience/Proj1")
    local_file1 <- here("data", "Breweries.csv")
    local_file2 <- here("data", "Beers.csv")
    Breweries <- read.csv(paste(local_file1),sep=",", header = TRUE)
    head(Breweries, n=25)

    ##    Brew_ID                         Name          City State
    ## 1        1           NorthGate Brewing    Minneapolis    MN
    ## 2        2    Against the Grain Brewery    Louisville    KY
    ## 3        3     Jack's Abby Craft Lagers    Framingham    MA
    ## 4        4    Mike Hess Brewing Company     San Diego    CA
    ## 5        5      Fort Point Beer Company San Francisco    CA
    ## 6        6        COAST Brewing Company    Charleston    SC
    ## 7        7 Great Divide Brewing Company        Denver    CO
    ## 8        8             Tapistry Brewing      Bridgman    MI
    ## 9        9             Big Lake Brewing       Holland    MI
    ## 10      10   The Mitten Brewing Company  Grand Rapids    MI
    ## 11      11               Brewery Vivant  Grand Rapids    MI
    ## 12      12             Petoskey Brewing      Petoskey    MI
    ## 13      13           Blackrocks Brewery     Marquette    MI
    ## 14      14       Perrin Brewing Company Comstock Park    MI
    ## 15      15  Witch's Hat Brewing Company    South Lyon    MI
    ## 16      16     Founders Brewing Company  Grand Rapids    MI
    ## 17      17            Flat 12 Bierwerks  Indianapolis    IN
    ## 18      18      Tin Man Brewing Company    Evansville    IN
    ## 19      19       Black Acre Brewing Co.  Indianapolis    IN
    ## 20      20            Brew Link Brewing    Plainfield    IN
    ## 21      21           Bare Hands Brewery       Granger    IN
    ## 22      22          Three Pints Brewing  Martinsville    IN
    ## 23      23        Four Fathers Brewing     Valparaiso    IN
    ## 24      24         Indiana City Brewing  Indianapolis    IN
    ## 25      25             Burn 'Em Brewing Michigan City    IN

    library('plyr') # to call the count command

    ## 
    ## Attaching package: 'plyr'

    ## The following object is masked from 'package:here':
    ## 
    ##     here

    States <- (Breweries$State) #assigns variable to States
    count(States) #Generates frequency table.  Number of Observations(breweries)/State

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

1.  Merge beer data with Breweries data and consolidate into
    one document. A printing of the first 6 observations and the last 6
    observations are provided here as a sample of the output.

<!-- -->

    Beers <- read.csv(paste(local_file2),sep=",", header = TRUE)
    mergedData <- merge(Breweries, Beers, by.x=c('Brew_ID'), by.y=c('Brewery_id'))
    names(mergedData)[names(mergedData) == "Name.x"] <- "Brewery_Name"
    names(mergedData)[names(mergedData) == "Name.y"] <- "Beer_Name"
    head(mergedData,n=6)

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

    tail(mergedData, n=6)

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

1.  Identification of missing data. In this output missing data will be
    represented by an "NA" term.

2.  Number of different beers in each state highlighting how the
    selected state compares. This provides insight into the level of
    competition in your state as well as an indication which states are
    "Brew Friendly."

3.  Number of beers in your state by style. Are there too many Pilsners
    already in your state?

4.  An Alcohol by Volume (ABV) graphical comparison of the selected
    state to other states. Is the market already saturated with high ABV
    beers in your state compared to others?

5.  An International Bitterness Units (IBU) graphical comparison of the
    selected state to other states. Does your state already brew too
    many bitter beers?

6.  Relationship of ABV and IBU in the United States through a
    visual scatter-plot. Do high ABV beers also tend to have high IBU or
    low IBU?

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*Should we add any more? (MAY DEPEND ON AVAIALBLE TIME) \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*
===============================================================================================================================================================================================

BACKGROUND BREWERY AND BEER STATISTICS Add other information here as
background information

CODE, ETC.
