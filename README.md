# AIS-processing: Summary of Repository

In brief: R code for manipulation and analysis of automatic identification system (AIS) data

Description: This repository contains multiple scripts for processing decoded AIS data using R. They assume the data were decoded using the R decoder that was developed by Fisheries and Oceans Canada - Maritimes region in 2018. With modification, the code may also be useful for manipulating decoded AIS data in slightly different formats, or see example files (example.decodedAIS.dynamic.csv and example.decodedAIS.static.csv) for expected AIS data format. Expected naming convention for AIS files is that the file name end with the date in the form of: YYYY-MM-DD

Code was written in R version 3.3.3 (2017-03-06) -- "Another Canoe"

These methods were developed in 2018 using data from the Canadian Coast Guard terrestrial AIS network, for an analysis of vessels in the Eastern Shore Islands of Nova Scotia. These methods should also be applicable to satellite-AIS data (though modification would be required for the section on extracting raw vessel data). For additional details on the purpose, use and development of these scripts, see the following manuscript report:

**... link to document not yet available ...**


# Extract decoded data from a target geographic region (and time period)
-	Requires decoded AIS data
-	Use file: SelectAreaDates_example.R
-	Can specify desired time period by using ‘pattern’ variable in ‘list.files’ function
-	Specify desired area by giving lat/long coordinates of a 4-cornered region
-	Consolidates all data from desired dates/region to a single .csv file
-	This script uses: 

    o	Custom R function: GetPointsInArea_SpecifyRegion

    o	R package: mgcv


# Extract raw vessel data from AIS data 
## Summary

This section describes a process for extracting vessel information to be validated from AIS data, using a series of custom R scripts. It assumes you are using dynamic AIS data (aka quicklogs; for format see: example.decodedAIS.dynamic.csv) from a desired region and time period and have the accompanying static AIS data (aka slowlogs; for format see: example.decodedAIS.static.csv) for this time period. 

It is recommended that, prior to running these scripts, you extract data for only the region and timeframe of interest (see above). 

