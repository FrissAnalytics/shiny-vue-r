$(document).on("shiny:connected", function (event) {

  // create components based on the options API 
  // note: vuetify 2 is not compatible with vue 3 yet so we don't use the composition API

  Vue.component("vr-search-box", {

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
      <div class="ma-2">

        <v-autocomplete
            v-model="model"
            :items="suggestions"
            :search-input.sync="search"
            label="search"
            placeholder="Start typing to search"
            prepend-icon="mdi-database-search"
            clearable>
        </v-autocomplete>

      </div>`
  });

});

Vue.component("vr-wrapper", {

  data() {
    return {
      name: "test",
      show: false,
      payload: null,
    }
  },

  mounted() {
    this.$bus.on("r2vue", this.update);
  },

  methods: {
    update(payload) {
      this.payload = payload;
    }
  },

  computed: {
    count() {
      return this.$store.state.count;
    },

    backdrop() {
      return this.payload ? 'https://image.tmdb.org/t/p/w1280/' + this.payload.backdrop_path : '';
    }

  },

  template: `
      <div class="ma-2">

        <vr-search-box class="mx-auto" style="width: 600px"/>
 
        <img :src="backdrop" />

        <div class="my-5 text-center">{{ $i18n.t("message.hello") }}</div>

        <v-btn x-small @click="show=!show">open</v-btn>

        <c3-bar-chart id="bar1"/>

        <vr-table />
        
        <v-bottom-sheet v-model="show">
            <v-sheet
              class="text-center"
              height="200px"
            >
              <v-btn
                class="mt-6"
                text
                color="red"
                @click="show=!show"
              >
                close
              </v-btn>
              <div class="py-3">
               bottom sheet example
              </div>
            </v-sheet>
          </v-bottom-sheet>
      </div>`
});

Vue.component("c3-bar-chart", {

  props: ["id"],

  template: `
    <v-card class="mt-2 mb-5 pa-2 d-flex justify-center align-center"  height=400 color="grey lighten-5">
      
      <div :id="id"></div>

      <slot name="footer"></slot>

    </v-card>
      `,

  computed: {
    c3() {
      return this.$store.state.c3
    }
  },

  watch: {
    c3(val) {

      this.chart = bb.generate({
        data: val,
        bar: {
          width: {
            ratio: 0.5
          }
        },
        bindto: "#" + this.id
      });
    }
  }
});

Vue.component("vr-table", {

  template: `
  <div>
     <v-data-table
      fixed-header
       height="300px"
      :headers="headers"
      :items="movies"
      :items-per-page="10"
      class="elevation-1">
  </v-data-table>
  </div>
  `,

  data() {
    return {

    }
  },

  computed: {
    movies() {
      return this.$store.state.movies;
    },

    headers() {
      return this.movies[0] ? Object.keys(this.movies[0]).map(d => ({ text: d, value: d })) : []
    }

  }

})