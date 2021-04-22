$(document).on("shiny:connected", function (event) {

    // vuex store
    const store = new Vuex.Store({

        state: {
            count: 10,
            c3: {},
            movies: []
        },

        mutations: {

            setMovies(state, value) {
                state.movies = value;
            },

            setC3(state, value) {
                state.c3 = value;
            }
        }
    })

    // event bus
    const bus = mitt();

    // make bus available in vue instances
    Vue.prototype.$bus = bus;

    const messages = {
        en: {
            message: {
                hello: 'hello world'
            }
        },
        ja: {
            message: {
                hello: 'こんにちは、世界'
            }
        }
    }

    // create vueI18n instance with options
    const i18n = new VueI18n({
        locale: 'ja', // set locale
        messages, // set locale messages
    })

    const app = new Vue({

        el: "#app",

        vuetify: new Vuetify(),

        store: store,

        i18n: i18n,

        methods: {
            test() {
                Shiny.setInputValue('vue', Math.random())
            }
        }
    });

    // events from R to javascript
    const rBus = function (message) {
        bus.emit("r2vue", message);
    }

    const rVuex = function (message) {
        store.commit(message.mutation, message.value);
    }

    Shiny.addCustomMessageHandler("r2vue", rBus);

    Shiny.addCustomMessageHandler("r2vuex", rVuex);
});