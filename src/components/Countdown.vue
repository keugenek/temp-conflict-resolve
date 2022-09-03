<template>
  <div>
    <div v-if="!completed" class="container content">
      <div class="block">
        <p class="digit">{{ days | two_digits }}</p>
        <p class="text">Days</p>
      </div>
      <div class="block">
        <p class="digit">{{ hours | two_digits }}</p>
        <p class="text">Hours</p>
      </div>
      <div class="block">
        <p class="digit">{{ minutes | two_digits }}</p>
        <p class="text">Minutes</p>
      </div>
      <div class="block">
        <p class="digit">{{ seconds | two_digits }}</p>
        <p class="text">Seconds</p>
      </div>
    </div>
    <div v-else><slot></slot></div>
  </div>
</template>

<script>
export default {
  mounted() {
    window.setInterval(() => {
      this.now = Math.trunc(new Date().getTime() / 1000);
    }, 1000);
  },
  props: {
    date: {
      type: Number,
    },
  },
  data() {
    return {
      now: Math.trunc(new Date().getTime() / 1000),
    };
  },
  computed: {
    seconds() {
      return (this.date - this.now) % 60;
    },
    minutes() {
      return Math.trunc((this.date - this.now) / 60) % 60;
    },
    hours() {
      return Math.trunc((this.date - this.now) / 60 / 60) % 24;
    },
    days() {
      return Math.trunc((this.date - this.now) / 60 / 60 / 24);
    },
    completed() {
      return this.now > this.date;
    },
  },
};
</script>

<style>
.content {
  text-align: center;
}

.block {
  width: 25%;
}

.container {
  display: flex;
  flex-direction: row;
}

.text {
  color: #00bbbd;
  font-size: 200%;
  font-weight: 400;
  margin: 10px;
  text-align: center;
}

.digit {
  color: #ecf0f1;
  font-size: 400%;
  font-weight: 100;
  margin: 10px;
  text-align: center;
}

@media (max-width: 768px) {
  .text {
    font-size: 175%;
  }
  .digit {
    font-size: 350%;
  }
}

@media (max-width: 576px) {
  .text {
    font-size: 100%;
  }
  .digit {
    font-size: 200%;
  }
}
</style>
