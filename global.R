library(shiny)
library(jsonlite)
library(tidyverse)
library(magrittr)
library(shadowtext)
library(plotly)
library(TMDb)
library(curl)
library(leaflet)
library(htmltools)

source("helpers.R")

source("modules/plotServer.R")

load("data/imdb_movies.RData")

api_key    <- "1832c46bf5ad73f96183eaddb5f8ab88"

top10      <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(10)

df_popular <- popular_urls(15) %>% get_urls_async