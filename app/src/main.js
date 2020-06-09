import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router' 
import About from './About.vue'
import Homepage from './components/Homepage.vue'

Vue.config.productionTip = false

Vue.use(VueRouter);

const routes = [
	{
		path: '/',
		name: 'Homepage',
		component: Homepage
	},
	{
		path: '/About',
		name: 'About',
		component: About
	}
];

const router = new VueRouter({ 
	routes,
	mode: 'history'
});

new Vue({
	el: '#app',
	router,
	render: h => h(App)
}).$mount('#app')