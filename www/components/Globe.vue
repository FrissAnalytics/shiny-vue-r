<template>
  <div id="globe-panel">
    <!-- globe -->
    <div id="globe"></div>

    <!-- storyline -->
    <div id="storyline-wrapper">
      <storyline :items="storylines" />
    </div>

    <!-- timeline -->
    <div id="timeline-wrapper">
      <timeline />
    </div>

    <!-- globe controls right hand side-->
    <globe-controls
      id="globe-controls"
      @zoom-in="zoomIn"
      @zoom-out="zoomOut"
      @rotate="rotate"
    ></globe-controls>

    <!-- covid stats -->
    <div id="stats-wrapper">
      <covid-stats />
    </div>

    <!-- globe controls bottom panel -->
    <globe-bottom-nav />
  </div>
</template>

<script>
module.exports = {
  name: "globe",

  components: {
    storyline: httpVueLoader("components/Storyline.vue"),
    timeline: httpVueLoader("components/Timeline.vue"),
    "covid-stats": httpVueLoader("components/CovidStats.vue"),
    "globe-bottom-nav": httpVueLoader("components/GlobeBottomNav.vue"),
    "globe-controls": httpVueLoader("components/GlobeControls.vue"),
  },

  mounted() {
    this.createGlobe();

    this.setGlobeEventHandlers();

    this.setEventBusHandlers();
  },

  data() {
    return {
      rotating: false,
    };
  },

  computed: {
    storylines() {
      return this.$store.getters.storylines;
    },

    covid() {
      return this.$store.state.covid;
    },

    airports() {
      return this.$store.getters.airports;
    },

    geoData() {
      return this.$store.state.countries.features.map((d) => ({
        geometry: {
          type: d.geometry.type,
          coordinates: d.geometry.coordinates,
        },
        centroid: this.get_polygon_centroid(d),
        name: d.properties.NAME,
      }));
    },
  },

  methods: {
    createGlobe() {
      const transparent = "rgba(255,255,255,0)";

      this.el = document.getElementById("globe");

      const globe = Globe()
        .globeImageUrl("//unpkg.com/three-globe/example/img/earth-night.jpg")
        .backgroundColor(transparent)
        .showAtmosphere(false)
        .pointAltitude("size")
        .pointColor("color");

      this.globe = globe(this.el);

      this.globe.controls().autoRotateSpeed = 0.8;
    },

    clear() {
      const pointsData = [];
      const labelsData = [];
      this.setPointsData(pointsData);
      this.setLabelsData(labelsData);
    },

    setEventBusHandlers() {
      this.$bus.on("globe-show-airports", this.showAirports);
      this.$bus.on("globe-hide-airports", this.hideAirports);
      this.$bus.on("globe-clear-data", this.clear);
      this.$bus.on("globe-series-update", this.seriesUpdate);
    },

    seriesUpdate(val) {
      const option = [
        { series: "Active", color: "#FFB300", cutoff: 21962 },
        { series: "Deaths", color: "rgba(255,23,68,0.95)", cutoff: 2953 },
        { series: "Confirmed", color: "#00E5FF", cutoff: 125347 },
        { series: "Recovered", color: "#76FF03", cutoff: 62346 },
      ].find((d) => d.series == val);

      const { series, color, cutoff } = option;

      this.setMarkers(series, color, cutoff);
    },

    showAirports() {
      const pointsData = [...this.airports];

      this.setPointsData(pointsData, 4);
    },

    setPointsData(pointsData, pointResolution = 30) {
      this.globe
        .pointsData(pointsData)
        .pointAltitude((d) => d.pointAltitude)
        .pointColor((d) => d.pointColor)
        .pointLat((d) => d.pointLat)
        .pointLng((d) => d.pointLng)
        .pointRadius((d) => d.pointRadius)
        .pointResolution(pointResolution);
    },

    setLabelsData(labelsData, labelColor) {
      this.globe
        .labelsData(labelsData)
        .labelLat((d) => d.labelLat)
        .labelLng((d) => d.labelLng)
        .labelText((d) => d.labelText)
        .labelAltitude((d) => d.labelAltitude)
        .labelSize((d) => d.labelSize)
        .labelDotRadius((d) => d.labelDotRadius)
        .labelColor((d) => (labelColor ? labelColor : d.labelColor))
        .labelIncludeDot((d) => d.labelIncludeDot)
        .labelResolution(2);
    },

    get_polygon_centroid(d) {
      let coordinates = [0, 0];

      if (d.geometry.type == "Polygon") {
        coordinates = d.geometry.coordinates[0];
      }

      // find largest polygon
      if (d.geometry.type == "MultiPolygon") {
        let area_max = -1;

        d.geometry.coordinates.forEach((d) => {
          const area = d3.polygonArea(d[0]);

          if (area > area_max) {
            area_max = area;
            coordinates = d[0];
          }
        });
      }

      return d3.polygonCentroid(coordinates);
    },

    setPolygonsData(polygonsData) {
      this.globe
        .polygonsData(polygonsData)
        .polygonAltitude(0.005)
        .polygonCapColor(() => "rgba(33,150,243,0.01)")
        .polygonSideColor(() => "rgba(0,188,212, 0.015)")
        .polygonsTransitionDuration(0)
        .polygonStrokeColor(() => "rgba(101, 31, 255,0.4)")
        .onPolygonHover((hoverD) =>
          this.globe.polygonStrokeColor((d) =>
            d === hoverD ? "#FFC107" : "rgba(101, 31, 255,0.4))"
          )
        )
        .onPolygonClick((d) => {
          this.globe.pointOfView(
            { lat: d.centroid[1], lng: d.centroid[0], altitude: 0.75 },
            750
          );
        });
    },

    covidMarkers(type, color) {
      const max = d3.max(this.covid.map((d) => +d[type]));

      const s = d3
        .scalePow()
        .exponent(1 / 3)
        .domain([0, max])
        .range([0, 1.5]);

      const markers = this.covid
        .filter((d) => d[type] > 0)
        .map((d) => ({
          pointLat: +d.Lat,
          pointLng: +d.Long_,
          pointRadius: s(d[type]),
          pointColor: color,
          pointAltitude: 0.01,
          value: +d[type],
        }));

      return markers;
    },

    setMarkers(type = "Deaths", color = "rgba(255,23,68,0.95)", cutoff = 3000) {
      const markers = this.covidMarkers(type, color);

      const pointsData = [...markers];

      const labels = markers
        .filter((d) => +d.value > cutoff)
        .map((d) => ({
          labelAltitude: 0.011,
          labelSize: 0.25,
          labelDotRadius: 0.15,
          labelIncludeDot: false,
          labelColor: "#F8BBD0",
          labelText: (+d.value).toString(),
          labelLat: d.pointLat,
          labelLng: d.pointLng,
        }));

      const labelsData = [...labels];

      this.setLabelsData(labelsData, "grey");

      this.setPointsData(pointsData);
    },

    setGlobeEventHandlers() {
      // background click (not globe)
      d3.select("#globe").on("dblclick", () => this.resetView());

      // globe right click
      this.globe.onGlobeRightClick(this.logCameraPosition);

      // point left click
      this.globe.onPointClick((d) => {
        this.globe.pointOfView(
          { lat: d.pointLat, lng: d.pointLng, altitude: 0.75 },
          750
        );
      });

      // pointer hover
      this.globe.onPointHover((d) => {
        d
          ? (this.el.style.cursor = "pointer")
          : (this.el.style.cursor = "default");
      });
    },

    logCameraPosition() {
      const pos = this.globe.camera().position;
      console.log("camera position toGeoCoords", this.globe.toGeoCoords(pos));
    },

    viewGlobe(region, duration = 1000) {
      const view = this.views[region];
      console.log("viewGlobe", view);
      this.globe.pointOfView(view, view.duration ? view.duration : duration);
    },

    resetView() {
      this.globe.pointOfView(
        {
          altitude: 2.499999999999998,
          lat: 4.123756921679771,
          lng: -72.57432194324835,
        },
        750
      );
    },

    viewCity(view, duration = 1500) {
      this.globe.pointOfView(view, duration);
    },

    zoomIn() {
      const view = this.globe.toGeoCoords(this.globe.camera().position);
      view.altitude = 0.5 * view.altitude;
      this.globe.pointOfView(view, 750);
    },

    zoomOut() {
      const view = this.globe.toGeoCoords(this.globe.camera().position);
      view.altitude = 1.5 * view.altitude;
      this.globe.pointOfView(view, 750);
    },

    pauseAnimation() {
      this.globe.pauseAnimation();
    },

    resumeAnimation() {
      this.globe.resumeAnimation();
    },

    rotate() {
      this.rotating = !this.rotating;

      this.globe.controls().autoRotate = this.rotating;
    },
  },

  watch: {
    covid: {
      immediate: true,
      handler(val) {
        if (val.length > 0) {
          // globe needs a little bit of time during init
          setTimeout(this.setMarkers, 100);
        }
      },
    },

    geoData: {
      immediate: true,
      handler(val) {
        setTimeout((d) => this.setPolygonsData(val), 100);
      },
    },
  },
};
</script>

<style scoped>
#globeViz {
  z-index: 1;
}

#globe-panel {
  position: fixed;
  top: 0;
  left: 0;
  height: 100vh;
  width: 100vw;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background: rgb(45, 37, 37);
  background: radial-gradient(
    circle,
    rgba(20, 37, 37, 1) 0%,
    rgba(12, 13, 13, 1) 67%
  );
}

#globe-controls {
  position: absolute;
  right: 20px;
  z-index: 2;
  background-color: rgb(49, 46, 46);
  top: 50%;
  transform: translate(0, -50%);
}

#storyline-wrapper {
  position: absolute;
  top: 100px;
  left: 20px;
}

#timeline-wrapper {
  position: absolute;
  width: 100%;
  height: 150px;
  pointer-events: none;
  top: 80px;
  z-index: 2;
  color: white;
}

#stats-wrapper {
  position: absolute;
  width: 100%;
  height: 50px;
  top: 0;
  z-index: 3;
}
</style>