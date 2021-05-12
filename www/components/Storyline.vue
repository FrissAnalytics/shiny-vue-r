<template>
  <div>
    <div id="storylines">
      <div v-for="(item, index) in storylines" :key="index">
        <storyline-item :item="item" :index="index" @click="goto" />
      </div>

      <div class="end"></div>
    </div>

    <div class="mt-1 d-flex justify-space-around">
      <v-btn icon color="indigo" @click="start"
        ><v-icon small>fa-angle-double-left</v-icon></v-btn
      >

      <v-btn icon color="indigo" @click="down"
        ><v-icon small>fa-angle-left</v-icon></v-btn
      >

      <v-btn icon color="indigo" @click="up"
        ><v-icon small>fa-angle-right</v-icon></v-btn
      >

      <v-btn icon color="indigo" @click="end"
        ><v-icon small>fa-angle-double-right</v-icon></v-btn
      >

      <v-btn icon color="#00bcd4" :class="{ flip: reversed }" @click="reverse">
        <v-icon x-small>mdi-arrow-expand-down</v-icon></v-btn
      >
    </div>
  </div>
</template>

<script>
module.exports = {
  name: "storyline",

  components: {
    "storyline-item": httpVueLoader("components/StorylineItem.vue"),
  },

  props: ["items"],

  mounted() {
    // bus
    this.$bus.on("show-storyline", (val) => (this.show = val));

    //this.$bus.on("timeline-click", this.timelineClick);

    // overlay scrolller
    const el = document.querySelector("#storylines");

    const options = {
      className: "os-theme-round-light",
      scrollbars: { autoHide: "leave" },
    };

    this.scroller = OverlayScrollbars(el, options);
  },

  data() {
    return {
      index: 0,
      reversed: true,
      storylines: this.items,
    };
  },

  methods: {
    timelineClick(date) {
      if (this.multi) {
        this.gotoDate(date);
      } else {
        this.index = this.findIndex(date);
      }
    },

    timelineMove(date) {
      if (!this.multi) {
        this.index = this.findIndex(date);
      }
    },

    findIndex(date) {
      // what is the closest date in dates?
      // for more info on bisect, see https://observablehq.com/@d3/d3-bisect
      const index = d3.bisect(this.dates, date);

      return index;
    },

    itemClick(item, i) {
      this.$bus.emit("storyline-click", { date: item.date });

      this.goto(i, 250);
    },

    gotoDate(date) {
      const index = this.findIndex(date);

      this.goto(index, 250);
    },

    goto(index, duration = 700) {
      const el = document.getElementById("item-" + index);

      // see https://easings.net/ for available easings
      this.scroller.scroll(el, duration, "easeInOutCubic", () => {});

      this.index = index;
    },

    up() {
      if (this.index < this.items.length - 2) {
        this.index = this.index + 1;
      }

      this.goto(this.index);
    },

    down() {
      if (this.index > 1) {
        this.index = this.index - 1;
      }

      this.goto(this.index);
    },

    start() {
      this.index = 0;

      this.goto(this.index);
    },

    end() {
      this.index = this.items.length - 1;

      this.goto(this.index);
    },

    reverse() {
      this.reversed = !this.reversed;
      this.storylines = this.storylines.slice().reverse();
    },
  },
};
</script>

<style scoped>
#storylines {
  width: 360px;
  height: 700px;
  overflow: scroll;
  padding-right: 20px;
}

.flip {
  transform: rotate(180deg);
}

.end {
  height: 1000px;
}
</style>