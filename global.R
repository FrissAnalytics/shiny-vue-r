library(shiny)
library(jsonlite)
library(tidyverse)
library(magrittr)
library(TMDb)
library(curl)

source("helpers.R")
source("modules/plotServer.R")

# kaggle imdb movies set
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
hopkins    <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-10-2021.csv")

hopkins    <- hopkins %>% drop_na(Lat, Long_)

# choropleth country data
countries  <- fromJSON("data/ne_110m_admin_0_countries.json")

# amcharts data
urls       <- c("https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/total_timeline.json",
                "https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/total.json",
                "https://raw.githubusercontent.com/amcharts/covid-charts/master/data/json/world_timeline.json")

keys       <- c("total_timeline", "total", "world_timeline")

am_data    <- get_urls(urls, keys)

load("data/df_covid_world.RData")

load("data/df_countries.RData")

storylines <- fromJSON("data/timeline.json")

top10      <- imdb_movies %>% drop_na(production_company) %>% count(production_company) %>% top_n(10)

# popular movies
df_popular <- popular_urls(15) %>% get_urls_async %>% arrange(desc(popularity))


load("tmdb_oscar_winners.RData")
load("data/kaggle_oscars_tmdb.RData")