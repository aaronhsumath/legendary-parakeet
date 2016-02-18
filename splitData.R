splitData <- function(data, prop.xval, prop.test) {
  
  # Create indices for test set
  indicesTest <- sample(nrow(data), round(prop.test * nrow(data)))
  # Create test set
  dataTest <- data[indicesTest, ]
  removeTest <- data[-indicesTest, ]
  dataTest <- data[order(row.names(dataTest)), ]
  
  
  # Create indices for cross validation set 
  indicesXval <- sample(setdiff(1:nrow(data), indicesTest), round(prop.xval * nrow(data)))
  # Create xval set
  dataXval <- data[indicesXval, ]
  dataXval <- dataXval[order(row.names(dataXval)), ]
  
  # Create training set
  removeThese <- c(indicesTest, indicesXval)
  dataTrain <- data[-removeThese, ]
  
  # Return what we want
  whatWeWant <- list(dataTrain, dataXval, dataTest)
}

dataTrain <- splitData(data, .2, .2)[[1]]
dataXval <- splitData(data, .2, .2)[[2]]
dataTest <- splitData(data, .2, .2)[[3]]

intersect(dataTrain, dataXval)
intersect(dataTrain, dataTest)
intersect(dataXval, dataTest)
nrow(rbind(dataTrain, rbind(dataXval, dataTest)))
ncol(rbind(dataTrain, rbind(dataXval, dataTest)))
intersect(row.names(dataTrain), row.names(dataXval))
