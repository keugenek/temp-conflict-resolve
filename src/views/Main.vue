<template>
  <div style="width: 100%">
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="Countdown"></mu-card-title>
        <mu-card-text>
          <Countdown
            :date="Math.trunc(Date.parse('November 11, 2022 15:30:00 UTC') / 1000)"
          >
            <h2>Congratulations!</h2>
          </Countdown>
        </mu-card-text>
      </mu-card>
    </mu-flex>
    <br/>
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="The Rings"></mu-card-title>
        <mu-card-text @mouseover="ringLit = canHover ? true:ringLit" @mouseleave="ringLit = canHover ? false:ringLit">
            <img
              @click="ringLit = !canHover ? !ringLit:ringLit"
              :src="ringLit ? require('@/assets/ring_overlay_night.png'):require('@/assets/ring_day.png')"
              width="100%" />
          <h3><span v-if="canHover">Hover</span><span v-else>Click</span> to see them glow</h3>
        </mu-card-text>
      </mu-card>
    </mu-flex>
  </div>
</template>

<script>
import Countdown from "../components/Countdown";

export default {
  components: {
    Countdown,
  },
  created() {},
  mounted() {
    // hover: hover matches on Android phones with Chrome, thus we can't use it for our purposes
    this.canHover = window.matchMedia('(pointer: fine)').matches;
  },
  data: function() {
    return {
      ringLit: false,
      canHover: false,
    };
  },
  methods: {
  },
};
</script>

<style scoped>
</style>
