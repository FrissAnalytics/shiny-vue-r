<template>
  <div
    class="movie-background"
    :style="`backgroundImage: url(${backgroundImg})`"
  >
    <div class="home-content">
      <div>
        <home-title @click="updateIndex" />
      </div>

      <div>
        <search-box />
      </div>

      <div>
        <popular />
      </div>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "home",

  components: {
    "home-title": httpVueLoader("components/HomeTitle.vue"),
    "search-box": httpVueLoader("components/SearchBox.vue"),
    popular: httpVueLoader("components/Popular.vue"),
  },

  data() {
    return {
      imgIndex: 0,

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
        "https://www.themoviedb.org/t/p/original/uQtqiAu2bBlokqjlURVLEha6zoi.jpg",
      ],
    };
  },

  computed: {
    backgroundImg() {
      return this.imgSrc[this.imgIndex];
    },
  },

  methods: {
    updateIndex() {
      this.imgIndex =
        this.imgIndex < this.imgSrc.length - 1 ? this.imgIndex + 1 : 0;
    },
  },
};
</script>

<style scoped>
.movie-background {
  position: relative;
  height: 100vh;
  width: 100%;
  overflow: hidden;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  color: white;
  text-align: center;
  background-color: black;
}

.home-content {
  position: absolute;
  bottom: 10px;
  left: 0;
  width: 100%;
}
</style>
