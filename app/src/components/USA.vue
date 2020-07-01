<template>
	<div>
		<DataTable id="USDataTotal" v-bind:data="USTotalData" v-bind:title="'United States & Territories'"/>
		<CustomTable id="USDataTable" v-bind:data="USData" v-bind:searchedData="statesSearched"/>
	</div>
</template>

<script>
import DataTable from './DataTable.vue';
import CustomTable from './CustomTable.vue';

export default {
	name: "USA",
	components: {
		DataTable,
		CustomTable
	},
	computed: {
		USTotalData() {return this.$store.state.us.USTotalData},
		USData() {return this.$store.state.us.USData},
		statesSearched() {return this.$store.state.us.statesSearched},
		statesData() {return this.$store.state.us.statesData}
	},
	mounted() {
		if(!this.statesData[0])
			this.$store.dispatch('fetchStatesData');
	}
}
</script>

<style>
#USDataTotal .population{display: none;}
#USDataTotal .population2{display: inline-block;}
#USDataTotal .rowElement{width: calc(100%/5);}
#USDataTable .rowElement {width: calc(97%/8);}
#USDataTable .expend1{display: inline-block;}
#USDataTable .expend2{display: inline-block;}
#USDataTable .expend3{display: inline-block;}
#USDataTable .expend4{display: inline-block;}

/*smaller screens*/
@media only screen and (max-width: 1200px){
	#USDataTotal .population{display: inline-block;}
	#USDataTotal .population2{display: none;}
	#USDataTotal .rowElement{width: calc(100%/3);}
}
@media only screen and (max-width: 850px){
	#USDataTable .expend4{display: none;}
	#USDataTable .rowElement{width: calc(97%/7);}
}
@media only screen and (max-width: 750px){
	#USDataTable .expend3{display: none;}
	#USDataTable .rowElement{width: calc(97%/6);}
}
@media only screen and (max-width: 630px){
	#USDataTable .rowNumber{display: none;}
	#USDataTable .expend2{display: none;}
	#USDataTable .rowElement{width: calc(100%/5);}
}
@media only screen and (max-width: 550px){
	#USDataTotal .displayRow{font-size: 85%;}
	#USDataTotal .population{font-size: 95%;}
	#USDataTotal .title{font-size: 125%;}

	#USDataTable .row {font-size: 90%;}
	#USDataTable .rowElement{padding-top: 2px;}
	#USDataTable .subNumber {font-size: 69%;}
}
@media only screen and (max-width: 465px){#USDataTable .row {font-size: 80%;}}
@media only screen and (max-width: 410px){#USDataTable .row {font-size: 70%;}}
@media only screen and (max-width: 360px){#USDataTable .row {font-size: 62%;}}
@media only screen and (max-width: 340px){#USDataTable .row {font-size: 58%;}}

</style>