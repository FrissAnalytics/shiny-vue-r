export default Vue.component("Home", {

    data() {
        return {
            imgSrc: [
                "https://www.themoviedb.org/t/p/original/r8z2HRNFag56tGvaXBxEg6EgwoY.jpg",
                "https://www.themoviedb.org/t/p/original/2j5zlVyhSDi8VkMc2BlpA2sxRmg.jpg",
                "https://www.themoviedb.org/t/p/original/fZPSd91yGE9fCcCe6OoQr6E3Bev.jpg",
                "https://www.themoviedb.org/t/p/original/sGncEMPoUOSJQ93eO0U3xCGIyZn.jpg",
                "https://www.themoviedb.org/t/p/original/OdD7A0LgLXPjqzmfcEl9sTYVPo.jpg",
                "https://www.themoviedb.org/t/p/original/ff2ti5DkA9UYLzyqhQfI2kZqEuh.jpg",
                "https://www.themoviedb.org/t/p/original/2Su8VR1SfnMBK9gAlEaajYyoxO6.jpg",
                "https://www.themoviedb.org/t/p/original/dVSMKPEaiwujXE7kQkvixPLieHR.jpg",
                "https://www.themoviedb.org/t/p/original/yzpCv8CCWondN7O5au1KGiqnC3A.jpg",
                "https://www.themoviedb.org/t/p/original/uT895WNwm0aIJRtGizcQhrejWUo.jpg",
                "https://www.themoviedb.org/t/p/original/tl5PoDXHwwgTjYv5T5k4aut9YXH.jpg",
                "https://www.themoviedb.org/t/p/original/wWqTMWkEw6HouLd1zPZbZWxtAPr.jpg",
                "https://www.themoviedb.org/t/p/original/xJHokMbljvjADYdit5fK5VQsXEG.jpg",
                "https://www.themoviedb.org/t/p/original/2UrGpntyQtgunf039MErok78ZOK.jpg",
                "https://www.themoviedb.org/t/p/original/6zbKgwgaaCyyBXE4Sun4oWQfQmi.jpg",
                "https://www.themoviedb.org/t/p/original/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg",
                "https://www.themoviedb.org/t/p/original/6SfX1p5G4EEEDnEulFJeSxgbtSV.jpg",
                "https://www.themoviedb.org/t/p/original/vpdBOYTWgjrh90JN1Yc1YnCPFkD.jpg",
                "https://www.themoviedb.org/t/p/original/bgQUBbZ14hfeb975yZ2YzTnAwen.jpg",
                "https://www.themoviedb.org/t/p/original/uQtqiAu2bBlokqjlURVLEha6zoi.jpg"][0],
            styleImg: {
                height: "100vh",
                width: "100vw",
                backgroundPosition: "center",
                backgroundRepeat: "no-repeat",
                backgroundSize: "cover",
                position: "absolute"
            },
            styleWrapper: {
                position: "absolute",
                top: 0,
                left: 0,
                height: "100vh",
                width: "100vw",
                zIndex: 1
            }
        }
    },

    template: `
    <div class="d-flex align-center justify-center" :style="styleWrapper">
        <v-container style="z-index: 1">
        <div class="text-center text-uppercase white--text" style="letter-spacing: 0.7rem; font-size: 1rem; font-weight: 400">Shiny</div>
          <div class="app-title text-center text-uppercase">Movie <span class="orange--text">Vue</span> <span>R</span></div>
            <vr-search-box class="mx-auto" style="width: 600px"/>
        </v-container>
        <v-img :src="imgSrc" :style="styleImg"></v-img >
    </div>`
})