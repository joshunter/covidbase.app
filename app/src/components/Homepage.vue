<template>
	<div>
		<DataTable id="WorldTable" v-bind:data="worldData" v-bind:title="'Global Data'"/>
		<CountriesTable v-bind:countryData="countryData"/>
	</div>
</template>

<script>
import DataTable from './DataTable.vue';
import CountriesTable from './CountriesTable.vue';

export default {
	name: 'Homepage',
	components: {
		DataTable,
		CountriesTable
	},
	props: ["worldData", "countryData"]
}
</script>



<style>
</style>