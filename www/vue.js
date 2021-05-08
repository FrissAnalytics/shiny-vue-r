import router from "/router.js"
import store from "/store.js"
import bus from "/bus.js"
import i18n from "/i18n.js"

$(document).on("shiny:connected", function (event) {

    const app = new Vue({

        el: "#app",

        vuetify: new Vuetify({
            theme: {
                dark: true
            }
        }),

        store: store,

        router: router,

        i18n: i18n,

        components: {
            "top-nav": httpVueLoader("components/TopNav.vue"),
        },
    });

    const rBus = function (message) {
        bus.emit("r2vue", message);
    }

    const rVuex = function (message) {
        store.commit(message.mutation, message.value);
    }

    const rVuexSetState = function (message) {
        store.commit("setState", message);
    }

    Shiny.addCustomMessageHandler("r2vue", rBus);

    Shiny.addCustomMessageHandler("r2vuex", rVuex);

    Shiny.addCustomMessageHandler("rVuexSetState", rVuexSetState);


});