<template>
	<div class="worldTable">
		<div class="title">Global Info</div>
		<div class="top row">
			<div class="rowElement active">Active
					<div>{{worldData.active}}</div>
				<div class="subNumber">{{worldData.newActive}}</div>
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
			<div class="rowElement">Total
				<div>{{worldData.total}}</div>
			</div>
		</div>
	</div>
</template>


<script>
export default {
	name: "WorldTable",
	data(){
		return {
			worldData: {}
		}
	},
	methods: {
		fetchWorldData: function(){
			fetch('http://18.223.121.212:5000/api/wData')
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
	},
	created: function() {
		this.worldData = this.fetchWorldData()
	}
}
</script>


<style>

.worldTable {
    width:90%;
	margin-bottom: 3%;
    border-radius: 15px;
    background-color: #1b395d;
	color: #d8dbe2;
}

.row {
	display: flex;
    font-size: 80%;
    text-align: center;
    padding-bottom: 5px;
    padding-left: 3.5%;
    padding-right: 4%;
    padding-top: 5px;
}
.title {
    text-align: center;
	font-size: 125%;
    padding-top: 5px;
}
.rowElement {
	display: block;
    text-align: center;
	width: 20%;
}
.subNumber {
	font-size: 81%;
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
