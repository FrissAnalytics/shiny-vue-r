<template>
  <div class="poster-grid d-flex flex-wrap">
    <div v-for="(movie, index) in popular" :key="movie.id">
      <div class="ma-1 pa-1 poster d-flex justify-center align-center">
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
  },
};
</script>

<style scoped>
.poster-grid {
  max-height: 400px;
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