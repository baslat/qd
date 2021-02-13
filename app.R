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
            radioButtons("type",
                        "Workout type",
                        choices = c("snatch", "swing"),
                        selected = "swing"),
            actionButton("button",
                         "Generate")
                ),

        # Show a plot of the generated distribution
        mainPanel(
            shiny::verbatimTextOutput("workout")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$workout <- renderText({
        input$button
        generate_qd(type = input$type)
    },
    sep = "\n\n")
}

# Run the application 
shinyApp(ui = ui, server = server)
