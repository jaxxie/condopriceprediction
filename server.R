library(shiny)

predictPrice <- function(inputDF){
  load("linearModel.RData")
  #return(cat( predict(model,inputDF)))
  
  return(cat("SGD",formatC(predict(model,inputDF), format="d", big.mark=',')))
  
  
}

shinyServer(
  function(input,output){
    inputDF <- reactive({
      data.frame(
                          "Area.in.Sqft" = input$Area.in.Sqft, 
                          #"Floor.Numeric" = input$Floor.Level,
                          "Market.Segment" = input$Market.Segment,
                          "Postal.District" = input$Postal.District,
                          "Type.of.Sale" = input$Type.of.Sale
                          )
    })
    
    output$predicted.price <- renderPrint({predictPrice(inputDF())})
    output$your.input <- renderPrint({inputDF()})
    
  }
)