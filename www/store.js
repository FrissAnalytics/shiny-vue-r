export default new Vuex.Store({

    state: {
        count: 10,
        suggestions: [],
        popular: [],
        movie: null,

        leaflet_x: null
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

        setLeafletx(state, value) {
            state.leaflet_x = JSON.parse(value).x;
        }
    }
})