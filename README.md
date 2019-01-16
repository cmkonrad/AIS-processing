# AIS-processing
R code for manipulation and analysis of automatic identification system (AIS) data

Description:

This repository contains multiple scripts for processing decoded AIS data using R. They assume the data were decoded using the R decoder that was developed by Fisheries and Oceans Canada - Maritimes region in 2018. With modification, the code may also be useful for manipulating decoded AIS data in slightly different formats, or see attached example files (example.decodedAIS.dynamic.csv and example.decodedAIS.static.csv) to see expected format.

All code was written in R version 3.3.3.

# Extracting decoded data from a target geographic region (and time period)
-	Requires decoded AIS data
-	Use file: SelectAreaDates_example.R
-	Can specify desired time period by using ‘pattern’ variable in ‘list.files’ function
-	Specify desired area by giving lat/long coordinates of a 4-cornered region
-	Consolidates all data from desired dates/region to a single .csv file
-	This script uses: 
    o	Custom R function: GetPointsInArea_SpecifyRegion
    o	R package: mgcv


