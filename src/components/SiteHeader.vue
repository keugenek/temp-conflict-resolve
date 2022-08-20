<template>
  <div class="header">
    <div id="nav">
      <h2><router-link to="/" class="title">Katelyn Maes &hearts; Jacob McSwain</router-link></h2> |
      <router-link to="/rsvp">RSVP</router-link>
      <router-link to="/location">Location</router-link>
      <router-link to="/dresscode">Dress Code</router-link>
      <router-link to="/coc">Code of Conduct</router-link>
      <router-link to="/about">About Us</router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "SiteHeader",
};
</script>

<style scoped>
.title {
  font-weight: 900;
  font-size: xx-large;
}

.header {
  margin-top: 0;
  top: 0;
  left: 0;
  width: 100%;
  position: fixed;
  font-family: Mada, sans-serif;
  font-weight: bold;
  font-size: x-large;
  z-index: 1;
}

#nav {
  padding: 1em;
  background-color: rgba(28,37,65, 0.85);
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
}

#nav a {
  font-weight: bold;
  color: #477485;
  text-decoration: none;
  padding: 1em;
}

#nav a.router-link-exact-active {
  color: #00bbbd;
}
</style>
