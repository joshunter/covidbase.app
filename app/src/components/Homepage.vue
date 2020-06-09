<template>
	<div>
		<WorldTable/>
		<CountriesTable v-bind:countryData = "countryData"/>
	</div>
</template>

<script>
import WorldTable from './WorldTable.vue';
import CountriesTable from './CountriesTable.vue';

export default {
	name: 'Homepage',
	components: {
		WorldTable,
		CountriesTable
	},
	data(){
		return {
			countryData: this.fetchCountryData(),
		}
	},
	methods :  {
		fetchCountryData(){
			fetch('https://db.covidbase.app/api/data')
				.then(response => { 
					if(response.ok){
						return response.json()
					} else {
					alert("Server returned " + response.status + " : " + response.statusText);
					}                
				})
				.then(response => {
					sessionStorage.setItem('sortedBy', 'totalD');
					this.countryData = response;
				})
				.catch(err => {
					console.log(err);
				});
		}
	}
}
</script>



<style>
</style>