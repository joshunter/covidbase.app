<template>
	<div>
		<DataTable id="USDataTable" v-bind:data="USAData" v-bind:title="'United States'"/>
	</div>
</template>

<script>
import DataTable from './DataTable.vue';

export default {
	name: "USA",
	components: {
		DataTable
	},
	// data(){
	// 	return {
	// 		USAData: {},
	// 	}
	// },
	props: [ "USAData" ],
	// created(){
 //      fetch('https://db.covidbase.app/api/wData')
 //        .then(response => { 
 //          if(response.ok){
 //            return response.json()    
 //          } else {
 //            alert("Server returned " + response.status + " : " + response.statusText);
 //          }
 //        })
 //        .then(response => {
 //          this.USAData = response[0]; 
 //        })
 //        .catch(err => {
 //          console.log(err);
 //        });
 // }
}
</script>

<style scoped>

</style>