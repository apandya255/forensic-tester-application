library(shiny)
library(readxl)
library(rhandsontable)
library(jsonlite)
library(rsconnect)

ui <- fluidPage(
    navlistPanel(
        "Options",
        tabPanel("File Input", textInput("filein", "Please Enter C:// file name", ""), actionButton("filebtn", "Save File")), 
        tabPanel("Search", textInput("sample", "Enter Sample Number", ""), textOutput("samplevalue"), tableOutput("searchFrame"), actionButton("searchbtn", "Search")),
        tabPanel("Check",helpText("Input to check answers"), rHandsontableOutput("table"), actionButton("checkbtn", "Check"), tableOutput("checkFrame"), textOutput("correcttext"), textOutput("incorrecttext"), textOutput("incorrecttext2"), tableOutput("checkFrame2")),
        tabPanel("View", h3("This table contains all of the answers to all of the sample data that could be tested. If you would like to search for a specific sample, use the search function"), tableOutput("dataFrame"))))


server <- function(input, output, session) {
    #View/inputfile
    observeEvent(input$filebtn, { 
        dataFrame = data.frame(read_excel(as.character(input$filein)))
        output$dataFrame = renderTable(dataFrame)
        #check
        dfuser = data.frame("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17")
        names(dfuser) = names(dataFrame)
        output$table = renderRHandsontable(rhandsontable(dfuser))})
        
    #search
    observeEvent(input$searchbtn, { 
        usersample1 = input$sample
        usercheckindices = which(dataFrame["Sample"] == usersample1)
        dataSubsetcheck = dataFrame[usercheckindices, ]
        names(dataSubsetcheck) = c(names(dataFrame))
        output$searchFrame = renderTable(dataSubsetcheck)})
    #check
    observeEvent(input$checkbtn, {
        df = hot_to_r(input$table)
        usercheckindices2 = which(dataFrame["Sample"] == df[1,1])
        dataSubsetcheck2 = dataFrame[usercheckindices2, ]
        names(dataSubsetcheck2) = c(names(dataFrame))
        if (all(df == dataSubsetcheck2)) {
            output$correcttext = renderText("Congratulations!!! all of your values are correct")
        }
        else {
            dfincorrect = data.frame(setdiff(df, dataSubsetcheck2))
            output$incorrecttext = renderText(("These are the incorrect answers: "))
            output$incorrecttext2 = renderText(names(dfincorrect))
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
