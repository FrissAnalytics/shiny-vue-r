const bus = mitt();

Vue.prototype.$bus = bus;

export default bus;