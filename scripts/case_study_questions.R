# library here needed


# question1 ---------------------------------------------------------------

# returns a list with breweries and beers dataframes
get_BreweriesAndBeers_AndTidy <- function() {
  library(here)
  
  # --- Raw data
  local_file1 <- here("data", "Breweries.csv")
  local_file2 <- here("data", "Beers.csv")
  
  the_breweries <- read.csv(paste(local_file1), header = TRUE, sep = ",")
  the_beers <- read.csv(paste(local_file2), header = TRUE, sep = ",")

  colnames(the_breweries)[1] <- "Brewery_id"
  the_breweries$Name <- trimws(the_breweries$Name)
  the_breweries$State <- trimws(the_breweries$State)
  the_beers$Style <- trimws(the_beers$Style)
  
  return(list(breweries = the_breweries, beers = the_beers))
  
  # note: on return, 
  #  breweries <- listreturned[["breweries"]] 
  #  beers <- listreturned[["beers"]]
}

# Q1
# 1. How many breweries are present in each state?
print_BreweriesByState_dplyr <- function(breweries) {
  library(dplyr)
  
  # verify using dplyr
  number_breweries_byState_dplyr <- breweries
  number_breweries_byState_dplyr %>% group_by(State) %>% summarize(count=n()) %>% print(n = 100)
  
  return(number_breweries_byState_dplyr)
}

print_BreweriesByState_datatable <- function(breweries) {
  library(data.table)

  number_breweries_byState <- setDT(breweries)[, .(count = uniqueN(Brewery_id)), by = State]
  setorder(number_breweries_byState, State)
  
  return(number_breweries_byState)
}  


# question2 ---------------------------------------------------------------

# merge beer data and brewery data. Print first and last 6 observations to check the merged file.
merge_brewery_data_and_beer_data <- function(breweries, beers) {
  merged_beer_data <- merge(beers, breweries, by = "Brewery_id")
  names(merged_beer_data)[names(merged_beer_data) == "Name.x"] <- "Beer_Name"
  names(merged_beer_data)[names(merged_beer_data) == "Name.y"] <- "Brewery_Name"
  
  return(merged_beer_data)
}


# question3 ---------------------------------------------------------------

# Q3
# Report the number of NA's in each column
number_of_merged_NAs <- function(merged_beer_data) {
  num_NAs <- sapply(merged_beer_data, function(x) sum(is.na(x)))
  
  return(num_NAs)
}


# question4 ---------------------------------------------------------------

# Q4
# compute the median alcohol content and IBU for each state Plot a bar chart to compare

compute_and_plot_ABV_and_IBU <- function(merged_beer_data) {
  state_ABV <- aggregate(merged_beer_data["ABV"], by=merged_beer_data[c("State")], FUN=median, na.rm=TRUE)
  barplot(state_ABV$ABV, main="Beer ABV by State", names.arg = state_ABV$State, las=2)

  state_IBU <- aggregate(merged_beer_data["IBU"], by=merged_beer_data[c("State")], FUN=median, na.rm=TRUE)
  barplot(state_IBU$IBU, main="Beer IBU by State", names.arg = state_IBU$State, las=2)

}

get_state_ABV <- function(merged_beer_data) {
  state_ABV <- aggregate(merged_beer_data["ABV"], by=merged_beer_data[c("State")], FUN=median, na.rm=TRUE)
  return(state_ABV)
}

get_state_IBU <- function(merged_beer_data) {
  state_IBU <- aggregate(merged_beer_data["IBU"], by=merged_beer_data[c("State")], FUN=median, na.rm=TRUE)
  return(state_IBU)
}

compute_and_plot_ABV_and_IBU_EX <- function(mergedData, StateSelected = "TX") {
#  state_ABV <- aggregate(merged_beer_data["ABV"], by=merged_beer_data[c("State")], FUN=median, na.rm=TRUE)
#  state_IBU <- aggregate(merged_beer_data["IBU"], by=merged_beer_data[c("State")], FUN=median, na.rm=TRUE)
  
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
  
  # Loop to construct the color scheme for fill option in plotting median IBU by state
  ColorOfPlotIBU <- 0
  for(i in 1:51){
    ColorOfPlotIBU[i] <- 'Red'
  }
  State_IBU <- State_IBU[order(-State_IBU$IBU),]#Orders from high to low based on IBU
  State_IBU[is.na(State_IBU)] <- 0
  ColorOfPlotIBU[which(grepl(StateSelected, State_IBU$State))] <- 'blue' 
  ggplot(data=State_IBU, aes(x=reorder(State, -IBU), y=IBU)) + geom_bar(stat = "identity", fill=ColorOfPlotIBU) +  theme(axis.text.x=element_text(angle=90,vjust=0.5)) + xlab("State") + ylab("IBU") + ggtitle("IBU Median by State") + labs(caption = "(*SD did not have any reported IBU values)")
}

# question5 ---------------------------------------------------------------

# Q5
# Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?

which_state_has_max_ABV <- function(state_ABV) {
  # max ABV
  state_max_ABV <- state_ABV[which.max(state_ABV$ABV),]
  return(state_max_ABV)
}
which_state_has_max_IBU <- function(state_IBU) {
  # max IBU
  state_max_IBU <- state_IBU[which.max(state_IBU$IBU),]
  return(state_max_IBU)
}



# question7 ---------------------------------------------------------------

plot_IBU_IBV <- function(merged_beer_data) {
  
ggplot(merged_beer_data, aes(x = IBU, y = ABV)) + 
  geom_point(colour = 'red', size = 1, na.rm=TRUE) + 
  labs(title = "Relationship between Bitterness and Alcohol content", subtitle = "Is bitter better?") + 
  labs(caption = "(based on data from ...?? where's the data from ??)") +
  geom_smooth(method=lm, se=FALSE, size = 1, na.rm=TRUE)

  ggplot(merged_beer_data, aes(x = IBU, y = ABV)) + 
    geom_point(colour = 'red', size = 1, na.rm=TRUE) + 
    labs(title = "Relationship between Bitterness and Alcohol content", subtitle = "Is bitter better?") + 
    labs(caption = "(based on data from GBDI") +
    geom_smooth(method=lm, se=FALSE, size = 1, na.rm=TRUE)  
  
}



# additional_questions ----------------------------------------------------

get_merged_listOfStates <- function(merged_beer_data) {
  ListOfStates <- sort(unique(merged_beer_data$State))
  return(ListOfStates)
}

get_state_beers <- function(merged_beer_data, state_selected) {
  StateBeers <- merged_beer_data[grep(state_selected, merged_beer_data$State),]
  return(StateBeers)
}

analyze_and_plot_longitudeAndABV <- function(state_ABV) {
  #state_ABV <- state_ABV
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
  plot(StateCenterABV$Longitude, StateCenterABV$ABV)
  abline(lm(StateCenterABV$ABV~StateCenterABV$Longitude),col="blue",lwd=2)
  cor.test(StateCenterABV$Longitude, StateCenterABV$ABV)
}

analyze_and_plot_latitudeAndABV <- function(state_ABV) {
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
  
  cor.test(StateCenterABV$Latitude, StateCenterABV$ABV)
  lm(StateCenterABV$ABV~StateCenterABV$Latitude) #in the form Y=X
  myfit=lm(StateCenterABV$ABV~StateCenterABV$Latitude) #in the form Y=X
  myfit
  plot(StateCenterABV$Latitude, StateCenterABV$ABV)
  abline(lm(StateCenterABV$ABV~StateCenterABV$Latitude),col="blue",lwd=2)
}


