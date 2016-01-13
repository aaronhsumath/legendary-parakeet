dataComplete <- data
dataComplete[,"PS.Ratio"][which(is.nan(dataComplete[,"PS.Ratio"]))] <- NA
dataComplete[,"PS.Ratio"][which(dataComplete[,"PS.Ratio"] == Inf)] <- NA
dataComplete <- dataComplete[complete.cases(dataComplete[,"PS.Ratio"]),]


model <- lm(
  (.0001 * Sale.Price)
  ~
    Postal.City +
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
  data = dataComplete
)
summary(model)

sum(is.na(data[,"PS.Ratio"])
sum(is.na(dataComplete[,"PS.Ratio"])

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    model2 <- lm(
      (PS.Ratio)
      ~
        Postal.City +
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
      data = dataComplete
    )
    summary(model2)