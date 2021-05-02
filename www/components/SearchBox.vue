<template>
  <v-autocomplete
    v-model="model"
    dark
    :items="suggestions"
    :search-input.sync="search"
    item-text="original_title"
    item-value="original_title"
    label="search"
    placeholder="Start typing to search"
    prepend-icon="mdi-database-search"
    clearable
  >
    <template v-slot:item="{ item }">
      <search-box-item :item="item" />
    </template>
  </v-autocomplete>
</template>

<script>
module.exports = {
  name: "search-box",

  components: {
    "search-box-item": httpVueLoader("components/SearchBoxItem.vue"),
  },

  data() {
    return {
      search: null,
      items: [],
      model: null,
    };
  },

  computed: {
    suggestions() {
      return this.$store.state.suggestions;
    },
  },

  methods: {
    getSuggestions: _.debounce((val) => {
      Shiny.setInputValue("search", { field: "movies", value: val });
    }, 500),
  },

  watch: {
    search(val) {
      this.getSuggestions(val);
    },
  },
};
</script>
