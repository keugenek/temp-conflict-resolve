<template>
  <mu-card raised style="width: 100%">
    <mu-card-title title="Location"></mu-card-title>
    <mu-card-text>
      <h2>
        We will be getting married on the 11th of November, 2022 at Crew
        Workspace in Downtown Oklahoma City.
      </h2>
      <div class="row">
        <div class="column">
          <img
            style="width: 100%"
            :src="require('@/assets/parking.png')"
            alt="Park South of Crew Workspace. Avoid the lot directly East of the entrance."
          />
        </div>
        <div class="column">
          <iframe
            style="width: 100%; height: 100%; border: 0"
            loading="lazy"
            allowfullscreen
            :src="
              'https://www.google.com/maps/embed/v1/place?q=' +
              'place_id:ChIJfXBPdBYXsocRP5bVyBYm8Dw&key=AIzaSyBb74A4xeZCuY1QpPIwKXFV1bTJw_6asYg'
            "
          >
          </iframe>
        </div>
      </div>
    </mu-card-text>
  </mu-card>
</template>

<script>
export default {
  components: {},
  created() {},
  data: function () {
    return {};
  },
  methods: {
    async getData() {},
  },
};
</script>

<style scoped>
.row {
  display: flex;
  padding: 3em;
}

.column {
  flex: 50%;
}
</style>
