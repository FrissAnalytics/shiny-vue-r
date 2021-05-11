<template>
  <div id="person-credits">
    <div class="d-flex flex-wrap">
      <v-card
        v-for="credit in credits"
        :key="credit.id"
        class="ma-2 pa-2 credit"
        @click="showMovieDetails(credit)"
      >
        <img
          loading="lazy"
          :src="`https://image.tmdb.org/t/p/w150_and_h225_bestv2${credit.poster_path}`"
        />
      </v-card>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "person-credits",

  props: ["credits"],

  data() {
    return {};
  },

  mounted() {
    OverlayScrollbars(document.querySelector("#person-credits"), {
      className: "os-theme-round-light",
    });
  },

  computed: {},

  methods: {
    showMovieDetails(movie) {
      this.$store.commit("setState", { key: "movie", value: movie });

      this.$router.push("/movie-detail");

      this.$bus.emit("shiny-data-store", {
        type: "movie-details",
        id: movie.id,
      });
    },
  },

  watch: {},
};
</script>

<style scoped>
#person-credits {
  box-sizing: border-box;
  height: 550px;
  width: 100%;
  margin: 20px;
  padding: 20px;
}

.credit:hover {
  cursor: pointer;
}
</style>