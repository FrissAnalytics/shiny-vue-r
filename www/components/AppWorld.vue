<template>
  <div class="my-2">
    <p>
      {{ greeting }} World! <span class="ml-3">{{ count }}</span>
      <v-btn x-small @click="update()" class="ml-3">shiny</v-btn>
    </p>
  </div>
</template>

<script>
module.exports = {
  data() {
    return {
      greeting: "Hello",
    };
  },

  computed: {
    count() {
      return this.$store.state.count;
    },
  },

  methods: {
    update() {
      console.log("hello!");
      this.$store.commit("setShiny");
    },
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

div {
  background-color: red;
  color: white;
}
</style>