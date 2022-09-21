<template>
    <canvas id="confetti" ref="confetti"></canvas>
</template>

<script>
export default {
  name: "Confetti",
  data: function() {
    return {
      confetti: [],
      confettiCount: 500,
      gravity: 0.8,
      refillThreshold: 1,
      terminalVelocity: 4,
      drag: 0.075,
      minXSize: 10,
      maxXSize: 20,
      minYSize: 10,
      maxYSize: 30,
      minXVelocity: -25,
      maxXVelocity: 25,
      maxYVelocity: -45,
      colors: [
        { front: '#a864fd', back: '#7e18fc' },
        { front: '#29cdff', back: '#00a8dc' },
        { front: '#78ff44', back: '#45f700' },
        { front: '#ff718d', back: '#ff2550' },
        { front: '#fdff6a', back: '#fcff1e' },
        { front: '#ff80fe', back: '#ff34fd' },
        { front: '#ffa07a', back: '#ff692e' },
        { front: '#4169e1', back: '#1d44b8' },
      ],
    };
  },
  created() {
    window.addEventListener("resize", this.resizeHandler);
  },
  destroyed() {
    window.removeEventListener("resize", this.resizeHandler);
  },
  mounted() {
    this.resizeHandler();
    this.initConfetti();
    window.requestAnimationFrame(this.animate);
  },
  methods: {
    resizeHandler: function() {
      this.$refs.confetti.width = this.$refs.confetti.clientWidth;
      this.$refs.confetti.height = this.$refs.confetti.clientHeight;
    },
    randomRange: function(min, max) {
      return Math.random() * (max - min) + min;
    },
    randomRangeFloat: function(min, max, decimals) {
      const str = (Math.random() * (max - min) + min).toFixed(decimals);
      return parseFloat(str);
    },
    initConfetti: function() {
      for (let i = 0; i < (this.confettiCount-this.confetti.length); i++) {
        this.confetti.push({
          color: Math.floor(this.randomRange(0, this.colors.length)),
          dimensions: {
            x: this.randomRange(this.minXSize, this.maxXSize),
            y: this.randomRange(this.minYSize, this.maxYSize),
          },
          position: {
            x: this.randomRange(0, this.$refs.confetti.width),
            y: this.$refs.confetti.height - 1,
          },
          startingRotation: this.randomRange(0, 2 * Math.PI),
          rotation: this.randomRangeFloat(0.02, 0.1, 3),
          scale: {
            x: 1,
            y: 1,
          },
          velocity: {
            x: this.randomRange(this.minXVelocity, this.maxXVelocity),
            y: this.randomRange(0, this.maxYVelocity),
          },
        });
      }
    },
    animate: function() {
      const canvas = this.$refs.confetti;
      const ctx = canvas.getContext("2d");

      canvas.height = canvas.clientHeight;
      canvas.width = canvas.clientWidth;

      ctx.clearRect(0, 0, canvas.width, canvas.height);

      this.confetti.forEach((confetto, index) => {
        const width = (confetto.dimensions.x * confetto.scale.x);
        const height = (confetto.dimensions.y * confetto.scale.y);

        // Move canvas to position and rotate
        ctx.translate(confetto.position.x, confetto.position.y);
        ctx.rotate(confetto.startingRotation);

        // Apply forces to velocity
        confetto.velocity.x -= confetto.velocity.x * this.drag;
        confetto.velocity.y = Math.min(confetto.velocity.y + this.gravity, this.terminalVelocity);
        confetto.velocity.x += Math.random() > 0.5 ? Math.random() : -Math.random();

        // Set position
        confetto.position.x += confetto.velocity.x;
        confetto.position.y += confetto.velocity.y;

        // Delete confetti when out of frame
        if (confetto.position.y >= canvas.height) {
          this.confetti.splice(index, 1);
        } else if (confetto.position.x >= canvas.width) {
          this.confetti.splice(index, 1);
        } else if (confetto.position.x <= 0-confetto.dimensions.x) {
          this.confetti.splice(index, 1);
        }

        // Spin confetto by scaling y
        confetto.scale.y = Math.cos(confetto.position.y * confetto.rotation);
        ctx.fillStyle = confetto.scale.y > 0 ? this.colors[confetto.color].front : this.colors[confetto.color].back;

        // Draw confetti
        ctx.fillRect(-width / 2, -height / 2, width, height);

        // Reset transform matrix
        ctx.setTransform(1, 0, 0, 1, 0, 0);
      });

      // Fire off another round of confetti
      if (this.confetti.length <= this.refillThreshold) this.initConfetti();

      window.requestAnimationFrame(this.animate);
    },
  },
};
</script>

<style scoped>
#confetti {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  overflow: hidden;
  z-index: 100;
  width: 100%;
  height: 100%;
  pointer-events: none;
}
</style>
