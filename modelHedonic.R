
complete <- data[complete.cases(data$Photo.Count, data$Public.Death, data$Price.Drop.dummy, 
                                data$Market.Rate.Commission, data$List.Agent.Lic.leading,
                                data$Out.Of.Area.Agent, data$Lot.Size, data$Sq.Ft.Total, data$Age,
                                data$Postal.City, data$Listing.Date.Month, data$As.Factor,
                                data$Sale.Price),]    
complete = subset(complete, Postal.City %in% c("Los Altos", "Menlo Park", "Mountain View", "Palo Alto", "Redwood City", "Redwood Shores"))

model <- lm(
  # (.0001 * Sale.Price)
  Sale.Price
  ~
    as.factor(Listing.Date.year) +
    as.factor(Listing.Date.month) +
    Postal.City +
    Age +
    Sq.Ft.Total +
    Lot.Size +
    Out.Of.Area.Agent +
    List.Agent.Lic.leading +
    Market.Rate.Commission +
    # Vacant.dummy +
    Price.Drop.dummy +
    # Possession.dummy +
    # REO.dummy +
    Public.Death +
    # Agent.Death +
    Photo.Count
  ,
  data = subset(complete, Postal.City %in% c("Los Altos", "Menlo Park", "Mountain View", "Palo Alto", "Redwood City", "Redwood Shores"))
)
summary(model)


plot(model$fitted.values, model$residuals)
plot(complete$Sq.Ft.Total, model$residuals)

    
    
    
    
complete["Sq.Ft.Total" > 15000]
    
    
    
    
    
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