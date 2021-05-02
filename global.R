library(shiny)
library(jsonlite)
library(tidyverse)
library(magrittr)
library(shadowtext)
library(plotly)
library(TMDb)
library(curl)

load("data/imdb_movies.RData")

api_key <- "1832c46bf5ad73f96183eaddb5f8ab88"

popular_urls <- function(n){
  sapply(1:n, function(k){
    paste0("http://api.themoviedb.org/3/movie/popular?api_key=1832c46bf5ad73f96183eaddb5f8ab88&page=",k,"&language=en")
  })
}

top5    <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(5)
top3    <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(3)

urls <- popular_urls(15)

get_urls_async <- function(urls){
  
  # create pool
  pool <- new_pool()
  
  # storage
  data <- list()
  
  # callback
  cb   <- function(req){ data <<- c(data, list(req)) }
  
  # scheduled requests
  x <- urls  %>% sapply(curl_fetch_multi, done=cb, pool=pool)

  # perform requests
  out  <- multi_run(pool = pool)

  # extract data
  L    <- lapply(data, function(req){req$content %>% rawToChar %>% fromJSON( flatten = TRUE)})
  
  # merge into single data frame
  df <- NULL
  
  for(l in 1:length(L)){
    df <- rbind(df, L[[l]]$results)
  }
  
  # remove rows with missing values
  df %>% drop_na()

}

df_popular <- get_urls_async(urls)