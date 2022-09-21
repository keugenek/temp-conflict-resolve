<template>
  <span>
    <Starfield />
    <span v-if="this.time >= this.weddingDate">
      <Confetti />
    </span>
    <div id="application">
      <SiteHeader />
      <mu-container class="mu-container">
        <router-view />
      </mu-container>
      <SiteFooter />
    </div>
  </span>
</template>

<script>
import SiteHeader from "./components/SiteHeader";
import SiteFooter from "./components/SiteFooter";
import Starfield from "./effects/Starfield";
import Confetti from "./effects/Confetti";

export default {
  components: {
    SiteHeader,
    SiteFooter,
    Starfield,
    Confetti,
  },
  data: function() {
    return {
      weddingDate: Math.trunc(Date.parse('November 11, 2022 17:30:00 UTC')),
      time: new Date().getTime(),
    };
  },
  created() {
    setInterval(() => {
      this.time = new Date().getTime();
    }, 1000);
  },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css?family=Mada");
@import url("https://fonts.googleapis.com/css?family=Hind");
@import url("https://fonts.googleapis.com/css?family=Libre+Franklin");

#application {
  font-family: "Libre Franklin", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #bebebe;
  padding: 3em;
  padding-top: 5em;
  padding-bottom: 1em;
  margin-bottom: 0;
}

html {
  min-height: 100%;
  position: relative;
}

.alert {
  background-color: #b41f0e;
  color: #ddd;
  display: inline-block;
  padding: 1em;
  margin-bottom: 0;
}

h1,
h2,
h3,
h4,
h5,
h6 {
  display: inline-block;
  margin-top: 0;
  margin-bottom: 0;
  font-weight: 900;
}

h1 {
  font-size: 64pt;
}

h2 {
  font-size: 36pt;
}

h3 {
  font-size: 28pt;
}

h4 {
  font-size: 18pt;
}

h1,
h2 {
  font-family: Mada, sans-serif;
}

h3,
h4,
h5,
h6 {
  font-family: Hind, sans-serif;
}

body {
  background-color: #000;
  height: 100%;
}

a {
  color: #8daab8;
}

.mu-card {
  border-radius: 5px;
  background-color: rgba(58, 80, 107, 0.4) !important;
  backdrop-filter: blur(3px);
  -webkit-backdrop-filter: blur(3px);
}

.mu-card-title-container {
  background-color: rgba(40, 56, 73, 0.4) !important;
  border-radius: 5px;
  backdrop-filter: blur(3px);
  -webkit-backdrop-filter: blur(3px);
}

.mu-card-text > h1,
.mu-card-text > h2,
.mu-card-text > h3,
.mu-card-text > h4,
.mu-card-text > h5,
.mu-card-text > h6 {
  display: block;
  text-align: center;
}

.mu-container {
  margin-top: 6vh;
}

.mu-card {
  width: 100%;
}

p, li {
  font-size: 1.3em;
}

.mu-popover {
  margin-top: 2.5em;
  border-radius: 5px;
  background-color: rgba(28, 37, 65, 0.85) !important;
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
}

.router-link-exact-active,
.router-link-exact-active .mu-item {
  color: #00bbbd !important;
}

.mu-item {
  color: #bebebe !important;
}

@media (min-width: 1800px) {
  .container {
    max-width: 1710px;
  }
}

@media (max-width: 675px) {
  p, li {
    font-size: 1em;
  }

  h1 {
  font-size: 48pt;
  }

  h2 {
    font-size: 27pt;
  }

  h3 {
    font-size: 21pt;
  }

  h4 {
    font-size: 13.5pt;
  }
  .mu-container {
    margin-top: 3vh;
  }
}

@media (max-width: 500px) {
  h1 {
    font-size: 38pt;
  }

  h2 {
    font-size: 21pt;
  }

  h3 {
    font-size: 16.6pt;
  }

  h4 {
    font-size: 10.6pt;
  }
  .mu-container {
    margin-top: .5vh;
  }
}
</style>
