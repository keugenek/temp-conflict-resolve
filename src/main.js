import Vue from 'vue';

import 'muse-ui/lib/styles/base.less';
import { Alert, Button, Card, Checkbox, Form, Icon, List, Menu, Snackbar, TextField } from 'muse-ui';
import Container from 'muse-ui/src/Grid';
import 'muse-ui/lib/styles/theme.less';
import theme from 'muse-ui/lib/theme';
theme.use('dark');

import App from './App.vue';
import router from './router';

Vue.config.productionTip = false;

Vue.use(Alert);
Vue.use(Button);
Vue.use(Card);
Vue.use(Container);
Vue.use(Checkbox);
Vue.use(Form);
Vue.use(Icon);
Vue.use(List);
Vue.use(Menu);
Vue.use(Snackbar);
Vue.use(TextField);

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');

Vue.filter('two_digits', (value) => {
  if (value.toString().length <= 1) {
    return "0" + value.toString();
  }
  return value.toString();
});
