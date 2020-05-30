<template>
	<div>
		<WorldTable v-bind:worldData = "worldData"/>
		<CountriesTable v-bind:countryData = "countryData"/>
	</div>
</template>

<script>
import WorldTable from './WorldTable.vue';
import CountriesTable from './CountriesTable.vue';

export default {
	name: 'Homepage',
	props : [
		"countryData",
		"worldData"
	],
	components: {
		WorldTable,
		CountriesTable
	}
	}
</script>



<style>
</style>