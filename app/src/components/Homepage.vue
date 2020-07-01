<template>
	<div>
		<DataTable id="WorldTable" v-bind:data="worldData" v-bind:moreData="continentData" v-bind:title="'Global Info'"/>
		<CustomTable v-bind:data="countryData" v-bind:filteredData="filteredData" v-bind:searchedData="searchedData" v-bind:type="'Country'"/>
	</div>
</template>

<script>
import DataTable from './DataTable.vue';
import CustomTable from './CustomTable.vue';

export default {
	name: 'Homepage',
	components: {
		DataTable,
		CustomTable
	},
	computed: {
		worldData() {return this.$store.state.world.worldData},
		continentData() {return this.$store.state.world.continentData},
		countryData() {return this.$store.state.world.countryData},
		filteredData() {return this.$store.state.world.filteredData},
		searchedData() {return this.$store.state.world.searchedData}
	}
}
</script>

<style>
/*smaller screens*/
@media only screen and (max-width: 1100px){
	#WorldTable .expend2{display: none;}
	#WorldTable .rowElement{width: calc(100%/6);}
}

@media only screen and (max-width: 811px){
	#WorldTable .expend1{display: none;}
	#WorldTable .rowElement{width: calc(100%/5);}
}
@media only screen and (max-width: 550px){
	#WorldTable .displayRow {font-size: 85%;}
	#WorldTable .title{font-size: 125%;}
}
@media only screen and (max-width: 465px){
	#WorldTable .displayRow {font-size: 70%;}
	#WorldTable .title{font-size: 110%;}
}
@media only screen and (max-width: 400px){
	#WorldTable .displayRow {font-size: 65%;}
	#WorldTable .title{font-size: 105%;}
}
@media only screen and (max-width: 360px){
	#WorldTable .displayRow {font-size: 62%;}
	#WorldTable .title{font-size: 102%;}
}
@media only screen and (max-width: 340px){
	#WorldTable .displayRow {font-size: 58%;}
	#WorldTable .title{font-size: 98%;}
}

</style>