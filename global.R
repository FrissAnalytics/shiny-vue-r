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
# load("data/imdb_movies.RData")
load("data/imdb_movies_tmdb.RData")

# kaggle oscar winners 
load("data/oscars_kaggle.RData")

# kaggle oscar winners demographics
load("data/oscars_demographics_kaggle")

# oscar winners pulled from wikipedia
load("data/oscars_wiki.RData")

# movie ids pulled from the movie database on may 1st
load("data/movie_ids.RData")

# person ids pulled from the movie database on may 1st
load("data/person_ids.RData")

# airport locations
load("data/airports.RData")

# The Movie DataBase 
api_key    <- "1832c46bf5ad73f96183eaddb5f8ab88"

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

###
### 
###

top10      <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(10)

# popular movies
df_popular <- popular_urls(15) %>% get_urls_async %>% arrange(desc(popularity))

# combine oscars with tmdb ids
load("tmdb_oscar_winners.RData")

load("data/kaggle_oscars_tmdb.RData")



# "Big Five" Best Picture, Best Director, Best Actor, Best Actress, and Best Screenplay (Best Original Screenplay or Best Adapted Screenplay)