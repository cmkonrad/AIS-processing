
# For extracting dates for each unique MMSI that isn't on the clean list 
# this version makes a list of dates with vectors of MMSIs


getMMSIdates <- function(newMMSIs, infiles){
  
  # set up list to store ships dates for unique dates
 MMSIdatelist <- list()
 
  
 for(i in 1:length(infiles)){                     # for each file
    
    infile <- read.csv(infiles[i], stringsAsFactors = F)
    
    # This code currently works when each file contains data from a single month
    
    if(length(unique(infile$year)) > 1){
      
      print("Infile has more than one year. Need to re-write code")
    
    } else if(length(unique(infile$month)) > 1){
      
      print("Infile has more than one month. Need to re-write code.")
      
    } else {
      
      filedays <- unique(infile$day)
      
      for(date in filedays){              # for each day
          
        if(nchar(infile$month[1]) == 1){                      # add zero to month number if needed
          month <- paste(0,infile$month[1], sep = "")
        } else { month <- infile$month[1] }
      
        if(nchar(date) == 1){                                 # add zero to date number if needed
          day <- paste(0,date, sep = "")
        } else { day <- date }
        
        ymd <- paste(infile$year[1], month, day, sep = "-")   # save yyyy-mm-dd
      
        dayrows <- which(infile$day == date)  
        
        dayMMSI <- unique(infile[dayrows,"MMSI"])             # list of MMSIs for that day
        
        newMMSIsdaily <- intersect(dayMMSI, newMMSIs)         # list of MMSIs for that day that are from the list of interest
        
        datecount <- length(MMSIdatelist)
        
        MMSIdatelist[[datecount +1]] <- newMMSIsdaily        # add MMSIs to new vector in list
        
        names(MMSIdatelist)[[datecount +1]] <- ymd           # name vector with date
          
      }
      
    }
    
 }
 
 return(MMSIdatelist)
  
}
