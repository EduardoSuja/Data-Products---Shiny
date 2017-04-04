library(shiny)

shinyServer(function(input, output) {
        my_fit <- reactive({
                brushed_data <- brushedPoints(airquality,
                                              input$brush_area,
                                              xvar = "Temp",
                                              yvar = "Ozone")
                if (nrow(brushed_data) < 2) {
                        return(NULL)
                }
                lm(Ozone ~ Temp, data = brushed_data)
        })

        tempInput <- reactive({input$sliderTemp})
        my_pred <- reactive({
                if (!is.null(my_fit())) {
                        predict(my_fit(), newdata = data.frame(Temp = tempInput()))
                } else {
                       "Not enough data selected"
                }
        })

        output$ozone_temp <- renderPlot({
                plot(airquality$Temp, airquality$Ozone, xlab="Temperature",
                     ylab = "Ozone", main = "Ozone versus temperature")
                if (!is.null(my_fit())) {
                        abline(my_fit(), col="red", lwd=2)
                        points(tempInput(), my_pred(), col="blue", pch=18, cex= 1.5)
                }
        })
        output$my_pred <- renderText({
                my_pred()
        })
})
