export default Vue.component("Home", {

    components: {
        "search-box": httpVueLoader('components/SearchBox.vue'),
        "popular": httpVueLoader('components/Popular.vue')
    },

    data() {
        return {
            imgIndex: 0,

            dialog: Math.random(),

            imgSrc: [
                "https://www.themoviedb.org/t/p/original/2UrGpntyQtgunf039MErok78ZOK.jpg",
                "https://www.themoviedb.org/t/p/original/r8z2HRNFag56tGvaXBxEg6EgwoY.jpg",
                "https://www.themoviedb.org/t/p/original/OdD7A0LgLXPjqzmfcEl9sTYVPo.jpg",
                "https://www.themoviedb.org/t/p/original/2Su8VR1SfnMBK9gAlEaajYyoxO6.jpg",
                "https://www.themoviedb.org/t/p/original/dVSMKPEaiwujXE7kQkvixPLieHR.jpg",
                "https://www.themoviedb.org/t/p/original/uT895WNwm0aIJRtGizcQhrejWUo.jpg",
                "https://www.themoviedb.org/t/p/original/tl5PoDXHwwgTjYv5T5k4aut9YXH.jpg",
                "https://www.themoviedb.org/t/p/original/6zbKgwgaaCyyBXE4Sun4oWQfQmi.jpg",
                "https://www.themoviedb.org/t/p/original/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg",
                "https://www.themoviedb.org/t/p/original/6SfX1p5G4EEEDnEulFJeSxgbtSV.jpg",
                "https://www.themoviedb.org/t/p/original/vpdBOYTWgjrh90JN1Yc1YnCPFkD.jpg",
                "https://www.themoviedb.org/t/p/original/bgQUBbZ14hfeb975yZ2YzTnAwen.jpg",
                "https://www.themoviedb.org/t/p/original/uQtqiAu2bBlokqjlURVLEha6zoi.jpg"],

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

    computed: {
        backgroundImg() {
            return this.imgSrc[this.imgIndex]
        }
    },

    methods: {
        updateIndex() {
            this.imgIndex = this.imgIndex < this.imgSrc.length - 1 ? this.imgIndex + 1 : 0;

            this.dialog = Math.random();
        }
    },

    watch: {
        dialog(val) {

            if (val) {
                Vue.nextTick(() => {

                    if (!Shiny.shinyapp.$bindings.hasOwnProperty('plot1')) {
                        Shiny.bindAll($('#shiny-test'));
                    }
                });
            }

            Shiny.setInputValue('vue', val);
        }
    },

    template: `
    <div class="d-flex align-center justify-center" :style="styleWrapper">

        <v-container style="z-index: 1" id="shiny-test">
 
          <div id="plot1" class="shiny-plot-output" style="width: 100% ; height: 200px; margin-top: 70px;"></div>

          <div class="text-center text-uppercase white--text" style="letter-spacing: 0.7rem; font-size: 1rem; font-weight: 400">Shiny 
            <v-btn icon color="blue" @click="updateIndex">
                <v-icon>mdi-camera </v-icon>
            </v-btn>
         </div>
          
          <div class="app-title text-center text-uppercase">Movie <span class="orange--text">Vue</span> <span>R</span></div>
    
          <search-box style="width: 600px" class="mx-auto"/> 

          <popular />
        
        </v-container>

        <v-img :src="backgroundImg" :style="styleImg"></v-img >
    </div>`
})