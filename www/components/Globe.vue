<template>
  <div id="globeViz"></div>
</template>

<script>
module.exports = {
  name: "globe",

  mounted() {
    const transparent = "rgba(255,255,255,0)";

    this.el = document.getElementById("globeViz");

    const globe = Globe()
      .globeImageUrl("//unpkg.com/three-globe/example/img/earth-night.jpg")
      .backgroundColor(transparent)
      .showAtmosphere(false)
      .pointAltitude("size")
      .pointColor("color");

    this.globe = globe(this.el);

    this.setGlobeEventHandlers();
  },

  computed: {
    covid() {
      return this.$store.state.covid;
    },
  },

  methods: {
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

    setLabelsData(labelsData) {
      this.globe
        .labelsData(labelsData)
        .labelLat((d) => d.labelLat)
        .labelLng((d) => d.labelLng)
        .labelText((d) => d.labelText)
        .labelAltitude((d) => d.labelAltitude)
        .labelSize((d) => d.labelSize)
        .labelDotRadius((d) => d.labelDotRadius)
        .labelColor((d) => d.labelColor)
        .labelIncludeDot((d) => d.labelIncludeDot)
        .labelResolution(2);
    },

    getHopkinsDaily() {
      const max = d3.max(this.covid.map((d) => +d.Deaths));

      const s = d3
        .scalePow()
        .exponent(1 / 3)
        .domain([0, max])
        .range([0, 1.5]);

      const pointsDataDaily = this.covid
        .filter((d) => d.Deaths > 0)
        .map((d) => ({
          pointLat: +d.Lat,
          pointLng: +d.Long_,
          pointRadius: s(d.Deaths),
          pointColor: "rgba(255,23,68,0.95)",
          pointAltitude: 0.01,
          value: +d.Deaths,
        }));

      return pointsDataDaily;
    },

    setMarkers() {
      const pointsDataDaily = this.getHopkinsDaily();
      const pointsData = [...pointsDataDaily];

      const labels = pointsDataDaily
        .filter((d) => +d.value > 3000)
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

      this.setLabelsData(labelsData);

      this.setPointsData(pointsData);
    },

    setGlobeEventHandlers() {
      // background click (not globe)
      d3.select("#globeViz").on("dblclick", () => this.resetView());

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
  },
};
</script>

<style scoped>
#globeViz {
  position: relative;
  opacity: 1;
  background: rgb(45, 37, 37);
  background: radial-gradient(
    circle,
    rgba(20, 37, 37, 1) 0%,
    rgba(12, 13, 13, 1) 67%
  );
  margin: 0;
  padding: 0;
}
</style>