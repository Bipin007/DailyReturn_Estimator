library(shiny)

shinyUI(
    
    fluidPage(
        #Sidebarpanel containing sets of user inputs fields
        sidebarPanel(
            
            selectInput("inp2", h5("Please select the ticker"), 
                        
                        choices = c("GOOG", "AAPL","MSFT")),
            
            h5("For downloading stock data:"),
            
            dateRangeInput('dateRange',
                           label = 'Please select date range within 10 days ',
                           start = Sys.Date() - 10, end = Sys.Date()
            )
            
        ),
        
        # Its the main panel where results will be displayed
        
        mainPanel(
            
            h3("SHINY APPLICATION"),
            tabsetPanel(
                #Tab for Downloading the stock of 1 year and also shows default 10 rows for selected stock
                tabPanel("One_Year_Data", downloadButton('downloadData', 'Download'),tableOutput("out5")),
                
                #Tab that displays the Daily return of MSFT after browser is refereshed
                tabPanel("Dly_Rtn_MSFT", tableOutput("out7")),
                
                #Tab that displays the Daily return of GOOG after browser is refereshed
                tabPanel("Dly_Rtn_GOOG", tableOutput("out8")),
                
                #Tab that displays the Daily return of AAPL after browser is refereshed
                tabPanel("Dly_Rtn_AAPL", tableOutput("out9")),
                
                #Tab for ploting the daily return of all 3 stocks 
                tabPanel("Plots", plotOutput("out2")), 
                
                #Tab for displaying the cluster plot grouped into 2
                tabPanel("Cluster_Plot", plotOutput("out3"))
            ),
            # It displays the logic that should be used to find the mismatch between the dates
            column(4,
                   textOutput("text1")
            )
        )
    )
    
)
