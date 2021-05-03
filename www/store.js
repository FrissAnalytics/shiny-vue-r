export default new Vuex.Store({

    state: {
        suggestions: [],
        popular: [],
        movie: null,
        movieDetails: null
    },

    mutations: {

        setPopular(state, value) {
            state.popular = value;
        },

        setSuggestions(state, value) {
            state.suggestions = value;
        },

        setMovie(state, value) {
            state.movie = value;
        },

        movieDetails(state, value) {
            console.log("movie-details", value)
            state.movieDetails = value;
        },

    }
})