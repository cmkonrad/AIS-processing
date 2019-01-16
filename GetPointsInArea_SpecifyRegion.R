######################################################################
# This function does the following:
# brings in two or more daily files
# keeps only the specied region data
# uses an area or polygon (specified by corner coordinates) 
# to extract the data from area of interest
# and writes it to a single csv outfile
######################################################################



# function that writes a file of AIS data from within a specified polygon (within the Maritime region)
GetPointsInArea_SpecifyRegion = function(filelist, filepath, outfilepath, outfilename, polycorners, region){
  
  for(i in 1){  # for first file
    
    infile <- read.csv(filepath[i])
    
    if(region[1] == "All"){
      Mdat<-infile
    }  else {
      keep <- which(is.element(infile$Region, region))
      Mdat <- infile[keep,]   # save specified region data only
    }
    
    
    # make a list of location points based on long and lat of AIS data
    points <- matrix(data = c(Mdat$Longitude_decimal_degrees, Mdat$Latitude_decimal_degrees), ncol = 2)
    
    badpoints <- which(is.na(points[,1]) | is.na(points[,2]) )  # find points with not Lat/Long info
    points[badpoints,] <- 999                                   # set to 999, so they will be excluded (b/c not in the polygon)
    
    area <- matrix(polycorners, ncol = 2, byrow = T)
    
    # subset data to only include data for points that fall within the specified polygon
    areaDat <- Mdat[which(in.out(area, points) == T),]
    
  }  
  
  for(i in 2:length(filepath)){  # for each subsequent file
    
    infile <- read.csv(filepath[i])
    
    if(region[1] == "All"){
      Mdat<-infile
    } else {
      keep <- which(is.element(infile$Region, region))
      Mdat <- infile[keep,]   # save specified region data only
    }
    
    # make a list of location points based on long and lat of AIS data
    points <- matrix(data = c(Mdat$Longitude_decimal_degrees, Mdat$Latitude_decimal_degrees), ncol = 2)
    
    badpoints <- which(is.na(points[,1]) | is.na(points[,2]) )  # find points with not Lat/Long info
    points[badpoints,] <- 999                                   # set to 999, so they will be excluded (b/c not in the polygon)
    
    area <- matrix(polycorners, ncol = 2, byrow = T)
    
    # subset data to only include data for points that fall within the specified polygon
    # and add that data onto that of the previous files
    areaDat <- rbind(areaDat, Mdat[which(in.out(area, points) == T),])
    
  }  
    
  outfile <- file.path(outfilepath, outfilename)
    
  write.csv(areaDat, outfile, row.names = F) #write file (without rownames)
    
  
}
