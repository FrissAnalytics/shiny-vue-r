export default Vue.component("Popular", {

    computed: {
        popular() {
            return this.$store.state.popular
        }
    },

    methods: {
        getPosterUrl(movie) {
            return "https://image.tmdb.org/t/p/w94_and_h141_bestv2" + movie.poster_path;
        },

        getStyle(hover) {
            return hover ? { backgroundColor: 'red', cursor: "pointer" } : {};
        }
    },

    template: `
    <div id="popular" style="max-height: 400px; overflow-y: scroll" class="d-flex flex-wrap">
        <div v-for="(movie,index) in popular" :key="movie.id">
            <div class="ma-1 pa-1 movie-poster d-flex justify-center align-center" >
                    <img loading="lazy" :src="getPosterUrl(movie)" />
                </div>
            </div>
        </div>
    </div>
     `
});

