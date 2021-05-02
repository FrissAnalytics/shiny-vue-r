export default new Vuex.Store({

    state: {
        count: 10,
        suggestions: [],
        popular: [],
    },

    mutations: {

        setPopular(state, value) {
            state.popular = value;
        },

        setSuggestions(state, value) {
            state.suggestions = value;
        },

        setShiny() {
            Shiny.setInputValue('vue', Math.random());
        }
    }
})