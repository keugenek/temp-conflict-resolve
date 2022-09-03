<template>
  <div class="header">
    <h2 style="height: 100%">
      <router-link to="/" class="title"
        >Katelyn Maes &hearts; Jacob McSwain</router-link
      >
    </h2>
    <span class="separator">|</span>
    <router-link class="nav" to="/rsvp">RSVP</router-link>
    <router-link class="nav" to="/location">Location</router-link>
    <router-link class="nav" to="/dresscode">Dress Code</router-link>
    <router-link class="nav" to="/coc">Code of Conduct</router-link>
    <router-link class="nav" to="/about">About Us</router-link>
    <span class="hamburger"><mu-icon size="36" value="menu"></mu-icon></span>
  </div>
</template>

<script>
export default {
  name: "SiteHeader",
};
</script>

<style scoped>
.title {
  font-size: 0.75em;
  height: 100%;
}

.hamburger {
  display: none;
  margin-left: auto;
  margin-top: .5em;
}

.header {
  top: 0;
  left: 0;
  width: 100%;
  min-height: 10vh;
  max-height: 10vh;
  position: fixed;
  font-family: Mada, sans-serif;
  font-weight: bold;
  font-size: 1.5em;
  z-index: 1;
  padding: .75em;
  background-color: rgba(28, 37, 65, 0.85);
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
  display: flex;
  align-items: center;
}

.header a,
.header .separator {
  padding: .75em;
  margin-top: .25em;
}

.header a {
  font-weight: bold;
  color: #477485;
  text-decoration: none;
}

.header a.router-link-exact-active {
  color: #00bbbd;
}

@media (max-width: 1233px) {
  .header .nav,
  .separator {
    display: none;
  }
  .hamburger {
    display: initial;
  }
}

@media (max-width: 675px) {
  .header {
    min-height: 8vh;
    max-height: 8vh;
  }
}

@media (max-width: 500px) {
  .header {
    min-height: 6vh;
    max-height: 6vh;
  }
}

@media (max-width: 320px) {
  .title {
    font-size: 0.6em;
  }
}
</style>
