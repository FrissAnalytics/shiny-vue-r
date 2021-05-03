<template>
  <div class="sfc-template ma-2 pa-2">vue sfc template</div>
</template>

<script>
module.exports = {
  name: "sfc-template",

  components: {
    // "": httpVueLoader("components/"),
  },

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