export default Vue.component("vr-wrapper", {

  data() {
    return {
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

    popularMovies() {
      return this.$store.state.popularMovies;
    }
  },

  template: `
    <div class= "ma-2">

        <v-card v-for="(movie,index) in popularMovies" :key="index" class="my-10 elevation-2 mx-auto" :width="1280">

          <div class="text-center text-h4 my-2">{{movie.title}}</div>

          <v-img width="1280" :src="'https://image.tmdb.org/t/p/w1280/' + movie.backdrop_path"></v-img>

          <v-card-text>{{movie.overview}}</v-card-text>

        </v-card>

        <div class="my-5 text-center">{{ $i18n.t("message.hello") }}</div>

        <v-btn x-small @click="show=!show" > open</v-btn >

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
      </div > `
});