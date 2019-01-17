
## Remove rows of ship data that have no unique identifier info (using output of 'SlowlogShipIDs.R')
## part of the process of generating a list of ships that needs to be manually verified
## does not remove rows if there is more than one unique and useful ID for any given column, except for rows with no useful info

RemoveUselessReps <- function(allshipdat){
  
  uniqueMMSIs <- unique(allshipdat$mmsi)
  
  
  for(MMSI in 1:length(uniqueMMSIs)){                            # for each unique MMSI
    
    copies <- which(allshipdat$mmsi == uniqueMMSIs[MMSI])
    
    
    if(length(copies) > 1){                                             # if there is more than one copy of that MMSI
      
      uniqueVals <- c(0, NA, NA, NA)  # first 0 is just place holder
      
      # count how many different values that contain content (not just NA or "")
      
      uniqueIMO <- unique(c(allshipdat$imo[copies], NA, ""))
      uniqueVals[2] = length(uniqueIMO) - 2                    
      
      uniqueCall <- unique(c(allshipdat$callsign[copies], NA, ""))
      uniqueVals[3] = length(uniqueCall) - 2  
      
      uniqueName <- unique(c(allshipdat$shipname[copies], NA, ""))
      uniqueVals[4] = length(uniqueName) - 2
      
      
      if(max(uniqueVals) == 1){            # if no more than one unique and useful ID for all given column
        
        IDs <- which(uniqueVals == 1)
        
        for(ID in IDs){
           
          keep <- which(allshipdat[copies,ID] != "" & (is.na(allshipdat[copies,ID]) == F)) # which row has unique data
          
          allshipdat[copies[1],ID] <- allshipdat[copies[keep],ID]  # add unique data to the first row
          
        }
       
        removecopies <- copies[2:length(copies)]  # remove all copies but first
        
        allshipdat <- allshipdat[-removecopies,]
        
      }

      
      
      if(max(uniqueVals) > 1){       # if more than one unique and useful ID for all given column
        
        copycount <- length(copies)
        
        for(r in copies){         # for each row
          
          redunantrow <- which(allshipdat[r,2:4] == "" | is.na(allshipdat[r,2:4]))
          
          if(length(redunantrow) == 3){   # if all three identifiers don't have useful info
            
             if(copycount > 1){             # as long as there is still more than one copy
               
               allshipdat <- allshipdat[-r,]   # remove the uninformative row
               
               copycount = copycount - 1
             }
           }
         }
       }
        
        
    }

  }
      
  uniqueMMSIs <- unique(allshipdat$mmsi)
  
  return(allshipdat)
  
}

