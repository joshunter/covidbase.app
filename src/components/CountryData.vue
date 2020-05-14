<template>
	<table>
		<div v-bind:key="country.id" v-for="country in countries">
			<Country v-bind:country="country" />
		</div>
	</table>
</template>

<script>
import Country from './Country.vue';

export default{
	name:"CountryData",
	components: {
		Country
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
