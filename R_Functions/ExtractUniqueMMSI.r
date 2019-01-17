# For extracting unique MMSI from multiple input files 

	
ExtractUniqueMMSI <- function(infiles){
	
  uniqueMMSI <- c() # dataframe to store unique MMSIs
	
	shipcount <- 0   #counter for unique ships
	
	shiplist <- NA  # start with a null ship list to compare first ship to
	

	for(i in 1:length(infiles)){  # for each file

		infile <- read.csv(infiles[i])
		
		fileships <- unique(infile$MMSI)
		
		addships <- which(is.element(fileships, shiplist) == F)
		
		addcount <- length(addships)
		
		if(addcount > 0){
		  
		  shiplist[(shipcount+1):(shipcount+addcount)] <- fileships[addships]
		  
		}
	
	 shipcount <- shipcount + addcount
		
		
	 print(paste("done file #", i, ": ", filelist[i], sep = ""))
	 print(paste("Ships added:", addcount))
	 print(paste("Ship count:", shipcount))
	 print(paste("% ships new:", round(addcount/length(fileships)*100, 2)))
	 
	
	}
	
	print(paste(length(which(nchar(shiplist) < 7)),"MMSI with < 7 digits were excluded"))
	print(paste(length(which(nchar(shiplist) > 9)),"MMSI with > 9 digits were excluded"))
	
	keepMMSI <- which(nchar(shiplist) >= 7 & nchar(shiplist) <= 9) # because all MMSIs in clean list have 7-9 characters (see below)
	shiplist <- shiplist[keepMMSI]
	
	
	
	return (shiplist)
	
	#write.csv(uniqueships, file = outfile, row.names=FALSE)
	
}