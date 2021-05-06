library(rvest)

# see https://github.com/trinker/entity
library(entity)

### rvest
devex <- read_html("https://www.devex.com/news/covid-19-in-2020-a-timeline-of-the-coronavirus-outbreak-99634")
items <- devex %>% html_elements("#article-content > p")
df    <- items %>% html_text2

### named entity recognition 
persons       <- person_entity(df)

# name should not be number, not single word

locations     <- location_entity(df)
organizations <- organization_entity(df) 
money         <- money_entity(df) %>% unlist
percentages   <- percent_entity(df)
dates         <- date_entity(df)

# show 
entity_table <- function(entities){
  tt <- entities %>% unlist %>% table 
  tt[order(tt,decreasing = TRUE)]
}

entity_table(persons)
entity_table(organizations)

# location should not be a number
entity_table(locations)
entity_table(money)
entity_table(percentages)
entity_table(dates)


###
### timeline part 2
###

devex <- read_html("https://www.devex.com/news/covid-19-a-timeline-of-the-coronavirus-outbreak-96396")
items <- devex %>% html_elements("#article-content > p")
df    <- items %>% html_text2












# extract place entities + dates + people








COVID-19 delays gender data collection on Colombian borde