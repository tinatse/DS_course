install.packages("data.table")
library("data.table")

directory = "specdata"



# part1 (pollutantmean.R) -------------------------------------------------------------------


pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  # Format number with fixed width and then append .csv to number
  fileNames <- paste0(directory, '/', formatC(id, width=3, flag="0"), ".csv" )
  
  # Reading in all files and making a large data.table
  lst <- lapply(fileNames, data.table::fread)
  dt <- rbindlist(lst)
  
  if (c(pollutant) %in% names(dt)){
    return(dt[, lapply(.SD, mean, na.rm = TRUE), .SDcols = pollutant][[1]])
  } 
}

pollutantmean(directory = 'specdata', pollutant = 'sulfate', id = 20)



# Part2 (complete.R) -------------------------------------------------------------------




complete <- function(directory,  id = 1:332) {
  
  # Format number with fixed width and then append .csv to number
  fileNames <- paste0(directory, '/', formatC(id, width=3, flag="0"), ".csv" )
  
  # Reading in all files and making a large data.table
  lst <- lapply(fileNames, data.table::fread)
  dt <- rbindlist(lst)
  
  return(dt[complete.cases(dt), .(nobs = .N), by = ID])
  
}

#Example usage
complete(directory = 'specdata', id = 20:30)


# Part3 (corr.R)-------------------------------------------------------------------


corr <- function(directory, threshold = 0) {
  
  # Reading in all files and making a large data.table
  lst <- lapply(file.path(directory, list.files(path = directory, pattern="*.csv")), data.table::fread)
  dt <- rbindlist(lst)
  
  # Only keep completely observed cases
  dt <- dt[complete.cases(dt),]
  
  # Apply threshold
  dt <- dt[, .(nobs = .N, corr = cor(x = sulfate, y = nitrate)), by = ID][nobs > threshold]
  return(dt[, corr])
}

# Example Usage
corr(directory = 'specdata', threshold = 150)
