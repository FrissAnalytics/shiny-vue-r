export default Vue.component("vr-test", {

    data() {
        return {
            message: "hello from test",
        }
    },

    template: `
    <div>
        {{message}}
    </div>`
})