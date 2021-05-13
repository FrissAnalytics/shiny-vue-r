<template>
  <v-card flat tile color="black" class="card">
    <v-container>

        <!-- shiny server module 1 -->
        <div class="mt-3">
              <v-btn x-small @click="$bus.emit('shiny-update','server1-var1')">server 1 plot 1</v-btn>
              <shiny-plot-output id="server1-plot1" height="160px">
        </div>

        <div class="mt-3">
              <v-btn x-small @click="$bus.emit('shiny-update','server1-var2')">server 1 plot 2</v-btn>
              <shiny-plot-output id="server1-plot2" height="160px">
        </div>

        <v-divider class="my-8 cyan accent-2"></v-divider>

        <!-- shiny server module 2 -->
        <div class="mt-3">
              <v-btn x-small @click="$bus.emit('shiny-update','server2-var1')">server 2 plot 1</v-btn>
              <shiny-plot-output id="server2-plot1" height="160px">
        </div>

        <div class="mt-3">
              <v-btn x-small @click="$bus.emit('shiny-update','server2-var2')">server 2 plot 2</v-btn>
              <shiny-plot-output id="server2-plot2" height="160px">
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