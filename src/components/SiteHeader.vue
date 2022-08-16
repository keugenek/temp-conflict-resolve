<template>
  <div class="header">
    <h1>Katelyn Maes &hearts; Jacob McSwain</h1><br/>
    <h3 class="alert">This site is under construction. Some things may be broken.</h3>
    <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/rsvp">RSVP</router-link> |
      <router-link to="/location">Location</router-link> |
      <router-link to="/dresscode">Dress Code</router-link> |
      <router-link to="/coc">Code of Conduct</router-link> |
      <router-link to="/about">About Us</router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "SiteHeader",
};
</script>

<style>
#nav {
  padding: 1em;
}

#nav a {
  font-weight: bold;
  color: #c3c3c3;
  text-decoration: none;
}

#nav a.router-link-exact-active {
  color: #8ca5b9;
}
</style>
