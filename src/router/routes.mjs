export default [
  {
    path: '/',
    name: 'Main',
    sitemap: {
      changefreq: 'daily',
      priority: 1,
    },
    component: () => import(/* webpackChunkName: "Main" */ '../views/Main.vue'),
  },
  {
    path: '/rsvp',
    name: 'RSVP',
    sitemap: {
      changefreq: 'daily',
      priority: 1,
    },
    component: () => import(/* webpackChunkName: "RSVP" */ '../views/RSVP.vue'),
  },
  {
    path: '/location',
    name: 'Location',
    sitemap: {
      changefreq: 'daily',
      priority: 1,
    },
    component: () => import(/* webpackChunkName: "Location" */ '../views/Location.vue'),
  },
  {
    path: '/dresscode',
    name: 'Dresscode',
    sitemap: {
      changefreq: 'daily',
      priority: 1,
    },
    component: () => import(/* webpackChunkName: "Dresscode" */ '../views/Dresscode.vue'),
  },
  {
    path: '/about',
    name: 'About',
    sitemap: {
      changefreq: 'daily',
      priority: 1,
    },
    component: () => import(/* webpackChunkName: "RSVP" */ '../views/About.vue'),
  },
  {
    path: '/coc',
    name: 'CodeOfConduct',
    sitemap: {
      changefreq: 'daily',
      priority: 1,
    },
    component: () => import(/* webpackChunkName: "CodeOfConduct" */ '../views/CodeOfConduct.vue'),
  },
];
