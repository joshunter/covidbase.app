<template>
	<table>
		<div class="row">
			<div class="rowNumber">#</div>
			<div class="rowElement">Country</div>
			<div class="rowElement active">Active</div>
			<div class="rowElement recovered">Recovered</div>
			<div class="rowElement critical">Critical</div>
			<div class="rowElement deaths">Deaths</div>
			<div class="rowElement">Total</div>
			<div class="rowElement">Tests</div>
		</div>
		<div v-bind:key="country.id" v-for="country in countries">
			<CountryRow v-bind:country="country" />
		</div>
	</table>
</template>

<script>
import CountryRow from './CountryRow.vue';
export default{
	name:"CountriesTable",
	components: {
		CountryRow
	},
	props: ["countries"]
}
</script>

<style scoped>
table {
	border-collapse: collapse;
	text-align: center;
    width:90%; 
	margin: 5%;
    border-radius: 15px;
    background-color: #1b395d;
	color: #d8dbe2;
}
</style>