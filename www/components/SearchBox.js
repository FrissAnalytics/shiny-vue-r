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
            return this.$store.state.suggestions
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
            item-text="original_title"
            item-value="original_title"
            label="search"
            placeholder="Start typing to search"
            prepend-icon="mdi-database-search"
            clearable>
            <template v-slot:item="{ item }">

                <v-list-item>
                    <v-list-item-content>
                        <v-list-item-title>{{item.original_title}}</v-list-item-title>
                        <v-list-item-subtitle>{{item.genre}}, {{item.year}}, {{item.director}}, {{item.duration}} min.</v-list-item-subtitle>
                    </v-list-item-content>
                </v-list-item>
  
                <v-list-item-action>
                    <v-btn small text>
                    {{item.avg_vote}}
                    </v-btn>
                </v-list-item-action>

                <v-list-item-action>
                    <v-btn small text>
                     {{item.metascore}}
                    </v-btn>
                </v-list-item-action>

                <v-divider inset></v-divider>

            </template>
        </v-autocomplete>`
});