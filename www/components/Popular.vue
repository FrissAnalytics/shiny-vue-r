<template>
  <div class="poster-grid d-flex flex-wrap">
    <div v-for="(movie, index) in popular" :key="movie.id">
      <div
        class="ma-1 pa-1 poster d-flex justify-center align-center"
        @click="showMovieDetails(movie)"
      >
        <img loading="lazy" :src="getPosterUrl(movie)" />
        <div class="poster-index">{{ index + 1 }}</div>
      </div>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "popular",

  computed: {
    popular() {
      return this.$store.state.popular;
    },
  },

  methods: {
    getPosterUrl(movie) {
      return (
        "https://image.tmdb.org/t/p/w94_and_h141_bestv2" + movie.poster_path
      );
    },

    showMovieDetails(movie) {
      this.$store.commit("setMovie", movie);
      this.$router.push("/movie-detail");

      this.$bus.emit("shiny-data-store", {
        type: "movie-details",
        id: movie.id,
      });
    },
  },
};
</script>

<style scoped>
.poster-grid {
  --row-count: 2;
  --poster-height: 141px;
  --poster-padding: 16px;
  height: calc(
    var(--row-count) * (var(--poster-height) + var(--poster-padding))
  );
  overflow-y: scroll;
}

.poster {
  position: relative;
  color: white;
  background-color: none;
}

.poster:hover {
  background-color: rgb(76, 0, 255);
  cursor: pointer;
}

.poster-index {
  position: absolute;
  top: 4px;
  left: 4px;
  color: white;
  width: 16px;
  height: 16px;
  font-size: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgb(76, 0, 255);
  opacity: 1;
}
</style>