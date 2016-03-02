splitData <- function(data, prop.xval = 0.2, prop.test = 0.2) {
  
  # Create indices for test set
  indicesTest <- sample(nrow(data), round(prop.test * nrow(data)))
  # Create test set
  dataTest <- data[indicesTest, ]
  dataTest <- dataTest[order(as.numeric(row.names(dataTest))), ]
  
  
  # Create indices for cross validation set 
  indicesXval <- sample(setdiff(1:nrow(data), indicesTest), round(prop.xval * nrow(data)))
  # Create xval set
  dataXval <- data[as.numeric(indicesXval), ]
  dataXval <- dataXval[order(as.numeric(row.names(dataXval))), ]
  
  # Create training set
  removeThese <- c(indicesTest, indicesXval)
  dataTrain <- data[-removeThese, ]
  
  # Return what we want
  whatWeWant <- list(dataTrain, dataXval, dataTest)
}


# # Just for fun, can we do splitData.R using three rows of code?
# splitData <- function(data, prop.xval, prop.test) {
#   
#   # Create test set
#   dataTest <- data[sample(nrow(data), round(prop.test * nrow(data))), ][order(as.numeric(row.names(data[sample(nrow(data), round(prop.test * nrow(data))), ]))), ]
#   
#   # Create xval set
#   dataXval <- data[as.numeric(sample(setdiff(1:nrow(data), indicesTest), round(prop.xval * nrow(data)))), ][order(as.numeric(row.names(data[as.numeric(sample(setdiff(1:nrow(data), indicesTest), round(prop.xval * nrow(data)))), ]))), ]
#   
#   # Create training set
#   dataTrain <- data[-c(indicesTest, indicesXval), ]
#   
#   # Return what we want
#   whatWeWant <- list(dataTrain, dataXval, dataTest)
#   
#   # Almost, but not quite (something wrong with ordering)
# }
# 
# # For testing splitData.R
# dataTrain <- splitData(data, .2, .3)[[1]]
# dataXval <- splitData(data, .2, .3)[[2]]
# dataTest <- splitData(data, .2, .3)[[3]]
# 
# intersect(dataTrain, dataXval)
# intersect(dataTrain, dataTest)
# intersect(dataXval, dataTest)
# nrow(rbind(dataTrain, rbind(dataXval, dataTest)))
# ncol(rbind(dataTrain, rbind(dataXval, dataTest)))
# intersect(row.names(dataTrain), row.names(dataXval))
