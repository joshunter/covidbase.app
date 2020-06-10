<template>
	<div class="worldTable">
		<div class="title">Global Info</div>
		<div class="worldRow" id="worldRow">
			<div class="rowElement">Total Cases
				<div>{{worldData.total}}</div>
				<div class="subNumber">{{worldData.newActive}}</div>
			</div>
			<div class="rowElement active">Active
					<div>{{worldData.active}}</div>
			</div>
			<div class="rowElement recovered">Recovered
				<div>{{worldData.recovered}}</div>
				<div class="subNumber">{{worldData.newRecovered}}</div>
			</div>
			<div class="rowElement critical">Critical
				<div>{{worldData.critical}}</div>
			</div>
			<div class="rowElement deaths">Deaths
				<div>{{worldData.deaths}}</div>
				<div class="subNumber">{{worldData.newDeaths}}</div>
			</div>
			<div class="rowElement expend1">Cases/1M
				<div>{{worldData.casesPM}}</div>
			</div>
			<div class="rowElement deaths expend2">Deaths/1M
				<div>{{worldData.deathsPM}}</div>
			</div>
		</div>
	</div>
</template>


<script>
export default {
	name: "WorldTable",
	data(){
		return{
			worldData: this.fetchWorldData()
		}
	},
	methods:{
		fetchWorldData: function(){
				fetch('https://db.covidbase.app/api/wData')
					.then(response => { 
						if(response.ok){
							return response.json()    
						} else {
							alert("Server returned " + response.status + " : " + response.statusText);
						}
					})
					.then(response => {
						this.worldData = response[0]; 
					})
					.catch(err => {
						console.log(err);
					});
		}
	}
}
</script>


<style scoped>

.worldTable {
    width:90%;
	display: inline-block;
	margin-top: 2%;
	margin-bottom: 2%;
    border-radius: 15px;
    background-color: #1b395d;
	color: #d8dbe2;
}
.lightMode {
	background-color: #f5f5f5;
	color: #3C3C3C;
}
.worldRow {
	width: 100%;
	display: inline-block;
    font-size: 100%;
    text-align: center;
    padding-bottom: 5px;
}
.title {
    text-align: center;
	font-size: 140%;
    padding-top: 5px;
}
.rowElement {
    text-align: center;
	width: calc(100%/7);
	padding-left: 2%;
	padding-right: 2%;
	vertical-align: top;
	display: inline-block;
}
.subNumber {
	font-size: 81%;
}
.active {
	color: #00a1e0;
}
.recovered {
	color:  #a0ed8c;
}
input#dm:checked + .recovered {
	color:  #2ad100;
}
.critical {
	color:  #ffaf3f;
}
.deaths {
	color: #ff6575;
}
@media only screen and (max-width: 1100px){
	.worldRow > .expend2{
		display: none;
	}
	.worldRow > .rowElement{
		width: calc(100%/6);
	}
}

@media only screen and (max-width: 811px){
	.worldRow > .expend1{
		display: none;
	}
	.worldRow > .rowElement{
		width: calc(100%/5);
	}
}

@media only screen and (max-width: 500px) {
  .worldRow {
    font-size: 75%;
  }
  .title{font-size: 105%;}
}
</style>
