library(shiny)
library(leaflet)

shinyUI(fluidPage(
    titlePanel("Search US Zipcode location"),
    h4("Hou Zhong"),
    h4("Feb 05, 2017"),
    sidebarPanel(
        textInput("box1", "Enter a five digit US Zipcode:", value = "20500"),
        submitButton("Submit") #adding a submit button
    ),
    mainPanel(
        #plotOutput("plot1")
        htmlOutput("loca"),
        leafletOutput("locaMap")
    )
))