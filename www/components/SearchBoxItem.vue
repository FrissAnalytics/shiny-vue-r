<template>
  <div class="item">
    <v-list-item @click="showMovie()">
      <v-list-item-content>
        <v-list-item-title>{{ item.original_title }}</v-list-item-title>
        <v-list-item-subtitle
          >{{ item.genre }}, {{ item.year }}, {{ item.director }},
          {{ item.duration }} min.</v-list-item-subtitle
        >
      </v-list-item-content>

      <v-list-item-action>
        <div class="d-flex">
          <v-btn small text>
            {{ item.avg_vote }}
          </v-btn>

          <v-btn small text>
            {{ item.metascore }}
          </v-btn>
        </div>
      </v-list-item-action>
    </v-list-item>

    <v-divider></v-divider>
  </div>
</template>

<script>
module.exports = {
  name: "search-box-item",
  props: ["item"],
  methods: {
    showMovie() {
      this.$store.commit("setState", { key: "movie", value: this.item });

      this.$router.push("/movie-detail");

      this.$bus.emit("shiny-data-store", {
        type: "movie-details",
        id: this.item.movie_id_tmdb,
      });
    },
  },
};
</script>

<style>
.item {
  width: 600px;
}
</style>
