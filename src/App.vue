<template>
  <div id="app">
    <Header />
    <router-view />
  </div>
</template>

<script>
import Header from "./components/Header";

export default {
  components: {
    Header,
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
  },
  mounted() {
    this.supportsWebp().then((supportsWebp) => {
      document.body.classList.add(supportsWebp ? "webp" : "no-webp");
    });
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

h1, h2, h3, h4, h5, h6 {
  display: inline-block;
  margin-bottom: 0px;
}

body {
  background-color: #000;
}

p {
  font-size: 1.3em;
}

a {
  color: #8daab8;
}
</style>
