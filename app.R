library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = shinytheme("paper"),
    tags$head(HTML("<title>Baller Lab</title>")), #Without company logo
    navbarPage(title = div(img(src="ballerlablogo.png", style="margin-top: -14px;", height = 50)))
)

# Define server logic required to draw a histogram
server <- function(input, output) {



}

# Run the application 
shinyApp(ui = ui, server = server)
