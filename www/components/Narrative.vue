<template>
  <div class="panel">
    <v-btn x-small class="ml-2" @click="goto(5)">5</v-btn>

    <v-btn x-small class="ml-2" @click="goto(10)">10</v-btn>

    <v-btn x-small class="ml-2" @click="goto(20)">20</v-btn>

    <div id="narrative-panel" class="mx-auto px-3 narrative-content">
      <p class="text-h3 text-center">Becoming a front-end developer</p>

      <v-timeline>
        <v-timeline-item
          v-for="(item, i) in storylines"
          :key="i"
          color="#4c00ff"
          small
        >
          <v-card class="elevation-2" slot="opposite">
            <div class="d-flex justify-space-around pa-5">
              <img src="img/superzip-example.png" height="250px" alt="" />
            </div>
          </v-card>

          <v-card class="elevation-2">
            <v-card-title v-if="item.headline" class="headline"
              >Introduction</v-card-title
            >
            <v-card-text class="large" v-html="item.text"> </v-card-text>
          </v-card>
        </v-timeline-item>
      </v-timeline>
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "narative",

  methods: {
    goto(id) {
      const target = "#ipsum" + id;

      this.$vuetify.goTo(target, { container: "#narrative-panel" });
    },
  },

  data() {
    return {
      storylines: [
        {
          headline: "Introduction",
          text: `<p>
                Today I work as a front-end developer and love making webapps!
                Before Shiny came along I had no clue what I wanted to do
                carreer wise. I finished university, worked a number of years
                for a big tech company, but I was never truely excited about
                what I did.
              </p>
              <p>
                When I saw Shiny that changed! It allowed a true beginner like
                me to make full blown apps and allowed me to express myself
                creatively with data in a way such that others could experience
                the power of data too. I could go from concept to prototype
                within a few days.
              </p>
              <p>
                Becoming a front-end developer has been one of the best
                experiences for me, for which I’m extremely thankful to the
                RSTUDIO team and the incredible work of Joe Cheng and others.
                Shiny is an unbelievably powerful way of building apps. It’s
                super intuitive and so easy that almost anyone can make an
                interactive web app!
              </p>`,
        },

        {
          text: `<p>
          When I started with Shiny in 2013 I literally knew nothing about
          making apps. HTML, JavaScript and CSS where things I never heard
          about. It was around the same time that d3 and twitter bootstrap
          became big. There were the first signs of reactive frameworks, but
          nothing like you see today. In that sense Shiny was extremely
          innovative and ahead of its time. Modern JavaScript was not yet born
          (ES6) and internet explorer was still king.
        </p>
        <p>
          My first steps were tinkering with existing shiny apps. Joe Cheng had
          his first version of an app with Leaflet ready, but many of the UI
          helper functions available today were not there yet. I had no clue how
          it worked, but it was awesome to see!
          
          Winston Chang also had a mini-dashboard, which used Gridster, 
          Gridster, JustGage and Highcharts
          
          These use something called an OutputBinding. 
          <a href="https://github.com/wch/shiny-jsdemo">shiny-jsdemo</a>
          
          
          It also has an animated gauge
          and some dynamic text, which was based on something called JavaScript.
          I had no clue what that meant, but it looked super cool. I showed it
          to my boss and as a person with sales DNA he went through the roof. I
          quickly realized “I want to do this!”. D3 was cool, but out of range,
          but Shiny seemed something even I could understand. It gave me the
          confidence to continue.

          https://vuejs.org/v2/guide/single-file-components.html
        </p>`,
        },

        {
          text: `<p>
          At that time I was not aware that Bootstrap was a 12 column grid
          system and the idea that things were supposed to ‘add to 12’. I
          vividly remember walking to a ‘real’ developer and asked what the
          point of a ‘div’ tag was. I said “Hey, I wrapped something in a div,
          but it doesn’t do anything”! Sadly, I did not realize the connection
          with CSS. Heck, CSS was yet another thing I was not even realizing was
          a thing!
        </p>
        <p>
          Slowly but surely I was making progress by re-mixing examples. Some
          things I copied I understood, but others like the code for the
          JavaScript bindings did not make any sense to me at the time. What the
          heck was ‘$el’? I made every silly mistake you can make and many
          terrible layouts or things that by mistake still worked.
        </p>
        <p>
          The interactivity in Leaflet and the just gauge example motivated me
          to learning more about JavaScript. The coolest app examples I found
          all had some JavaScript, so perhaps I needed to look into that more!
        </p>`,
        },

        {
          text: `<p>
          Today the number of books and YouTube videos is massive and high
          quality materials on R and Shiny exist, but at the time almost no
          resources were available other than a few examples on the RSTUDIO
          website. D3 was still extremely cool and had lots of examples, but
          many seemed totally incomprehensible to me, so for the moment I gave
          up on that.
        </p>`,
        },
      ],
    };
  },
};
</script>

<style scoped>
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

.narrative-content {
  width: 80vw;
  background-color: rgb(41, 39, 39);
}

.narrative-content .large {
  font-size: 1.1rem;
  line-height: 1.7rem;
}
</style>