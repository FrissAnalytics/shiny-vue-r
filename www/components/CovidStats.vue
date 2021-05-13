<template>
  <div>
    <v-dialog
      v-model="dialog"
      width="80%"
      transition="dialog-bottom-transition"
    >
      <v-card id="country-comparison">
        <div class="text-center text-h3 white--text">
          Covid timeline comparison
        </div>

        <div class="ma-5">
          <shiny-plot-output id="covid" :height="height" />
        </div>

        <v-divider class="my-2"></v-divider>

        <v-card-actions>
          <div class="country-selector">
            <v-select
              v-model="selection"
              :items="countryCodes"
              item-text="country"
              item-value="id"
              multiple
              chips
              small-chips
              deletable-chips
              hint="select two or more countries to compare"
              persistent-hint
            ></v-select>
          </div>

          <v-btn-toggle
            v-model="type"
            tile
            color="light-blue"
            group
            class="mx-5"
          >
            <v-btn small value="confirmed"> confirmed </v-btn>

            <v-btn small value="deaths"> deaths </v-btn>

            <v-btn small value="recovered"> recovered </v-btn>
          </v-btn-toggle>

          <v-btn-toggle v-model="mode" tile color="teal" group class="mx-5">
            <v-btn small value="delta"> delta </v-btn>

            <v-btn small value="total"> total </v-btn>
          </v-btn-toggle>

          <v-btn
            small
            color="orange"
            dark
            text
            @click="updateShiny"
            class="mx-5"
            >compare
          </v-btn>

          <v-spacer></v-spacer>

          <v-btn small color="primary" text @click="dialog = false"
            >close
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
module.exports = {
  name: "covid-stats",

  mounted() {
    // react to bus event
    this.$bus.on("show-covid-stats", () => {
      this.dialog = true;
    });

    // make sure shiny has the initial values
    this.el = d3.select("#country-comparison").node();

    this.updateShiny();
  },

  components: {
    "shiny-plot-output": httpVueLoader("components/ShinyPlotOutput.vue"),
  },

  data() {
    return {
      type: "confirmed",
      mode: "delta",
      selection: ["IT", "BE", "NL", "CN"],
      dialog: false,
      height: "400px",
    };
  },

  computed: {
    ids() {
      return this.$store.state.ids;
    },

    countryCodes() {
      return this.$store.state.countryCodes;
    },
  },

  methods: {
    updateShiny() {
      Shiny.bindAll(this.el);
      Shiny.setInputValue("covid_compare", {
        countries: this.selection,
        mode: this.mode,
        type: this.type,
      });

      this.height = this.selection.length * 100 + "px";
    },
  },
};
</script>

<style scoped>
.country-selector {
  max-width: 400px;
  width: 400px;
  display: inline;
}
</style>