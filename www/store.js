export default new Vuex.Store({

    state: {
        suggestions: [],
        popular: [],
        movie: null,
        movieDetails: null,
        covid: []
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
            state.movieDetails = value;
        },

        setCovid(state, value) {
            state.covid = value;
        }
    }
})