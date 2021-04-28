export default new Vuex.Store({

    state: {
        suggestions: []
    },

    mutations: {

        setSuggestions(state, value) {
            state.suggestions = value;
        }
    }
})