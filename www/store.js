export default new Vuex.Store({

    state: {
        count: 10,
        c3: {},
        movies: [],
        popularMovies: [],
        suggestions: []
    },

    mutations: {

        setPopularMovies(state, value) {
            state.popularMovies = value;
        },

        setSuggestions(state, value) {
            state.suggestions = value;
        },

        setMovies(state, value) {
            state.movies = value;
        },

        setC3(state, value) {
            state.c3 = value;
        }
    }
})