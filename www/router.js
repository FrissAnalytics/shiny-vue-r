const routes = [
    { path: '/', component: httpVueLoader('components/Home.vue') },
    { path: '/movie-stats', component: httpVueLoader('components/MovieStats.vue') },
    { path: '/movie-detail', component: httpVueLoader('components/MovieDetail.vue') },
    { path: '/person-details', component: httpVueLoader('components/PersonDetails.vue') },
    { path: '/oscars', component: httpVueLoader('components/Oscars.vue') },
    { path: '/globe', component: httpVueLoader('components/Globe.vue') },
    { path: '/narrative', component: httpVueLoader('components/Narrative.vue') },
]

export default new VueRouter({
    routes
})
