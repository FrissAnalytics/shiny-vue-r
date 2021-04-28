export default Vue.component("SearchBox", {

    data() {
        return {
            search: null,
            items: [],
            model: null
        }
    },

    computed: {
        suggestions() {
            return this.$store.state.suggestions;
        }
    },

    methods: {

        getSuggestions: _.debounce((val) => {
            Shiny.setInputValue('search', { field: "movies", value: val })
        }, 500)

    },

    watch: {
        search(val) {
            this.getSuggestions(val);
        }
    },

    template: `
        <v-autocomplete
            v-model="model"
            dark
            :items="suggestions"
            :search-input.sync="search"
            label="search"
            placeholder="Start typing to search"
            prepend-icon="mdi-database-search"
            clearable>
        </v-autocomplete>`
});