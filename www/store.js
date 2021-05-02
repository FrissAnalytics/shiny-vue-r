export default new Vuex.Store({

    state: {
        count: 10,
        suggestions: [],
        popular: [],
        movie: null
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
        }
    }
})