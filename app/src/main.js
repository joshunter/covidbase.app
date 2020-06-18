import Vue from 'vue'
import App from './App.vue'
import Vuex from 'vuex' 
import {mapState} from 'vuex'
import VueRouter from 'vue-router' 

// pages
import About from './About.vue'
import Homepage from './components/Homepage.vue'
import USA from './components/USA.vue'

var myHeaders = new Headers();
myHeaders.set('Content-Security-Policy', 'default-src \'self\' *.covidbase.app;');

Vue.config.productionTip = false

Vue.use(Vuex);
Vue.use(VueRouter);


const store = new Vuex.Store({
	state: {
		countryData: {},
		worldData: {},
		filteredData: {},
		searchedData: {},
		currentContinent: 'Global Data',
		query: ''
	},
	mutations: {
		assignCountryData(state, payload){
			state.countryData = payload;
		},
		assignWorldData(state, payload){
			state.worldData = payload;
		},
		assignFilteredData(state, payload){
			state.filteredData = payload;
		},
		assignSearchedData(state, payload){
			state.searchedData = payload;
		},
		assignContinent(state, continent){
			state.currentContinent = continent;
		},
		assignQuery(state, query) {
			state.query = query;
		}
	},
	getters: {
		getCountriesByContinent: (state) => {
			return state.countryData.filter(country => country.continent == state.currentContinent);
		},
		getCountriesBySearch: (state) => {
			if(state.currentContinent == 'Global Data')
				return state.countryData.filter(country => country.name.toLowerCase().includes(state.query));
			else
				return state.filteredData.filter(country => country.name.toLowerCase().includes(state.query));
		}
	},
	actions: {
		fetchData ({ commit }) {
			// Grab and assign countryData
			fetch('https://db.covidbase.app/api/data')
				.then(response => { 
					if(response.ok){
						return response.json()
					} else {
						alert("Server returned " + response.status + " : " + response.statusText);
					}
				})
				.then(response => {
					commit('assignCountryData', response);
				})
				.catch(err => {
					console.log(err);
				});

			// Grab and assign worldData
			fetch('https://db.covidbase.app/api/wData')
				.then(response => { 
					if(response.ok){
						return response.json()
					} else {
						alert("Server returned " + response.status + " : " + response.statusText);
					}
				})
				.then(response => {
					commit('assignWorldData', response[0]);
				})
				.catch(err => {
					console.log(err);
				});
		},
		filterData ( {commit, getters} ) {
			commit('assignFilteredData', getters.getCountriesByContinent);
		},
		searchData ( {commit, getters} ) {
			commit('assignSearchedData', getters.getCountriesBySearch);
		},
		setContinent ( {commit}, continent ) {
			commit('assignContinent', continent);
		},
		setQuery ( {commit}, query ) {
			commit('assignQuery', query);
		}
	}
});

const routes = [
	{	path: '/',
		name: 'Homepage',
		component: Homepage,
	},
	{	path: '/about',
		name: 'about',
		component: About
	},
	{	path: '/USA',
		name: 'USA',
		component: USA
	},
	{	path: "*",
		component: Homepage
	}
];

const router = new VueRouter({ 
	routes,
	mode: 'history'
});

new Vue({
	el: '#app',
	store,
	computed: mapState(['countryData', 'worldData']),
	router,
	render: h => h(App)
}).$mount('#app')

