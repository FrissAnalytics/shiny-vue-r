library(shiny)
library(jsonlite)
library(tidyverse)
library(magrittr)
library(plotly)
library(TMDb)
library(curl)
library(leaflet)
library(htmltools)

source("helpers.R")

source("modules/plotServer.R")

# kaggle imdb movies set
load("data/imdb_movies.RData")

# airport locations
load("data/airports.RData")

# The Movie DataBase 
api_key    <- "1832c46bf5ad73f96183eaddb5f8ab88"

top10      <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(10)

df_popular <- popular_urls(15) %>% get_urls_async

# john hopkins daily data 
hopkins    <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-05-2021.csv")

hopkins    <- hopkins %>% drop_na(Lat, Long_)

# choropleth country data
countries  <- fromJSON("data/ne_110m_admin_0_countries.json")

# amcharts data
urls       <- c("https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/total_timeline.json",
                "https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/total.json")

keys       <- c("total_timeline", "total")

am_data    <- get_urls(urls, keys)


