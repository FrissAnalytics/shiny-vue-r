function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
  
  output$plot1 <- renderPlot({

    input$"v-plot1"
    
    df <- imdb_movies %>% sample_frac(0.1) %>% filter(production_company %in% top5$production_company)

    ggplot(df, aes(production_company)) + geom_bar()

  })
  
  output$plot2 <- renderPlot({
    
    input$"v-plot2"
    
    df <- imdb_movies %>% sample_frac(0.05) %>% filter(production_company %in% top3$production_company)
    
    ggplot(df, aes(production_company)) + geom_bar()
    
  })
  
  rVuex("setPopular", df_popular %>%toJSON) 
  
  
 observeEvent(input$search, {

    req(input$search$value)

    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)

    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )

    rVuex("setSuggestions", result %>% head(200) %>%toJSON)
 })

}