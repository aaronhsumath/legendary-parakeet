
a <- c("a","b","c")
b <- c(1:3)

c <- (1001:1004)
d <- rep("mother", 4)

x <- data.frame(a,b)
y <- data.frame(c,d)


a <- rnorm(100)
b <- rbinom(100, 2, .2)
c <- rgamma(100, 2)
d <- data.frame(a, b, c)

d1 <- splitData(d, .2, .2)[[1]]
d2 <- splitData(d, .2, .2)[[2]]
d3 <- splitData(d, .2, .2)[[3]]


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
