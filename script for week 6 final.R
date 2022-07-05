getwd()
install.packages("tidyverse")
library(tidyverse)
#we have to get te data into R 
print(data_A3)
#lets get the expected data (limiting the data)
myvars<- c("BEGIN_YEARMONTH","BEGIN_DAY","BEGIN_TIME","END_YEARMONTH","END_DAY","END_TIME","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE","SOURCE","BEGIN_LAT","BEGIN_LON","END_LAT","END_LON")
newnew1<-data_A3[myvars]
print(newnew1)
head(newnew1)
#let us arrange data by state 
library(dplyr)
newarrang<-arrange(newnew1,STATE)
print(newarrang)
newnew1$STATE = str_to_title(newnew1$STATE)
newnew1$CZ_NAME = str_to_title(newnew1$CZ_NAME)
newnew2 <- filter(newnew1, CZ_TYPE == "C" )
newnew3<- select (newnew1,-c(CZ_TYPE))
newnew3$STATE_FIPS <- str_pad(newnew3$STATE_FIPS,width =  2, side = "left", pad = 0)
newnew3$CZ_FIPS <- str_pad(newnew3$CZ_FIPS, 3, side = "left", pad = 0)
newnew3$FIPS <- paste(newnew3$STATE_FIPS, newnew3$CZ_FIPS, sep="")
newnew31<- rename_all(newnew3,tolower)
data("state")
us_state_info<-data.frame(state=state.name, region=state.region, area=state.area)
table(us_state_info$state)
newnew313<- data.frame(table(us_state_info$state))
head(newnew313)
newnew4<-rename(newnew313, c("state"="Var1"))
merged <- merge(x=newnew4,y=us_state_info,by.x = "state",by.y = "state")
head(merged)
install.packages("ggplot2")
library(ggplot2)
storm_plot <- ggplot(merged, aes(x = area,y = Freq)) + geom_point(aes(color=region)) + labs(x = "Land area(square miles)",y = "# of storm events in 2017")
print(storm_plot)





