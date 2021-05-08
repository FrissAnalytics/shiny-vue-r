# from R to JavaScript event bus
rBus <- function (message){
  session$sendCustomMessage("r2vue", message %>% toJSON)
}

# from R to JavaScript Vuex
rVuex <- function (mutation, value){
  session$sendCustomMessage("r2vuex", list(mutation = mutation, value = value %>% toJSON()))
}