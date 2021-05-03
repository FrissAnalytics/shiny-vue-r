const bus = mitt();

bus.on('shiny-update', (id) => Shiny.setInputValue(id, Math.random()));

bus.on('shiny-data-store', (val) => Shiny.setInputValue("data_store", val));

Vue.prototype.$bus = bus;

export default bus;