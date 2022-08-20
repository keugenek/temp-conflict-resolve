<template>
  <div>
    <div class="card">
      <div class="header">
        <h2>Countdown</h2>
      </div>
      <div class="content">
        <Countdown :date="Math.trunc(Date.parse('November 11, 2022 15:30:00 UTC') / 1000)">
          <h2>Congratulations!</h2>
        </Countdown>
      </div>
    </div>
  </div>
</template>

<script>
import Countdown from "../components/Countdown";

export default {
  components: {
    Countdown,
  },
  created() {},
  data: function() {
    return {};
  },
  methods: {
    async getData() {},
  },
};
</script>

<style scoped>
</style>
