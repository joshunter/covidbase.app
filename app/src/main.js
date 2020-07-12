import Vue from 'vue'
import App from './App.vue'
import Vuex from 'vuex' 
import {mapState} from 'vuex'
import VueRouter from 'vue-router' 

// pages
import About from './About.vue'
import Homepage from './Homepage.vue'
import USA from './USA.vue'
import StatePage from './StatePage.vue'

Vue.config.productionTip = false

Vue.use(Vuex);
Vue.use(VueRouter);

const USModule = {
	state: {
		USData: [{name:"",total:"",active:"",recovered:"",critical:"",deaths:"",tests:"",casesPM:"",deathsPM:"",testsPM:""}],
		USTotalData: {},
		statesData: {},
		statesSearched: {},
		currentState: '',
		citiesSearched: {},
		cityQuery: '',
		statesQuery: ''
	},
	mutations: {
		assignUSData(state, payload){
			state.USData = payload;
		},
		assignUSTotalData(state, payload){
			state.USTotalData = payload;
		},
		assignStatesQuery(state, query) {
			state.statesQuery = query;
		},
		assignStatesData(state, payload) {
			state.statesData = payload;
		},
		assignCurrentState(state, payload){
			state.currentState = payload;
		},
		assignStatesSearched(state, payload){
			state.statesSearched = payload;
		},
		assignCitiesSearched(state, payload){
			state.citiesSearched = payload;
		},
		assignCityQuery(state, query) {
			state.cityQuery = query;
		}
	},
	getters: {
		getStatesBySearch: (state) => {
			return state.USData.filter(curr => curr.name.toLowerCase().includes(state.statesQuery));
		},
		getStateBySearch: (state) => (name) => {
			return state.USData.filter(curr => curr.name.toLowerCase().includes(name));
		},
		getStateDataBySearch: (state) => (name) => {
			return state.statesData.filter(curr => curr.state.toLowerCase().includes(name));
		},
		getCitiesBySearch: (state, getters) => {
			var data = getters.getStateDataBySearch(state.currentState)[0].data;
			return data.filter(curr => curr.name.toLowerCase().includes(state.cityQuery));
		},
	},
	actions: {
		fetchUSData ({ commit }) {				
			// Grab and assign USData
			fetch('https://db.covidbase.app/api/usData')
				.then(response => { 
					if(response.ok){
						return response.json()
					} else {
						alert("Server returned " + response.status + " : " + response.statusText);
					}
				})
				.then(response => {
					commit('assignUSData', response);
				})
				.catch(err => {
					console.log(err);
				});
		},
		fetchStatesData ({ commit }) {
			// Grab and assign USData
			fetch('https://db.covidbase.app/api/statesData')
				.then(response => { 
					if(response.ok){
						return response.json()
					} else {
						alert("Server returned " + response.status + " : " + response.statusText);
					}
				})
				.then(response => {
					commit('assignStatesData', response);
				})
				.catch(err => {
					console.log(err);
				});
		},
		searchStatesData ( {commit, getters} ) {
			commit('assignStatesSearched', getters.getStatesBySearch);
		},
		searchCitiesData ( {commit, getters} ) {
			commit('assignCitiesSearched', getters.getCitiesBySearch);
		},
		setCurrentState ( {commit}, query ) {
			commit('assignCurrentState', query);
		},
		setStatesQuery ( {commit}, query ) {
			commit('assignStatesQuery', query);
		},
		setCityQuery ( {commit}, query ) {
			commit('assignCityQuery', query);
		}
	}
}

const worldModule = {
	state: {
		countryData: [{name:"",population:"",total:"",active:"",recovered:"",critical:"",deaths:"",tests:"",casesPM:"",deathsPM:"",testsPM:"",continent:""}],
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
		},
		getCountryByName: (state) => (name) => {
			return state.countryData.filter(country => country.name==name);
		}
	},
	actions: {
		fetchData ({ commit, getters }) {
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
					commit('assignUSTotalData',getters.getCountryByName("USA")[0])
				})
				.catch(err => {
					console.log(err);
				});
		},
		filterData ( {commit, getters} ) {
			commit('assignFilteredData', getters.getCountriesByContinent);
		},
		searchCountry ( {commit, getters} ) {
			commit('assignSearchedData', getters.getCountriesBySearch);
		},
		setContinent ( {commit}, continent ) {
			commit('assignContinent', continent);
		},
		setCountryQuery ( {commit}, query ) {
			commit('assignQuery', query);
		}
	}
}


const store = new Vuex.Store({
	modules: {
		us: USModule,
		world: worldModule,
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
	{	
		path: "/usa/*",
		component: StatePage
	},
	{	path: "*",
		component: Homepage
	}
];

const router = new VueRouter({ 
	routes,
	base: __dirname,
	mode: 'history'
});

new Vue({
	el: '#app',
	store,
	computed: mapState(['countryData', 'worldData']),
	router,
	render: h => h(App)
}).$mount('#app')

