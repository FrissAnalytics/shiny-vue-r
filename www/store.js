export default new Vuex.Store({

    state: {
        suggestions: [],
        popular: [],
        movie: null,
        movieDetails: null,
        covid: [],
        countries: null,
        airports: null
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

        movieDetails(state, value) {
            state.movieDetails = value;
        },

        setCovid(state, value) {
            state.covid = value;
        },

        setCountries(state, value) {
            state.countries = value;
        },

        setAirports(state, value) {
            state.airports = value;
        }
    },

    getters: {
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