<template>
  <div :id="`shiny-plot-output-${id}`">
    <div
      :id="id"
      class="shiny-plot-output"
      :style="`width: ${width}; height: ${height};`"
    ></div>
  </div>
</template>

<script>
module.exports = {
  name: "shiny-plot-output",

  props: {
    id: {
      type: String,
      required: true,
    },

    width: {
      type: String,
      default: "100%",
    },

    height: {
      type: String,
      default: "400px",
    },
  },

  mounted() {
    Vue.nextTick(() => {
      if (!Shiny.shinyapp.$bindings.hasOwnProperty(this.id)) {
        Shiny.bindAll($(`#shiny-plot-output-${this.id}`));
      }
    });

    const val = Math.random();
    Shiny.setInputValue("v-" + this.id, val);
  },
};
</script>

<style scoped>
</style>