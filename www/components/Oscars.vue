<template>
  <v-card flat tile color="black" class="pz-8 py-2 white--text card">
    <div id="movie-wrapper">
      <div class="d-flex justify-center">
        <img src="img/oscar.png" height="55px" class="pr-3" />
        <span class="text-h3 title">Academy awards</span>
      </div>

      <div
        v-for="item in items"
        :key="item.id"
        class="d-flex justify-center my-5 movie"
        @click="showMovie(item)"
      >
        <img
          loading="lazy"
          :src="`https://image.tmdb.org/t/p/w300_and_h450_bestv2${item.poster_path}`"
          :height="`${height}px`"
        />

        <v-card :height="height" :width="500" class="card-detail pa-2">
          <v-card-title class="headline justify-center">
            {{ item.title }}
          </v-card-title>

          <v-card-text class="pt-3">{{ item.overview }}</v-card-text>
          <div class="card-footer text-center pb-2 text-overline">
            {{ item.release_date }}
          </div>
        </v-card>

        <img
          loading="lazy"
          :src="`https://www.themoviedb.org/t/p/original${item.backdrop_path}`"
          :height="`${height}px`"
          class="mx-3"
        />
      </div>
    </div>
  </v-card>
</template>

<script>
module.exports = {
  name: "oscars",

  mounted() {
    OverlayScrollbars(document.querySelector("#movie-wrapper"), {
      className: "os-theme-round-light",
    });
  },

  computed: {
    items() {
      return this.$store.state.oscars;
    },

    height() {
      return 0.5 * 0.9 * window.innerHeight;
    },
  },

  methods: {
    backdrop(item) {
      return "https://www.themoviedb.org/t/p/original" + item.backdrop_path;
    },

    showMovie(item) {
      this.$store.commit("setState", { key: "movie", value: item });

      this.$router.push("/movie-detail");

      this.$bus.emit("shiny-data-store", {
        type: "movie-details",
        id: item.id,
      });
    },
  },
};
</script>

<style scoped>
.card {
  margin-top: 48px;
  height: calc(100vh - 48px);

  color: white;
}

.card-detail {
  position: relative;
}

.card-footer {
  position: absolute;
  bottom: 0;
  width: 100%;
}

.title {
  color: #a17228;
}

.movie:hover {
  cursor: pointer;
}

#movie-wrapper {
  height: 90vh;
  width: 90vw;
  margin: 0 auto;
  overflow-x: hidden;
  overflow-y: scroll;
}
</style>