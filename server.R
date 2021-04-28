function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)
  
  output$plot1 <- renderPlot({
    
    input$vue
    
    # sample movies, show bar chart top 5 production companies 
    df <- imdb_movies %>% sample_frac(0.1) %>% filter(production_company %in% top5$production_company)

    ggplot(df, aes(production_company)) + geom_bar()
  })  
  
 observeEvent(input$search, {

    req(input$search$value)

    m      <- grep(paste0("^",input$search$value), imdb_movies$original_title, ignore.case = TRUE)

    result <- imdb_movies[m, ] %>% arrange( desc(avg_vote) )

    rVuex("setSuggestions", head(result$original_title,200))
 })

}