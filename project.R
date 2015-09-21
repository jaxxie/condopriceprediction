######PART 1 SHINY APP#######
#install.packages("shiny")
library(shiny)
setwd('/Users/kindaixin/MEGA/09 Developing Data Product/project')

#Read the data file to do a simple lm
train <- read.csv("Sep 2013-Sep 2015.csv") #data taken from URA https://www.ura.gov.sg/realEstateIIWeb/transaction/search.action

#Data cleaning
  #relevel the floor number
  train$Floor.Level <- relevel(train$Floor.Level,"B1 to B5")
  
  #add a column for floor numeric by groups of 5. i.e. "1 to 5" is 1, "6 to 10" is 2 etc.
  train$Floor.Numeric <- as.numeric(train$Floor.Level)
  
#Train the data
str(train)

model <- lm(Price ~ Area.in.Sqft + Market.Segment + Postal.District + Type.of.Sale,data <- train)



#Save the model object to be use by shiny app
save(model, file = "linearModel.RData")

#Load the model
load("linearModel.RData")

#Save the list of factor to be used by UI
factor.market.segment <- unique(train$Market.Segment)
factor.type.of.sale <- unique(train$Type.of.Sale)
save(factor.floor.level,factor.market.segment,factor.type.of.sale, file = "factorList.RData")

#Try predicting
result <- predict(model,(train[1,]))
result

#Try incomplete predicting (cannot work if incomplete)
result.incomplete <- predict(model,(train[1,1:3]))
result.incomplete

#Try predicting from input
test.df <- 
  data.frame(
    "Area.in.Sqft" = 2000, 
    "Floor.Numeric" = 2,
    "Market.Segment" = "CCR",
    "Postal.District" = 1,
    "Type.of.Sale" = "New Sale"
  )
result.df <- predict(model,test.df)
result.df





#####PART 2 SLIDIFY######
install.packages("devtools")
library(devtools)

install_github("slidify", "ramnathv")
install_github("slidifyLibraries", "ramnathv")

library(slidify)
setwd('/Users/kindaixin/MEGA/09 Developing Data Product/project/slidify')
author("private_prop_predictor")

setwd('/Users/kindaixin/MEGA/09 Developing Data Product/project/slidify/private_prop_predictor')

#publish to git hub as git page
publish(user = "jaxxie", repo = "condopricepredictionslidify")
