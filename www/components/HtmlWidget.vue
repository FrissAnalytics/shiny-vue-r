<template>
  <div>
    <slot></slot>
  </div>
</template>

<script>
module.exports = {
  name: "html-widget",
  props: ["x", "name"],
  methods: {
    // Copied from HTMLWidgets code
    // Implement a vague facsimile of jQuery's data method
    elementData: function (el, name, value) {
      if (arguments.length == 2) {
        return el["htmlwidget_data_" + name];
      } else if (arguments.length == 3) {
        el["htmlwidget_data_" + name] = value;
        return el;
      } else {
        throw new Error(
          "Wrong number of arguments for elementData: " + arguments.length
        );
      }
    },
    updateWidget: function () {
      // see comments in mounted which is nearly identical except in update we do not initialize or attach
      //   initial data to the element.  we could clean this up and make one function.
      var component = this;
      // use HTMLWidgets.widgets to give us a list of available htmlwidget bindings
      var widgets = window.HTMLWidgets.widgets;
      // assume there might be lots, so filter for the one we want
      //  in this case, we want jsonedit
      var widget = widgets.filter(function (widget) {
        return widget.name === component.name;
      })[0];

      // get our htmlwidget DOM element
      var el = this.$el.querySelector(".html-widget");
      var instance = this.elementData(el, "init_result");
      if (typeof instance === "undefined") {
        // get our htmlwidget instance with initialize
        instance = widget.initialize(el);
        this.elementData(el, "init_result", instance);
        widget.renderValue(el, this.x, instance);
      }
      widget.renderValue(el, this.x, instance);
    },
  },
  mounted: function () {
    // could use HTMLWidgets static render but this expects script tags with x (data and options) which I do not like and
    //  should not be necessary with our component.  x can live in JavaScript.
    //  so we will do most of what static render does except handle pre-render and post-render calls, which we can add later
    // handle empty or undefined x especially in case of Shiny context that might populate after load
    if (typeof this.x === "undefined" || this.x === null) {
      return;
    }
    var component = this;
    // use HTMLWidgets.widgets to give us a list of available htmlwiget bindings
    var widgets = window.HTMLWidgets.widgets;
    // assume there might be lots, so filter for the one we want
    var widget = widgets.filter(function (widget) {
      return widget.name === component.name;
    })[0];

    // get our htmlwidget DOM element
    var el = this.$el.querySelector(".html-widget");
    // get our htmlwidget instance with initialize
    var instance = widget.initialize(el);
    this.elementData(el, "init_result", instance);
    widget.renderValue(el, this.x, instance);
  },
  // updated not working since does not watch deep
  //   but if the expectation is that data and options are replaced completely
  //   then updated will trigger
  updated: function () {
    this.updateWidget();
  },
  watch: {
    //  use watch so that we can monitor deep changes such as x.data or x.options
    x: {
      handler: function () {
        this.updateWidget();
      },
      deep: true,
    },
  },
};
</script>