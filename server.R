function(input, output, session) {
  
 source("r2Vue.R" , local = TRUE)

 rBus(movie)
 
 rVuex("setMovies", df_movies %>% toJSON)
 
 rVuex("setC3", c3_data)
 
 output$plot1 <- renderPlot({
   input$vue
   ggplot(df_movies %>% filter(production_company %in% top10$production_company) %>% sample_frac( runif(1)), aes(production_company)) + geom_bar()
 })
 
 observeEvent(input$vue, {
   cat("\nupdate:", input$vue)
 })
 
}

