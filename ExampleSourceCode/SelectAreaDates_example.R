
require(mgcv)  #package that contains the 'in.out' function

source("C:/Users/KONRADC/Desktop/RCode/R_Functions/GetPointsInArea_SpecifyRegion.R")


filelist <- list.files(path = "E:/ESI_project/Dynamic_Data/FromDiana/Dynamic", pattern = "2017-06")  # this lists all files in June 2017
filepath <- file.path("E:/ESI_project/Dynamic_Data/FromDiana/Dynamic", filelist)


outfilepath <- "E:/ForAngelia"            # specify directory where outfile should go
outfilename = "CCG_gulf_June2017.csv"     # rename as needed


polycorners <- c(-66, 44.5, -59, 44.5, -59, 51.5, -66, 51.5)  # latitude and longitude coordinates for corners of area of interest


region = c("M", "N", "Q", "U")    # options: "C", "M", "N", "P", "Q", "U", or can specify "All"; for satellite data, specify "All"


GetPointsInArea_SpecifyRegion(filelist, filepath, outfilepath, outfilename, polycorners, region)

