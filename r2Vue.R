# from R to JavaScript event bus
rBus <- function (message){
  session$sendCustomMessage("r2vue", message %>% toJSON(auto_unbox = TRUE))
}

# from R to JavaScript Vuex
rVuex <- function (mutation, value){
  session$sendCustomMessage("r2vuex", list(mutation = mutation, value = value %>% toJSON(auto_unbox = TRUE)))
}

rVuexSetState <- function (key, value, auto_unbox = TRUE){
  session$sendCustomMessage("rVuexSetState", list(key = key, value = value %>% toJSON(auto_unbox = auto_unbox)))
}

rVuexSetStateWidget <- function (key, value){
  session$sendCustomMessage("rVuexSetStateWidget", list(key = key, value = value))
}
