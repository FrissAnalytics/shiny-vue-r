<template>
  <div>
    <div
      class="item-wrapper"
      :id="`item-${index}`"
      @click="$emit('click', index)"
    >
      <div class="item-top">
        <div class="date">{{ monthDay(item.date) }}</div>

        <div class="year" v-if="item.year">
          {{ item.year }}
        </div>
      </div>
      <div
        class="item-center"
        v-for="(l, k) in item.text"
        v-html="l"
        :key="k"
      ></div>
    </div>
  </div>
</template>

<script>
module.exports = {
  props: ["item", "index"],

  name: "storyline-item",

  methods: {
    monthDay: d3.timeFormat("%B %d"),
  },
};
</script>

<style  scoped>
.item-wrapper {
  border-left: 1px solid rgb(33, 35, 39, 1);
  padding-left: 14px;
  font-size: 11px;
}

.item-wrapper:hover {
  background: rgb(33, 35, 39, 0.5);
  cursor: pointer;
}

.date {
  background: rgb(33, 35, 39, 1);
  color: #f50057;
  padding: 0 10px;
}

.year {
  background: #36393d;
  color: #00bcd4;
  padding: 0 10px;
}

.item-top {
  margin: 10px 0;
  display: flex;
  justify-content: center;
}

.item-center {
  font-size: 12px;
  line-height: 1.5em;
  text-align: left;
  margin: 15px 0;
}
</style>