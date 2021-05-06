# unfortunately Vue with v-bind or @ does not recognize plotly events
#   but we can capture this with a Shiny event handler - difficult due to event naming,
#   an even uglier hack in mounted and beforeDestroy shown below with plotly_click,
#   or some global plotly event handlers shown below with plotly_hover

library(htmltools)
library(vueR)
library(shiny)

ui <- tagList(
  plot_ly()$dependencies,
  vueR::html_dependency_vue(minified = FALSE),
  tags$div(
    id = "app",
    tag(
      'html-widget',
      list(
        `:x` = "plot1settings",
        `name` = "plotly",
        plotlyOutput("plot1")
      )
    ),
    tag(
      'html-widget',
      list(
        `:x` = "leaf2settings",
        `name` = "leaflet",
        leafletOutput("leaf2")
      )
    )
  ),
  tags$script(HTML(
"
  Vue.component(
    'html-widget',
    {
      props: ['x', 'name'],
      template: '<div><slot></slot></div>',
      methods: {
        // Copied from HTMLWidgets code
        // Implement a vague facsimilie of jQuery's data method
        elementData: function(el, name, value) {
          if (arguments.length == 2) {
            return el['htmlwidget_data_' + name];
          } else if (arguments.length == 3) {
            el['htmlwidget_data_' + name] = value;
            return el;
          } else {
            throw new Error('Wrong number of arguments for elementData: ' +
              arguments.length);
          }
        },
        updateWidget: function() {
          // see comments in mounted which is nearly identical except in update we do not initialize or attach
          //   initial data to the element.  we could clean this up and make one function.
          var component = this
          // use HTMLWidgets.widgets to give us a list of available htmlwidget bindings
          var widgets = window.HTMLWidgets.widgets
          // assume there might be lots, so filter for the one we want
          //  in this case, we want jsonedit
          var widget = widgets.filter(function(widget){
            return widget.name === component.name
          })[0]
          
          // get our htmlwidget DOM element
          var el = this.$el.querySelector('.html-widget');
    
          var instance = this.elementData(el, 'init_result')
    
          if(typeof(instance) === 'undefined') {
            // get our htmlwidget instance with initialize
            instance = widget.initialize(el);
            this.elementData(el, 'init_result', instance);
            widget.renderValue(
              el,
              this.x,
              instance
            )
          }
    
          widget.renderValue(
            el,
            this.x,
            instance
          )
        }
      },
      mounted: function() {
        if(typeof(this.x) === 'undefined' || this.x === null) { return }
        var component = this;
        // use HTMLWidgets.widgets to give us a list of available htmlwiget bindings
        var widgets = HTMLWidgets.widgets;
        // assume there might be lots, so filter for the one we want
        //  in this case, we want jsonedit
        var widget = widgets.filter(function(widget){
          return widget.name === component.name
        })[0];
        
        // get our htmlwidget DOM element
        var el = this.$el.querySelector('.html-widget');

        // get our htmlwidget instance with initialize
        var instance = widget.initialize(el);
        this.elementData(el, 'init_result', instance);
        widget.renderValue(
          el,
          this.x,
          instance
        );
      },
      // updated not working since does not watch deep
      //   but if the expectation is that data and options are replaced completely
      //   then updated will trigger
      updated: function() {
        this.updateWidget()
      },
      watch: {
        x: {
          handler: function() {console.log('updating');this.updateWidget()},
          //deep: true
        }
      }
    }
  )
"
  )),
  tags$script(
'
$(document).on("shiny:connected", function (event) {

    Shiny.shinyapp.$inputValues.plot1settings = null
    Shiny.shinyapp.$inputValues.leaf2settings = null

    const app = new Vue({

        el: "#app",
        
        /* does not work but can be made to work
        components: {
          "html-widget": httpVueLoader("HtmlWidget.vue")
        },
        */
        
        data: Shiny.shinyapp.$inputValues,
        
        methods: {
          onPlotlyClick(e) {
            console.log("clicked", e)
          }
        },
        
        mounted() {
          $(this.$el).on("plotly_click", this.onPlotlyClick)
        },
        
        beforeDestroy() {
          $(this.$el).off("plotly_click", this.onPlotlyClick)
        }
        
    });
    
    // message handler and function to set a Shiny input for state purposes
    Shiny.addCustomMessageHandler("setShinyInput", function(message) {
      Shiny.setInputValue(message.input, typeof(message.value) === "string" ? JSON.parse(message.value).x : message.value.x);
      
      // trigger shiny:inputchanged event
      var evt = jQuery.Event("shiny:inputchanged");
      evt.name = message.input;
      evt.value = message.value;
      evt.binding = null;
      evt.el = null;
      evt.inputType = null;
      $(document).trigger(evt);
    });

    $(document).on("plotly_hover", function(e) {console.log("hover", e)})
})
'   
  ),
)

server <- function(input, output, session) {
  ###  leaflet widget example
  # helper function to extract x from a widget
  get_widget_data <- function(widget) { htmltools::as.tags(widget)[[2]]$children[[1]] }
  # functions from leaflet example
  rand_lng <- function(n = 10) rnorm(n, -93.65, .01)
  rand_lat <- function(n = 10) rnorm(n, 42.0285, .01)
  # quick leaflet widget
  m <- leaflet() %>% 
    addTiles() %>% 
    addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 50, 150))
  
  # ggplotly example
  ggpenguins <- qplot(bill_length_mm , body_mass_g, 
                      data = palmerpenguins::penguins, color = species)
  p <- ggplotly(ggpenguins)
  
  # update Shiny input with leaflet data and options
  session$sendCustomMessage(
    "setShinyInput",
    list(input = "leaf2settings", value = get_widget_data(m))
  )
  # update Shiny input with plotly data and options
  session$sendCustomMessage(
    "setShinyInput",
    list(input = "plot1settings", value = get_widget_data(p))
  )
  
  #   since Vue `x` will deviate from proxy updated `x`
  observe({
    invalidateLater(1000, session)
    leafletProxy("leaf2") %>%
      clearShapes() %>%
      addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 50, 150))
  })
}

shinyApp(ui,server)
