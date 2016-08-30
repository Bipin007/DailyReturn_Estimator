library(shiny)
library(quantmod)
library(ggplot2)

shinyServer(function(input, output) {  
    
    stockdata <- reactive({
        
        data.frame (getSymbols(input$inp2, src = "yahoo", 
                               from = input$dateRange[1],
                               to = input$dateRange[2],
                               auto.assign = FALSE,verbose = FALSE,
                               warnings = TRUE))
    })

    MyData_MSFT <- reactive ({
        
        apl_df_msft <-data.frame(read.csv(file="C:\\Users\\Bipin\\Downloads\\MSFT.csv"
                                          , header=TRUE))
        rowNum_msft <- nrow(apl_df_msft)
        
        Return_MSFT = as.double(apl_df_msft[2:rowNum_msft , 2]) / as.double(apl_df_msft
                                                                            [1:(rowNum_msft-1) ,2]) -1
        df_msft<-data.frame(Return_MSFT)
        
        df_msft$Dates<-rownames(head(apl_df_msft,-1))
        df_msft
        
    })
    
    MyData_GOOG <- reactive ({
        
        apl_df_goog<-data.frame(read.csv(file="C:\\Users\\Bipin\\Downloads\\GOOG.csv"
                                         , header=TRUE))
        rowNum_goog <- nrow(apl_df_goog)
        # Logic for calculating the daily return
        Return_Goog = as.double(apl_df_goog[2:rowNum_goog , 2]) / as.double(apl_df_goog
                                                                            [1:(rowNum_goog-1) ,2]) -1
        df_goog<-data.frame(Return_Goog)
        df_goog$Dates<-rownames(head(apl_df_goog,-1))
        df_goog
    })
    
    MyData_AAPL <- reactive ({
        
        apl_df <-data.frame(read.csv(file="C:\\Users\\Bipin\\Downloads\\AAPL.csv"
                                     , header=TRUE))
        rowNum <- nrow(apl_df)
        AAPLReturn = as.double(apl_df[2:rowNum , 2]) / as.double(apl_df
                                                                 [1:(rowNum-1) ,2]) -1
        df_aapl<-data.frame(AAPLReturn)
        df_aapl$rownames<-NULL
        df_aapl$Dates<-rownames(head(apl_df,-1))
        df_aapl
    })
    
    output$out5 <- renderTable({
        stockdata()
    })
    output$out7 <- renderTable({
        MyData_MSFT()
    })
    
    output$out8 <- renderTable({
        MyData_GOOG()
    })
    
    output$out9 <- renderTable({
        MyData_AAPL()
    })
    
    oneyeardata <- reactive({
        data.frame(getSymbols(input$inp2, src = "yahoo" ,from=Sys.Date()-365,to=Sys.Date(),
                              auto.assign = FALSE,verbose = FALSE,
                              warnings = TRUE))
    })
    
    output$downloadData <- downloadHandler(
        file = function() {
            
            paste(input$inp2, "csv", sep = ".")
            
        },
        content = function(file) {
            write.table(oneyeardata(), file, sep = ",",
                        
                        row.names = TRUE)
        }
    )
    #Ploting the daily returns for MSFT, APPL and GOOG with the help of ggplot2
    output$out2 <- renderPlot({
        
        ggplot() + 
            
            geom_line(data=df_msft, aes(x=df_msft$Return_MSFT, y=df_msft$Dates), color='green') +
            
            geom_line(data=df_aapl, aes(x=df_aapl$AAPLReturn, y=df_aapl$Dates), color='red') +
            
            geom_line(data=df_goog, aes(x=df_goog$Return_Goog, y=df_goog$Dates), color='violet')
    })
    
    })

