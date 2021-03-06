data <- read.csv("C:/Users/ahsu/Desktop/Data Stuff/data from mlslistings/bulk.csv", header = TRUE, skip = 1)

data[, "Living.SqFt.Sq"] <- data[, "Living.SqFt"]^2

# Define which variables hold dates
kDateVariables = c( "Listing.Date", "Original.List.Date", "Contract.Date", "Close.of.Escrow.Date")

# For loop to generate year, month, and day of week
for (i in kDateVariables) {
  # Read date variable as date
  data[,i] <- as.Date(data[,i], "%Y-%m-%d")
  # Generate month
  foo <- as.character(paste(i,".month", sep=""))
  data[, foo] <- as.factor(format(data[,i],"%m"))
  # Generate year
  foo <- as.character(paste(i,".year", sep=""))
  data[, foo] <- as.factor(format(data[,i],"%Y"))
  # Generate day of week
  foo <- as.character(paste(i,".dayofweek", sep=""))
  data[, foo] <- weekdays(data[,i])
}



# Generate dummy variable for whether agent is out of the area ------------

# Extract first three digits of List.Office.Phone
areacode <- substr(data$Listing.Agent.Primary.Phone,2,4)
# Generate 1 if area code is not 408, 650 or 800
data[,"Out.Of.Area.Agent1"] <- (!areacode == "650" & !areacode == "800" & !areacode == "408")

# Extract first three digits of List.Agent.Direct.Work.Phone
areacode2 <- substr(data$Listing.Office.Primary.Phone,2,4)
# Generate 1 if area code is not 408, 650 or 800
data[,"Out.Of.Area.Agent2"] <- (!areacode2 == "650" & !areacode2 == "800" & !areacode == "408")

# If either is a 1, generate a 1
data[,"Out.Of.Area.Agent"] <- (data[,"Out.Of.Area.Agent1"] == TRUE | data[,"Out.Of.Area.Agent2"] == TRUE)

# Clean up
rm(areacode, areacode2)
data[,"Out.Of.Area.Agent1"] <- NULL
data[,"Out.Of.Area.Agent2"] <- NULL


# Generate first kDigits digits of listing agent license number -----------

# Define kDigits = how many leading digits of license number to use
kDigits = 8

# Pad license numbers with zeroes and convert to factors
data[,"Listing.Agent.ID"] <- as.factor(str_pad(data[,"Listing.Agent.ID"], 8, pad = "0"))

# Extract the first kDigits digits and convert to numbers
data[,"Listing.Agent.ID.leading"] <- (substr(data[,"Listing.Agent.ID"], 1, kDigits))
data[,"Listing.Agent.ID.leading"] <- as.numeric(data[,"Listing.Agent.ID.leading"])

# Set any value greater than 25 in first two digits to NA
data[,"Listing.Agent.ID.leading"][data$Listing.Agent.IDfirstfour > 25 * (10 ^ (kDigits - 2))] <- NA


# Make sure commission figures are reasonable -----------------------------

# If Commission is written as decimal instead of percentage, convert to percentage
# Also set those agents as out of area agents

data[,"Out.Of.Area.Agent"][0 < data$Commission & data$Commission < 0.5 & is.na(data[, "Commission"]) == F] <- 1
data[,"Commission"][0 < data[,"Commission"] & data[,"Commission"] < 0.5 & is.na(data[, "Commission"]) == F] <- 
  data[,"Commission"][0 < data[,"Commission"] & data[,"Commission"] < 0.5 & is.na(data[, "Commission"]) == F]  * 100

# If Commission is a fixed amount (i.e., > 100), convert to percentage
for (i in 1:nrow(data)) {
  if (data[i,"Commission"] > 100 & !is.na(data[i, "Commission"])) {
    data[i,"Commission"] <- as.numeric(data[i,"Commission"]) / as.numeric(data[i,"Sale.Price"])
    # data[i,"Commission"] <- NULL
    
  }
}

# Determine whether commissions are below, at, or above market rate
# -1 == below; 0 == at; 1 == above
data[,"Market.Rate.Commission"] = rep(0, nrow(data))
data[,"Market.Rate.Commission"][data[, "Commission"] < 2.5]   <- -1
data[,"Market.Rate.Commission"][data[, "Commission"] == 2.5]  <-  0
data[,"Market.Rate.Commission"][data[, "Commission"] > 2.5]   <-  1
data[,"Market.Rate.Commission"] <- as.factor(data[,"Market.Rate.Commission"])

# Is the house occupied?
data[,"Vacant.dummy"] <- rep(NA, nrow(data))
data[,"Vacant.dummy"][data[,"Occupied.By"] == 3] <- 0
data[,"Vacant.dummy"][data[,"Occupied.By"] == 4] <- 0
data[,"Vacant.dummy"][data[,"Occupied.By"] == 5] <- 1



# Has there been a price drop?
data[,"Price.Difference"] <- data[,"Original.List.Price"] - data["List.Price"] # check this
data[,"Price.Drop.dummy"] <- rep(0, nrow(data))
data[,"Price.Drop.dummy"][data[,"Price.Difference"] > 0] <- 1
data[,"Price.Difference"] <- NULL



# Search for interesting text labels --------------------------------------

# # Proof of concept
# grep("death",c("death in household, actually two deaths","many deaths","one death","no deat","no death"))

# Set remarks data to uppercase
data[,"Public.Remarks"] <- toupper(data[,"Public.Remarks"])
data[,"Agent.Remarks"] <- toupper(data[,"Agent.Remarks"])

# Find "death" and "passed away" in public remarks
data[,"Public.Death"] <- rep(0, nrow(data))
data[,"Public.Death"][grep("DEATH", data[,"Public.Remarks"])] <- 1
data[,"Public.Death"][grep("PASSED AWAY", data[,"Public.Remarks"])] <- 1
data[,"Public.Death"][grep("DECEASED", data[,"Public.Remarks"])] <- 1
data[,"Public.Death"][grep("DIED", data[,"Public.Remarks"])] <- 1
# data[,"Public.Death"][grep("PEACE", data[,"Public.Remarks"])] <- 1
# data[,"Public.Death"][grep("NATURAL", data[,"Public.Remarks"])] <- 1

# Find "death" and "passed away" in agent remarks
data[,"Public.Death"] <- rep(0, nrow(data))
data[,"Public.Death"][grep("DEATH", data[,"Agent.Remarks"])] <- 1
data[,"Public.Death"][grep("PASSED AWAY", data[,"Agent.Remarks"])] <- 1
data[,"Public.Death"][grep("DECEASED", data[,"Agent.Remarks"])] <- 1
data[,"Public.Death"][grep("DIED", data[,"Agent.Remarks"])] <- 1
# data[,"Public.Death"][grep("PEACE", data[,"Agent.Remarks"])] <- 1
# data[,"Public.Death"][grep("NATURAL", data[,"Agent.Remarks"])] <- 1


# Is the house staged?
data[,"Staged"] <- rep(0, nrow(data))
data[,"Staged"][grep("STAG", data[,"Agent.Remarks"])] <- 1
data[,"Staged"][grep("STAG", data[,"Public.Remarks"])] <- 1



# Classify photo count ----------------------------------------------------

# Create bins for photo count
# -3 = 0 photos; -2 = 1; -1 = 2-9, 0 = 10, 1 = 11-24, 2 = 25, 3 = 26+
data[,"Photo.Count.Optimal"] <- rep(0, nrow(data))
data[,"Photo.Count.Optimal"][data[,"Photo.Count"] == 0 ]  <- -3
data[,"Photo.Count.Optimal"][data[,"Photo.Count"] == 1 ]  <- -2
data[,"Photo.Count.Optimal"][1 < data[,"Photo.Count"] &
                               data[,"Photo.Count"] < 10]   <- -1
data[,"Photo.Count.Optimal"][data[,"Photo.Count"] == 10 ] <-  0
data[,"Photo.Count.Optimal"][10 < data[,"Photo.Count"] &
                               data[,"Photo.Count"] < 25] <-  1
data[,"Photo.Count.Optimal"][data[,"Photo.Count"] == 25 ] <-  2
data[,"Photo.Count.Optimal"][data[,"Photo.Count"] >  25 ] <-  3
data[,"Photo.Count.Optimal"] <- as.factor(data[,"Photo.Count.Optimal"])

# Make city names uppercase ---

data[, "City.Name"] <- toupper(data[, "City.Name"])


# Clean up ---
rm(foo, i, kDateVariables, kDigits)



diff = data$Maximum.Lot.Size - data$Minimum.Lot.Size
summary(diff)

