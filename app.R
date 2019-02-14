library(shiny)
library(ggplot2)

ui <- shinyUI(fluidPage(
  verticalLayout(
    titlePanel("Sensor data dashboard"),
    plotOutput("main")
  )  
))

server <- shinyServer(function(input, output) {
  # Load data when app is visited
  data <- fread("https://docs.google.com/spreadsheets/d/e/2PACX-1vSpRkRsQz1sjgo6yRbnJyzJQTmtkAQVg5-oMqUpzREBbcXmOxm93FQNUg4HZiEiHRpNisvGcCddlnfS/pub?gid=897205738&single=true&output=csv", encoding = "UTF-8")
  data[, Timestamp := as.POSIXct(Timestamp, format = "%m/%d/%Y %H:%M:%S")]
  output$main <- renderPlot({
    ggplot(data[Timestamp >= as.POSIXct("2019-02-10")], aes(x = as.factor(`Student ID (Matrikelnummer)`), y = ..count.., fill = 16 - ..count..)) +geom_bar(width = .8) +geom_hline(yintercept = 16, linetype = 2) +theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.2), axis.ticks.x = element_blank()) +xlab("Matrikelnr.") + scale_y_continuous("Nr. Studien", breaks = seq(0,16,4), expand = c(0,0)) +scale_fill_viridis(option = "B", end = .8, begin = 0) +guides(fill = "none") +geom_text(aes(label = "N Studien: >= 3 Labor- + 13 Onlinestudien", x = 1, y = 17), hjust = 0, color = "black", family = "Roboto Condensed Light", inherit.aes = FALSE)
  })

})

shinyApp(ui = ui, server = server)