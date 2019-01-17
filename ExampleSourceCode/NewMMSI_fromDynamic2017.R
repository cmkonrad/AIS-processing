
# Find ships that are  not on clean list
# For data from Eastern Shore Islands, 2017

source("C:/Users/KONRADC/Desktop/RCode/R_Functions/ExtractUniqueMMSI.R")
source("C:/Users/KONRADC/Desktop/RCode/R_Functions/getMMSIdates.R")
source("C:/Users/KONRADC/Desktop/RCode/R_Functions/SlowlogShipIDs.R")
source("C:/Users/KONRADC/Desktop/RCode/R_Functions/RemoveUselessReps.R")


# generate list of MMSIs from Dynamic data

filelist <- list.files(path = "E:/ESI_project/MonthlyDynamicData")
infiles <- file.path("E:/ESI_project/MonthlyDynamicData", filelist)	

allMMSIs <- ExtractUniqueMMSI(infiles)


# compare to clean list

cleanlist <- read.csv("E:/ESI_project/CleanShipData_2018_02_22.csv", stringsAsFactors = F)

nomatch <- which((is.element(allMMSIs, cleanlist$mmsi) | is.element(allMMSIs, cleanlist$New_MMSI)) == F)

newMMSIs <- allMMSIs[nomatch]   # 597 ships from the dynamic data have no match in the clean list



# get daily list of MMSIs

MMSIdatelist <- getMMSIdates(newMMSIs, infiles)


# Extract vessel information from slow log

slowlogfilelist <- list.files(path = "E:/CCG_Decoded_AIS_2017/Static")
slowlogs <- file.path("E:/CCG_Decoded_AIS_2017/Static", slowlogfilelist)	

allshipdat <- SlowlogShipIDs(MMSIdatelist, slowlogs)



# remove duplicated rows with no useful info 

shipdatreduced <- RemoveUselessReps(allshipdat)
  
outfile <- "E:/ESI_project/UncleanShipsInfo_ESI_2017.csv"  
write.csv(shipdatreduced, file = outfile, row.names=FALSE)

