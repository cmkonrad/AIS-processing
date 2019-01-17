
# Find ships that are not on clean list
# For data from specified region and time period

# locations of required custom R functions
source("C:/Users/CMKONRAD/Desktop/RCode/R_Functions/ExtractUniqueMMSI.R")
source("C:/Users/CMKONRAD/Desktop/RCode/R_Functions/getMMSIdates.R")
source("C:/Users/CMKONRAD/Desktop/RCode/R_Functions/SlowlogShipIDs.R")
source("C:/Users/CMKONRAD/Desktop/RCode/R_Functions/RemoveUselessReps.R")


# generate list of MMSIs from Dynamic data files of interest

filelist <- list.files(path = "E:/AIS_data/DynamicData")
infiles <- file.path("E:/AIS_data/DynamicData", filelist)	

allMMSIs <- ExtractUniqueMMSI(infiles)


# compare to clean list (optional)

cleanlist <- read.csv("E:/AIS_data/example.validatedvessels.csv", stringsAsFactors = F)

nomatch <- which((is.element(allMMSIs, cleanlist$mmsi) | is.element(allMMSIs, cleanlist$New_MMSI)) == F)

newMMSIs <- allMMSIs[nomatch]  



# get daily list of MMSIs

MMSIdatelist <- getMMSIdates(newMMSIs, infiles)


# Extract vessel information from slow log

slowlogfilelist <- list.files(path = "E:/AIS_data/StaticData")
slowlogs <- file.path("E:/AIS_data/StaticData", slowlogfilelist)	

allshipdat <- SlowlogShipIDs(MMSIdatelist, slowlogs)



# remove duplicated rows with no useful info 

shipdatreduced <- RemoveUselessReps(allshipdat)
  
outfile <- "E:/AIS_data/UncleanShipsInfo.csv"  
write.csv(shipdatreduced, file = outfile, row.names=FALSE)

