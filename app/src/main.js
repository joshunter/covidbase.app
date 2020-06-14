import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router' 
import About from './About.vue'
import Homepage from './components/Homepage.vue'
import USA from './components/USA.vue'

Vue.config.productionTip = false

Vue.use(VueRouter);

const routes = [
	{
		path: '/',
		name: 'Homepage',
		component: Homepage,
	},
	{
		path: '/about',
		name: 'about',
		component: About
	},
	{
		path: '/USA',
		name: 'USA',
		component: USA
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