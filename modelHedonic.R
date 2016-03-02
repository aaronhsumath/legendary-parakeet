

model <- lm(
  # (.0001 * Sale.Price)
  Sale.Price
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