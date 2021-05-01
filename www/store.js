export default new Vuex.Store({

    state: {
        suggestions: []
    },

    mutations: {

        setSuggestions(state, value) {
            console.log(value)
            state.suggestions = value;
        }
    }
})