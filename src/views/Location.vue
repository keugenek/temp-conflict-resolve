<template>
  <div style="width: 100%">
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="Location"></mu-card-title>
        <mu-card-text>
          <p>
            We will be getting married on the 11th of November, 2022 at Crew
            Workspace in Downtown Oklahoma City.
          </p>
          <iframe
                style="width: 100%; height: 80vh; border: 0"
                loading="lazy"
                allowfullscreen
                :src="
                  'https://www.google.com/maps/embed/v1/place?q=' +
                  'place_id:ChIJfXBPdBYXsocRP5bVyBYm8Dw&key=AIzaSyBb74A4xeZCuY1QpPIwKXFV1bTJw_6asYg'
                "
              >
              </iframe>
        </mu-card-text>
      </mu-card>
    </mu-flex>
    <br />
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="Parking"></mu-card-title>
        <mu-card-text>
          <img
                style="width: 100%"
                :src="require('@/assets/parking.png')"
                alt="Park South of Crew Workspace. Avoid the lot directly East of the entrance."
              />
          <p>Park South of Crew Workspace. Avoid the lot directly East of the entrance.</p>
        </mu-card-text>
      </mu-card>
    </mu-flex>
  </div>
</template>

<script>
export default {
  components: {},
  created() {},
  data: function() {
    return {};
  },
  methods: {
    async getData() {},
  },
};
</script>

<style scoped>
</style>
