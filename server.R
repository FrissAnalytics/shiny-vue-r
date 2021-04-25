function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)

 rBus(movie)
 
 rVuex("setMovies", df_movies %>% toJSON)
 
 rVuex("setC3", c3_data)
 
 rVuex("setPopularMovies", popular_movies %>% toJSON)
 
 output$plot1 <- renderPlot({
   input$vue
   ggplot(df_movies %>% filter(production_company %in% top10$production_company) %>% sample_frac( runif(1)), aes(production_company)) + geom_bar()
 })
 
 # movie search service
 observeEvent(input$search, {
    
    req(input$search$value)
    
    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)
    
    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )
    
    rVuex("setSuggestions", head(result$original_title,200))
 })
 
}

