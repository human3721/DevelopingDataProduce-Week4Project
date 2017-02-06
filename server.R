library(shiny)

shinyServer(function(input,output) {
    library(zipcode)
    library(leaflet)
    data("zipcode")
    
    
#    notZipcode<-function(input){
#        if(is.na(input)){
#            "Zipcode not found. "
#        }
#        else{
#            NULL
#        }
#    }
    
    zipComp <- reactive({
        zipI <- input$box1
        k <- subset(zipcode, zip == as.character(zipI))
        validate(
            need(!is.na(k), "Zipcode is not found. Enter another code :)")
        )
        k
    })
    
    output$loca <- renderText({
        zipInfo <- zipComp()
        paste0("<font size=4>Zipcode <font color=\"#0000FF\"><b>",zipInfo$zip, 
               "</b></font> is located at <font color=\"#0000FF\"><b>",
               zipInfo$city, ", ",zipInfo$state,"</b></font></font>")
        })
    output$locaMap <- renderLeaflet({
        zipInfo <- zipComp()
        leaflet()%>%
            addProviderTiles("Stamen.TonerLite") %>%
            addMarkers(lat=zipInfo$latitude, lng=zipInfo$longitude,
                       popup=paste0("Zipcode: ", zipInfo$zip,"<br/>", 
                                    zipInfo$city,", ",zipInfo$state))
    })
    
})