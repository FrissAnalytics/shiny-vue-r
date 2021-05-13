import { annotations } from "./data/annotations.js";

export default new Vuex.Store({

    state: {
        annotations: annotations,
        personDetails: null,
        airports: null,
        storylines: null,
        totalTimeline: null,
        ids: [],
        countryCodes: []
    },

    mutations: {

        setState(state, payload) {

            const { key, value } = payload;

            Vue.set(state, key, value);
        }
    },

    getters: {

        storylines: state => {

            if (!state.storylines) return []

            const items = state.storylines;

            const dateParser = d3.timeParse("%m-%d-%Y");

            items.forEach((d) => {
                d.date = dateParser(d.date);
            });

            return items.reverse()

        },

        airports: state => {

            const lambda = d3.scaleLinear()
                .domain([-90, 90])
                .range([0, 1])
                .clamp(true);

            return state.airports.map((d) => ({
                pointLat: +d.lat,
                pointLng: +d.lng,
                pointColor: d3.interpolateRainbow(lambda(+d.lat)),
                pointAltitude: 0.02,
                pointRadius: 0.04,
                name: d.name,
                city: d.city,
                country: d.country,
                code: d.IATA
            }));

        }
    }
})