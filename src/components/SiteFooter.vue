<template>
  <div class="footer">
    <h4>Copyright &copy; 2022 - Jacob McSwain</h4>
  </div>
</template>

<script>
export default {
  name: "SiteFooter",
};
</script>

<style scoped>
.footer {
  text-align: center;
  display: block;
  font-family: Mada, sans-serif;
  font-weight: bold;
  font-size: large;
  padding: 1em;
  padding-bottom: 0;
  margin-bottom: 0;
}

.footer h4 {
  background-color: rgba(28,37,65, 0);
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);

}
</style>
