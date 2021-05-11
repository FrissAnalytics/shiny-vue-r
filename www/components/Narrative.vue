<template>
  <div class="panel">
    <div id="narrative-panel" class="mx-auto px-3 ma-3 narrative-wrapper">
      <p class="text-h3 text-center title">Becoming a front-end developer</p>

      <div class="narrative-content text-justify">
        <div class="text-overline text--secondary text-center">First steps</div>

        <div class="d-flex justify-start">
          <v-card class="my-2 pa-4">
            Today I work as a front-end developer. Before Shiny came along I had
            no clue what I wanted to do. I finished university, worked a number
            of years for a big tech company, but I was never truely excited
            about what I did. When I saw Shiny that changed! Shiny allowed a
            true beginner like me to make full blown apps and allowed me to
            creatively express myself with data in a way such that others could
            experience the power of data too! I could go from concept to
            prototype within a few days. When I started with Shiny in 2013 I
            literally knew nothing about making web apps. HTML, JavaScript and
            CSS where things I never heard about. &#128556; There were the first
            signs of reactive frameworks, but nothing like you see today. In
            that sense Shiny was extremely innovative and well ahead of its
            time.
          </v-card>
        </div>

        <v-card class="my-2 pa-4">
          My first steps were tinkering with existing shiny apps. Joe Cheng just
          completed his first Leaflet app, but many of the UI helper functions
          available today were not yet created. I had no clue how it worked, but
          it was awesome to see! Winston Chang created a mini-dashboard using
          Gridster, JustGage and Highcharts. It had an animated gauge and showed
          dynamic status updates in a cool looking widget, based on something
          called
          <span class="font-italic">JavaScript</span> &#128566;. I had no clue
          what that meant, but it looked super cool! I showed it to my boss and
          as a person with sales DNA he went through the roof. I quickly
          realized “I want to do this!”. D3 was emerging and also super cool,
          but was technically much more involved and was definitely out of reach
          for me at the time. Shiny, however, seemed something I could quickly
          understand. It gave me the confidence to continue. At that time I was
          not aware that Bootstrap was a 12 column grid system or that things
          were supposed to ‘add to 12’. I vividly remember walking to a ‘real’
          developer and asked what the point of a ‘div’ tag was. I said “Hey, I
          wrapped something in a div, but it doesn’t do anything”! Sadly, I was
          not aware of the connection with CSS. &#128528; The awesome
          interactivity in Leaflet and the JustGage example motivated me to
          learn more about JavaScript. The coolest app examples I found all had
          some JavaScript, so perhaps I needed to look into that more! My first
          break was finding the books by Jon Duckett:
          <span class="font-italic px-2">HTML & CSS</span> and
          <span class="font-italic px-2">JavaScript & jQuery</span>. [...to be
          completed]
        </v-card>

        <div class="d-flex justify-center ma-5">
          <img
            src="img/duckett1.jpg"
            height="100px"
            alt="duckett-html-css"
            class="mx-5"
          />
          <img
            src="img/duckett2.jpg"
            height="100px"
            alt="duckett-javascript-jQuery"
            class="mx-5"
          />
        </div>

        <!-- <p>Books</p>
        <p>
          Outstanding User Interfaces with Shiny,
          https://unleash-shiny.rinterface.com/index.html
        </p>

        <p>
          Engineering Production-Grade Shiny Apps,
          https://engineering-shiny.org/index.html
        </p>

        <p>JavaScript for R https://book.javascript-for-r.com/</p>

        <p>mastering shiny https://mastering-shiny.org/</p>

        <p>https://github.com/daattali/shinyjs</p>

        <p>https://www.htmlwidgets.org/</p>

        <p>https://shiny.rstudio.com/articles/js-build-widget.html</p> -->
      </div>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "narative",

  mounted() {
    const el = document.querySelector("#narrative-panel");

    const options = {
      className: "os-theme-round-light",
      scrollbars: { autoHide: "leave" },
    };

    this.scroller = OverlayScrollbars(el, options);
  },

  methods: {
    goto(id) {
      const target = "#ipsum" + id;

      this.$vuetify.goTo(target, { container: "#narrative-panel" });
    },
  },
};
</script>

<style scoped>
.title {
  color: #673ab7;
}

.panel {
  background-color: black;
  width: 100%;
  height: calc(100vh);
  padding-top: 48px;
}

#narrative-panel {
  height: 85vh;
  overflow: scroll;
}

.narrative-wrapper {
  width: 60vw;
  background-color: #202023;
}

.narrative-content .large {
  font-size: 1.1rem;
  line-height: 1.7rem;
}

.narrative-content > p {
  padding: 20px;
  margin: 20px;
  background-color: #242424;
  color: #c7c7c7;
  max-width: 50%;
}
</style>