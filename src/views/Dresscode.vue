<template>
  <div style="width: 100%">
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="Wedding Color Theme"></mu-card-title>
        <mu-card-text>
          <ul>
            <li class="white">White</li>
            <li class="navy">Navy Blue</li>
            <li class="sky">Sky Blue</li>
          </ul>
        </mu-card-text>
      </mu-card>
    </mu-flex>
    <br /><mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="Suit Wearer's Dress Code"></mu-card-title>
        <mu-card-text>
          <p>
            Please attend wearing a suit of any solid color except blue.
            Ties, bowties, handkerchiefs, etc. are allowed and encouraged to be colorful.
          </p>
        </mu-card-text>
      </mu-card>
    </mu-flex>
    <br />
    <mu-flex justify-content="center">
      <mu-card>
        <mu-card-title title="Dress Wearer's Dress Code"></mu-card-title>
        <mu-card-text>
          <p>
            Please attend wearing a dress of any solid color except light blue. Jumpsuit dresses are allowed.
          </p>
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
ul {
  list-style: none;
}

ul li::before {
  content: "\2BC0";
  display: inline-block;
  margin-left: -1em;
  font-size: 140%;
  margin-right: 1em;
  font-weight: bold;
}

ul li.navy::before {
  color: #0d18ae;
}

ul li.white::before {
  color: #eeeeee;
}

ul li.sky::before {
  color: #63d4f3;
}
</style>
