<template>
  <div>
    <div class="text-uppercase movie-app-sub-title">
      shiny {{ test }}
      <v-btn icon color="#4c00ff" @click="$emit('click')">
        <v-icon>mdi-camera </v-icon>
      </v-btn>
    </div>

    <div class="text-uppercase text-center movie-app-title">
      movie <span class="orange--text">Vue</span> <span>R</span>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "home-title",

  computed: {
    test() {
      return this.$store.state.test;
    },
  },
};
</script>

<style scoped>
.movie-app-title {
  font-family: "Open Sans", Helvetica, Arial, sans-serif;
  letter-spacing: 0.7rem;
  font-weight: 700 !important;
  font-size: 4rem !important;
}

.movie-app-sub-title {
  letter-spacing: 0.7rem;
  font-size: 1rem;
  font-weight: 400;
}
</style>