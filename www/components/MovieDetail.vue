<template>
  <v-card flat tile color="black" class="card">
    <div class="text-center" v-if="movie">
      <p class="text-h2 font-weight-black">
        {{ movie.original_title }}
      </p>

      <p class="text-body-2">
        {{ movie.release_date }}
      </p>

      <div class="d-flex justify-center">
        <div>
          <img :src="backdrop" alt="backdrop" class="backdrop" />
        </div>
        <div class="ml-2">
          <img :src="poster" alt="" />
        </div>
      </div>

      <div style="width: 60%" class="mx-auto">
        <p class="text-body-2" v-html="movie.overview"></p>
      </div>

      <div>
        <movie-cast :items="cast"></movie-cast>
      </div>
    </div>
  </v-card>
</template>

<script>
module.exports = {
  name: "movie-detail",

  components: {
    "movie-cast": httpVueLoader("components/MovieCast.vue"),
  },

  computed: {
    movie() {
      if (!this.$store.state.movieDetails) return null;

      console.log("movie detail: ", this.$store.state);
      return this.$store.state.movieDetails;
    },

    backdrop() {
      return (
        "https://www.themoviedb.org/t/p/original" + this.movie.backdrop_path
      );
    },

    poster() {
      return (
        "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/" +
        this.movie.poster_path
      );
    },

    cast() {
      return this.movie ? this.movie.credits.cast : [];
    },
  },
};
</script>

<style scoped>
.card {
  margin-top: 48px;
  height: calc(100vh - 48px);
  overflow: hidden;
}

.backdrop {
  height: 450px;
}
</style>