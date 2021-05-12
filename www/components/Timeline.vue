<template>
  <div id="timeline">
    <div id="bars"></div>
  </div>
</template>

<script>
module.exports = {
  name: "timeline",

  computed: {
    annotations() {
      return this.$store.state.annotations;
    },

    totalCasesTimeline() {
      return this.$store.state.totalTimeline;
    },
  },

  mounted() {
    this.$bus.on("timeline-v-click", this.showDate);

    this.$bus.on("show-timeline-v", (val) => (this.show = val));
  },

  methods: {
    showDate(val) {
      console.log("bars:", val);
    },

    createChart() {
      // note in some d3 functions the 'this' context is changed
      // so we keep a reference to the vue instance in vm (see below)
      // hence inside d3 functions we can still access the vue instance via vm instead of this
      // for an extensive tutorial on the meaning of 'this' in javascript google kyle simpson ydkjs

      const vm = this;

      // parse time string into date
      const parser = d3.timeParse("%Y-%m-%d");

      // format a date
      const format = d3.timeFormat("%A %B %d, %Y");

      // get cases and dates
      const cases = this.totalCasesTimeline;
      const dates = cases.map((d) => parser(d.date));

      // compute chart dimensions
      // see https://observablehq.com/@d3/margin-convention
      const width_outer = document.querySelector("#bars").offsetWidth;
      const height_outer = 120;
      const margin = { top: 20, bottom: 20, left: 30, right: 30 };
      const height = height_outer - margin.top - margin.bottom;
      const width = width_outer - margin.left - margin.right;

      // main svg
      const svg = d3
        .select("#bars")
        .append("svg")
        .attr("width", width_outer)
        .attr("height", height_outer)
        .append("g")
        .attr("transform", `translate(${margin.left},${margin.top})`);

      // svg rect used to capture mouse events
      // see https://www.datamake.io/blog/d3-zoom by lars verspohl
      const listener_rect = svg
        .append("rect")
        .classed("listener-rect", true)
        .attr("width", width)
        .attr("height", height)
        .style("fill", "none")
        .style("pointer-events", "all");

      // create x-scale
      const start = parser("2019-12-30");

      // end date
      const end = d3.max(dates);

      // x-scale
      const x = d3.scaleTime().domain([start, end]).range([0, width]);

      // x-axis
      const gx = svg
        .append("g")
        .classed("xAxis", true)
        .attr("transform", `translate(0,${height})`);

      const tick_format = "%b-%Y";

      const axisX = d3.axisBottom(x).tickFormat(d3.timeFormat(tick_format));

      gx.call(axisX);

      // style x-axis
      gx.selectAll(".domain, line").style("stroke", "#E91E63");

      gx.selectAll("text").style("fill", "#BDBDBD");

      // y-scale
      const y = d3
        .scaleLinear()
        .domain([0, d3.max(cases.map((d) => +d.deaths))])
        .range([height, 0])
        .nice();

      // y-axis
      const gy = svg
        .append("g")
        .classed("yAxis", true)
        .attr("transform", `translate(${width},0)`);

      const axisY = d3
        .axisRight(y)
        .ticks(5)
        .tickSizeOuter(0)
        .tickFormat(d3.format("~s"));

      gy.call(axisY);

      // style y-axis
      gy.selectAll(".domain, line").style("stroke", "#424242");

      gy.selectAll("text").style("fill", "#757575");

      // create vertical bars representing daily counts
      const bars = svg
        .append("g")
        .classed("g-bar", true)
        .selectAll(".bars")
        .data(cases)
        .join("line")
        .classed("bar-line", true)
        .style("stroke", "rgba(101, 31, 255, 1)")
        .style("stroke-width", 2)
        .style("pointer-events", "none")
        .attr("x1", (d) => x(parser(d.date)))
        .attr("x2", (d) => x(parser(d.date)))
        .attr("y2", (d) => height)
        .attr("y1", (d) => height)
        .transition()
        .delay((d, i) => i * 1)
        .attr("y1", (d) =>
          y(+d.deaths) < height - 2 ? y(+d.deaths) : height - 2
        );

      // create plot annotations
      const ga = svg.append("g").classed("annotation", true);

      const start_height = 5;

      ga.selectAll(".annotation")
        .data(this.annotations)
        .join("line")
        .attr("x1", (d) => x(parser(d.date)))
        .attr("x2", (d) => x(parser(d.date)))
        .attr("y1", height)
        .attr("y2", height)
        .style("stroke", "#BDBDBD")
        .style("stroke-width", 1)
        .style("pointer-events", "none")
        .transition()
        .attr("y1", (d, i) => (d.h ? d.h : start_height + i * 10));

      ga.selectAll(".annotation-text")
        .data(this.annotations)
        .join("text")
        .style("font", "10px sans-serif")
        .style("fill", (d) => (d.color ? d.color : "#BDBDBD"))
        .attr("x", (d) => x(parser(d.date)) - 3)
        .attr("y", (d, i) => (d.h ? d.h - 5 : start_height - 5 + i * 10))
        .style("text-anchor", (d) => (d.ta ? d.ta : "left"))
        .text((d) => d.text);

      // create legend
      const legend = d3
        .select("#bars")
        .append("div")
        .style("position", "absolute")
        .style("top", height)
        .style("left", "20px")
        .style("font", "10px sans-serif")
        .style("color", "#BDBDBD");

      // add mouse hover line + hover text
      const hover_text = svg
        .append("text")
        .attr("y", -10)
        .attr("text-anchor", "middle")
        .style("font-size", "10px")
        .style("fill", "#EEE");

      const bar = svg
        .append("line")
        .classed("hover-bar", true)
        .style("pointer-events", "none")
        .attr("style", "stroke:#EEE; stroke-width:1; stroke-dasharray: 2 2;")
        .attr("y2", height);

      const marker = svg
        .append("rect")
        .style("pointer-events", "none")
        .attr("width", 4)
        .attr("height", 4)
        .attr("fill", "#EEE")
        .attr("stroke", "#EEE");

      // handle mouse move
      svg.select(".listener-rect").on("mousemove", function (event) {
        // get current mouse coordinates relative to base svg
        const m = d3.pointer(event, this);

        // find nearest data point
        // for more info on bisect, see https://observablehq.com/@d3/d3-bisect
        const i = d3.bisectLeft(dates, x.invert(m[0]));

        vm.$bus.emit("timeline-move", x.invert(m[0]));

        legend.text(`date: ${cases[i].date}, deaths: ${cases[i].deaths}`);

        // move hover line
        bar.attr("x1", x(dates[i])).attr("x2", x(dates[i])).style("opacity", 1);

        marker.attr("x", x(dates[i]) - 2).attr("y", y(+cases[i].deaths) - 2);

        bar.style("opacity", 1);
        marker.style("opacity", 1);
        legend.style("opacity", 1);

        // hover text
        hover_text.attr("x", x(dates[i])).text(format(dates[i]));
      });

      // handle mouse left click
      svg.select(".listener-rect").on("click", function (event) {
        // get x, y position of the mouse relative to its container
        const pos = d3.pointer(event, this);

        // convert x position to a date using the x scale
        const date = x.invert(pos[0]);

        vm.$bus.emit("timeline-click", date);
      });
    },
  },

  watch: {
    // see also https://vuejs.org/v2/guide/reactivity.html
    totalCasesTimeline: {
      immediate: true,
      handler(val) {
        // we use next tick to make sure the container div (#bars) exists
        // and is mounted in the DOM so d3 can get it.
        // see https://vuejsdevelopers.com/2019/01/22/vue-what-is-next-tick/
        // see https://vuejs.org/v2/api/#Vue-nextTick
        console.log("timeline watch");

        if (this.$route.path != "/globe") return;
        this.$nextTick(this.createChart);
      },
    },
  },
};
</script>

<style  scoped>
#bars {
  position: absolute;
  top: 0px;
  right: 50px;
  height: 120px;
  width: 75%;
  color: white;
  pointer-events: all;
}

svg {
  pointer-events: all;
}
</style>