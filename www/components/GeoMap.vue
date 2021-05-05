<template>
  <v-card flat tile color="black" class="card">
    <html-widget :x="leafsettings" name="leaflet">
      <div
        id="leaf1"
        style="width: 100%; height: 400px"
        class="leaflet html-widget html-widget-output"
      ></div>
    </html-widget>

    <html-widget :x="leaf2settings" name="leaflet">
      <div
        id="leaf2"
        style="width: 100%; height: 400px"
        class="leaflet html-widget html-widget-output"
      ></div>
    </html-widget>

    {{ leaf2settings }}
  </v-card>
</template>

<script>
module.exports = {
  name: "geo-map",

  data() {
    let { leafsettings, leaf2settings } = Shiny.shinyapp.$inputValues;

    return {
      leafsettings: leafsettings,
      leaf2settings: leaf2settings,
    };
  },

  components: {
    "html-widget": httpVueLoader("components/HtmlWidget.vue"),
  },
};
</script>

<style scoped>
.card {
  margin-top: 48px;
  height: calc(100vh - 48px);
}
</style>