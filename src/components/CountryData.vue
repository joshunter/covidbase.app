<template>
	<table>
		<div class="top row">
			<div class="rowElement">Country</div>
			<div class="rowElement active">Active</div>
			<div class="rowElement recovered">Recovered</div>
			<div class="rowElement critical">Critical</div>
			<div class="rowElement deaths">Deaths</div>
			<div class="rowElement">Total</div>
			<div class="rowElement">Tests</div>
		</div>
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


<style>
table {
    width:90%;
    border-radius: 15px;
    background-color: #1b395d;
	color: #d8dbe2;
    text-align: center;
}

.row {;
	display: block;
    font-size: 80%;
    text-align: center;
    padding-bottom: 5px;
    padding-left: 3.5%;
    padding-right: 4%;
}
.top {
    padding-top: 5px;
}
.rowElement {
	width: 13%;
}
.active {
	color: #58A4B0;
}
.recovered {
	color:  #a0ed8c;
}
.critical {
	color:  #ffaf3f;
}
.deaths {
	color: #ff6575;
}
</style>
