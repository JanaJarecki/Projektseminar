library(shiny)
shinyUI(fluidPage(
  verticalLayout(
    titlePanel("Sensor data dashboard"),
    plotOutput("boxplot")
  )  
))