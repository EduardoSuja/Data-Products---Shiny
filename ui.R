library(shiny)

shinyUI(fluidPage(
        titlePanel("Predict Ozone from temperature"),

        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderTemp", "Temperature",
                            min = min(airquality$Temp),
                            max = max(airquality$Temp),
                            value = valueTemp <- median(airquality$Temp))
                ),
                mainPanel(
                        plotOutput("ozone_temp", brush = brushOpts(
                                id = "brush_area"
                        )),
                        h3("Predicted ozone level"),
                        textOutput("my_pred")
                )
        )
))
