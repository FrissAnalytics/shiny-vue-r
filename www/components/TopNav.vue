<template>
  <v-app-bar color="#24242596" dense dark>
    <v-app-bar-nav-icon @click="$router.push('/')"></v-app-bar-nav-icon>

    <v-toolbar-title>movie-vue-r</v-toolbar-title>

    <v-spacer></v-spacer>

    <v-btn small icon to="/">
      <v-icon small>mdi-heart</v-icon>
    </v-btn>

    <v-btn small icon to="/movie-stats" class="ml-2">
      <v-icon small>mdi-alpha-r-box</v-icon>
    </v-btn>

    <v-btn small icon to="/oscars" class="ml-2">
      <v-icon small>mdi-trophy</v-icon>
    </v-btn>

    <v-btn small icon to="/globe" class="ml-2">
      <v-icon small>mdi-map-marker </v-icon>
    </v-btn>
    <!-- 
    <v-btn small icon to="/narrative" class="ml-2">
      <v-icon small>mdi-information</v-icon>
    </v-btn> -->
  </v-app-bar>
</template>

<script>
module.exports = {
  name: "top-nav",
};
</script>