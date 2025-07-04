library(shiny)
library(readxl)
library(rhandsontable)
library(jsonlite)
library(rsconnect)
library(compareDF)
library(htmlTable)
library(shinydashboard)


ui <- fluidPage(
    dashboardPage(skin = "yellow",
                  dashboardHeader(title = "Welcome Students/Administrators/Etc... to DataCheck.R", titleWidth = 600, 
                                  tags$li(class = "dropdown", a(href = 'http://www.duii.com',
                                                                tags$img(src = 'company_logo.png', height = "30px")))),
                  dashboardSidebar(
                      sidebarMenu(
                          menuItem(text = "File Input", tabName = "FileInput", icon = icon("upload")),
                          menuItem(text = "Search", tabName = "Search", icon = icon("search")),
                          menuItem(text = "Check", tabName = "Check", icon = icon("check")),
                          menuItem(text = "View", tabName = "View", icon = icon("window-maximize")))
                      
                  ),
                  dashboardBody(
                      tabItems(
                          tabItem(tabName = "FileInput", textInput("filein", "Please Enter C:// file name", ""), actionButton("filebtn", "Save File", skin = "yellow")),
                          tabItem(tabName = "Search", textInput("sample", "Enter Sample Number", ""), textOutput("samplevalue"), tableOutput("searchFrame"), actionButton("searchbtn", "Search")),
                          tabItem(tabName = "Check",helpText("Input to check answers"),sliderInput("row","Number of Rows", 1, 100, value = 1),actionButton("rowbtn", "Create Frame for Checking"), rHandsontableOutput("table"), actionButton("checkbtn", "Check"), tableOutput("checkFrame"), textOutput("correcttext"), textOutput("incorrecttext"), textOutput("incorrecttext2"), tableOutput("incorrecttable"), tableOutput("correcttable")),
                          tabItem(tabName = "View", h3("This table contains all of the answers to all of the sample data that could be tested. If you would like to search for a specific sample, use the search function"), tableOutput("dataFrame")
                          )))))

server <- function(input, output, session) {
    #View/inputfile
    observeEvent(input$filebtn, { 
        dataFrame = data.frame(read_excel(as.character(input$filein)))
        output$dataFrame = renderTable(dataFrame)})
    
    #set number of rows for checkFrame 
    observeEvent(input$rowbtn, {
        dataFrame = data.frame(read_excel(as.character(input$filein)))
        dfuser = data.frame(matrix("Enter", ncol = ncol(dataFrame), nrow = input$row))
        names(dfuser) = names(dataFrame)
        output$table = renderRHandsontable(rhandsontable(dfuser))})  
    
    #search
    observeEvent(input$searchbtn, {
        dataFrame = data.frame(read_excel(as.character(input$filein)))
        usersample1 = input$sample
        usercheckindices = which(dataFrame["Sample"] == usersample1)
        dataSubsetcheck = dataFrame[usercheckindices, ]
        names(dataSubsetcheck) = c(names(dataFrame))
        output$searchFrame = renderTable(dataSubsetcheck)})
    #check
    observeEvent(input$checkbtn, {
        dataFrame = data.frame(read_excel(as.character(input$filein)))
        df = hot_to_r(input$table)
        usercheckindices2 = which(dataFrame["Sample"] == df[,1])
        dataSubsetcheck2 = dataFrame[usercheckindices2, ]
        names(dataSubsetcheck2) = c(names(dataFrame))
        if (all(df == dataSubsetcheck2)) {
            output$correcttext = renderText("Congratulations!!! all of your values are correct")}
        else {
            dfincorrect1 = (compare_df(dataSubsetcheck2,df, c("Sample")))
            view_html(dfincorrect1)
            output$incorrecttext = renderText("These are the incorrect answers: ")
            create_output_table(dfincorrect1,'html')
            output$incorrecttable=renderUI(((create_output_table(dfincorrect1,'html'))))
            #output$incorrecttable=renderHtmlTableWidget(((htmlTableWidgetOutput(create_output_table(dfincorrect1,'html')))))
            print(dfincorrect1$comparison_df)
            dfincorrect1$html_output
            
        }
        
        
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
# 