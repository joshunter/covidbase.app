<template>
	<div>
		<DataTable id="StateTotal" v-bind:data="totalData" v-bind:title="data.state"/>
		<CustomTable id="StateTable" v-bind:data="data" v-bind:searchedData="citiesSearched" v-bind:type="'City'"/>
	</div>
</template>

<script>
import DataTable from './DataTable.vue';
import CustomTable from './CustomTable.vue';

export default {
	name: "StatePage",
	components: {
		DataTable,
		CustomTable
	},
	computed: {
		statesData() {return this.$store.state.us.statesData},
		citiesSearched() {return this.$store.state.us.citiesSearched},
		currentState() {
			const path = this.$route.fullPath.split("/");
			const stateName = path[path.length-2].replace(/-/g,' ');

			this.$store.dispatch('setCurrentState',stateName);

			return stateName;
		},
		totalData() {
			var totalData
			try {
				totalData=this.$store.getters.getStateBySearch(this.currentState)[0]
			} catch {
				console.log("wow!");
			}
			if(!totalData)
				totalData = {}

			return totalData;
		},
		data() {
			var data
			try {
				data=this.$store.getters.getStateDataBySearch(this.currentState)[0].data
			} catch {
				data=[{name:"",total:"",active:"",deaths:"",tests:""}]
			}				

			return data;
		}
	},
	created() {
		if(!this.statesData[0])
			this.$store.dispatch('fetchStatesData');
	},
	beforeDestroy(){
		this.$store.dispatch('setCurrentState','');
	}
}
</script>

<style>
#StateTotal .rowElement{width: calc(100%/4);}
#StateTable .rowNumber{width: 7%}
#StateTable .rowElement{width: calc(93%/5);}
#StateTable .expend1{display: inline-block;}
#StateTable .expend2{display: inline-block;}
#StateTable .expend3{display: inline-block;}
#StateTable .expend4{display: inline-block;}

/*smaller screens*/
@media only screen and (max-width: 630px){
	#StateTotal .rowElement{width: calc(100%/3);}
	#StateTable .rowElement{width: calc(100%/5);}
	#StateTable .rowNumber{display: none;}
}
@media only screen and (max-width: 560px){
	#StateTotal .displayRow{font-size: 85%;}
	#StateTotal .population{font-size: 95%;}
	#StateTotal .title{font-size: 125%;}

	#StateTable .row {font-size: 90%;}
	#StateTable .rowElement{padding-top: 2px;}
	#StateTable .subNumber {font-size: 69%;}
}
@media only screen and (max-width: 510px){#StateTable .row {font-size: 85%;}}
@media only screen and (max-width: 465px){
	#StateTable .row {font-size: 80%;}
	#StateTable .searchBar {padding-left: 10px;}
}
@media only screen and (max-width: 360px){#StateTable .row {font-size: 62%;}}
@media only screen and (max-width: 340px){#StateTable .row {font-size: 58%;}}
</style>