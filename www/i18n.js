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

const i18n = new VueI18n({
    locale: 'ja',
    messages,
})

export default i18n;