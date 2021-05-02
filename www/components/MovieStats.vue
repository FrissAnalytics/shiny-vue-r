<template>
  <v-card flat tile color="black" class="card">
    <v-container>
         <div class="mt-3">
              <shiny-plot-output id="plot1">
        </div>
         <div class="mt-3">
              <shiny-plot-output id="plot2">
        </div>
    </v-container>
  </v-card>
</template>

<script>
module.exports = {
  name: "movie-stats",

  components: {
    "shiny-plot-output": httpVueLoader("components/ShinyPlotOutput.vue"),
  },
};
</script>

<style scoped>
.card {
  margin-top: 48px;
  height: calc(100vh - 48px);
}
</style>