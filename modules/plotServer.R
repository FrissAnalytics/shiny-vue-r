plotServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$plot1 <- renderPlot({
      
      input$var1
      
      df <- imdb_movies %>% sample_frac(0.1) %>% filter(production_company %in% top10$production_company)
      
      ggplot(df, aes(production_company)) + geom_bar()
      
    })
    
    output$plot2 <- renderPlot({
      
      input$var2
      
      df <- imdb_movies %>% sample_frac(0.05) %>% filter(production_company %in% top10$production_company)
      
      ggplot(df, aes(production_company)) + geom_bar(fill="#FF9999", colour="#FF9999")
      
    })
    
  })
}