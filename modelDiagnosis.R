# Which model do we wish to diagnose?
model <- model1

pairs(~  Sale.Price +
      Postal.City +
        Sq.Ft.Total +
        Lot.Size +
#         as.factor(Listing.Date.year) +
#         as.factor(Listing.Date.month) +
        Out.Of.Area.Agent +
        List.Agent.Lic.leading +
        Market.Rate.Commission +
        Vacant.dummy +
        Price.Drop.dummy +
        Possession.dummy +
        REO.dummy +
        Public.Death +
        Agent.Death +
        Photo.Count.Optimal
      
      
      
      , data = dataComplete)


dataComplete["Lot.Size" > 100000000,]
subset(dataComplete, Lot.Size > 1e8)
subset(dataComplete, Sale.Price > 1e7)[, "Lot.Size"]


dataComplete$Lot.Size

# remove stuff with huge lot sizes





# Create indices for 

dataComplete.train <- 
















