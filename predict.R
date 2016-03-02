
dataTrain <- splitData(data, .2, .2)[[1]]
dataXval <- splitData(data, .2, .2)[[2]]
dataTest <- splitData(data, .2, .2)[[3]]


model <- lm(
  (.0001 * Sale.Price)
  ~
    Postal.City +
    Original.List.Price +
    Sq.Ft.Total +
    Lot.Size +
    as.factor(Listing.Date.year) +
    as.factor(Listing.Date.month) +
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
  ,
  data = dataTrain
)
summary(model)

predicted <- predict(model, dataXval)

error <- (.0001 * dataXval[, "Sale.Price"]) - predicted
mean(error, na.rm = TRUE)
IQR(error, na.rm = TRUE)
hist(error, na.rm = TRUE)
