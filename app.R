library(shiny)
library(readxl)
library(rhandsontable)
library(jsonlite)


# Define UI for application that draws a histogram
ui <- fluidPage(
    
    titlePanel("Forensics Test Check Application"),
    
    #Establishes panel to choose between options as well as display what each option does (no instruction)
    navlistPanel(
        "Options",
        tabPanel("Search", textInput(reactive("sample"), "Enter Sample Number"), textOutput("samplevalue"), tableOutput("searchFrame")), 
        tabPanel("Check",helpText("Input to check answers"), rHandsontableOutput("Table"), br(), actionButton("check.Btn", "Check"), actionButton("save.Btn", "Save")),
        tabPanel("View", h3("This table contains all of the answers to all of the sample data that could be tested. If you would like to search for a specific sample, use the search function"), tableOutput("dataFrame"))
    )

)
server <- function(input, output, session) {
    #Established the way that shiny should create dataframes between input and output sessions 
    dataFrame = data.frame(read_excel("C:\\Users\\Anand\\Downloads\\QC Data Actual.xlsx",))
    output$dataFrame = renderTable(dataFrame)
    
   dfuser = data.frame("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17")
   names(dfuser) = names(dataFrame)
   output$Table = renderRHandsontable(rhandsontable(dfuser))
   observeEvent(input$save.Btn, 
               write.csv(hot_to_r(input$Table), file = "MyData.csv", row.names = FALSE))
}

# Run the application 
shinyApp(ui = ui, server = server)
