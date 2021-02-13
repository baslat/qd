#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(purrr)
library(dplyr)
library(tibble)
library(glue)

source("R/generate_qd.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("The Quick and The Dead Generator"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("type",
                        "Workout type",
                        choices = c("snatch", "swing"),
                        selected = "swing")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            shiny::verbatimTextOutput("workout")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$workout <- renderPrint({
       generate_qd(type = input$type)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
