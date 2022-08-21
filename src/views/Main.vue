<template>
  <mu-card raised style="width: 100%">
    <mu-card-title title="Countdown"></mu-card-title>
    <mu-card-text>
      <Countdown
        :date="Math.trunc(Date.parse('November 11, 2022 15:30:00 UTC') / 1000)"
      >
        <h2>Congratulations!</h2>
      </Countdown>
    </mu-card-text>
  </mu-card>
</template>

<script>
import Countdown from "../components/Countdown";

export default {
  components: {
    Countdown,
  },
  created() {},
  data: function () {
    return {};
  },
  methods: {
    async getData() {},
  },
};
</script>

<style scoped>
</style>
