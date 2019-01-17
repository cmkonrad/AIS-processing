
## Extract vessel information from slow log, based on daily lists of MMSIs of interest

SlowlogShipIDs <- function(MMSIdatelist, slowlogs){
  

  allshipdat <- data.frame(mmsi=character(),
                   imo=character(), 
                   callsign=character(), 
                   shipname=character(),
                   shiptype=character(),
                   Length=character(),
                   Width=character(),
                   Date=character(),
                   
                   stringsAsFactors=FALSE) 
  
  
  # columns to take from slowlog
  colswanted <- c("MMSI","IMO_number", "Call_Sign", "Vessel_Name", "Type_of_Ship_and_Cargo", "Vessel_Length_meters", "Vessel_Width_meters")
  
  shipmissdat = 0   # to count ships that are missing from the slowlog from a given day
  
  
  for(date in 1:length(MMSIdatelist)){        # for each day
  
    ymd <- names(MMSIdatelist)[[date]]
    
    daylog <- which(grepl(ymd, slowlogs))          # find and read in the log for that day
    
    if(length(daylog) == 0){                          # check for corresponding slowlog
      
      print(paste("Slowlog missing for", ymd, "which has", length(MMSIdatelist[[date]]), "ships"))
      
      for(ship in 1:length(MMSIdatelist[[date]])){   # for each MMSI
        
        mmsi <- MMSIdatelist[[date]][ship]
        
        shipdat <- matrix(nrow = 1, ncol = 8)
        colnames(shipdat) <- c(colswanted,"Date")
        
        shipdat[1,c(1,8)] <- c(mmsi,ymd)    # save date and mmsi
      }  
      
    } else {
    
    daydat <- read.csv(slowlogs[daylog], stringsAsFactors = F)
    
    for(ship in 1:length(MMSIdatelist[[date]])){   # for each MMSI
      
      mmsi <- MMSIdatelist[[date]][ship]
      
      rows <- which(daydat$MMSI == mmsi)                   # find rows for that ship
      
      
      if(length(rows > 0)){                               # if there are rows for this ship in the static data
      
        shipdat <- daydat[rows,colswanted]
        
        uniqueIDs <- which(duplicated(shipdat[,1:4]) == F)   # keep only those rows that aren't duplicated
      
        shipdat <-  shipdat[uniqueIDs,]  
      
        shipdat$Date <- ymd
     
      } else {
        
        shipmissdat = shipmissdat + 1
        
        shipdat <- matrix(nrow = 1, ncol = 8)
        colnames(shipdat) <- c(colswanted,"Date")
        
        shipdat[1,c(1,8)] <- c(mmsi,ymd)    # save date and mmsi
        
        #print(paste(shipmissdat, "incidents of ships of interest being missing from expected daily slowlogs (but still included in output)"))
        
        
      }
      
      rowstart <- nrow(allshipdat) + 1
      rowend <- nrow(allshipdat) + nrow(shipdat)
      
      allshipdat[c(rowstart:rowend), ] <- shipdat   
      
      
    }
   } 
  }
  
  print(paste("Note:", shipmissdat, "ships of interest were missing from daily slowlogs"))
  
  uniqueIDs <- which(duplicated(allshipdat[,1:4]) == F)   # keep only those rows that aren't duplicated
  allshipdat <-  allshipdat[uniqueIDs,]  
  
  
  for(row in 1:nrow(allshipdat)){                         # add dimesions column
     
    if(is.na(allshipdat$Length[row]) | is.na(allshipdat$Width[row])){
      allshipdat$dimensions[row] <- "0 x 0"
    } else {
      allshipdat$dimensions[row] <- paste(allshipdat$Length[row], "x", allshipdat$Width[row])
    }
    
  }
 
  allshipdat <-  subset(allshipdat, select = -c(Length, Width)) 
  allshipdat <- allshipdat[,c(1:5,7,6)]
  
  
  return(allshipdat)
  
}

  
