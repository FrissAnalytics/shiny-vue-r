import router from "/router.js"
import store from "/store.js"
import bus from "/bus.js"
import i18n from "/i18n.js"

$(document).on("shiny:connected", function (event) {

    const app = new Vue({

        el: "#app",

        vuetify: new Vuetify(),

        store: store,

        router: router,

        i18n: i18n
    });

    const rBus = function (message) {
        bus.emit("r2vue", message);
    }

    const rVuex = function (message) {
        store.commit(message.mutation, message.value);
    }

    Shiny.addCustomMessageHandler("r2vue", rBus);

    Shiny.addCustomMessageHandler("r2vuex", rVuex);
});