<template>
  <div :id="id" class="control-panel">
    <v-btn
      x-small
      text
      color="pink"
      @click="close()"
      class="close-btn"
      v-show="showClose"
    >
      open
    </v-btn>

    <transition name="slide" v-on:after-leave="afterLeave">
      <v-sheet
        class="sheet text-center"
        color="rgb(33,35,39, 0.5)"
        v-show="sheet"
      >
        <div class="py-3 white--text wrapper">
          <v-btn
            x-small
            outlined
            color="indigo"
            class="mr-4 btn-wide"
            @click="handleAirports()"
          >
            <v-icon left v-show="showAirports" x-small color="pink"
              >mdi-record</v-icon
            >airports
          </v-btn>

          <v-btn
            x-small
            outlined
            color="indigo"
            class="mr-4 btn-wide"
            @click="handleArcs()"
          >
            <v-icon left v-show="showArcs" x-small color="pink"
              >mdi-record</v-icon
            >flights
          </v-btn>

          <v-btn-toggle
            v-model="series"
            tile
            color="deep-purple accent-3"
            group
            @change="$bus.emit('globe-series-update', series)"
          >
            <v-btn x-small value="Active">Active</v-btn>
            <v-btn x-small value="Confirmed">Confirmed</v-btn>
            <v-btn x-small value="Deaths">Deaths</v-btn>
            <v-btn x-small value="Recovered">Recovered</v-btn>
          </v-btn-toggle>

          <v-btn
            x-small
            outlined
            color="indigo"
            class="mr-4 btn-wide"
            @click="handleCovidMarkers()"
          >
            <v-icon left v-show="showCovidMarkers" x-small color="pink"
              >mdi-record</v-icon
            >covid markers
          </v-btn>

          <v-btn
            x-small
            outlined
            color="indigo"
            class="mr-4 btn-wide"
            @click="handleDailyMarkers()"
          >
            <v-icon left v-show="showDaily" x-small color="pink"
              >mdi-record</v-icon
            >daily markers
          </v-btn>

          <v-btn x-small outlined color="indigo" class="mr-4" @click="clear()"
            >clear</v-btn
          >

          <v-btn
            x-small
            outlined
            color="indigo"
            class="mr-4 btn-wide"
            @click="handleTimeline()"
          >
            <v-icon left v-show="showTimeline" x-small color="pink"
              >mdi-record</v-icon
            >timeline
          </v-btn>

          <v-btn
            x-small
            outlined
            color="indigo"
            class="mr-4 btn-wide"
            @click="handleGlobeAnnotation()"
          >
            <v-icon left v-show="showGlobeAnnotation" x-small color="pink"
              >mdi-record</v-icon
            >annotation
          </v-btn>

          <v-btn
            x-small
            text
            color="pink"
            @click="sheet = !sheet"
            class="close-btn"
          >
            close
          </v-btn>
        </div>
      </v-sheet>
    </transition>
  </div>
</template>


<script>
module.exports = {
  name: "globe-bottom-nav",
  props: ["id"],
  data() {
    return {
      sheet: true,
      showClose: false,
      city: "Amsterdam",
      showAirports: false,
      showGlobeAnnotation: false,
      showCovidMarkers: false,
      showArcs: false,
      showDaily: false,
      showTimeline: true,
      rotate: false,
      series: "Deaths",
    };
  },

  methods: {
    close() {
      this.sheet = true;
      this.showClose = false;
    },

    afterLeave() {
      setTimeout(() => {
        this.showClose = true;
      }, 100);
    },

    resetBtns() {
      this.showAirports = false;
      this.showCovidMarkers = false;
      this.showDaily = false;
    },

    clear() {
      this.resetBtns();
      this.$bus.emit("globe-clear-data");
    },

    handleView() {
      this.$bus.emit("view-globe", this.view);
    },

    handleArcs() {
      this.resetBtns();
      this.showArcs = !this.showArcs;
      this.$bus.emit(this.showArcs ? "globe-show-arcs" : "globe-hide-arcs");
    },

    handleCovidMarkers() {
      this.resetBtns();
      this.showCovidMarkers = !this.showCovidMarkers;
      this.$bus.emit("globe-covid-markers");
    },

    handleDailyMarkers() {
      this.resetBtns();
      this.showDaily = !this.showDaily;
      this.$bus.emit("globe-daily");
    },

    handleGlobeAnnotation() {
      this.showGlobeAnnotation = !this.showGlobeAnnotation;
      this.$store.commit("setShowGlobeAnnotation", this.showGlobeAnnotation);
    },

    handleAirports() {
      this.resetBtns();
      this.showAirports = !this.showAirports;

      this.$bus.emit(
        this.showAirports ? "globe-show-airports" : "globe-hide-airports"
      );
    },

    handleTimeline() {
      this.showTimeline = !this.showTimeline;
      this.$bus.emit("show-timeline-v", this.showTimeline);
    },
  },
};
</script>

<style scoped>
.selector {
  width: 150px;
  display: inline-block;
  margin: 0 10px;
}

.close-btn {
  position: absolute;
  top: 10px;
  right: 10px;
}

.open-btn {
  position: absolute;
  bottom: 10px;
  right: 10px;
}

.wrapper {
  position: relative;
}

.btn-wide {
  width: 130px;
}

.close-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  z-index: 10;
}

.open-btn {
  float: right;
}

.bottom-panel {
  position: absolute;
}

.slide-enter,
.slide-leave-to {
  transform: translateY(50px);
}

.slide-enter-active,
.slide-leave-active {
  transition: transform 0.2s ease-out;
}

.slide-enter-to,
.slide-leave {
  transform: translateY(0px);
}

.control-panel {
  height: 50px;
}
</style>