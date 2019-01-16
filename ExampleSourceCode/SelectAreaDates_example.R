
require(mgcv)  #package that contains the 'in.out' function

source("C:/Users/CMKONRAD/Desktop/RCode/R_Functions/GetPointsInArea_SpecifyRegion.R") #to allow R to use this custom function


filelist <- list.files(path = "E:/AIS/Dynamic_Data", pattern = "2017-06")  # pattern example lists all files in June 2017
filepath <- file.path("E:/AIS/Dynamic_Data", filelist)


outfilepath <- "E:/AIS_Subset"            # specify directory where outfile should go
outfilename = "CCG_gulf_June2017.csv"     # rename as needed

# latitude and longitude coordinates for corners of area of interest
left <- -67.9
right <- -54.8
top <- 47.9
bot <- 39.9

polycorners <- c(left, top, 
                 left, bot,
                 right, bot,
                 right, top)

region = c("M", "N", "Q", "U")    # options: "C", "M", "N", "P", "Q", "U", or can specify "All"; for satellite data, specify "All"


GetPointsInArea_SpecifyRegion(filelist, filepath, outfilepath, outfilename, polycorners, region)

