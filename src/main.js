import Vue from 'vue';
import App from './App.vue';
import router from './router';

Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
  propsData: { canvasElement: document.getElementById('constellations') },
}).$mount('#app');

Vue.filter('two_digits', (value) => {
  if (value.toString().length <= 1) {
    return "0" + value.toString();
  }
  return value.toString();
});
