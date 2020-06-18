<template>
	<div>
		<DataTable id="WorldTable" v-bind:data="worldData" v-bind:title="'Global Info'"/>
		<CountriesTable/>
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
	computed: {
		worldData() {
			return this.$store.state.worldData
		}
	}
}
</script>



<style>
</style>