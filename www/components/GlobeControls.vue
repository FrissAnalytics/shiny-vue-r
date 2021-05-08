<template>
  <v-card id="globe-controls" color="#37343461" class="rounded-xl ma-2" dark>
    <v-btn icon color="#3f51b5" class="d-block" @click="$emit('zoom-in')">
      <v-icon>mdi-magnify-plus-outline</v-icon>
    </v-btn>

    <v-btn icon color="#3f51b5" class="d-block" @click="$emit('zoom-out')">
      <v-icon> mdi-magnify-minus-outline</v-icon>
    </v-btn>

    <v-btn icon color="#3f51b5" class="d-block" @click="$emit('rotate')">
      <v-icon> mdi-axis-z-rotate-counterclockwise</v-icon>
    </v-btn>
  </v-card>
</template>

<script>
module.exports = {
  name: "globe-controls",

  props: ["items"],

  data() {
    return {};
  },

  mounted() {},

  computed: {},

  methods: {},

  watch: {},
};
</script>

<style scoped>
.sfc-template {
  background-color: red;
}
</style>