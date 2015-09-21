library(shiny)

load('factorList.RData')
#convert the factor list to the format for selection in the UI
factor.floor.numeric <- as.numeric(factor.floor.level)
names(factor.floor.numeric) <- factor.floor.level
factor.floor.numeric <- sort(factor.floor.numeric)

factor.market.segment <- as.character(factor.market.segment)
names(factor.market.segment) <- factor.market.segment
factor.market.segment <- sort(factor.market.segment)

factor.type.of.sale <- as.character(factor.type.of.sale)
names(factor.type.of.sale) <- factor.type.of.sale
factor.type.of.sale <- sort(factor.type.of.sale)

shinyUI(
        pageWithSidebar(
          headerPanel("Predicted Price Of Private Apt/Condo in SG"),
          sidebarPanel(
            h4('Enter the property attributes'),
            numericInput('Area.in.Sqft','Area in Sqft:',1000,min = 1,step=1),
            #selectInput("Floor.Level", "Floor Level:",factor.floor.numeric),
            selectInput("Market.Segment", "Market Segment:",factor.market.segment),
            numericInput('Postal.District','Postal Code (01 to 28):',01,min = 1,max = 28,step=1),
            selectInput("Type.of.Sale", "Type of Sale:",factor.type.of.sale),
            submitButton("Get Predicted Price")
          ),
          mainPanel(
            h4("Read me:"),
            p("This is a price predictor for private condominium and apartment in Singapore. Enter the attributes of the property on the left and click the button to get the predicted price. For Market Segment, CCR is 'Core Central Region', OCR is 'Outside Central Region' and RCR is 'Rest of Central Region'. Data used is from sales of private condo/apt between Sep 2013 to Sep 2015 for the training of a simple linear model."),
            p("Data source: https://www.ura.gov.sg/realEstateIIWeb/transaction/search.action"),
            p("Created by Jax Xie 2015"),
            #h3('Predicted Price in Singapore Dollars ($SGD)'),
            h4("Your input:"),
            verbatimTextOutput("your.input"),
            h4("The predicted price in SGD:"),
            verbatimTextOutput("predicted.price")

            
          )
       )
)