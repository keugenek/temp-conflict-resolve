<template>
  <div id="app">
    <canvas ref="constellations"></canvas>
    <SiteHeader />
    <router-view />
  </div>
</template>

<script>
import SiteHeader from "./components/SiteHeader";

export default {
  components: {
    SiteHeader,
  },
  data: function() {
    return {
      particles: [],
      maxParticles: 64,
      numGridX: 8,
      numGridY: 8,
    };
  },
  methods: {
    supportsWebp: async function() {
      if (!self.createImageBitmap) return false;

      const webpData =
        "data:image/webp;base64,UklGRh4AAABXRUJQVlA4TBEAAAAvAAAAAAfQ//73v/+BiOh/AAA=";
      const blob = await fetch(webpData).then((r) => r.blob());
      return createImageBitmap(blob).then(
        () => true,
        () => false,
      );
    },
    drawStar: function(context, x, y) {
      // Circle
      context.beginPath();
      context.lineWidth = 1;
      context.strokeStyle = "#cfaf4a";
      context.fillStyle = "#cfc54a";
      context.arc(x, y, 2, 0, 2 * Math.PI);
      context.fill();
      context.stroke();

      // Starburst
      context.beginPath();
      context.lineWidth = 1;
      context.moveTo(x, y);
      const maxStarburstLen = 3;
      context.lineTo(
        x + Math.floor(Math.random() * maxStarburstLen + 1),
        y + Math.floor(Math.random() * maxStarburstLen + 1),
      );
      context.lineTo(
        x - Math.floor(Math.random() * maxStarburstLen + 1),
        y - Math.floor(Math.random() * maxStarburstLen + 1),
      );
      context.moveTo(x, y);
      context.lineTo(
        x + Math.floor(Math.random() * maxStarburstLen + 1),
        y - Math.floor(Math.random() * maxStarburstLen + 1),
      );
      context.lineTo(
        x - Math.floor(Math.random() * maxStarburstLen + 1),
        y + Math.floor(Math.random() * maxStarburstLen + 1),
      );
      context.fill();
      context.stroke();
    },
    checkPoint: function(point) {
      // Check the point to ensure it doesn't occupy
      // the same grid square bounds as another point
      if (this.squareOccupied(point.square)) {
        return false;
      }
      return true;
    },
    fillParticles: function(canvas) {
      while (this.particles.length < this.maxParticles) {
        const point = {
          x: Math.floor(Math.floor(Math.random() * canvas.width)),
          y: Math.floor(Math.floor(Math.random() * canvas.height)),
          timer: Math.floor(Math.random() * (88 - 29) + 29 + 1), // ~3secs per star
          delay: Math.floor(Math.random() * 88), // 0-3s delay to visibility
          square: { x: 0, y: 0 }, // filled in a moment
        };
        point.square = this.getSquare(point, canvas);
        if (this.checkPoint(point, canvas)) {
          this.particles.push(point);
        }
      }
    },
    squareOccupied: function(square) {
      for (const particle of this.particles) {
        if (particle.square.x == square.x && particle.square.y == square.y) {
          return true;
        }
      }
    },
    getSquare: function(point, canvas) {
      // Divide into grid
      const widthOfSquare = Math.floor(canvas.width / this.numGridX);
      const heightOfSquare = Math.floor(canvas.height / this.numGridY);

      // For each grid square, check if x and y are greater than
      // widthOfSquare*squareIndex AND less than widthOfSquare*squareIndex+widthOfSquare
      // If so, return this grid square
      for (let x = 0; x < this.numGridX; x++) {
        for (let y = 0; y < this.numGridY; y++) {
          if (
            point.x >= widthOfSquare * x &&
            point.y >= heightOfSquare * y &&
            point.x < widthOfSquare * x + widthOfSquare &&
            point.y < heightOfSquare * y + heightOfSquare
          ) {
            return { x, y };
          }
        }
      }
      return { x: 0, y: 0 };
    },
    animate: function() {
      const canvas = this.$refs.constellations;
      const context = canvas.getContext("2d");

      canvas.height = canvas.parentNode.parentNode.parentNode.clientHeight;
      canvas.width = canvas.parentNode.parentNode.parentNode.clientWidth;

      context.fillStyle = "#060a17";
      context.fillRect(0, 0, canvas.width, canvas.height);

      // const widthOfSquare = Math.floor(canvas.width / this.numGridX);
      // const heightOfSquare = Math.floor(canvas.height / this.numGridY);

      // for (let x = 0; x < this.numGridX; x++) {
      //   context.strokeStyle = "white";
      //   context.moveTo(widthOfSquare * x, 0);
      //   context.lineTo(widthOfSquare * x, canvas.height);
      //   context.stroke();
      //   context.fill();
      // }

      // for (let y = 0; y < this.numGridY; y++) {
      //   context.strokeStyle = "white";
      //   context.moveTo(0, heightOfSquare * y);
      //   context.lineTo(canvas.width, heightOfSquare * y);
      //   context.stroke();
      //   context.fill();
      // }

      if (this.particles.length > this.maxParticles) {
        this.particles = this.particles.slice(0, this.maxParticles);
      } else {
        this.fillParticles(canvas);
      }

      const newParticles = [];
      for (let i = 0; i < this.particles.length; i++) {
        this.particles[i].delay = this.particles[i].delay - 1;
        if (this.particles[i].delay <= 0) {
          this.particles[i].delay = 0; // Prevent unbound negatives
          this.particles[i].timer = this.particles[i].timer - 1;
          if (this.particles[i].timer > 0) {
            this.drawStar(context, this.particles[i].x, this.particles[i].y);
            newParticles.push(this.particles[i]);
          }
        }
      }
      this.particles = newParticles;

      setTimeout(() => {
        window.requestAnimationFrame(this.animate);
      }, 34); // Roughly 60"f"ps
    },
  },
  mounted() {
    this.supportsWebp().then((supportsWebp) => {
      document.body.classList.add(supportsWebp ? "webp" : "no-webp");
    });
    this.animate();
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #bebebe;
}

.alert {
  background-color: #b41f0e;
  color: #ddd;
  display: inline-block;
  padding: 1em;
  margin-bottom: 0px;
}

h1,
h2,
h3,
h4,
h5,
h6 {
  display: inline-block;
  margin-bottom: 0px;
}

body {
  background-color: #000;
  margin: 0;
  padding: 0;
}

canvas {
  position: absolute;
  left: 0;
  top: 0;
  z-index: -1;
}

p {
  font-size: 1.3em;
}

a {
  color: #8daab8;
}
</style>
