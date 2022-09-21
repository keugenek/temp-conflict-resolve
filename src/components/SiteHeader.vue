<template>
  <div class="header">
    <h2 style="height: 100%">
      <router-link v-if="this.weddingDate > this.time" to="/" class="title"
        >Katelyn Maes &hearts; Jacob McSwain</router-link
      >
      <router-link v-else to="/" class="title"
        >Katelyn McSwain &hearts; Jacob McSwain</router-link
      >
    </h2>
    <span class="separator">|</span>
    <mu-menu cover v-if="dropdownMenu">
      <mu-icon class="hamburger" size="36" value="menu"></mu-icon>
      <mu-list slot="content">
        <mu-list-item :ripple="false" class="nav" to="/rsvp">
          <mu-list-item-title>RSVP</mu-list-item-title>
        </mu-list-item>
        <mu-list-item :ripple="false" class="nav" to="/location">
          <mu-list-item-title>Location</mu-list-item-title>
        </mu-list-item>
        <mu-list-item :ripple="false" class="nav" to="/dresscode">
          <mu-list-item-title>Dress Code</mu-list-item-title>
        </mu-list-item>
        <mu-list-item :ripple="false" class="nav" to="/coc">
          <mu-list-item-title>Code of Conduct</mu-list-item-title>
        </mu-list-item>
        <mu-list-item :ripple="false" class="nav" to="/about">
          <mu-list-item-title>About Us</mu-list-item-title>
        </mu-list-item>
      </mu-list>
    </mu-menu>
    <span v-else>
      <router-link class="nav" to="/rsvp">RSVP</router-link>
      <router-link class="nav" to="/location">Location</router-link>
      <router-link class="nav" to="/dresscode">Dress Code</router-link>
      <router-link class="nav" to="/coc">Code of Conduct</router-link>
      <router-link class="nav" to="/about">About Us</router-link>
    </span>
  </div>
</template>

<script>
export default {
  name: "SiteHeader",
  data: function() {
    return {
      dropdownMenu: false,
      weddingDate: Math.trunc(Date.parse('November 11, 2022 17:30:00 UTC')),
      time: new Date().getTime(),
    };
  },
  created() {
    setInterval(() => {
      this.time = new Date().getTime();
    }, 1000);
  },
  mounted() {
    this.updateDropdown();
    window.addEventListener('resize', this.updateDropdown);
  },
  methods: {
    updateDropdown: function() {
      this.dropdownMenu = window.matchMedia('(max-width: 1233px)').matches;
    },
  },
};
</script>

<style scoped>
.title {
  font-size: 0.75em;
  height: 100%;
}

.mu-menu {
  margin-left: auto;
  margin-top: .5em;
}

.hamburger {
  display: none;
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

@media (max-width: 420px) {
  .title {
    font-size: 0.6em;
  }
}
</style>
