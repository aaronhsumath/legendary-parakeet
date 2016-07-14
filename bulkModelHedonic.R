

model <- lm(
  # (.0001 * Sale.Price)
  Sale.Price
  ~
    as.factor(Listing.Date.year) +
    as.factor(Listing.Date.month) +
    City.Name +
    Age +
    Living.SqFt +
    Living.SqFt.Sq +
    Minimum.Lot.Size +
    Out.Of.Area.Agent +
    as.numeric(Listing.Agent.ID) +
    Market.Rate.Commission +
    Vacant.dummy +
    Price.Drop.dummy +
    Public.Death +
    Photo.Count
  ,
  data = data
)


summary(model)
