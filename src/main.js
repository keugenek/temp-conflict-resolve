import Vue from 'vue';

import 'muse-ui/lib/styles/base.less';
import { Card } from 'muse-ui';
import Container from 'muse-ui/src/Grid';
import 'muse-ui/lib/styles/theme.less';
import theme from 'muse-ui/lib/theme';
theme.use('dark');

import App from './App.vue';
import router from './router';

Vue.config.productionTip = false;

Vue.use(Card);
Vue.use(Container);

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
