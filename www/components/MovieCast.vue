<template>
  <div class="d-flex justify-space-around">
    <div
      v-for="item in items.filter((d, i) => i < 6 && d.profile_path)"
      :key="item.id"
      flat
      class="ma-4 pa-2 person"
      @click="getPersonDetails(item)"
    >
      <img :src="getImg(item)" :height="175" />
      <div class="cast-name font-weight-black">{{ item.name }}</div>
      <div class="cast-character">{{ item.character }}</div>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "movie-cast",

  props: ["items"],

  methods: {
    getImg(item) {
      return (
        "https://www.themoviedb.org/t/p/" +
        "w138_and_h175_face" +
        item.profile_path
      );
    },

    getPersonDetails(item) {
      this.$store.commit("setState", { key: "person", value: item });

      this.$router.push("/person-details");

      this.$bus.emit("shiny-data-store", {
        type: "person-details",
        id: item.id,
      });
    },
  },
};
</script>

<style scoped>
.cast-name {
  font-size: 0.9rem;
}

.cast-character {
  font-size: 0.8rem;
}

.person:hover {
  cursor: pointer;
}
</style>
