library(shiny)
library(jsonlite)
library(tidyverse)
library(magrittr)
library(shadowtext)
library(plotly)

load("data/imdb_movies.RData")

top5 <- imdb_movies  %>% drop_na(production_company) %>% count(production_company) %>% top_n(5)